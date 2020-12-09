class BudgetsController < ApplicationController
  def index
    user = User.find(current_user.id)
    if user.fixed_budget.present?
      @fixed_budget = user.fixed_budget
    end
  end

  def new
    @fixed_budget = FixedBudget.new
  end

  def create
    @fixed_budget = FixedBudget.new(fixed_budget_params)
    if @fixed_budget.save
      redirect_to new_budget_path
    else
      render 'new'
    end
  end

  def edit
    @fixed_budget = FixedBudget.find(params[:id])
  end

  def update
    fixed_budget = FixedBudget.find(params[:id])
    if fixed_budget.update(fixed_budget_params)
      redirect_to budgets_path
    else
      render 'edit'
    end
  end

  private

  def fixed_budget_params
    params.require(:fixed_budget).permit(:house, :communications, :electricity, :gas, :water, :education, :premium, :lawn, :etcetera).merge(user_id: current_user.id)
  end

end
