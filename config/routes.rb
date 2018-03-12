Rails.application.routes.draw do

	root "static_pages#welcome"

	get  "static_pages/welcome" => "static_pages#welcome", as: 'welcome'
	get  "static_pages/allocations" => "static_pages#allocations", as: 'allocations'
	get  "static_pages/contact" => "static_pages#contact", as: 'contact'
	get  "rents/report" => "rents#report", as: 'rent_report'

  resources :properties
  resources :people
  resources :calendars
  resources :roles
  resources :jobs
  resources :rents
  resources :contractors
  resources :maintenances
  resources :worktypes
  
end
