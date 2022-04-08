class Comment < ApplicationRecord
  include Visible

  belongs_to :article
  belongs_to :user

  validates :commenter, presence: true, length: {minimum: 3, maximum: 20}
  validates :body, presence: true, length: {minimum: 3, maximum: 250}
end
