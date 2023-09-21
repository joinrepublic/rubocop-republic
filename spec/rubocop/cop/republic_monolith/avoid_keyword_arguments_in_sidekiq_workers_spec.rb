# frozen_string_literal: true

RSpec.describe RuboCop::Cop::RepublicMonolith::AvoidKeywordArgumentsInSidekiqWorkers, :config do
  subject(:cop) { described_class.new(config) }
  let(:config) { RuboCop::Config.new }

  it 'registers an offense when using `#bad_method`' do
    expect_offense(<<~RUBY)
      module SomeModule
        class SomeSidekiqWorker
          include Sidekiq::Worker
          def perform(arg:)
          ^^^^^^^^^^^^^^^^^ RepublicMonolith/AvoidKeywordArgumentsInSidekiqWorkers: Do not use keyword arguments in Sidekiq workers. For details, check https://github.com/mperham/sidekiq/issues/2372
          end
        end
      end
    RUBY
  end

  it 'does not register an offense when using `#good_method`' do
    expect_no_offenses(<<~RUBY)
      module SomeModule
        class SomeSidekiqWorker
          include Sidekiq::Worker
          def perform(arg)
          end
        end
      end
    RUBY
  end
end
