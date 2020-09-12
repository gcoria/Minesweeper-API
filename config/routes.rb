Rails.application.routes.draw do
  resources :users do
    resources :games do
      member do
        put "mark/:x_axis/:y_axis" => :mark
        put "reveal/:x_axis/:y_axis" => :reveal
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
