require 'spec_helper'

# Create a verifier to encrypy/decrypt the cookie: .generate to encrypt & .verify to decrypt
verifier = ActiveSupport::MessageVerifier.new(Dummy::Application.config.secret_token)

describe CookieAlert::CookiesController do

before do
  @routes = CookieAlert::Engine.routes
end

  context "GET Request:" do

    it "redirects the user to the URL within the cookie" do
      cookie_value = verifier.generate("30" << CookieAlert.config.cookie_value_text_separator << 'http://dummy_url.com')
      request.cookies[CookieAlert.config.cookie_name.to_sym] = cookie_value
      get :cookie_accepted
      expect(response).to redirect_to 'http://dummy_url.com'
    end

    it "will change the cookie value to 'accepted'" do
       cookie_value = verifier.generate("30" << CookieAlert.config.cookie_value_text_separator << 'http://dummy_url.com')
       request.cookies[CookieAlert.config.cookie_name.to_sym] = cookie_value
       get :cookie_accepted
       cookie_data = verifier.verify(response.cookies[CookieAlert.config.cookie_name])
       expect(cookie_data).to eq 'accepted'
     end

  end # End GET Context

  context "JavaScript Request" do

    it "renders the JavaScript reposnse template" do
      cookie_value = verifier.generate("30" << CookieAlert.config.cookie_value_text_separator << 'http://dummy_url.com')
      request.cookies[CookieAlert.config.cookie_name.to_sym] = cookie_value
      get :cookie_accepted, :format => 'js'
      expect(response).to render_template CookieAlert.config.js_acceptance_template
    end

    it "will change the cookie value to 'accepted'" do
       cookie_value = verifier.generate("30" << CookieAlert.config.cookie_value_text_separator << 'http://dummy_url.com')
       request.cookies[CookieAlert.config.cookie_name.to_sym] = cookie_value
       get :cookie_accepted, :format => 'js'
       cookie_data = verifier.verify(response.cookies[CookieAlert.config.cookie_name])
       expect(cookie_data).to eq 'accepted'
     end

  end

end # End describe WelcomeController
