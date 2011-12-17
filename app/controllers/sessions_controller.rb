class SessionsController < ApplicationController
  before_filter :pocsess,:except=>["destroy"]
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      #render :text=>Time.now and return
       user.update_attributes(:count=>user.count+1,:last_login=>Time.now)
        session[:user_id] = user.id
      if user.role_user.role.name=="admin"
         #render :text=> "Admin" and return
          redirect_to admin_logged_in_url  and return
      else
         redirect_to logged_in_url and return
      end
     
      session[:user_id] = user.id
      redirect_to logged_in_url, :notice => "Logged in!"
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end



  def pocsess
  if session[:user_id].present?
      if User.find_by_id(session[:user_id]).role_user.role.name=="admin"
        redirect_to :controller=>"admin",:action=>"index" and return
      else
         redirect_to logged_in_url and return
      end
  end

end
end
