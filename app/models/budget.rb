class Budget < ApplicationRecord
  belongs_to :user

  with_options  numericality: { only_integer: true } do
    validates :house 
    validates :communications 
    validates :electricity 
    validates :gas 
    validates :water 
    validates :education 
    validates :premium 
    validates :lawn 
    validates :etcetera 
    validates :food 
    validates :commodity 
    validates :transportation 
    validates :hobby 
    validates :clothes 
    validates :health 
    validates :culture 
    validates :book 
    validates :cafe 
    validates :social 
    validates :special 
    validates :etcetera
  end
end
