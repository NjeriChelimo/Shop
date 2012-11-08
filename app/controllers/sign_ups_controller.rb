class SignUpsController < ApplicationController
  # GET /sign_ups
  # GET /sign_ups.json
  def index
    @sign_ups = SignUp.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sign_ups }
    end
  end

  # GET /sign_ups/1
  # GET /sign_ups/1.json
  def show
    @sign_up = SignUp.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sign_up }
    end
  end

  # GET /sign_ups/new
  # GET /sign_ups/new.json
  def new
    @sign_up = SignUp.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sign_up }
    end
  end

  # GET /sign_ups/1/edit
  def edit
    @sign_up = SignUp.find(params[:id])
  end

  # POST /sign_ups
  # POST /sign_ups.json
  def create
    @sign_up = SignUp.new(params[:sign_up])

    respond_to do |format|
      if @sign_up.save
        format.html { redirect_to @sign_up, notice: 'Sign up was successfully created.' }
        format.json { render json: @sign_up, status: :created, location: @sign_up }
      else
        format.html { render action: "new" }
        format.json { render json: @sign_up.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sign_ups/1
  # PUT /sign_ups/1.json
  def update
    @sign_up = SignUp.find(params[:id])

    respond_to do |format|
      if @sign_up.update_attributes(params[:sign_up])
        format.html { redirect_to @sign_up, notice: 'Sign up was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sign_up.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sign_ups/1
  # DELETE /sign_ups/1.json
  def destroy
    @sign_up = SignUp.find(params[:id])
    @sign_up.destroy

    respond_to do |format|
      format.html { redirect_to sign_ups_url }
      format.json { head :no_content }
    end
  end
end
