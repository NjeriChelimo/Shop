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

    if @image.save
      redirect_to root_url
    end
  end
end
