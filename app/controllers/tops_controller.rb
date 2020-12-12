class TopsController < ApplicationController
  def index
    user = User.find(current_user.id)
    one_year_period = (1.years.ago.beginning_of_month)..(Date.today.end_of_month)
    this_month = Date.today.beginning_of_month..Date.today.end_of_month                  # 期間を今月に指定

    @income = user.incomes.where(income_date: one_year_period).group('YEAR(income_date)').group('MONTH(income_date)').sum(:price)
    @fixed_cost = user.fixed_costs.where(expense_date: one_year_period).group('YEAR(expense_date)').group('MONTH(expense_date)').sum(:price)
    @variable_cost = user.variable_costs.where(expense_date: one_year_period).group('YEAR(expense_date)').group('MONTH(expense_date)').sum(:price)

    @income_month = user.incomes.where(income_date: this_month).sum(:price)              # 今月の収入
    @fixed_cost_month = user.fixed_costs.where(expense_date: this_month).sum(:price)     # 今月の固定費
    @variable_cost_month = user.variable_costs.where(expense_date: this_month).sum(:price)    # 今月の変動費
    @this_month_balance = @income_month - (@fixed_cost_month + @variable_cost_month)          # 今月の収支

    @income_all = user.incomes.sum(:price)                                 # 収入総額
    @fixed_cost_all = user.fixed_costs.sum(:price)                         # 固定費総額
    @variable_cost_all = user.variable_costs.sum(:price)                   # 変動費総額
    @savings = @income_all - (@fixed_cost_all + @variable_cost_all)        # 収支総額

    @purchase_plans = user.purchase_plans.order('purchase_date ASC')
    @sum = 0
    @purchase_plans.each do |plan|
      @sum += plan.price / (plan.purchase_date - plan.created_at.to_date).numerator if plan.purchase_date > Date.today
    end

    @fixed_cost_category = user.fixed_costs.where(expense_date: this_month)
    @variable_cost_category = user.variable_costs.where(expense_date: this_month)

    if user.budget.present?
      @budget = user.budget
      @fixed_budget = (@budget.house + @budget.communications + @budget.electricity + @budget.gas + @budget.water + @budget.education + @budget.premium + @budget.lawn + @budget.fixed_etcetera)
      @variable_budget = (@budget.food + @budget.commodity + @budget.transportation + @budget.hobby + @budget.clothes + @budget.health + @budget.culture + @budget.book + @budget.cafe + @budget.social + @budget.special + @budget.variable_etcetera)
      @budget_sum = (@fixed_budget + @variable_budget)
      @budget_nokori = @budget_sum - (@fixed_cost_month + @fixed_cost_month)
    end
  end
end
