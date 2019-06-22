Rails.application.routes.draw do
  devise_for :users, only: :omniauth_callbacks, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  scope ":locale", locale: /#{I18n.available_locales.join("|")}/ do
    get "omniauth/:provider" => "omniauth#localized", as: :localized_omniauth
    devise_for :users, skip: :omniauth_callbacks, controllers: {
      registrations: "users/registrations",
      confirmations: "users/confirmations",
    }
    resources :users, only: [:index, :show]
    resources :books
    resources :reports
    resources :comments, except: [:index, :show]
    resources :friendships, only: [:create, :destroy]
  end
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
