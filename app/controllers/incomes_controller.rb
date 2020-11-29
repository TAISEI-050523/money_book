class IncomesController < ApplicationController

  def new
    user = User.find(current_user.id)
    @income = Income.new
    @incomes = user.incomes
  end

  def create
    @income = Income.new(income_params)
    if @income.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  private
  def income_params
    params.require(:income).permit(:category_id, :remarks,  :price, :date_entered).merge(user_id: current_user.id)
  end
end
