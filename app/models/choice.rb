class Choice < ActiveRecord::Base
  attr_accessible :description, :item_id, :order_id
  belongs_to :user
  belongs_to :item
end
