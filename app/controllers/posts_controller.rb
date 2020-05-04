class PostsController < ApplicationController

    before_action :ensure_author, only:[:edit, :update]

    def new 
        @post = Post.new 
        render :new
    end 

    def show 
        @post = Post.find(params[:id])
        render :show
    end

    def create
        @post = Post.new(post_params)
        @post.sub_id = params[:sub_id]

        if @post.save
        else
            flash[:errors] = @post.errors.full_messages
        end
        #redirect_to sub_posts(sub_id)
        redirect_to sub_url(@post.sub)
    end

    def destroy
        @post = Post.find(params[:id])
        @post.destroy
        redirect_to subs_url 
    end

    def edit
        @post = Post.find(params[:id])
        render :edit
    end

    def update
        @post = Post.find(params[:id])
        if @post.update(post_params) 
            redirect_to post_url(@post.id)
        else
            flash.now[:errors] = @post.errors.full_messages 
            render :edit 
        end
        # redirect_to post_url(@post.id) #are we redirecting the client to the current page
        #they are updating???
    end
    
    private 

    def post_params 
        params.require(:post).permit(:title, :url, :content, :sub_id)
    end

end

#QUESTION: which pages do we need and how do we know e.g update page?
