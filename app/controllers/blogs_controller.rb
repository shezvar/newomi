class BlogsController < ApplicationController
  before_filter :get_blog, :only => [:show, :edit, :update, :destroy]

  def index
    #reset_session
    @blogs = Blog.all

    unless params[:tag].blank?
      @blogs = @blogs.tagged_with(params[:tag])
    end
    
    @blogs = @blogs.order('created_at DESC').paginate(:page => params[:page])
  end

  def new
    @blog = Blog.new
  end

  def show
  end

  def edit
  end

  def create
    @blog = Blog.new(blog_params)

    if @blog.save
      redirect_to root_path
    else
      redirect_to new_blogs_path
    end
  end

  def update
    if @blog.update(blog_params)
      redirect_to blog_path(@blog), notice: 'Blog was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @blog.destroy
    redirect_to root_path, notice: 'Blog was successfully destroyed.'
  end

  private
    def blog_params
      params.require(:blog).permit(
        :title,
        :author,
        :content,
        :embed_id,
        :tag_list
      )
    end

    def get_blog
      @blog = Blog.find(params[:id])
    end
end