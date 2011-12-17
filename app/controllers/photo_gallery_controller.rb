class PhotoGalleryController < ApplicationController
   
   before_filter :login_check

  def index
  	#@data=Painting.all(:conditions=>[user_id!=?])
  	@data=Painting.where("user_id!=?",session[:user_id]).paginate(:page => params[:page], :per_page => 6)
  end

  def save
   @painting=Painting.new(params[:painting])
   @painting.user_id=session[:user_id] 
   @album=Album.new  
     if @painting.save
       redirect_to :action=>"upload" and return
      else
       render "upload" and return
   end
  end

  def show_image
     @image=Painting.find_by_id(params[:id])
     @comments=@image.comments
     @comment=Comment.new
     @id=params[:id]
  end

  def add_comment
     @comment=Comment.new(params[:comment])
     @comment.user_id=session[:user_id]
     @comment.painting_id=params[:id] 
     if @comment.save
        redirect_to :action=>"show_image",:id=>params[:id],:notice => "Comment Added"
      else
        @image=Painting.find_by_id(params[:id])
        @comments=@image.comments
        #@comment=Comment.new
        @id=params[:id]
        render :action=>"show_image",:id=>params[:id],:notice => "Comment Added"
    

    end
  end

  def my_album
    @albums=Album.where("user_id=?",session[:user_id]).paginate(:page => params[:page], :per_page => 6)
    #render :text=>@albums.to_yaml and return
    #@albums.paintings.first
  end

  def save_album
      @album=Album.new(params[:album])
      @album.user_id=session[:user_id]
      @painting=Painting.new
      if @album.save
         flash[:msg]="Album Added"
         redirect_to :action=>"upload" and return
       else
        render "upload" and return
      end
  end

  def upload
     @album=Album.new
     @painting=Painting.new
  end 

  def image_list
    @data=Painting.where("album_id=?",params[:id]).paginate(:page => params[:page], :per_page => 6)
  end

  def delete_album
    Album.delete_all("id=#{params[:id]}")
    Painting.delete_all("album_id=#{params[:id]}")
    redirect_to :action=>"my_album" and return
  end

  def delete_image
      data=Painting.find(params[:id])
      Painting.delete_all("id=#{params[:id]}")     
      if data.album.paintings.count > 0
         redirect_to :action=>"image_list",:id=>data.album.id
      else
          redirect_to :action=>"my_album" and return
      end
  end


   def delete_comment
      comment=Comment.find(params[:id])
      Comment.delete_all("id=#{params[:id]}")
      redirect_to :action=>"show_image",:id=>comment.painting_id and return
   end

  #private

  def login_check
     if !session[:user_id].present? 
      # if User.find_by_id(session[:user_id]).role_user.role.name=="admin"
        redirect_to root_url, :notice => "Please login!"
      #end
     end
  end

end
