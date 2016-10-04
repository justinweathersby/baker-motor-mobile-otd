class StaticPagesController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
    @moderators = User.with_role(:moderator, :any)
    @customers = User.with_role(:customer)

    if user_signed_in? and current_user.has_role?(:moderator, :any)
      @dealership = Dealership.with_role(:moderator, current_user).first
    end
  end
end
