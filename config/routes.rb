Rails.application.routes.draw do
  get '/projects/:id', to: 'projects#show'
  get '/contestants', to: 'contestants#index'
  post '/projects/:id/contestants', to: 'contestant_projects#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
