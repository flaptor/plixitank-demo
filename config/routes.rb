PlixitankDemo::Application.routes.draw do
    resources :home, :only => [:index]
    root :to => 'home#home'
end
