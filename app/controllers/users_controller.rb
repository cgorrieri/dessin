# coding: utf-8

class UsersController < ApplicationController
  layout :choose_layout
  before_filter :authenticate

  def authenticate
    unless user_signed_in?
      session[:user_return_to] = request.request_uri
      authenticate_user!
    end
  end

  def choose_layout
    if [:send_friend_request].include? action_name.to_sym
      'empty'
    else
      'application'
    end
  end

  def index
    @search = User.search(params[:search])
    @users = @search.all.paginate :page => @current_page, :per_page => Gallery.per_page
  end
  
  def show
    @user = User.find(params[:id])
  end

  def galleries
    @gallery = (flash['gallery'] ? flash['gallery'] : Gallery.new )
    @galleries = current_user.galleries

    render "users/galleries/galleries"
  end

  def friend_requests

  end

  def send_friend_request
    reciever = User.find(params[:id])
    unless already_requested_to?(current_user, reciever)
      unless already_requested_to?(reciever, current_user)
        unless are_friends?(current_user, reciever)
          @friend_request = FriendRequest.new()
          if params[:friend_request]
            @friend_request.sender = current_user
            @friend_request.reciever = reciever
            @friend_request.message = params[:friend_request][:message]
            if @friend_request.save
              flash.now[:notice] = "envoyé"
            else
              flash.now[:alert] = "erreur"
            end
          end
        else
          flash.now[:alert] = "vous êtes déja amis avec ce membre"
        end
      else
        flash.now[:alert] = "vous lui avez déja envoyer une demande d'amis"
      end
    else
      flash.now[:alert] = "il vous a déja envoyer une demande d'amis"
    end
  end

  def remove_friend_request
    if @f_request = FriendRequest.find_by_id(params[:id])
      if @f_request.sender == current_user or @f_request.reciever == current_use
        if @f_request.destroy
          flash[:notice] = "la demande à bien été refusé"
        else
          flash[:alert] = "erreur"
        end
      else
        flash[:alert] = "cette demande ne vous appartien pas ou ne vous est pas destinée"
      end
    else
      flash[:alert] = "cette demande n'éxiste pas"
    end
    redirect_to :friend_requests_user
  end

  def friends
    @friends = current_user.friends
  end

  def add_friend
    if params[:id]
      if friend = User.find_by_id(params[:id])
        if friend.id != current_user.id
          unless already_requested_to?(current_user, friend)
            unless are_friends?(current_user, friend)
              friend_record1 = Friend.new(:user => current_user, :fuser => friend)
              friend_record2 = Friend.new(:user => friend, :fuser => current_user)
              if friend_record1.save and friend_record2.save
                flash[:notice] = "vous etes maintenant amis avec #{friend.pseudo}"
              else
                flash[:alert] = "erreur lors de la sauvegarde"
              end
            else
              flash[:alert] = "vous etes déjà amis avec #{friend.pseudo}"
            end
          else
            flash[:alert] = "il faut que #{friend.pseudo} vous envoie une demande d'amis pour pouvoir l'accepter"
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
      if are_friends?(current_user, fuser)
        f_user = Friend.find_by_user_id_and_fuser_id(current_user.id, fuser.id)
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
