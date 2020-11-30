class TopsController < ApplicationController
  def index
    user = User.find(current_user.id)
    @income = user.incomes.where(income_date: (1.years.ago)..(Date.today)).group('YEAR(income_date)').group('MONTH(income_date)').sum(:price)
    @fixed_cost = user.fixed_costs.where(expense_date: (1.years.ago)..(Date.today)).group('YEAR(expense_date)').group('MONTH(expense_date)').sum(:price)
    @variable_cost = user.variable_costs.where(expense_date: (1.years.ago)..(Date.today)).group('YEAR(expense_date)').group('MONTH(expense_date)').sum(:price)

    # @balance　= 

    this_month = Date.today.beginning_of_month..Date.today.end_of_month
    @income_month = user.incomes.where(income_date: this_month).sum(:price)              # 今月の収入
    @fixed_cost_month = user.fixed_costs.where(expense_date: this_month).sum(:price)     # 今月の固定費
    @variable_month = user.variable_costs.where(expense_date: this_month).sum(:price)    # 今月の変動費

    @this_month_balance = @income_month - (@fixed_cost_month + @variable_month)



    user = User.find(current_user.id)
    @purchase_plans = user.purchase_plans.order("purchase_date ASC")

  end
end
