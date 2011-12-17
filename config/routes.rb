Auth::Application.routes.draw do
  get "admin/index"

  get "photo_gallery/index"

  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"
  root :to => "sessions#new"
  resources :users
  resources :sessions
  resources :photo_gallery do
  	collection do
  	 get 'index'
         post 'save'
         get  'show_image'
         post 'add_comment'
         get 'my_album'
         post 'save_album'
         get 'upload'
         get 'image_list'
         get 'delete_album'
         get 'delete_image'
         get 'delete_comment'
  	end
  end

  resources :admin do
    collection do
       get 'index'
       get 'user'
       get 'delete'
       get 'my_album'
       get 'remove_user'
       get 'image_list'
       get  'show_image'
       get 'delete_album'
       get 'delete_image'
       get 'show_image'
       get 'delete_comment'
    end
  end
 
  match 'admin_logged_in' => 'admin#index',:as=> 'admin_logged_in'
  match 'photo_gallery' =>"photo_gallery#index",:as=> "logged_in"
  get "secret" => "secret#index"
end
