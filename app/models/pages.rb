class Pages < ActiveRecord::Base
  validates :title, :content, presence: true
end
