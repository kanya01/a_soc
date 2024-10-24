# frozen_string_literal: true

require 'test_helper'

class AudiosControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @user = users(:one)
    @audio = audios(:one)
    sign_in @user
  end

  test 'should get index' do
    get '/audios/new'
    assert_response :success
  end

  test 'should get show' do
    get "/audios/#{@audio.id}"
    assert_response :success
  end

  test 'should get new' do
    get '/audios/new'
    assert_response :success
  end

  # test "should get create" do
  #   get audios_create_url
  #   assert_response :success
  # end
  test 'should create audio' do
    assert_difference('Audio.count') do
      post '/audios', params: {
        audio: {
          title: 'New Audio',
          audio_file: fixture_file_upload('test_aaudio.mp3', 'audio/mp3')
        }
      }
    end
    assert_redirected_to audio_url(Audio.last)
  end

  test 'should get edit' do
    get "/audios/#{@audio.id}/edit"
    assert_response :success
  end

  test 'should get update' do
    patch audio_url(@audio), params: {
      audio: { title: 'Updated Title' }
    }
    assert_redirected_to audio_url(@audio)
    @audio.reload
    assert_equal 'Updated Title', @audio.title
  end

  test 'should get destroy' do
    assert_equal 1, @user.audios.count, 'Should have exactly one audio before deletion'
    assert_difference('Audio.count', -1) do
      delete audio_url(@audio)
    end
    assert_redirected_to audios_url
  end
end
