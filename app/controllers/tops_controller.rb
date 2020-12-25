class TopsController < ApplicationController
  def index
    @user = User.find(current_user.id)
    @incomes = @user.incomes                                           # ログインユーザーの収入
    @fixed_costs = @user.fixed_costs                                   # ログインユーザーの固定費
    @variable_costs = @user.variable_costs                             # ログインユーザーの変動費
    @purchase_plans = @user.purchase_plans.order('purchase_date ASC')  # ログインユーザーの購入予定リスト

    set_monthly        # 月ごとの収入・固定費・変動費の総額を算出

    set_this_month     # 当月の収入・固定費・変動費の総額を算出

    set_total          # 過去の収入・固定費・変動費の総額を算出

    set_each_category              # 当月の固定費・変動費を算出（index.html.erbで分類ごとに合計値を算出）

    set_purchase_plans_saving      # 購入予定リストからの1日の貯金額の目安を算出

    set_budget_present             # 予算登録済みの場合に処理を行う
  end

  private

  def set_monthly
    @income_monthly = @incomes.income_monthly
    @fixed_cost_monthly = @fixed_costs.fixed_cost_monthly
    @variable_cost_monthly = @variable_costs.variable_cost_monthly
  end

  def set_this_month
    @income_this_month = @incomes.income_this_month                                                   # 当月の収入総額
    @fixed_cost_this_month = @fixed_costs.fixed_cost_this_month                                       # 当月の固定費総額
    @variable_cost_this_month = @variable_costs.variable_cost_this_month                              # 当月の変動費総額
    @balance_this_month = @income_this_month - (@fixed_cost_this_month + @variable_cost_this_month)   # 当月の収支
  end

  def set_total
    @income_total = @incomes.sum(:price)                                          # 過去の収入総額
    @fixed_cost_total = @fixed_costs.sum(:price)                                  # 過去の固定費総額
    @variable_cost_total = @variable_costs.sum(:price)                            # 過去の変動費総額
    @balance_total = @income_total - (@fixed_cost_total + @variable_cost_total)   # 過去の収支
  end

  def set_each_category
    this_month = Date.today.beginning_of_month..Date.today.end_of_month           # 当月の始めから終わりまでの期間
    @fixed_cost_category = @fixed_costs.where(expense_date: this_month)           # 当月の固定費データを取得
    @variable_cost_category = @variable_costs.where(expense_date: this_month)     # 当月の変動費データを取得
  end

  def set_purchase_plans_saving                                                   # 貯金額目安を算出
    @saving_sum = 0                                                               # 例:「貯金額目安」＝（「商品Aの値段」/「登録日から購入日までの日数」）+（「商品Bの値段」/「登録日から購入日までの日数」）+ ・・・・
    @purchase_plans.each do |plan|
      @saving_sum += plan.price / (plan.purchase_date - plan.created_at.to_date).numerator if plan.purchase_date > Date.today
    end
  end

  def set_budget_present
    if @user.budget.present?
      @budget = @user.budget
      @fixed_budget_sum = (@budget.house + @budget.communications + @budget.electricity + @budget.gas + @budget.water + @budget.education + @budget.premium + @budget.lawn + @budget.fixed_etcetera)
      @variable_budget_sum = (@budget.food + @budget.commodity + @budget.transportation + @budget.hobby + @budget.clothes + @budget.health + @budget.culture + @budget.book + @budget.cafe + @budget.social + @budget.special + @budget.variable_etcetera)
      @budget_sum = (@fixed_budget_sum + @variable_budget_sum)
      @budget_remains = @budget_sum - (@fixed_cost_this_month + @variable_cost_this_month)
    end
  end
end
