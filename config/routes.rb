Rails.application.routes.draw do
  namespace 'api' do
    resources :rankings, only: :index
    resources :results, only: :create
    resources :states_tournament, only: :index
    resources :tournaments, only: :create
  end
end
