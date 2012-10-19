class ImagesController < ApplicationController
#  def index
#  end

  def new
    #@image = Image.new(params[:image])
#    @account = @image.account
#    @organization = @account.organization
    @organization = Organization.find(params[:organization_id])
    @account = @organization.accounts.find(params[:account_id])
    @image = @account.images.new(params[:image])
  end

  def show
    @id = params[:id]
    @image = Image.find(@id)
  end

  def create
    #@image = Image.new(params[:image])
    @organization = Organization.find(params[:organization_id])
    @account = @organization.accounts.find(params[:account_id])
    @image = @account.images.build(params[:image])
    @image.account_id = @account.id
    @image.organization_id = @account.organization.id

#    if @image.save
#      redirect_to root_url
#    end

    if @image.save
      if params[:image].blank?
        flash[:notice] = "Successfully created image."
        redirect_to root_url
      else
        render :action => "crop"
      end
    else
      render :action => 'new'
    end
  end

  def update
    @image = Image.find(params[:image_id])
    if @image.update_attributes(params[:image])
      if params[:image].blank?
        flash[:notice] = "Successfully updated image."
        redirect_to root_url
      else
        render :action => "crop"
      end
#    else
#      render :action => 'edit'
    end
  end
end
