namespace :rubocop_republic do
  desc "Load Policy checks"
  task(:load_policy_checks => :environment) do
    Rails.application.eager_load! unless Rails.env.production?
    result = ObjectSpace.each_object(Class).filter_map do |policy_class|
      if policy_class.respond_to?(:name) && policy_class.name.to_s.end_with?('Policy')
        {
          policy_class => {
            'show?': policy_class.method_defined?(:show?),
            'scope': policy_class.const_defined?(:Scope),
          }
        }
      end
    end
    puts result.to_json
  end
end
