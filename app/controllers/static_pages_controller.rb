class StaticPagesController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
    @moderators = User.with_role(:moderator, :any)
    @customers = User.with_role(:customer)
  end
end
