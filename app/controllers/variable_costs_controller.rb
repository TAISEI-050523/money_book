class VariableCostsController < ApplicationController
  before_action :set_variable_costs, only: [:new, :create, :destroy]

  def new
    set_variable_costs
    @variable_cost = VariableCost.new
  end

  def create
    set_variable_costs
    @variable_cost = VariableCost.new(variable_cost_params)
    if @variable_cost.save
      redirect_to '/variable_costs/new'
    else
      render 'new'
    end
  end

  def destroy
    set_variable_costs
    @variable_cost = VariableCost.find(params[:id])
    if @variable_cost.destroy
      redirect_to '/variable_costs/new'
    else
      render 'new'
    end
  end

  private

  def set_variable_costs
    user = User.find(current_user.id)
    @variable_costs = user.variable_costs.order('expense_date DESC')
  end

  def variable_cost_params
    params.require(:variable_cost).permit(:variable_cost_category_id, :remarks, :price, :expense_date).merge(user_id: current_user.id)
  end
end
