class Notification < ActiveRecord::Base
  attr_accessible :body, :claimed_at, :description, :user_id
  belongs_to :user 
end
