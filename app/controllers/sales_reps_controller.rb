class SalesRepsController < ApplicationController
  before_action :authenticate_user!
  authorize_resource :class => false

  def new
  end

  def create
    @user = User.new(sign_up_params)
    @dealership = Dealership.find(params[:dealership_id])
    if @user.valid? and @dealership.present?
        @user.add_role :sales_rep, @dealership
        if @user.save
          redirect_to root_url, notice: 'Sales Representative was successfully created.'
        else
          render :new, notice: @user.errors
        end
    else
      render :new, notice: @user.errors
    end
  end

  private

  def sign_up_params
    params[:sales_rep].permit(:name, :email, :password, :password_confirmation, :dealership_id)
    # params.permit(:first_name,:last_name,:company_name,:organization_name ,:officer_name,:email, :password, :password_confirmation)
  end

  def update_params
    params.permit(:id, :name, :password)
  end
end
