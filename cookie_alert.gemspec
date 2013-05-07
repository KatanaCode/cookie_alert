$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "cookie_alert/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "cookie_alert"
  s.version     = CookieAlert::VERSION
  s.authors     = ["CodeMeister"]
  s.email       = ["bob@katanacode.com"]
  s.homepage    = "https://github.com/KatanaCode/cookie_alert"
  s.summary     = "Notify visitors that your site uses Cookies. For Rails 3.1 +"
  s.description = "Display a visual warning on your site to let visitors know that you use Cookes. Primarily intended for use with the UK Cookie Law"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 3.1"
  s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "yard"             # for Documentation
  s.add_development_dependency "github-markdown"  # for Documentation
end
