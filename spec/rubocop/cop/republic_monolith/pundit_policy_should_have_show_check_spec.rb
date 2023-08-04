# frozen_string_literal: true

RSpec.describe RuboCop::Cop::RepublicMonolith::PunditPolicyShouldHaveShowCheck, :config do
  subject(:cop) { described_class.new(config) }
  let(:config) { RuboCop::Config.new }

  it 'registers an offense when Pundit policy does not have show? method' do
    expect_offense(<<~RUBY)
      module SomeModule
        class SomePolicy
        ^^^^^^^^^^^^^^^^ RepublicMonolith/PunditPolicyShouldHaveShowCheck: Missed implementation of show? method in Pundit policy.
          def edit?
          end
        end
      end
    RUBY
  end

  it 'does not register an offense when Pundit policy have show? method' do
    expect_no_offenses(<<~RUBY)
      module SomeModule
        class SomePolicy
          def show?
          end
        end
      end
    RUBY
  end
end
