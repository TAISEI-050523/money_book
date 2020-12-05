class VariableCostsController < ApplicationController
  def new
    user = User.find(current_user.id)
    @variable_cost = VariableCost.new
    @variable_costs = user.variable_costs.order('expense_date DESC')
  end

  def create
    @variable_cost = VariableCost.new(variable_cost_params)
    if @variable_cost.save
      redirect_to root_path
    else
      user = User.find(current_user.id)
      @variable_costs = user.variable_costs.order('expense_date DESC')
      render 'new'
    end
  end

  def destroy
    @variable_cost = VariableCost.find(params[:id])
    @variable_cost.destroy
    user = User.find(current_user.id)
    @variable_costs = user.variable_costs.order('expense_date DESC')
    render 'new'
  end

  private

  def variable_cost_params
    params.require(:variable_cost).permit(:variable_cost_category_id, :remarks, :price, :expense_date).merge(user_id: current_user.id)
  end
end
