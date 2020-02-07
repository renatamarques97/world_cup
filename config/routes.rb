Rails.application.routes.draw do
  namespace 'api' do
    resources :teams
    resources :tournaments
    resources :rankings
    resources :results
  end
end
