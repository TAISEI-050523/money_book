class IncomesController < ApplicationController
  before_action :set_incomes, only: [:new, :create, :destroy]

  def new
    set_incomes
    @income = Income.new
  end

  def create
    set_incomes
    @income = Income.new(income_params)
    if @income.save
      redirect_to '/incomes/new'
    else
      render 'new'
    end
  end

  def destroy
    set_incomes
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
