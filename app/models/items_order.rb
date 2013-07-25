class ItemOrder < ActiveRecord::Base
  attr_accessible :item_id, :order_id, :description

  belongs_to :order
  belongs_to :item
end
