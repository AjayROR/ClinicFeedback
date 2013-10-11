Authentication::Application.routes.draw do

  resources :tests


 # get "password_reset/new"
 get 'users/doc_request', :as => 'request'
resources :manual_resets
resources :departments    
resources :users 
resources :sessions 
resources :password_resets

resources :feedbacks do
   resources :comments
end

resources :users do
	member do
		post :activate_my_doctor 
		delete :remove_doctor
	end
end

  resources :feedbacks do
   	 member do
   	         get :search_feedback
      end
  end

  resources :users do
    member do
      post :update_password
    end
  end
 
#<%= form_tag(find_token_feedback_path(:id), :method => :get) do %>
# resources :users do
# 	member do 
# 		 post :manual_password_reset 
# 	end
# end

match '/feedbackresult' => 'feedbacks#searchedfeedback' 
match '/reset' => 'users#manual_reset'
match '/signout' => 'sessions#destroy'
match '/thankyou' => 'feedbacks#thankyou', :as => 'thankyou'
 match '/patient' => 'feedbacks#info', :as => 'patient'
 match '/new_doc_list' => 'users#doc_request', :as => 'newdoc'


 match '/testy' => 'feedbacks#test1'
 #match '/request'  => 'users#request'
 #match '/doc_request', to: 'users#request', :as => 'request'
root :to => "users#new"
 
  #match '*', :to => "feedbacks#routing_error"
 match '/:anything', :to => "feedbacks#routing_error", :constraints => { :anything => /.*/ }
 
end