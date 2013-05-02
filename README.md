# CookieAlert (beta)

CookieAlert will add an alert to your webpage informing your visitor that your website uses Cookies. It can be configured to display the Alert for a fixed 
number of views, or display it constantly until the visitor 'accepts' the alert. It:

* Will work 'straight out the box' without any additional configuration
* Is fully customisable, including views, javascript response and number of displays.
* Aims to be a simple way to address the [EU Cookie Law](http://www.ico.org.uk/for_organisations/privacy_and_electronic_communications/the_guide/cookies) requiring websites to notify their visitors that they use Cookies.

## Install

1.  Update `Gemfile` to add

    ```Ruby
      gem "cookie_alert"
    ```


2. Run bundle

    ```bash
    bundle install
    ```

3. Install the configuration & view files

    ```bash
    rails g cookie_alert:install
    ```
4. Update your `app/helpers/application_helper.rb` file to include the CookieAlert module:

    ```Ruby
      include CookieAlert
    ```

5. Update your `config/routes.rb` file to add the CookieAlert route:

    ```Ruby
      mount CookieAlert::Engine => "/cookie-alert"
    ```

6. Update your Asset Manifest files to add the JavaScript and CSS files:

    * in application.js add 

        ```Ruby
        //= require cookie_alert
        ```

    * in application.css add 

        ```Ruby
        *= require cookie_alert
        ```

## Uninstall

To remove the installed files run `rails g cookie_alert:uninstall`

## Displaying Alerts


To display the Cookie Alerts, simply call the following method from your layout `<%= display_cookie_alert %>`

## How It Works

When a visitor first comes to your site CookieAlert will set an encrypted Cookie that keeps track of how many pages the visitor has viewed and display a 
Primary Alert notifying the visitor that your site uses Cookies. By default this Primary Alert is a large banner fixed at the foot of the screen.

After the Primary Alert has been displayed a number of times (5 by default) it is replaced by a Secondary Alert. By default this is a smaller box fixed to 
the bottom-left of the screen which transforms back to the the large banner when moused-over.

The visitor can click a link to 'hide the banner', thereby accepting the notice, and the Alerts will no longer be displayed for the remainder of the session.


## Configuration

CookieAlert can be configured to:

* Display a Primary Alert message until the visitor clicks the 'accept' link.
* Display a Primary Alert message which, after a number of views, changes to a Secondary Alert message until the visitor clicks the 'accept' link.
* Display a Primary Alert message then, after a number of views, stop showing any alert messages at all.

Please [check the WIKI](http://katanacode.com/cookie_alert/wiki) for a full list of the configuration options available.

## JavaScript

The default Alerts use JQuery to allow a server-side response and to add effects.  You can easily change this to use a different JavaScript framework 
(or none at all!). [Check the WIKI](https://github.com/KatanaCode/cookie_alert/wiki) to see how.

## IMPORTANT

  If you are using CookieAlert to address the [EU Cookie Law](http://www.ico.org.uk/for_organisations/privacy_and_electronic_communications/the_guide/cookies), 
  then within the Alert message you should also include a link to a Cookie Policy page where your visitors can view a description of the cookies used by 
  your site. See [KatanaCode.com](http://katanacode.com) for an example.

  Note that CookieAlert is designed to allow you to display alerts - **the content and wording of the alert is entirely your own responsibility**. 
  KatanaCode do not warrant in any way that the default message, operation or usage of this Gem will make you compliant with the EU Cookie Law. 
  It is up to you to ensure compliance!

  All we can say is that we use it ourselves.

## Issues

If you discover a problem with CookieAlert, please let us know about it. 

**Remember** to search the [issues list](https://github.com/KatanaCode/cookie_alert/issues) first in case your issue has already been raised
by another Githuber

## Documentation

Full documentation is available here: http://rubydoc.info/gems/cookie_alert

## Contributing

You're welcome to contribute to CookieAlert. Please consult the [contribution guidelines](https://github.com/KatanaCode/cookie_alert/wiki/Contributing) 
for more info.

## Legal Stuff

Copyright 2013 [Katana Code Ltd.](http://katanacode.com)

See MIT-LICENSE for full details.

## Credits

Developed by [CodeMeister](http://github.com/CodeMeister) at [Katana Code Ltd](http://katanacode.com)

## About Katana Code

Katana Code are [iPhone app and Ruby on Rails Developers in Edinburgh, Scotland](http://katanacode.com/ "Katana Code").