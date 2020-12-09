class BudgetsController < ApplicationController
  def index
    user = User.find(current_user.id)
    this_month = Date.today.beginning_of_month..Date.today.end_of_month 
    @fixed_cost = user.fixed_costs.where(expense_date: this_month)
    @variable_cost = user.variable_costs.where(expense_date: this_month)
    if user.budget.present?
      @budget = user.budget
    end
  end

  def new
    @budget = Budget.new
  end

  def create
    @budget = Budget.new(budget_params)
    if @budget.save
      redirect_to budgets_path
    else
      render 'new'
    end
  end

  def edit
    @budget = Budget.find(params[:id])
  end

  def update
    budget = Budget.find(params[:id])
    if budget.update(budget_params)
      redirect_to budgets_path
    else
      render 'edit'
    end
  end

  private

  def budget_params
    params.require(:budget).permit(:house, :communications, :electricity, :gas, :water, :education, :premium, :lawn, :fixed_etcetera, :food, :commodity, :transportation, :hobby, :clothes, :health, :culture, :book, :cafe, :social, :special, :variable_etcetera).merge(user_id: current_user.id)
  end

end

