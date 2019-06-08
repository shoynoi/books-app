Rails.application.routes.draw do
  scope ":locale", locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users, controllers: { registrations: "users/registrations" }
    resources :users, only: [:index, :show]
    resources :books
    resources :reports
    resources :comments, except: [:index, :show]
  end
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
