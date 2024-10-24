class Like < ApplicationRecord
  belongs_to :post, counter_cache: true  # This is the key line for counter cache
  belongs_to :user

  validates :post_id, uniqueness: { scope: :user_id }
end
