# frozen_string_literal: true

RSpec.describe RuboCop::Cop::RepublicMonolith::PunditPolicyShouldHaveScopeClass, :config do
  subject(:cop) { described_class.new(config) }
  let(:config) { RuboCop::Config.new }

  it 'does not register an offense when Pundit policy have Scope class' do
    expect_no_offenses(<<~RUBY)
      module SomeModule
        class SomePolicy
          class Scope
          end
        end
      end
    RUBY
  end
end
