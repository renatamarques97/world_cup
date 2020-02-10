Rails.application.routes.draw do
  namespace 'api' do
    resources :rankings
    resources :results
    resources :states_tournament
    resources :teams
  end
end
