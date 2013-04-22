CookieAlert::Engine.routes.draw do

  root to: "cookies#cookie_accepted" 

  get "/", to: "cookies#cookie_accepted" , as: :cookie_accepted

end
