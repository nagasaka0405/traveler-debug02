class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :message, presence: true, length: { maximum: 130 }
  #　メッセージは空欄はNG、かつ140字以内
end
