# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_audio
  before_action :set_comment, only: [:destroy]

  def create
    @comment = @audio.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @audio, notice: 'Comment was successfully added.'
    else
      redirect_to @audio, alert: 'Error adding comment.'
    end
  end

  def destroy
    if @comment.user == current_user
      @comment.destroy
      redirect_to @audio, notice: 'Comment was successfully deleted.'
    else
      redirect_to @audio, alert: 'Not authorized to perform this action.'
    end
  end

  private

  def set_audio
    @audio = Audio.find(params[:audio_id])
  end

  def set_comment
    @comment = @audio.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  # def authorize_user(comment)
  #     unless comment.user == current_user
  #       redirect_to @audio, alert: 'Not authorized to perform this action.'
  #     end
  # end
end
