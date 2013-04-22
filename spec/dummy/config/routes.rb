Rails.application.routes.draw do

  mount CookieAlert::Engine => "/cookie-alert"

  get '/welcome', to: "welcome#index"
  root to: "welcome#index"
  
end
