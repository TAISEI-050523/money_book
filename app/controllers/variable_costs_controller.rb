class VariableCostsController < ApplicationController
  def new
    user = User.find(current_user.id)
    @variable_cost = VariableCost.new
    @variable_costs = user.variable_costs
  end

  def create
    @variable_cost = VariableCost.new(variable_cost_params)
    if @variable_cost.save
      redirect_to root_path
    else
      user = User.find(current_user.id)
      @variable_costs = user.variable_costs
      render 'new'
    end
  end

  private
  def variable_cost_params
    params.require(:variable_cost).permit(:variable_cost_category_id, :remarks, :price, :date_entered).merge(user_id: current_user.id)
  end
end
