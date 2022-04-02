class Article < ApplicationRecord
    include Visible

    belongs_to :user
    has_many :comments, dependent: :destroy
  
    validates :title, presence: true
    validates :body, presence: true, length: { minimum: 10 }

    delegate :email, to: :user, prefix: true
  end
  