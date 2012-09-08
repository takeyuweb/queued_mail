$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "queued_mail/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "queued_mail"
  s.version     = QueuedMail::VERSION
  s.authors     = ["Yuichi Takeuchi"]
  s.email       = ["uzuki05@takeyu-web.com"]
  s.homepage    = "http://takeyu-web.com/"
  s.summary     = "Summary of QueuedMail."
  s.description = "Description of QueuedMail."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.0"

  s.add_development_dependency "sqlite3"
end
