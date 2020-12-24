class IncomesController < ApplicationController
  before_action :set_incomes, only: [:new, :create, :destroy]

  def new
    @income = Income.new
  end

  def create
    income = Income.create(income_category_id: params[:income_category_id], remarks: params[:remarks], price: params[:price], income_date: params[:income_date], user_id: current_user.id)
    # ActiveHashのidをnameに変換
    category = IncomeCategory.find(params[:income_category_id])
    # 金額を3桁区切りに変換
    price = income.price.to_s(:delimited)
    # 日付を年月日表記に変換
    date = income.income_date.strftime("%Y年%m月%d日")
    # income, category, dateをjson形式で送信
    render json:{ income: income, category: category, price: price, date: date }
  end

  def destroy
    @income = Income.find(params[:id])
    if @income.destroy
      redirect_to '/incomes/new'
    else
      render 'new'
    end
  end

  def search
    user = User.find(current_user.id)
    @incomes = user.incomes.search(params[:income_category_id], params[:year], params[:month]).order('income_date DESC')
  end

  private

  def set_incomes
    user = User.find(current_user.id)
    @incomes = user.incomes.order('income_date DESC')
  end

  def income_params
    params.require(:income).permit(:income_category_id, :remarks, :price, :income_date).merge(user_id: current_user.id)
  end
end
