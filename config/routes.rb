Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :orders do
        collection do
          get 'pipeline', 'getStatus', 'financialReport'
        end
      end
      resources :batches do
        collection do
          get 'orders'
          patch 'produceBatch', 'sentBatch'
        end
      end
    end
  end
end
