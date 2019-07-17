# frozen_string_literal: true

class AuthorsController < ApplicationController
  def index
    @authors = Author.all.limit(30)
  end

  def show
    @author = Author.find_by(id: params[:id])
  end
end
