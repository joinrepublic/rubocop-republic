# frozen_string_literal: true

RSpec.describe RuboCop::Cop::RepublicMonolith::GQLTypesShouldHaveIncludeAuthorization, :config do
  subject(:cop) { described_class.new(config) }
  let(:config) { RuboCop::Config.new }

  it 'registers an offense when using `#bad_method`' do
    expect_offense(<<~RUBY)
      module SomeModule
        class SomeGQLType
        ^^^^^^^^^^^^^^^^^ RepublicMonolith/GQLTypesShouldHaveIncludeAuthorization: Missed include_authorization method call in GQL type.
        end
      end
    RUBY
  end

  it 'does not register an offense when using `#good_method`' do
    expect_no_offenses(<<~RUBY)
      module SomeModule
        class SomeGQLType
          include_authorization
        end
      end
    RUBY
  end
end
