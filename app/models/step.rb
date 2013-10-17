class Step < ActiveRecord::Base

  attr_accessible :description, :list_id, :title
  belongs_to :list
end
