$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "queued_mail/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "queued_mail"
  s.version     = QueuedMail::VERSION
  s.authors     = ["Yuichi Takeuchi"]
  s.email       = ["uzuki05@takeyu-web.com"]
  s.homepage    = "https://github.com/uzuki05/queued_mail"
  s.summary     = "Summary of QueuedMail."
  s.description = "Description of QueuedMail."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 3.2.0"
  s.add_dependency "mail", ">= 2.4.4"
  s.add_development_dependency "rspec"
  s.add_development_dependency "mysql2"
end

