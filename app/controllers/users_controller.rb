# coding: utf-8

class UsersController < ApplicationController

  def index
    @search = User.search(params[:search])
    @users = @search.all.paginate :page => @current_page, :per_page => Folder.per_page
  end
  
  def show
    @user = User.find(params[:id])
  end

  def folders
    if flash["create_folder"] && flash["create_folder"] == true
      @folder = flash["folder"]
      if @folder.valid?
        @folder.user_id = current_user.id
        if @folder.save
          @folder = Folder.new
          flash.now[:notice] = "Dossier créer avec succès"
        else
          flash.now[:alert] = "une errieur est survenue lors de l'enregistrement"
        end
      end
    else
      @folder = Folder.new
    end
    @folders = current_user.folders
    
    render "users/folders/folders"
  end

  def edit
    @user = current_user
    if params[:user]
      if @user.update_attributes(params[:user])
        flash.now[:notice] = 'Folder was successfully updated.'
      end
    end
    render "users/edit"
    
  end

  def create_folder
    flash["create_folder"] = true
    flash["folder"] = Folder.new(params[:folder])
    redirect_to :controller => "users", :action => "folders"
  end

  def friends
    @friends = current_user.friends
  end
end
