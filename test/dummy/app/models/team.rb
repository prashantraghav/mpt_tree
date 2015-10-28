class Team < ActiveRecord::Base
  acts_as_tree
  self.inheritance_column = :type
end
