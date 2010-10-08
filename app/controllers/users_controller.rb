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

  def add_friend
    if params[:id]
      if friend = User.find_by_id(params[:id])
        if friend.id != current_user.id
          unless Friend.find_by_user_id_and_fuser_id(current_user.id, friend.id)
            friend_record1 = Friend.new(:user => current_user, :fuser => friend)
            friend_record2 = Friend.new(:user => friend, :fuser => current_user)
            if friend_record1.save and friend_record2.save
              flash[:notice] = "vous etes maintenant amis avec #{friend.pseudo}"
            else
              flash[:alert] = "erreur lors de la sauvegarde"
            end
          else
            flash[:alert] = "vous etes déjà amis avec ce membre"
          end
        else
          flash[:alert] = "Vous ne pouvais pas être amis avec vous même"
        end
      else
        flash[:alert] = "erreur ce membre n'existe pas"
      end
    end
    redirect_to :friends_user
  end

  def remove_friend
    if fuser = User.find_by_id(params[:id])
      if f_user = Friend.find_by_user_id_and_fuser_id(current_user.id, fuser.id)
        f_friend = Friend.find_by_user_id_and_fuser_id(fuser.id, current_user.id)
        logger.debug f_friend
        if f_user.delete and f_friend.delete
          flash[:notice] = "vous n'êtes desormais plus amis avec #{fuser.pseudo}"
        else
          flash[:alert] = "erreur lors de la suppriession de votre lien d'amitié"
        end
      else
        flash[:alert] = "vous êtes pas amis avec ce membre"
      end
    else
      flash[:alert] = "erreur ce membre n'existe pas"
    end
    redirect_to :friends_user
  end
end
