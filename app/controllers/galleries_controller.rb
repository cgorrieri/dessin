# coding: utf-8

class GalleriesController < ApplicationController
  before_filter :authenticate, :only => [:create, :uptade, :edit, :destroy]

  def authenticate
    unless user_signed_in?
      session[:user_return_to] = request.request_uri
      authenticate_user!
    end
  end

  # GET /galleries
  def index
    @search = Gallery.search(params[:search])
    @galleries = @search.all.paginate :page => @current_page, :per_page => Gallery.per_page

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @galleries }
    end
  end

  # GET /galleries/1
  def show
    @media = Media.new
    @gallery = Gallery.find(params[:id])
    @drawings = @gallery.drawings.reverse

    if current_user && @gallery.user.id == current_user.id
      render "users/galleries/edit"
    else
      render
    end
  end

  # GET /galleries/new
  def new
    @gallery = Gallery.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @gallery }
    end
  end

  # POST /galleries
  def create
    @gallery = Gallery.new(params[:gallery])
    if @gallery.valid?
      @gallery.user_id = current_user.id
      if @gallery.save
        @gallery = Gallery.new
        flash[:notice] = "Dossier créer avec succès"
      else
        flash[:alert] = "une errieur est survenue lors de l'enregistrement"
      end
    else
      flash['gallery'] = @gallery
    end
    redirect_to :controller => "users", :action => "galleries"
  end

  # PUT /galleries/1
  def update
    if @gallery = current_user.galleries.find_by_id(params[:id])
      if @gallery.update_attributes(params[:gallery])
        redirect_to(@gallery, :notice => 'Gallery was successfully updated.')
      else
        render :action => "edit"
      end
    else
      edirect_to :controller => "users", :action => "galleries", :alert => "This gallery don't exist or is not your's"
    end
  end

  def destroy
    if @gallery = current_user.galleries.find_by_id(params[:id])
      if @gallery.destroy
        flash[:notice] = "Gallery was deleted sucessfully"
      else
        flash[:alert] = "Gallery can't be deleted"
      end
    else
      flash[:alert] = "This gallery not exist or is not your own"
    end
    redirect_to :controller => "users", :action => "galleries"
  end


  def add_media
    @gallery = current_user.galleries.find(params[:id])
    if params[:media]
      media = @gallery.drawings.create(params[:media])
      if media.save
        flash.now[:notice] = "dessin ajoutée avec succès"
      else
        flash.now[:alert] = "l'upload a rencontré une erreur"
      end
    end
    redirect_to :action => :show
  end

  def remove_media
    @gallery = current_user.galleries.find(params[:id])
    if params[:media_id]
      media = @gallery.drawings.find(params[:media_id])
      if media.destroy
        flash[:notice] = "image supprimée avec succès"
      else
        flash[:alert] = "la suppression a échoué"
      end
    end
    redirect_to :action => :show, :anchor => "test"
  end
    
end
