class ImagesController < ApplicationController
#  def index
#  end

  def new
    @organization = Organization.find(params[:organization_id])
    @account = @organization.accounts.find(params[:account_id])
    @image = @account.images.new(params[:image])
  end

  def show
    @id = params[:id]
    @image = Image.find(params[:id])
  end

  def create
    @organization = Organization.find(params[:organization_id])
    @account = @organization.accounts.find(params[:account_id])
    @image = @account.images.build(params[:image])
    @image.account_id = @account.id
    @image.organization_id = @account.organization.id
#    if @image.save
#      if params[:image][:picture].present?
#        render :crop
#      else
#        redirect_to @image
#        flash[:notice] = "Successfully created image."
#      end
#    else
#      flash[:notice] = "Image not cropped."
#      render :new
#    end
    respond_to do |format|
      if @image.save
        #if params[:image][:picture].blank?
        format.html { redirect_to root_url, :notice => 'Image was successfully created.' }
        format.json { render :json => @image, :status => :created, :location => @image }
        #else
        #format.html { redirect_to edit_organization_account_image_path }
        #end
      else
        format.html { render :action => "new" }
        format.json { render :json => @image.errors, :status => :unprocessable_entity }
      end
    #@image.picture.reprocess!
    end

  end

  def update
    @organization = Organization.find(params[:organization_id])
    @account = @organization.accounts.find(params[:account_id])
    @image = @account.images.find(params[:id])
#    if @image.update_attributes(params[:image])
#      if params[:image][:picture].present?
#        render :crop
#        if @image.cropping?
#          @image.picture.reprocess!
#        end
#      else
#        flash[:notice] = "Successfully updated image."
#        redirect_to @image
#     end
#    else
#     render :edit
#    end

    respond_to do |format|
      if @image.update_attributes(params[:image])
#        if params[:image][:picture].blank?
#          format.html { redirect_to root_url, :notice => 'Image was successfully updated.' }
#          format.json { render :json => @image, :status => :created, :location => @image }
#        end
      @image.picture.reprocess!
      @image.save!
      format.html { redirect_to organization_account_image_path, :notice => 'Image was successfully updated.' }
          format.json { render :json => @image, :status => :created, :location => @image }
      #redirect_to organization_account_image_path
      else
        format.html { render :action => "edit" }
        format.json { render :json => @image.errors, :status => :unprocessable_entity }
      end
    #@image.picture.reprocess!
    end

  end

  def edit
    @organization = Organization.find(params[:organization_id])
    @account = @organization.accounts.find(params[:account_id])
    @image = @account.images.find(params[:id])
  end
end
