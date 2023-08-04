require_relative 'lib/rubocop/republic/version'

Gem::Specification.new do |spec|
  spec.name          = "rubocop-republic"
  spec.version       = RuboCop::Republic::VERSION
  spec.authors       = ["Andrey Lizunov"]
  spec.email         = ["andrey.lizunov@republic.com"]

  spec.summary       = %q{Storage for custom Republic Rubocop rules.}
  spec.description   = %q{Storage for custom Republic Rubocop rules.}
  spec.homepage      = "https://github.com/joinrepublic/rubocop-republic"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "https://github.com/"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/joinrepublic/rubocop-republic"
  spec.metadata["changelog_uri"] = "https://github.com/joinrepublic/rubocop-republic"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'rubocop'
end
