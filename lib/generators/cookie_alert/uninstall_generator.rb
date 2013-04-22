module CookieAlert
  module Generators
    class UninstallGenerator < Rails::Generators::Base
      
      source_root File.expand_path(File.join(File.dirname(__FILE__), 'templates'))

      desc "DESCRIPTION:\nRemoves any previously installed files.\n\n"

      def remove_install_files
        say "\n\n ==========================================="
        say "     Uninstalling CookieAlert"
        say " ==========================================="

        say "\n Removing configuration file:"
        remove_file "config/initializers/cookie_alert.rb"
        
        say "\n Removing Primary Alert View:"
        remove_file "app/views/cookie_alert/cookies/_primary_alert.html.erb"

        say "\n Removing Secondary Alert View:"
        remove_file "app/views/cookie_alert/cookies/_secondary_alert.html.erb"

        say "\n Removing JavaScript Response View:"
        remove_file "app/views/cookie_alert/cookies/cookie_accepted.js.erb"
        
 
        say "\n Removing StyleSheet:"
        remove_file "app/assets/stylesheets/cookie_alert.css"

        say "\n Removing JavaScript:"
        remove_file "app/assets/javascripts/cookie_alert.js"
        
        say "\n ==========================================="
        say "     Uninstall Complete"
        say " ===========================================\n\n"
      end

    end
  end
end