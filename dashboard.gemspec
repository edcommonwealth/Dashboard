require_relative "lib/dashboard/version"

Gem::Specification.new do |spec|
  spec.name = "dashboard"
  spec.version     = Dashboard::VERSION
  spec.authors     = ["Nelson Jovel"]
  spec.email       = ["memoryman51@hotmail.com"]
  spec.homepage    = "https://github.com/edcommonwealth/Dashboard"
  spec.summary     = "A school quality measures dashboard designed for inclusion in a ruby on rails project"
  spec.description = "A school quality measures dashboard designed for inclusion in a ruby on rails project"
  spec.license     = "GPL v3"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/edcommonwealth/Dashboard"
  spec.metadata["changelog_uri"] = "https://github.com/edcommonwealth/Dashboard"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "bcrypt_pbkdf"
  spec.add_dependency "cssbundling-rails"
  spec.add_dependency "ed25519"
  spec.add_dependency "friendly_id", "~> 5.4.0"
  spec.add_dependency "jsbundling-rails"
  spec.add_dependency "net-sftp"
  spec.add_dependency "rails", ">= 7.1.2"
  spec.add_dependency "rspec-rails"
  spec.add_dependency "stimulus-rails"
  spec.add_dependency "turbo-rails"
  spec.add_dependency "watir"

  spec.add_development_dependency "factory_bot_rails"
  spec.add_development_dependency "standard_deviation"
end
