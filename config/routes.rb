Rails.application.routes.draw do
  resources :venueadmins do
    resources :venues do
      resources :categorys do
        resources :photos
      end
    end
  end
end
