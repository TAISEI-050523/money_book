class FixedCostsController < ApplicationController
  before_action :set_fixed_costs, only: [:new, :create, :destroy]

  def new
    @fixed_cost = FixedCost.new
  end

  def create
    fixed_cost = FixedCost.create(fixed_cost_category_id: params[:fixed_cost_category_id], remarks: params[:remarks], price: params[:price], expense_date: params[:expense_date], user_id: current_user.id)
    if fixed_cost.valid?
      # ActiveHashのidをnameに変換
      category = FixedCostCategory.find(params[:fixed_cost_category_id])
      # 金額を3桁区切りに変換
      price = fixed_cost.price.to_s(:delimited)
      # 日付を年月日表記に変換
      date = fixed_cost.expense_date.strftime("%Y年%m月%d日")
      # fixed_cost, category, dateをjson形式で送信
      render json:{ fixed_cost: fixed_cost, category: category, price: price, date: date }
    end
  end

  def destroy
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
