Rails.application.routes.draw do
  resources :users do
    resources :subs, only:[:create, :edit, :update]
  end
  resource :session
  resources :subs, except:[:create, :edit, :update]
  resources :posts, execpt:[:index]
end 



