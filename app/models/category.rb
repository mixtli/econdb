class Category < ActiveRecord::Base
  acts_as_category
  has_many :graphs
end
