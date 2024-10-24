# frozen_string_literal: true

require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    @post = posts(:one)
    sign_in @user
  end

  test 'should get index' do
    get '/posts'
    assert_response :success
  end

  test 'should get new' do
    get '/posts/new'
    assert_response :success
  end

  test 'should create post' do
    assert_difference('Post.count') do
      post '/posts', params: {
        post: {
          content: 'New post content',
          image: fixture_file_upload('test_image.jpg', 'image/jpeg')
        }
      }
    end
    assert_redirected_to post_path(Post.last)
    assert_equal 'Post was successfully created.', flash[:notice]
  end

  test 'should show post' do
    get "/posts/#{@post.id}"
    assert_response :success
  end

  test 'should get edit' do
    get "/posts/#{@post.id}/edit"
    assert_response :success
  end

  test 'should update post' do
    patch "/posts/#{@post.id}", params: {
      post: { content: 'Updated content' }
    }
    assert_redirected_to post_path(@post)
    @post.reload
    assert_equal 'Updated content', @post.content
    assert_equal 'Post was successfully updated.', flash[:notice]
  end

  test 'should destroy post' do
    sign_in @user
    assert_difference('Post.count', -1) do
      delete "/posts/#{@post.id}"
    end
    assert_redirected_to posts_path
    assert_equal 'Post was successfully deleted.', flash[:notice]
  end

  test 'should not allow unauthorized edit' do
    other_user = users(:two)
    sign_in other_user

    get "/posts/#{@post.id}/edit"
    assert_redirected_to posts_path
    assert_equal 'Not authorized to perform this action.', flash[:alert]
  end

  test 'should not allow unauthorized update' do
    other_user = users(:two)
    sign_in other_user

    patch "/posts/#{@post.id}", params: {
      post: { content: 'Unauthorized update' }
    }
    assert_redirected_to posts_path
    assert_equal 'Not authorized to perform this action.', flash[:alert]
  end

  test 'should not allow unauthorized destroy' do
    other_user = users(:two)
    sign_in other_user

    assert_no_difference('Post.count') do
      delete "/posts/#{@post.id}"
    end
    assert_redirected_to posts_path
    assert_equal 'Not authorized to perform this action.', flash[:alert]
  end
end
