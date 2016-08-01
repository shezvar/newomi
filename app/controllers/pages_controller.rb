class PagesController < ApplicationController
  layout 'landing'
  before_filter :authenticate_user!, only: :dashboard

  def home
  end

  def about
  end

  def admin
    @projects = Project.all
  end

  def new
    render layout: 'new_landing'
  end

  def new_product
    render layout: 'new_landing'
  end

  def new_single_product
    render layout: 'new_landing'
  end

  def new_journal
    render layout: 'new_landing'
  end

  def new_single_journal
    render layout: 'new_landing'
  end

  def new_about
    render layout: 'new_landing'
  end

  def dashboard
    @ideas = Idea.all.order(cached_votes_up: :desc).limit(10)
    @projects = Project.all.order(created_at: :desc).limit(5)
    render layout: 'application'
  end
end