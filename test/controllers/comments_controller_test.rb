# frozen_string_literal: true

require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    sign_in @user
    @audio = audios(:one)
    @comment = comments(:one)
  end

  test 'should create comment' do
    assert_difference('Comment.count') do
      post "/audios/#{@audio.id}/comments", params: {
        comment: { content: 'New comment' }
      }
    end
    assert_redirected_to audio_path(@audio)
  end

  test 'should destroy comment' do
    assert_difference('Comment.count', -1) do
      delete "/audios/#{@audio.id}/comments/#{@comment.id}"
    end
    assert_redirected_to audio_path(@audio)
  end

  test 'should not allow unauthorized comment deletion' do
    other_user = users(:two)
    @comment.update(user: other_user)

    assert_no_difference('Comment.count') do
      delete audio_comment_path(@audio, @comment)
    end

    assert_redirected_to audio_path(@audio)
    assert_equal 'Not authorized to perform this action.', flash[:alert]
  end
end
