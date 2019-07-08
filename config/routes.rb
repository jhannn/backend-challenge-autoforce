Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :orders do
        collection do
          get 'pipeline', 'status', 'financialReport'
        end
      end
      resources :batches do
        collection do
          patch 'produce', 'sent'
        end
      end
    end
  end
end
