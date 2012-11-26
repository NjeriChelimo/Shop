class OrganizationsController < ApplicationController

  def index
    @organizations = Organization.all
    respond_to do |format|
      if user_signed_in?
        @user = current_user
        @organization = @user.organization
        format.html
        format.json { render :json => @organization }
      else
        format.html
        format.json { render :json => @organizations }
      end
    end
  end

  def show
    @organization = Organization.find(params[:id])
    @accounts = @organization.accounts

    respond_to do |format|
      format.html
      format.json { render :json => @organization }
    end
  end

  def new
    @organization = Organization.new

    respond_to do |format|
      format.html
      format.json { render :json => @organization }
    end
  end

  def create
    @organization = Organization.new(params[:organization])

    respond_to do |format|
      if @organization.save
        format.html { redirect_to @organization, notice: 'Organization was successfully created.' }
        format.json { render :json => @organization, status: :created, location: @organization }
      else
        format.html { render action: "new" }
        format.json { render :json => @organization.errors, status: :unprocessable_entity }
      end
    end
  end
end
