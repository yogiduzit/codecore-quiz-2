Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :ideas
  get '/', {to: 'ideas#home', as: 'home_page'}
end
