# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[show edit update destroy]
  before_action :authorize_user!, only: %i[edit update destroy]

  layout 'application'

  def index
    # @posts = Post.includes(:user).order(created_at: :desc)
    @posts = Post.includes(:user, image_attachment: :blob, audio_file_attachment: :blob)
                 .order(created_at: :desc)
                 .page(params[:page])
                 .per(12)
  end

  def show; end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to post_path(@post), notice: 'Post was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # authorize_user(@post)
  end

  def update
    # authorize_user(@post)
    if @post.update(post_params)
      redirect_to post_path(@post), notice: 'Post was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @post.user == current_user
      @post.destroy
      redirect_to posts_path, notice: 'Post was successfully deleted.'
    else
      redirect_to posts_path, alert: 'Not authorized to perform this action.'
    end

  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content, :location, :image, :audio_file)
  end

  def authorize_user!
    return if @post.user == current_user

    redirect_to posts_path, alert: 'Not authorized to perform this action.'
  end
end
