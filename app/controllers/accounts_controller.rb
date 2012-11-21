class AccountsController < ApplicationController

  def show
    @account = Account.find(params[:id])
    @images = @account.images
    @organization = @account.organization

    respond_to do |format|
      format.html
      format.json { render json: @account }
    end
  end

  def new
    @organization = Organization.find(params[:organization_id])
    @account = @organization.accounts.new(params[:account])

  end

  def edit
    @account = Account.find(params[:id])
  end

  def create
    @organization = Organization.find(params[:organization_id])
    @account = @organization.accounts.create!(params[:account])

    respond_to do |format|
      if @account.save
        format.html { redirect_to root_url, notice: 'Account was successfully created.' }
        format.json { render json: @account, status: :created, location: @account }
      else
        format.html { render action: "new" }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @account = Account.find(params[:id])

    respond_to do |format|
      if @account.update_attributes(params[:account])
        format.html { redirect_to @account, notice: 'Account was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @account = Account.find(params[:id])
    @account.destroy

    respond_to do |format|
      format.html { redirect_to accounts_url }
      format.json { head :no_content }
    end
  end
end
