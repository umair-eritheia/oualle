Rails.application.routes.draw do
  root 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  scope module: 'hotels' do
	  resources :base
	end

	scope module: 'cars' do
	  resources :base
	end

	scope module: 'flights' do
	  resources :base
	end
end
