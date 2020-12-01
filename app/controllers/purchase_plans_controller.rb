class PurchasePlansController < ApplicationController
  
  def index
    user = User.find(current_user.id)
    @purchase_plan = PurchasePlan.new
    @purchase_plans = user.purchase_plans.order("purchase_date ASC")
  end

  def create
    @purchase_plan = PurchasePlan.new(purchase_plan_params)
    if @purchase_plan.save
      redirect_to root_path
    else
      user = User.find(current_user.id)
      @purchase_plans = user.purchase_plans.order("purchase_date ASC")
      render 'index'
    end
  end

  def destroy
    @purchase_plan = PurchasePlan.find(params[:id])
    @purchase_plan.destroy
    user = User.find(current_user.id)
    @purchase_plans = user.purchase_plans.order("purchase_date ASC")
    render 'index'
  end

  private

  def purchase_plan_params
    params.require(:purchase_plan).permit(:name, :remarks, :price, :purchase_date, :image).merge(user_id: current_user.id)
  end
end
