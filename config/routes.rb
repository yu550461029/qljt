Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'scores#index'
  resources :employees do
    collection do
      post 'upload', to: 'employees#upload'
    end
  end
  resources :grades do
    collection do
      get 'grade'
    end
  end
  resources :teams do
    collection do
      get 'position'
      post 'team_relation_save', to: 'teams#team_relation_save'
      post 'employee_relation_save', to: 'teams#employee_relation_save'
      get 'export_license', to: 'teams#export_license'
    end
  end
  post 'reset_license', to: 'licenses#reset_license'
  resources :scores do
    collection do
      post 'get_score_list', to: 'scores#get_score_list'
      post 'save_team_score', to: 'scores#save_team_score'
      post 'save_employee_score', to: 'scores#save_employee_score'
      get 'success', to: 'scores#success'
    end
  end
end
