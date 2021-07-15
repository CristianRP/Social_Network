# frozen_string_literal: true

class StaticPagesController < ApplicationController
  layout 'static_pages'
  def home; end

  def help; end

  def about; end
end
