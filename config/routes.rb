Rails.application.routes.draw do

  root "entries#index"
  resources :entries do
    resources :attachments
  end

end
