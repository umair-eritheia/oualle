Rails.application.routes.draw do
  root 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/search', to: 'home#search'
  get '/terms_of_service', to: 'home#terms_of_service'
  get '/privacy_policy', to: 'home#privacy_policy'
  get '/about_us', to: 'home#about_us'
  get '/contact_us', to: 'home#contact_us'
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
