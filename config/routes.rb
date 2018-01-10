Rails.application.routes.draw do

	root "static_pages#welcome"

	get  "static_pages/welcome" => "static_pages#welcome"
	get  "static_pages/allocations" => "static_pages#allocations"
	get  "static_pages/contact" => "static_pages#contact"


  resources :properties
  resources :people
  resources :calendars
  resources :roles
  resources :jobs
  resources :rents
  resources :contractors
  resources :maintenances


end
