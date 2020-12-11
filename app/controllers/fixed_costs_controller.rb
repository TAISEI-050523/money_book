class FixedCostsController < ApplicationController
  before_action :set_fixed_costs, only: [:new, :create, :destroy]

  def new
    set_fixed_costs
    @fixed_cost = FixedCost.new
  end

  def create
    set_fixed_costs
    @fixed_cost = FixedCost.new(fixed_cost_params)
    if @fixed_cost.save
      redirect_to '/fixed_costs/new'
    else
      render 'new'
    end
  end

  def destroy
    set_fixed_costs
    @fixed_cost = FixedCost.find(params[:id])
    if @fixed_cost.destroy
      redirect_to '/fixed_costs/new'
    else
      render 'new'
    end
  end

  def search
    user = User.find(current_user.id)
    @fixed_costs = user.fixed_costs.search(params[:fixed_cost_category_id], params[:year], params[:month]).order('expense_date DESC')
  end

  private

  def set_fixed_costs
    user = User.find(current_user.id)
    @fixed_costs = user.fixed_costs.order('expense_date DESC')
  end

  def fixed_cost_params
    params.require(:fixed_cost).permit(:fixed_cost_category_id, :remarks, :price, :expense_date).merge(user_id: current_user.id)
  end
end
