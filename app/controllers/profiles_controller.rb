# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :load_profile, only: %i[show edit update]
  before_action :check_profile_access!
  attr_accessor :profile

  def index
    @profiles = if params[:search].present?
                  Profile.search(params[:search], load: true)
                else
                  Profile.all
                end
  end

  def show
    @users = User.all
    @user = @profile.user
    @posts = @profile.posts
  end

  def edit; end

  def update
    change_avatar if params[:avatar]
    if @profile.update(profile_params)
      redirect_to profile_path(profile), notice: t('controllers.profile.successfully_changed')
    else
      render :edit
    end
  end

  private

  def check_profile_access!
    if current_user.profile.id != params[:id].to_i
      redirect_to profile_path(current_user.profile), notice: 'Access closed'
    end
  end

  def change_avatar
    params[:avatar].empty? ? current_user.profile.avatar.purge : current_user.profile.avatar.attach(params[:avatar])
  end

  def load_profile
    @profile = Profile.find(params[:id])
  end

  def profile_params
    params.require(:profile).permit(:first_name, :second_name, :birthday, :avatar, :locate)
  end
end
