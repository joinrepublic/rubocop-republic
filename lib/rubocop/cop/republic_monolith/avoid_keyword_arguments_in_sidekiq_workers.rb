# frozen_string_literal: true

module RuboCop
  module Cop
    module RepublicMonolith
      # Sidekiq workers doesn't support keyword args.
      #
      class AvoidKeywordArgumentsInSidekiqWorkers < Base
        MSG = "Do not use keyword arguments in Sidekiq workers. " \
          "For details, check https://github.com/mperham/sidekiq/issues/2372"
        OBSERVED_METHOD = :perform

        def on_class(node)
          return unless sidekiq_worker_class?(node)
          return unless has_keyword_args?(node)

          add_offense(node)
        end

        private

        def sidekiq_worker_class?(node)
          node.body.each_node(:send) do |send_node|
            arg_value = send_node.arguments&.first&.const_name
            return true if send_node.method_name == :include && arg_value == 'Sidekiq::Worker'
          end
          false
        end

        def has_keyword_args?(node)
          return false unless node.body

          node.body.each_node(:def) do |method_node|
            next if method_node.method_name != OBSERVED_METHOD
            method_node.arguments.each do |argument|
              if argument.type == :kwarg || argument.type == :kwoptarg
                add_offense(method_node)
              end
            end
          end
          false
        end
      end
    end
  end
end
