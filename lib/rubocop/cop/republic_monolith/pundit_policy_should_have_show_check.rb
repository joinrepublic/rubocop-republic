# frozen_string_literal: true

module RuboCop
  module Cop
    module RepublicMonolith
      # Every Pundit policy should have implementation of show? method.
      # It's important because we use it in GQL API for authorization.
      #
      class PunditPolicyShouldHaveShowCheck < Base
        MSG = 'Missed implementation of show? method in Pundit policy.'

        def on_class(node)
          return unless policy_class?(node)
          return if has_show_method?(node)
          return if parent_class_has_show_method?(node)

          add_offense(node)
        end

        private

        def policy_class?(node)
          node.identifier.source =~ /.*Policy$/
        end

        def has_show_method?(node)
          return false unless node.body

          node.body.each_node(:def) do |method_node|
            return true if method_node.method_name == :show?
          end
          false
        end

        def parent_class_has_show_method?(node)
          return false unless node.parent_class

          parent_policy_data = self.class.policies_data.find { |h| h[node.parent_class.source] }
          parent_policy_data[node.parent_class.source]['show?']
        end

        def self.policies_data
          @policies_data ||= JSON.parse(%x[bundle exec rake rubocop_republic:load_policy_checks]).freeze
        end
      end
    end
  end
end
