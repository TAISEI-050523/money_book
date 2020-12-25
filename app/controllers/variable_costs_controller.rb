class VariableCostsController < ApplicationController
  before_action :set_variable_costs, only: [:new, :create, :destroy]

  def new
    @variable_cost = VariableCost.new
  end

  def create
    variable_cost = VariableCost.create(variable_cost_category_id: params[:variable_cost_category_id], remarks: params[:remarks], price: params[:price], expense_date: params[:expense_date], user_id: current_user.id)
    if variable_cost.valid?
      # ActiveHashのidをnameに変換
      category = VariableCostCategory.find(params[:variable_cost_category_id])
      # 金額を3桁区切りに変換
      price = variable_cost.price.to_s(:delimited)
      # 日付を年月日表記に変換
      date = variable_cost.expense_date.strftime('%Y年%m月%d日')
      # variable_cost, category, dateをjson形式で送信
      render json: { variable_cost: variable_cost, category: category, price: price, date: date }
    end
  end

  def destroy
    @variable_cost = VariableCost.find(params[:id])
    if @variable_cost.destroy
      redirect_to '/variable_costs/new'
    else
      render 'new'
    end
  end

  def search
    user = User.find(current_user.id)
    @variable_costs = user.variable_costs.search(params[:variable_cost_category_id], params[:year], params[:month]).order('expense_date DESC')
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
