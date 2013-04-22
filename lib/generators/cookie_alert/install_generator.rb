module CookieAlert
  module Generators
    class InstallGenerator < Rails::Generators::Base
      
      source_root File.expand_path(File.join(File.dirname(__FILE__), 'templates'))

      desc "DESCRIPTION:\nCreates a configuration file, view templates, JavaScript and CSS files to your application.\n\n"

      def create_install_files
        say "\n\n ==========================================="
        say "     Starting CookieAlert installation"
        say " ==========================================="

        say "\n Installing configuration file:"
        copy_file "cookie_alert.rb", "config/initializers/cookie_alert.rb"
        
        say "\n Installing Primary Alert View:"
        copy_file "_primary_alert.html.erb", "app/views/cookie_alert/cookies/_primary_alert.html.erb"

        say "\n Installing Secondary Alert View:"
        copy_file "_secondary_alert.html.erb", "app/views/cookie_alert/cookies/_secondary_alert.html.erb"

        say "\n Installing JavaScript Response View:"
        copy_file "cookie_accepted.js.erb", "app/views/cookie_alert/cookies/cookie_accepted.js.erb"
        
 
        say "\n Installing StyleSheet:"
        copy_file "cookie_alert.css", "app/assets/stylesheets/cookie_alert.css"

        say "\n Installing JavaScript:"
        copy_file "cookie_alert.js", "app/assets/javascripts/cookie_alert.js"
        
        say "\n\n NOTE:=> run 'rails g cookie_alert:uninstall' to remove installed files"

        say "\n ==========================================="
        say "     CookieAlert installation Completed"
        say " ===========================================\n\n"
      end

    end
  end
end