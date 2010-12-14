# coding: utf-8

class InformationsController < ApplicationController
  before_filter :authenticate, :only => [:create, :uptade, :edit, :destroy]

  def authenticate
    unless user_signed_in?
      session[:user_return_to] = request.request_uri
      authenticate_user!
    end
  end

  # GET /informations
  def index
    @informations = Information.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /informations/1
  def show
    @information = Information.find(params[:id])

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /informations/new
  def new
    @information = Information.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # POST /informations
  def create
    @information = Information.new(params[:information])
    @information.writer = current_user
    if @information.valid?
      if @information.save
        @information = Information.new
        flash[:notice] = "Dossier créer avec succès"
      else
        flash[:alert] = "une errieur est survenue lors de l'enregistrement"
      end
    else
      flash['information'] = @information
    end
    redirect_to informations_path
  end

  # GET /informations/1
  def edit
    @information = Information.find(params[:id])

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # PUT /informations/1
  def update
    if @information = Information.find_by_id(params[:id])
      if @information.update_attributes(params[:information])
        redirect_to(@information, :notice => 'Information was successfully updated.')
      else
        redirect_to(edit_information_path(@information), :alert => 'Error in update')
      end
    else
      redirect_to informations_path, :alert => "This information don't exist"
    end
  end

  def destroy
    if @information = Information.find_by_id(params[:id])
      if @information.destroy
        flash[:notice] = "Information was deleted sucessfully"
      else
        flash[:alert] = "Information can't be deleted"
      end
    else
      flash[:alert] = "This information not exist"
    end
    redirect_to informations_path
  end

end
