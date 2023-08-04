# frozen_string_literal: true

module RuboCop
  module Cop
    module RepublicMonolith
      # TODO: Write cop description and example of bad / good code. For every
      # `SupportedStyle` and unique configuration, there needs to be examples.
      # Examples must have valid Ruby syntax. Do not use upticks.
      #
      class GQLTypesShouldHaveIncludeAuthorization < Base
        MSG = 'Missed include_authorization method call in GQL type.'

        def on_class(node)
          return unless gql_type_class?(node)
          return if has_include_authorization_method?(node)

          add_offense(node)
        end

        private

        def gql_type_class?(node)
          node.identifier.source =~ /.*Type$/
        end

        def has_include_authorization_method?(node)
          return false unless node.body

          node.body.each_node(:send) do |method_node|
            return true if method_node.method_name == :include_authorization
          end
          false
        end
      end
    end
  end
end
