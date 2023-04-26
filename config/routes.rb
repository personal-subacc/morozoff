Rails.application.routes.draw do

  root 'homes#top'
  get 'about' => 'homes#about'
  get '/recipes', to: 'edamams#index'
  get 'rakutens/search'

  devise_for :admin, controllers: {
    sessions: 'admin/sessions',
    passwords: 'admin/passwords',
    registrations: 'admin/registration'
  }

  devise_for :end_users, controllers: {
    sessions: 'end_users/sessions',
    passwords: 'end_users/passwords',
    registrations: 'end_users/registrations'
  }

  resources :end_users, only: [:show, :edit, :update] do
    member do
      get :quit_confirm
    end
    patch "/hide" => "end_users#hide", as: 'hide'
  end

  resources :items, only: [:index, :show]

  resources :cart_items, only: [:index, :update, :destroy, :create] do
    collection do
      delete :destroy_all
    end
  end

  resources :addresses, only: [:index, :create, :edit, :update]

  resources :orders, only: [:index, :new, :create] do
    collection do
      post :confirm
      get :complete
    end
  end


  namespace :admin do
    get '/', to: 'homes#top'
    resources :end_users, only: [:index]
    resources :items
    resources :genres, only: [:index, :create, :edit, :update]

    resources :orders, only: [:index, :show, :update]
    resources :order_details, only: [:update]
  end

end
