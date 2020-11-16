Rails.application.routes.draw do
  namespace "api" do
    namespace "v1" do
      resources :posts,  only:  [:show, :update,  :index, :create] do
        resources :comments 
      end
    end
  end
end
