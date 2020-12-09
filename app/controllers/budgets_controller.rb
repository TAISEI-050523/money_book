class BudgetsController < ApplicationController
  def index
    user = User.find(current_user.id)
    if user.fixed_budget.present?
      @fixed_budget = user.fixed_budget
    end
  end

  def new
    @budget = Budget.new
  end

  def create
    @budget = Budget.new(budget_params)
    if @budget.save
      redirect_to new_budget_path
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
    params.require(:budget).permit(:house, :communications, :electricity, :gas, :water, :education, :premium, :lawn, :etcetera, :food, :commodity, :transportation, :hobby, :clothes, :health, :culture, :book, :cafe, :social, :special, :etcetera)
  end

end
