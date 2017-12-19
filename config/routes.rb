Rails.application.routes.draw do

	get  'static_pages/home'
	get  'static_pages/allocations'
	get  'static_pages/contact'

  resources :calendars
  resources :roles
  resources :jobs
  resources :rents
  resources :contractors
  resources :maintenances
  resources :properties
  resources :people

end
