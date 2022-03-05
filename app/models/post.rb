class Post < ApplicationRecord

  belongs_to :user

  validates :place, presence: true
  validates :schedule, presence: true
  validates :body, presence: true
  validates :contact, presence: true


end
