# coding: utf-8

class FoldersController < ApplicationController
  # GET /folders
  # GET /folders.xml
  def index
    @search = Folder.search(params[:search])
    @folders = @search.all.paginate :page => @current_page, :per_page => Folder.per_page

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @folders }
    end
  end

  # GET /folders/1
  # GET /folders/1.xml
  def show
    @media = Media.new
    @folder = Folder.find(params[:id])
    @drawings = @folder.drawings.reverse

    if current_user && @folder.user.id == current_user.id
      render "users/folders/edit"
    else
      render
    end
  end

  # GET /folders/new
  # GET /folders/new.xml
  def new
    @folder = Folder.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @folder }
    end
  end

  # GET /folders/1/edit
  def edit
    @folder = current_user.folders.find(params[:id])
  end

  # POST /folders
  # POST /folders.xml
  def create
    @folder = Folder.new(params[:folder])

    respond_to do |format|
      if @folder.save
        format.html { redirect_to(@folder, :notice => 'Folder was successfully created.') }
        format.xml  { render :xml => @folder, :status => :created, :location => @folder }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @folder.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /folders/1
  # PUT /folders/1.xml
  def update
    @folder = current_user.folders.find(params[:id])

    respond_to do |format|
      if @folder.update_attributes(params[:folder])
        format.html { redirect_to(@folder, :notice => 'Folder was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @folder.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /folders/1
  # DELETE /folders/1.xml
  def destroy
    @folder = current_user.folders.find(params[:id])
    @folder.destroy

    respond_to do |format|
      format.html {
        redirect_to(folders_users_path)
      }
      format.xml  { head :ok }
    end
  end

  def add_media
    @folder = current_user.folders.find(params[:id])
    if params[:media]
      media = @folder.drawings.create(params[:media])
      if media.save
        flash.now[:notice] = "dessin ajoutée avec succès"
      else
        flash.now[:alert] = "l'upload a rencontré une erreur"
      end
    end
    redirect_to :action => :show
  end

  def remove_media
    @folder = current_user.folders.find(params[:id])
    if params[:media_id]
      media = @folder.drawings.find(params[:media_id])
      if media.destroy
        flash[:notice] = "image supprimée avec succès"
      else
        flash[:alert] = "la suppression a échoué"
      end
    end
    redirect_to :action => :show, :anchor => "test"
  end
    
end
