# frozen_string_literal: true

class AudiosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_audio, only: %i[show edit update destroy]
  def index
    @audios = Audio.includes(:user).order(created_at: :desc)
  end

  def show
    @comments = @audio.comments.includes(:user).order(created_at: :desc)
  end

  def new
    @audio = current_user.audios.build
  end

  def create
    @audio = current_user.audios.build(audio_params)
    if @audio.save
      redirect_to @audio, notice: 'Audio was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize_user(@audio)
  end

  def update
    authorize_user(@audio)
    if @audio.update(audio_params)
      redirect_to @audio, notice: 'Audio was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize_user(@audio)
    @audio.destroy
    redirect_to audios_url, notice: 'Audio was successfully deleted.'
  end

  private

  def set_audio
    @audio = Audio.find(params[:id])
  end

  def audio_params
    params.require(:audio).permit(:title, :audio_file)
  end

  def authorize_user(audio)
    return if audio.user == current_user

    redirect_to audios_path, alert: 'Not authorized to perform this action.'
  end
end
