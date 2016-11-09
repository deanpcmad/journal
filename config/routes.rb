Rails.application.routes.draw do

  resources :events
  resources :tests
  root "entries#index"
  resources :entries do
    resources :attachments
  end

end
