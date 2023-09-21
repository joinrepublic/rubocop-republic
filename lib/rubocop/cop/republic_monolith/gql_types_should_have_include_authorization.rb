# frozen_string_literal: true

module RuboCop
  module Cop
    module RepublicMonolith
      # Pundit policy should have include_authorization to avoid
      # unacceptable data access in GQL API.
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
