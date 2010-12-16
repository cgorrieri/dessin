# coding: utf-8

class GalleriesController < ApplicationController
  before_filter :authenticate, :only => [:new, :create, :uptade, :edit, :destroy]

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
    end
  end

  # GET /galleries/1
  def show
    @gallery = Gallery.find(params[:id])
    @drawings = @gallery.drawings.reverse
  end

  # GET /galleries/new
  def new
    @gallery = Gallery.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # POST /galleries
  def create
    # params[:keywords] => hash {"keyword" => "keyword", ...}
    @gallery = Gallery.new(params[:gallery])
    @gallery.keywords = keywords_string(params[:keywords])
    if @gallery.valid?
      @gallery.user_id = current_user.id
      if @gallery.save
        @gallery = Gallery.new
        flash[:notice] = "Gallery created succesfully"
      else
        flash[:alert] = "an error has encoutered in creating"
      end
    else
      flash['gallery'] = @gallery
    end
    redirect_to galleries_user_path
  end

  def edit
    @media = Media.new
    @gallery = Gallery.find(params[:id])
    @drawings = @gallery.drawings.reverse
    
    if current_user && @gallery.user.id == current_user.id
      render "users/galleries/edit"
    else
      redirect_to @gallery, :alert => "You're not allowed to edit this gallery"
    end
  end

  # PUT /galleries/1
  def update
    if @gallery = current_user.galleries.find_by_id(params[:id])
      if @gallery.update_attributes(params[:gallery].merge!({:keywords => keywords_string(params[:keywords])}))
        redirect_to(edit_gallery_path(@gallery), :notice => 'Gallery was successfully updated.')
      else
        redirect_to(edit_gallery_path(@gallery), :alert => 'Error in update')
      end
    else
      redirect_to galleries_user_path, :alert => "This gallery don't exist or is not your's"
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
    redirect_to galleries_user_path
  end


  def add_media
    @gallery = current_user.galleries.find(params[:id])
    if params[:media]
      media = @gallery.drawings.create(params[:media])
      if media.save
        flash[:notice] = "drawing added succesfully"
      else
        flash[:alert] = "an error has encoutered in uploading"
      end
    end
    redirect_to edit_gallery_path(@gallery)
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
    redirect_to edit_gallery_path(@gallery)
  end

  def keywords_string(keywords_hash = nil)
    keywords_hash.map { |key, value| key}.join(',')
  end
end
