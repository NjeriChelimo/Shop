class ImagesController < ApplicationController

  def new
    @image = Image.new(params[:image])
  end

  def show
    @id = params[:id]
    @image = Image.find(params[:id])
  end

  def create
    @account = Account.find(params[:account_id])
    @image = @account.images.build(params[:image])
    @image.accounts_id = @account.id
    @organization = @account.organization
    @image.organization_id = @account.organization.id

    respond_to do |format|
      if @image.save
        format.html { redirect_to root_url, :notice => 'Image was successfully created.' }
        format.json { render :json => @image, :status => :created, :location => @image }
      else
        format.html { render :action => "new" }
        format.json { render :json => @image.errors, :status => :unprocessable_entity }
      end
    end

  end

  def update
    @account = Account.find(params[:account_id])
    @image = @account.images.find(params[:id])
    respond_to do |format|
      if @image.update_attributes(params[:image])
      @image.picture.reprocess!
      @image.save!
      format.html { redirect_to organization_account_image_path, :notice => 'Image was successfully updated.' }
          format.json { render :json => @image, :status => :created, :location => @image }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @image.errors, :status => :unprocessable_entity }
      end
    end

  end

  def edit
    @account = Account.find(params[:account_id])
    @image = @account.images.find(params[:id])
  end
end
