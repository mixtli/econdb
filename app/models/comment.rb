class Comment < ActiveRecord::Base
  stampable
  belongs_to :creator, :class_name => 'User'
  belongs_to :updater, :class_name => 'User'  
end
