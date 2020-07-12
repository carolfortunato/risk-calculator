Rails.application.routes.draw do
    resources :calculator, only: :create
end
