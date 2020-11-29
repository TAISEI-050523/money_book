class FixedCostsController < ApplicationController
  def new
    user = User.find(current_user.id)
    @fixed_cost = FixedCost.new
    @fixed_costs = user.fixed_costs
  end

  def create
    @fixed_cost = FixedCost.new(fixed_cost_params)
    if @fixed_cost.save
      redirect_to root_path
    else
      user = User.find(current_user.id)
      @fixed_costs = user.fixed_costs
      render 'new'
    end
  end

  private

  def fixed_cost_params
    params.require(:fixed_cost).permit(:fixed_cost_category_id, :remarks, :price, :expense_date).merge(user_id: current_user.id)
  end
end
