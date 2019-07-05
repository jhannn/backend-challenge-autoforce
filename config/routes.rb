Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :orders do
        collection do
          get 'pipeline', 'getStatus'
        end
      end
    end
  end
end
