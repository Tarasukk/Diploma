Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get 'service-worker' => 'rails/pwa#service_worker', as: :pwa_service_worker
  get 'manifest' => 'rails/pwa#manifest', as: :pwa_manifest

  # Defines the root path route ("/")
  root 'home#index'

  resource :profile, only: %i[show]
  resources :courses, only: %i[index show]
  resources :schedule_events, only: %i[create destroy]
  resources :course_materials, only: %i[show] do
    member do
      put :update_file
      delete :remove_file
    end
  end
  resources :course_sections, only: %i[create]
  resources :course_material_submissions, only: %i[create]
  resources :submission_comments, only: %i[create destroy]

  namespace :system do
    resources :course_material_submissions, only: %i[index show] do
      member do
        post :grade
      end
    end

    get 'course_builder', to: 'courses#builder'
    post 'course_builder/create_course', to: 'courses#create_course'
    post 'course_builder/create_section', to: 'courses#create_section'
    post 'course_builder/create_material', to: 'courses#create_material'
  end
end
