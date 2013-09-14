
class PostsController < ApplicationController
before_filter :signed_in_user
    def index
        @search=Post.search(params[:q])
        if params[:tag]
            @posts = Post.tagged_with(params[:tag])
            @page_title="Posts by Tag (" << params[:tag].upcase << ")"
        elsif params[:q]
            @posts=@search.result
            @page_title="Posts by Search Result"
        else
            @posts = Post.descending.paginate(page: params[:page], :per_page => 5) if signed_in?
            @page_title = "Recent Posts"
        end
    end

    def show
        @post = Post.find(params[:id])
        @search=Post.search(params[:q])

        @commentable = @post
        @comments = @commentable.comments
        @comment = Comment.new
    end

    def new
        @post = Post.new
    end

    def create
        @post = current_user.posts.build(params[:post])
        if @post.save
            redirect_to @post, :notice => "Blog post created."
        else
            render :action => 'new'
        end
    end

    def edit
        @post = Post.find(params[:id])
    end

    def update
        @post = Post.find(params[:id])
        if @post.update_attributes(params[:post])
            redirect_to @post, :notice => 'Updated Blog Post'
        else
            render :action => 'edit'
        end
    end

    def destroy
        @post = Post.find(params[:id])
        @post.destroy
        redirect_to posts_url, :notice => "Post Deleted."
    end

end


