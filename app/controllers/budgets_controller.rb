class BudgetsController < ApplicationController

  def index
    user = User.find(current_user.id)
    this_month = Date.today.beginning_of_month..Date.today.end_of_month
    @fixed_cost = user.fixed_costs.where(expense_date: this_month)
    @variable_cost = user.variable_costs.where(expense_date: this_month)
    @fixed_cost_month = user.fixed_costs.where(expense_date: this_month).sum(:price)
    @variable_cost_month = user.variable_costs.where(expense_date: this_month).sum(:price)
    # 予算登録済みユーザーにのみ予算を表示
    budget_present
  end

  # 予算登録済みログインユーザーが直接URLを入力して予算登録ページに遷移しようとするとトップページに遷移
  def new
    user = User.find(current_user.id)
    unless user.budget.present?
      @budget = Budget.new
    else
      redirect_to root_path 
    end
  end

  def create
    @budget = Budget.new(budget_params)
    if @budget.save
      redirect_to budgets_path
    else
      render 'new'
    end
  end

  # 予算登録していないログインユーザーが直接URLを入力して他ユーザーの予算編集ページに遷移しようとするとトップページに遷移
  def edit
    user = User.find(current_user.id)
    @budget = Budget.find(params[:id])
    unless current_user.id == @budget.user_id && user.budget.present?
      redirect_to root_path 
    end
  end

  def update
    @budget = Budget.find(params[:id])
    if @budget.update(budget_params)
      redirect_to budgets_path
    else
      render 'edit'
    end
  end

  private

  def budget_params
    params.require(:budget).permit(:house, :communications, :electricity, :gas, :water, :education, :premium, :lawn, :fixed_etcetera, :food, :commodity, :transportation, :hobby, :clothes, :health, :culture, :book, :cafe, :social, :special, :variable_etcetera).merge(user_id: current_user.id)
  end

  # 固定費予算の合計値と変動費予算の合計値を算出
  def budget_present
    user = User.find(current_user.id)
    if user.budget.present?
      @budget = user.budget
      @fixed_budget = (@budget.house + @budget.communications + @budget.electricity + @budget.gas + @budget.water + @budget.education + @budget.premium + @budget.lawn + @budget.fixed_etcetera)
      @variable_budget = (@budget.food + @budget.commodity + @budget.transportation + @budget.hobby+ @budget.clothes + @budget.health + @budget.culture + @budget.book + @budget.cafe + @budget.social + @budget.special + @budget.variable_etcetera)
    end
  end

end
