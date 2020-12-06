class PurchasePlansController < ApplicationController
  before_action :set_purchase_plans, only: [:index, :create, :destroy]

  def index
    set_purchase_plans
    @purchase_plan = PurchasePlan.new
  end

  def create
    set_purchase_plans
    @purchase_plan = PurchasePlan.new(purchase_plan_params)
    if @purchase_plan.save
      redirect_to '/purchase_plans'
    else
      render 'index'
    end
  end

  def destroy
    set_purchase_plans
    @purchase_plan = PurchasePlan.find(params[:id])
    if @purchase_plan.destroy
      redirect_to '/purchase_plans'
    else
      render 'index'
    end
  end

  private

  def set_purchase_plans
    user = User.find(current_user.id)
    @purchase_plans = user.purchase_plans.order('purchase_date ASC')
  end

  def purchase_plan_params
    params.require(:purchase_plan).permit(:name, :remarks, :price, :purchase_date, :image).merge(user_id: current_user.id)
  end
end
