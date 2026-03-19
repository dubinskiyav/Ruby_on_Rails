Rails.application.routes.draw do
  get "about", to: "pages#about", as: :about
  get "about/mission", to: "pages#about_mission", as: :about_mission
  get "about/values", to: "pages#about_values", as: :about_values
  get "about/competencies", to: "pages#about_competencies", as: :about_competencies
  get "about/vacancies", to: "pages#about_vacancies", as: :about_vacancies
  get "about/contacts", to: "pages#about_contacts", as: :about_contacts
  get "products", to: "pages#products", as: :products
  get "products/gelicon-core/pricelist", to: "pages#product_gelicon_core_pricelist", as: :product_gelicon_core_pricelist
  get "products/:slug", to: "pages#product", as: :product, constraints: { slug: /gelicon-erp|gelicon-utilities|gelicon-conference|gelios|atlant|gelicon-core|kapital-cse/ }
  get "services", to: "pages#services", as: :services
  get "experience", to: "pages#experience", as: :experience
  get "press", to: "pages#press", as: :press
  get "support", to: "pages#support", as: :support
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "welcome#index"
end
