require "spec_helper"


# Create a Fake Controller to return a text value, simply so we can test the cookie
class FakePageController < CookieAlert::ApplicationController
  include CookieAlert

  def cookie_test
    # Call the 'display_we_use_cookies_warning?' helper method that would normally be called from the template
    display_cookie_alert
   end
end

# Add a route to the test action
begin
  _routes = Rails.application.routes
  _routes.disable_clear_and_finalize = true
  _routes.clear!
  Rails.application.routes_reloader.paths.each{ |path| load(path) }
  _routes.draw do
    get  '/fake_page/test_cookie', to: "fake_page#cookie_test"
  end
  ActiveSupport.on_load(:action_controller) { _routes.finalize! }
ensure
  _routes.disable_clear_and_finalize = false
end

# Create a verifier to encrypy/decrypt the cookie: .generate to encrypt & .verify to decrypt
verifier = ActiveSupport::MessageVerifier.new(Dummy::Application.config.secret_token)


##############
#   TESTS
##############

describe FakePageController, :type => :controller  do
  describe 'Cookie:' do

    context "valid configuration:" do
      it "can set new name" do
        CookieAlert.configure do |config|
          config.cookie_name = 'abc'
        end
        expect(CookieAlert.config.cookie_name).to eq 'abc'
      end

      it "can set user_must_accept_cookie_use to true" do
        CookieAlert.configure do |config|
          config.user_must_accept_cookie_use = true
        end
        expect(CookieAlert.config.user_must_accept_cookie_use).to eq true
      end

      it "can set user_must_accept_cookie_use to false" do
        CookieAlert.configure do |config|
          config.user_must_accept_cookie_use = false
        end
        expect(CookieAlert.config.user_must_accept_cookie_use).to eq false
      end

      it "can set use_secondary_alert to true" do
        CookieAlert.configure do |config|
          config.use_secondary_alert = true
        end
        expect(CookieAlert.config.use_secondary_alert).to eq true
      end

      it "can set use_secondary_alert to false" do
        CookieAlert.configure do |config|
          config.use_secondary_alert = false
        end
        expect(CookieAlert.config.use_secondary_alert).to eq false
      end

      it "can set max_warning_display" do
        CookieAlert.configure do |config|
          config.max_alert_display_count = 50
        end
        expect(CookieAlert.config.max_alert_display_count).to eq 50
      end

      it "can set cookie_type to session" do
        CookieAlert.configure do |config|
          config.cookie_type = 'session'
        end
        expect(CookieAlert.config.cookie_type).to eq 'session'
      end

      it "can set cookie_type to fixed_duration" do
        CookieAlert.configure do |config|
          config.cookie_type = 'fixed_duration'
        end
        expect(CookieAlert.config.cookie_type).to eq 'fixed_duration'
      end

      it "can set cookie_type to permanent" do
        CookieAlert.configure do |config|
          config.cookie_type = 'permanent'
        end
        expect(CookieAlert.config.cookie_type).to eq 'permanent'
      end

      it "can set num_days_until_cookie_expires" do
        CookieAlert.configure do |config|
          config.num_days_until_cookie_expires = 50
        end
        expect(CookieAlert.config.num_days_until_cookie_expires).to eq 50
      end

      it "can set text_separator" do
        CookieAlert.configure do |config|
          config.cookie_value_text_separator = '|||'
        end
        expect(CookieAlert.config.cookie_value_text_separator).to eq '|||'
      end

      it "can set new alert template name" do
        CookieAlert.configure do |config|
          config.primary_alert_template = 'abc'
        end
        expect(CookieAlert.config.primary_alert_template).to eq 'abc'
      end

      it "can set new reminder template name" do
        CookieAlert.configure do |config|
          config.secondary_alert_template = 'abc'
        end
        expect(CookieAlert.config.secondary_alert_template).to eq 'abc'
      end

      it "can set new JavaScript response template name" do
        CookieAlert.configure do |config|
          config.js_acceptance_template = 'abc'
        end
        expect(CookieAlert.config.js_acceptance_template).to eq 'abc'
      end

    end # End Valid Configuration Context

    context "invalid configuration:" do

      it "name will be set to a default value on setting an nil name" do
        CookieAlert.configure do |config|
          config.cookie_name = nil
        end
        expect(CookieAlert.config.cookie_name.length).to be > 1
      end

      it "user_must_accept_cookie_use will default to 'true' on setting nil" do
        CookieAlert.configure do |config|
          config.user_must_accept_cookie_use = nil
        end
        expect(CookieAlert.config.user_must_accept_cookie_use).to eq true
      end

      it "user_must_accept_cookie_use will default to 'true' on setting a non-true value" do
        CookieAlert.configure do |config|
          config.user_must_accept_cookie_use = 'abcde'
        end
        expect(CookieAlert.config.user_must_accept_cookie_use).to eq true
      end

      it "max_warning_display will default to a positive integer on setting nil" do
        CookieAlert.configure do |config|
          config.max_alert_display_count = nil
        end
        expect(CookieAlert.config.max_alert_display_count).to be > 0
      end

      it "max_warning_display will default to a positive integer setting a negative value" do
        CookieAlert.configure do |config|
          config.max_alert_display_count = -5
        end
        expect(CookieAlert.config.max_alert_display_count).to be > 0
      end

      it "cookie_type will default to 'session' on setting nil" do
        CookieAlert.configure do |config|
          config.cookie_type = nil
        end
        expect(CookieAlert.config.cookie_type).to eq 'session'
      end

      it "cookie_type will default to 'session' on setting an invalid value" do
        CookieAlert.configure do |config|
          config.cookie_type = 'abcde'
        end
        expect(CookieAlert.config.cookie_type).to eq 'session'
      end

      it "num_days_until_cookie_expires will default to a positive integer on setting nil" do
        CookieAlert.configure do |config|
          config.num_days_until_cookie_expires = nil
        end
        expect(CookieAlert.config.num_days_until_cookie_expires).to be > 0
      end

      it "num_days_until_cookie_expires will default to a positive integer setting a negative value" do
        CookieAlert.configure do |config|
          config.num_days_until_cookie_expires = -5
        end
        expect(CookieAlert.config.num_days_until_cookie_expires).to be > 0
      end

      it "text_separator will be set to a default value on setting an nil name" do
        CookieAlert.configure do |config|
          config.cookie_value_text_separator = nil
        end
        expect(CookieAlert.config.cookie_value_text_separator.length).to be > 1
      end

      it "cookie alert template name will be set to a default value on setting it to nil" do
        CookieAlert.configure do |config|
          config.primary_alert_template = nil
        end
        expect(CookieAlert.config.primary_alert_template.length).to be > 1
      end

      it "cookie reminder template name will be set to a default value on setting it to nil" do
        CookieAlert.configure do |config|
          config.secondary_alert_template = nil
        end
        expect(CookieAlert.config.secondary_alert_template.length).to be > 1
      end

      it "JavaScript response template name will be set to a default value on setting it to nil" do
        CookieAlert.configure do |config|
          config.js_acceptance_template = nil
        end
        expect(CookieAlert.config.js_acceptance_template.length).to be > 1
      end

      it "use_secondary_alert will default to 'true' on setting nil" do
        CookieAlert.configure do |config|
          config.use_secondary_alert = nil
        end
        expect(CookieAlert.config.use_secondary_alert).to eq true
      end

      it "use_secondary_alert will default to 'true' on setting a non-true value" do
        CookieAlert.configure do |config|
          config.use_secondary_alert = 'abcde'
        end
        expect(CookieAlert.config.use_secondary_alert).to eq true
      end

    end # End Invalid Configuration Context

    context "view count:" do

      it "will have a count of 1 on first placing the cookie" do
        get :cookie_test
        cookie_data = verifier.verify(response.cookies[CookieAlert.config.cookie_name])
        view_count = cookie_data.split(CookieAlert.config.cookie_value_text_separator)[0].to_i
        expect(view_count).to eq 1
      end

       it "will increment the view_count by 1" do
         CookieAlert.config.max_alert_display_count = 30
         cookie_value = verifier.generate("25" << CookieAlert.config.cookie_value_text_separator << 'http://dummy_url.com')
         request.cookies[CookieAlert.config.cookie_name.to_sym] = cookie_value
         get :cookie_test
         cookie_data = verifier.verify(response.cookies[CookieAlert.config.cookie_name])
         view_count = cookie_data.split(CookieAlert.config.cookie_value_text_separator)[0].to_i
         expect(view_count).to eq 26
       end

      it "will change to 'accepted' when the max view counts have been reached" do
         CookieAlert.config.user_must_accept_cookie_use = false
         CookieAlert.config.use_secondary_alert = false
         CookieAlert.config.max_alert_display_count = 30
         cookie_value = verifier.generate("30" << CookieAlert.config.cookie_value_text_separator << 'http://dummy_url.com')
         request.cookies[CookieAlert.config.cookie_name.to_sym] = cookie_value
         get :cookie_test
         cookie_data = verifier.verify(response.cookies[CookieAlert.config.cookie_name])
         expect(cookie_data).to eq 'accepted'
       end

    end # End View Count Context

  end # End Describe Cookie

  describe "page rendered:" do

    context "user must accept with no reminder view:" do

      it "Should render the primary alert template" do
        CookieAlert.config.user_must_accept_cookie_use = true
        CookieAlert.config.use_secondary_alert = false
        CookieAlert.config.max_alert_display_count = 30
        cookie_value = verifier.generate("777" << CookieAlert.config.cookie_value_text_separator << 'http://dummy_url.com')
        request.cookies[CookieAlert.config.cookie_name.to_sym] = cookie_value

        template_parts = CookieAlert.config.primary_alert_template.split("/")
        num_parts = template_parts.size
        template_parts[num_parts-1] = "_" + template_parts[num_parts-1]
        expected_template = template_parts.join("/")
        get :cookie_test
        expect(response).to render_template expected_template
      end

    end # End user must accept with no reminder view Context 

    context "user must accept with reminder view:" do

      it "Should render the full alert template below the maximum full alert diaply count" do
        CookieAlert.config.user_must_accept_cookie_use = true
        CookieAlert.config.use_secondary_alert = true
        CookieAlert.config.max_alert_display_count = 30
        cookie_value = verifier.generate("29" << CookieAlert.config.cookie_value_text_separator << 'http://dummy_url.com')
        request.cookies[CookieAlert.config.cookie_name.to_sym] = cookie_value

        template_parts = CookieAlert.config.primary_alert_template.split("/")
        num_parts = template_parts.size
        template_parts[num_parts-1] = "_" + template_parts[num_parts-1]
        expected_template = template_parts.join("/")
        get :cookie_test
        expect(response).to render_template expected_template
      end

      it "Should render the reminder template above the maximum full alert diaply count" do
        CookieAlert.config.user_must_accept_cookie_use = true
        CookieAlert.config.use_secondary_alert = true
        CookieAlert.config.max_alert_display_count = 30
        cookie_value = verifier.generate("30" << CookieAlert.config.cookie_value_text_separator << 'http://dummy_url.com')
        request.cookies[CookieAlert.config.cookie_name.to_sym] = cookie_value

        template_parts = CookieAlert.config.secondary_alert_template.split("/")
        num_parts = template_parts.size
        template_parts[num_parts-1] = "_" + template_parts[num_parts-1]
        expected_template = template_parts.join("/")
        get :cookie_test
        expect(response).to render_template expected_template
      end

    end # End user must accept with no reminder view Context 


    context "user does not need to accept:" do

      it "Should render the full alert template below the maximum full alert diaply count" do
        CookieAlert.config.user_must_accept_cookie_use = false
        CookieAlert.config.max_alert_display_count = 30
        cookie_value = verifier.generate("29" << CookieAlert.config.cookie_value_text_separator << 'http://dummy_url.com')
        request.cookies[CookieAlert.config.cookie_name.to_sym] = cookie_value

        template_parts = CookieAlert.config.primary_alert_template.split("/")
        num_parts = template_parts.size
        template_parts[num_parts-1] = "_" + template_parts[num_parts-1]
        expected_template = template_parts.join("/")
        get :cookie_test
        expect(response).to render_template expected_template
      end

      it "Should render the no_response template above the maximum full alert diaply count" do
        CookieAlert.config.user_must_accept_cookie_use = false
        CookieAlert.config.max_alert_display_count = 30
        cookie_value = verifier.generate("30" << CookieAlert.config.cookie_value_text_separator << 'http://dummy_url.com')
        request.cookies[CookieAlert.config.cookie_name.to_sym] = cookie_value

        get :cookie_test
        expect(response).to render_template "cookie_alert/cookies/_no_response"
      end

    end # End user must accept with no reminder view Context 

  end # End Describe Page Rendered
end # End describe FakePageController
