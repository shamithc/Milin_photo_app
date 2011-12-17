class AdminController < ApplicationController

 before_filter :login_check
  def index
  	@users=User.all(:order=>"created_at")
  end

  def user
    @user=User.find_by_id(params[:id])
  end

  def remove_user
    user=User.find_by_id(params[:id])
    Painting.delete_all("user_id=#{params[:id]}")
    Album.delete_all("user_id=#{params[:id]}") 
    user.delete
    redirect_to :action=>"index" and return
  end

   def my_album
    @albums=Album.where("user_id=?",params[:id]).paginate(:page => params[:page], :per_page => 8)
    #render :text=>@albums.to_yaml and return
    #@albums.paintings.first
  end

  def image_list
    @data=Painting.where("album_id=?",params[:id]).paginate(:page => params[:page], :per_page => 8)
  end

  def delete_album
     Album.delete_all("id=#{params[:id]}")
     Painting.delete_all("album_id=#{params[:id]}")
     redirect_to admin_logged_in_url and return
  end

  def show_image
     @image=Painting.find_by_id(params[:id])
     @comments=@image.comments
     @comment=Comment.new
     @id=params[:id]
  end

 
  def delete_image
     Painting.delete_all("id=#{params[:id]}")
     redirect_to admin_logged_in_url and return
  end

  def delete_comment
      comment=Comment.find(params[:id])
      Comment.delete_all("id=#{params[:id]}")
      redirect_to :action=>"show_image",:id=>comment.painting_id and return
  end


  def login_check
     if !session[:user_id].present?
      # if User.find_by_id(session[:user_id]).role_user.role.name=="admin"
        redirect_to root_url, :notice => "Please login!"
      #end
     end
  end



end
