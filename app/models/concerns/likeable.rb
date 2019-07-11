module Likeable
  extend ActiveSupport::Concern

  included do
    has_many :likes, as: :likeable, inverse_of: :likeable, dependent: :destroy
    has_many :members, through: :likes
  end

  def liked_by?(member)
    member && members.include?(member)
  end
end
