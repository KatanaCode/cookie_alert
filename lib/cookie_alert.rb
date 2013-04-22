require "cookie_alert/engine"

module CookieAlert

  # Creates or updates the configuration settings for CookieAlert
  # @param &block [Initialiser Confirguration Block] block containing configuration settings for the module's Configuration object
  def self.configure(&block)
    yield @config ||= CookieAlert::Configuration.new

    # Validate the configuration
    config.cookie_type                          = 'session'   unless ['session','fixed_duration','permanent'].include? config.cookie_type
    
    config.user_must_accept_cookie_use          = true        unless [true,false].include? config.user_must_accept_cookie_use
    config.use_secondary_alert = true        unless [true,false].include? config.use_secondary_alert
    
    config.max_alert_display_count              = 5           unless config.max_alert_display_count.present?       and  config.max_alert_display_count       > 2
    config.num_days_until_cookie_expires        = 60          unless config.num_days_until_cookie_expires.present? and  config.num_days_until_cookie_expires > 1
    
    config.cookie_name                    = config.cookie_name                     || '_we_use_cookies'
    config.cookie_value_text_separator    = config.cookie_value_text_separator     || "~~" 
    config.primary_alert_template         = config.primary_alert_template          || 'cookie_alert/cookies/primary_alert'
    config.secondary_alert_template       = config.secondary_alert_template        || 'cookie_alert/cookies/secondary_alert'
    config.js_acceptance_template         = config.js_acceptance_template          || 'cookie_alert/cookies/cookie_accepted'
  end

  # Returns the configuration settings for CookieAlert
  def self.config
    @config
  end

  # Configuration Class
  class Configuration
    include ActiveSupport::Configurable

    config_accessor :cookie_name
    config_accessor :cookie_type
    config_accessor :num_days_until_cookie_expires
    config_accessor :user_must_accept_cookie_use
    config_accessor :use_secondary_alert
    config_accessor :max_alert_display_count
    config_accessor :cookie_value_text_separator
    config_accessor :primary_alert_template
    config_accessor :secondary_alert_template
    config_accessor :js_acceptance_template
  end

  # Sets the default configuration values
  # Is over-ridden by a config/initializer/cookie_alert.rb file
  configure do |config|
    config.cookie_name = '_we_use_cookies'
    config.cookie_type = 'session'
    config.user_must_accept_cookie_use = true
    config.use_secondary_alert = true
    config.max_alert_display_count = 5
    config.num_days_until_cookie_expires = 60
    config.cookie_value_text_separator = "~~"
    config.primary_alert_template = 'cookie_alert/cookies/primary_alert'
    config.secondary_alert_template = 'cookie_alert/cookies/secondary_alert'
    config.js_acceptance_template = 'cookie_alert/cookies/cookie_accepted'
  end


  # Primary helper method that decides which, if any, of the Alert templates should be rendered
  def display_cookie_alert
    # If the visitor has not seen the warning before
    # set a cookie recording the first view
    unless cookies.signed[CookieAlert.config.cookie_name.to_sym]
    
      cookie_alert_set_display_count_cookie 1
      cookie_alert_render_primary_alert

    else
    
      # If the warning has previously been accepted because the visitor has either clicked on the 'accept' link
      # or it has been displayed the required number of times
      if cookies.signed[CookieAlert.config.cookie_name.to_sym] == 'accepted'
      
        # Don't display the notice
        cookie_alert_render_nothing
      
      else
        
        # Retrieve the number of times the Alert has been displayed from the Cookie
        num_views = cookie_alert_get_view_count
          
        # MUST the Visitor accept the Cookie by clicking the link?
        unless CookieAlert.config.user_must_accept_cookie_use
          
          # is this past the max number of Warnings to display? 
          if num_views == CookieAlert.config.max_alert_display_count

            # The visitor has accepted through usage, so set the Cookie to 'accepted'
            cookie_alert_set_accepted_cookie

            # Don't display the notive
            cookie_alert_render_nothing
          
          else

            # Increment the view count & display the warning
            cookie_alert_set_display_count_cookie num_views + 1
            cookie_alert_render_primary_alert

          end

        else

          # The user MUST accept the cookie use and hasn't done so yet
          # Do we display the Full Alert of the Reminder?
          if CookieAlert.config.use_secondary_alert == true and num_views >= CookieAlert.config.max_alert_display_count

            # Display the reminder
            cookie_alert_render_secondary_alert
          
          else

            # Display the full alert
            cookie_alert_set_display_count_cookie num_views + 1
            cookie_alert_render_primary_alert

          end
        end
      end
    end
  end
  

private
  

  # Set the data value of the cookie to include the number of views and the current URL
  # @param num_views [integer] the number of time the visitor has viewed an Alert
  def cookie_alert_set_display_count_cookie num_views
    cookie_alert_set_cookie num_views.to_s << CookieAlert.config.cookie_value_text_separator << request.fullpath
  end

  # Sets the value of the cookie to "accepted"
  def cookie_alert_set_accepted_cookie
     cookie_alert_set_cookie "accepted"
  end

  # Creates the Cookie, setting the expiry time and the data value
  # @param cookie_value [string] data content of the Cookie
  def cookie_alert_set_cookie cookie_value=''
    if CookieAlert.config.cookie_type == 'permanent'
      # Set a permanent cookie
      cookies.permanent.signed[CookieAlert.config.cookie_name.to_sym] = cookie_value
    elsif CookieAlert.config.cookie_type == 'fixed_duration'
      # Set a fixed duration cookie
      cookies.signed[CookieAlert.config.cookie_name.to_sym] = { value: cookie_value, expires: CookieAlert.config.num_days_until_cookie_expires.days.from_now }
    else
      # Set a session cookie
      cookies.signed[CookieAlert.config.cookie_name.to_sym] = cookie_value
    end
  end

  # Renders the primary Alert template
  def cookie_alert_render_primary_alert
    render partial: CookieAlert.config.primary_alert_template
  end

  # Renders the secondary Alert remplate
  def cookie_alert_render_secondary_alert
    render partial: CookieAlert.config.secondary_alert_template
  end

  # Renders a blank template for those times when an Alert should not be displayed
  def cookie_alert_render_nothing
    render partial: "cookie_alert/cookies/no_response"
  end

  # Gets the number of views from the Cookie data
  def cookie_alert_get_view_count
    cookies.signed[CookieAlert.config.cookie_name.to_sym].split(CookieAlert.config.cookie_value_text_separator)[0].to_i
  end

  # Gets the visitor's current page URL from the Cookie data
  def cookie_alert_get_current_url
    cookies.signed[CookieAlert.config.cookie_name.to_sym].split(CookieAlert.config.cookie_value_text_separator)[1]
  end

end
