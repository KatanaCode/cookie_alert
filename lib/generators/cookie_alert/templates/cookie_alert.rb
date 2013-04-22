CookieAlert.configure do |config|
  
  # COOKIE NAME: 
  #
  # INFO: The name of the cookie to be saved on the Visitor's browser
  #
  # TYPE   : String
  #
  # VALUES :  At least four sequential characters with no spaces.  Stick to Alphanumeric, '-' and '_'
  #
  # DEFAULT: '_we_use_cookies'
  #
  config.cookie_name = '_we_use_cookies'

  
  # COOKIE TYPE: 
  #
  # INfO: This is the type of cookie that should be placed on the Visitor's browser type of
  #      being automatically removed.
  #
  # TYPE   : String
  #
  # VALUES : 'session'        -> The cookie will only last as long as the Visitor's browsing session
  #          'fixed_duration' -> The cookie will live for a fixed number of days or until the Visitor manually deletes it
  #          'permanent'      -> The cookie will live indefinately until the Visitor manually deletes it
  #
  # DEFAULT: 'session'
  #
  config.cookie_type = 'session'


  # NUM DAYS UNTIL COOKIE EXPIRES: 
  #
  # INfO: This is the number of days the cookie should remain valid on the Visito's browser
  #
  # TYPE   : Integer
  #
  # VALUES : Any integer value greater than 1 
  #
  # DEFAULT: 60
  #
  # REQUIRES: config.cookie_type = 'fixed_duration'
  #
  config.num_days_until_cookie_expires = 60
  
  
  # USER MUST ACCEPT COOKIE USE: 
  #
  # INfO: This determines whether the Visitor MUST click a link accepting the warning 
  #      OR whether the warning message will automatically dissapear after a set number of displays.
  #
  # 
  # TYPE   : Boolean
  #
  # VALUES : TRUE  -> if the Visitor MUSt accept the warning
  #          FALSE -> if the Warning should be removed after being  displayed a specific number of times
  #
  # DEFAULT: TRUE
  #
  # WARNING: If set to TRUE you MUST include a link for the Visitor to click, accepting the Warning.
  #          Link path = cookie_alert_acceptance_path
  #
  config.user_must_accept_cookie_use = true
  
  
  # USE SECONDARY ALERT: 
  #
  # INfO: If you have selected that the Visitor MUST accept cookies, you then have the option to
  #      display a secondary alert after viewing the primary alert for a specific number of times
  # 
  # TYPE   : Boolean
  #
  # VALUES : TRUE  -> The secondary Alert template will be rendered after a specific number of primary Alert displays
  #          FALSE -> The primary Alert template will always be rendered
  #
  # DEFAULT: TRUE
  #
  # NOTE: max_alert_display_count determines how many time the primary Alert should be displayed before rendering the reminder template
  #
  # REQUIRES: user_must_accept_cookie_use = TRUE
  #           max_alert_display_count > 1
  #
  config.use_secondary_alert = true
  

  # MAX ALERT DISPLAY COUNT: 
  #
  # INfO: This is the number of times the primary Alert should be displayed before
  #      either switching to the secondary alert or hiding any alert.
  #
  # TYPE   : Integer
  #
  # VALUES : Any integer value greater than 2 to allow for an initial redirect_to 
  #
  # DEFAULT: 5
  #
  # WARNING: A 'redirect_to' from a controller will result in the view count incrementing twice in succession
  #
  config.max_alert_display_count = 5


  # COOKIE VALUE TEXT SEPARATOR: 
  #
  # INfO: This is the character sequence used to separate multiple values stored in the cookie
  #        This only need changed if you use the default value and part of your routing table.
  #
  # TYPE   : String
  #
  # VALUES : At least two sequential Alphanumeric charaters 
  #
  # DEFAULT: '~~'
  #
  config.cookie_value_text_separator = "~~"

  
  # PRIMARY ALERT TEMPLATE: 
  #
  # INfO: The name of the the view to be rendered for the Primary Alert
  #
  # TYPE   : String
  #
  # VALUES :  Name of the View Template
  #
  # DEFAULT: 'cookie_alert/cookies/primary_alert'
  #
  config.primary_alert_template = 'cookie_alert/cookies/primary_alert'

  
  # SECONDARY ALERT TEMPLATE: 
  #
  # INfO: The name of the the view to be rendered for the Secondary Alert
  #
  # TYPE   : String
  #
  # VALUES :  Name of the View Template
  #
  # DEFAULT: 'cookie_alert/cookies/secondary_alert'
  #
  config.secondary_alert_template = 'cookie_alert/cookies/secondary_alert'

  
  # COOKIE JavaScript ACCEPTANCE RESPONSE: 
  #
  # INfO: The name of the the view to be rendered for a Javascript Response
  #       to the cookie being accepted
  #
  # TYPE   : String
  #
  # VALUES :  Name of the JavaScript View Template
  #
  # DEFAULT: 'cookie_alert/cookies/cookie_accepted'
  #
  config.js_acceptance_template = 'cookie_alert/cookies/cookie_accepted'
 
end
