Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "authentication#defaultAction"
  
  # AuthenticationController
  post 'signup', to: 'authentication#signup'
  post 'authenticate', to: 'authentication#authenticate'

  # User Controller
  get 'user/:uId', to: 'user#getUser'

end
