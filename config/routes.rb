Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only:[:new, :create, :show, :index]
  resources :posts, only:[:new, :show, :destroy, :edit, :update]
  resources :subs, only: [:new, :index, :create, :show, :edit, :update] do 
    resources :posts, only:[:create]
  end
  resource :session, only: [:new, :create, :destroy]
end
