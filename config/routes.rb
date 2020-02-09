Rails.application.routes.draw do
  namespace 'api' do
    resources :teams
    resources :states_tournament
    resources :rankings
    resources :results
  end
end
