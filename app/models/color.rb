class Color < ApplicationRecord

  validates :question, inclusion: {in: [true,false]}

end
