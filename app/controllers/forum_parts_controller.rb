class ForumPartsController < ApplicationController
  # GET /forum_parts
  # GET /forum_parts.xml
  def index
    @forum_parts = ForumPart.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @forum_parts }
    end
  end

  # GET /forum_parts/1
  # GET /forum_parts/1.xml
  def show
    @forum_part = ForumPart.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @forum_part }
    end
  end

  # GET /forum_parts/new
  # GET /forum_parts/new.xml
  def new
    @forum_part = ForumPart.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @forum_part }
    end
  end

  # GET /forum_parts/1/edit
  def edit
    @forum_part = ForumPart.find(params[:id])
  end

  # POST /forum_parts
  # POST /forum_parts.xml
  def create
    @forum_part = ForumPart.new(params[:forum_part])

    respond_to do |format|
      if @forum_part.save
        format.html { redirect_to(@forum_part, :notice => 'Forum part was successfully created.') }
        format.xml  { render :xml => @forum_part, :status => :created, :location => @forum_part }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @forum_part.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /forum_parts/1
  # PUT /forum_parts/1.xml
  def update
    @forum_part = ForumPart.find(params[:id])

    respond_to do |format|
      if @forum_part.update_attributes(params[:forum_part])
        format.html { redirect_to(@forum_part, :notice => 'Forum part was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @forum_part.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /forum_parts/1
  # DELETE /forum_parts/1.xml
  def destroy
    @forum_part = ForumPart.find(params[:id])
    @forum_part.destroy

    respond_to do |format|
      format.html { redirect_to(forum_parts_url) }
      format.xml  { head :ok }
    end
  end
end
