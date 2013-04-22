require_dependency "cookie_alert/application_controller"

module CookieAlert
  class CookiesController < ApplicationController

    # Implement cookie acceptance when a visitor click the 'accept' button
    def cookie_accepted

      # Get the visitor's current page URL or, if nil?,  default to the application root
      visitor_current_url = cookies.signed[CookieAlert.config.cookie_name.to_sym].split(CookieAlert.config.cookie_value_text_separator)[1] || main_app.root_path

      # Set the Cookie value to 'accepted'
      if CookieAlert.config.cookie_type == 'permanent'
 
        # Set a permanent cookie
        cookies.permanent.signed[CookieAlert.config.cookie_name.to_sym] = 'accepted'
 
      elsif CookieAlert.config.cookie_type == 'fixed_duration'
 
        # Set a fixed duration cookie
        cookies.permanent.signed[CookieAlert.config.cookie_name.to_sym] = { value: 'accepted', expires: CookieAlert.config.num_days_until_cookie_expires.days.from_now }
 
      else
 
        # Set a session cookie
        cookies.signed[CookieAlert.config.cookie_name.to_sym] = 'accepted'
 
      end
      
      # If the request is HTML then redirect the visitor back to their original page
      # If the request is javascript then render the javascript partial
      respond_to do |format|

        format.html { redirect_to(visitor_current_url) }
        format.js { render template: "cookie_alert/cookies/cookie_accepted" }

      end
  
    end

  end
end
