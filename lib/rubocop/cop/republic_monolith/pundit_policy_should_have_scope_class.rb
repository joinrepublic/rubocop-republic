# frozen_string_literal: true

module RuboCop
  module Cop
    module RepublicMonolith
      # Every Pundit policy should have implementation of Scope class.
      # It's important because we use it in GQL API for authorization.
      #
      class PunditPolicyShouldHaveScopeClass < Base
        MSG = 'Missed implementation of Scope class in Pundit policy.'

        def on_class(node)
          return unless policy_class?(node)
          return if has_scope_class?(node)
          return if parent_class_has_scope_class?(node)

          add_offense(node)
        end

        private

        def policy_class?(node)
          node.identifier.source =~ /.*Policy$/
        end

        def has_scope_class?(node)
          return false unless node.body

          node.body.each_node(:class) do |method_node|
            return true if method_node.identifier.source == 'Scope'
          end
          false
        end

        def parent_class_has_scope_class?(node)
          return false unless node.parent_class

          parent_policy_data = self.class.policies_data.find { |h| h[node.parent_class.source] }
          parent_policy_data[node.parent_class.source]['scope?']
        end

        def self.policies_data
          data = %x[bundle exec rake rubocop_republic:load_policy_checks]
          @policies_data ||= JSON.parse(data.gsub!(/.*?(?=\[\{)/im, "")).freeze
        end
      end
    end
  end
end
