# frozen_string_literal: true

require 'test_helper'

class PostTest < ActiveSupport::TestCase

  def setup
    @user = users(:one)
    @post = Post.new(content: "Lorem ipsum", user: @user)
  end

  test "should be valid" do
    assert @post.valid?
  end

  test "content should be present" do
    @post.content = "   "
    assert_not @post.valid?
  end

  test "user id should be present" do
    @post.user_id = nil
    assert_not @post.valid?
  end
  # test "the truth" do
  #   assert true
  # end
end
