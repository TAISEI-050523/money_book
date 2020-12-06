class IncomesController < ApplicationController
  def new
    user = User.find(current_user.id)
    @income = Income.new
    @incomes = user.incomes.order('income_date DESC')
  end

  def create
    @income = Income.new(income_params)
    if @income.save
      redirect_to root_path
    else
      user = User.find(current_user.id)
      @incomes = user.incomes.order('income_date DESC')
      render 'new'
    end
  end

  def destroy
    @income = Income.find(params[:id])
    @income.destroy
    user = User.find(current_user.id)
    @incomes = user.incomes.order('income_date DESC')
    render 'new'
  end

  private

  def income_params
    params.require(:income).permit(:income_category_id, :remarks, :price, :income_date).merge(user_id: current_user.id)
  end
end
