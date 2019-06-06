Rails.application.routes.draw do

  devise_for :people

	root "static_pages#welcome"

	get  "welcome" => "static_pages#welcome", as: 'welcome'
	get  "allocations" => "static_pages#allocations", as: 'allocations'
	get  "rent-report" => "rents#report", as: 'rent_report'
  get  "contractor-list" => "contractors#list", as: 'contractors_list'
  get  "upcoming-events" => "calendars#upcoming", as: 'upcoming_events'
  get  "participation" => "people#participation", as: 'participation'
  get 'contact' => 'messages#contact', as: 'new_message'
  post 'contact'=> 'messages#create', as: 'create_message'

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
