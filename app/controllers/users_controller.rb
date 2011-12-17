class UsersController < ApplicationController
  
before_filter :pocsess,:except=>["destroy"]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.count=0
    if @user.save
      @user.update_attributes(:count=>@user.count+1,:last_login=>Time.now)
      session[:user_id] = @user.id
      RoleUser.create(:user_id=>@user.id,:role_id=>2)
      #redirect_to root_url, :notice => "Signed up!"
      redirect_to logged_in_url and return
    else
      render "new"
    end
  end
private

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
