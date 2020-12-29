Rails.application.routes.draw do
  

  namespace :api do
  	# resources :orders
  	post '/robot/:robot_id/orders', to: 'orders#order'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
