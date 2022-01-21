Rails.application.routes.draw do
  resources :users do
    resources :subs, only:[:create, :edit, :update, :new]
  end
  resource :session
  resources :subs, except:[:create, :edit, :update, :new]
  resources :posts, except:[:index]
end 



