class SubsController < ApplicationController
    
    before_action :ensure_moderator, only:[:edit]

    def new
        @sub = Sub.new
        render :new 
    end

    def create
        @sub = Sub.new(sub_params)
        @sub.moderator_id = current_user.id 
        if @sub.save 
            #possible action this current redirect or maybe something else??
            redirect_to subs_url
        else 
            flash.now[:errors] = @sub.errors.full_messages
            render :new 
        end 
    end

    def edit 
        @sub = Sub.find_by(params[:id])
        render :edit 
    end

    def show
        @sub = Sub.find(params[:id])
        render :show 
    end

    def update
        @sub = Sub.find(params[:id])

        if @sub.update(sub_params)
        else 
            flash[errors] = @sub.errors.full_messages
        end 
        redirect_to sub_url(@sub.id) #come to this page regardless 
    end

    def index
        @subs = Sub.all.include(:username) #new school
        # @subs = Sub.all old school
        render :index 
    end

    private 
    def sub_params
        params.require(:sub).permit(:title, :description)
    end

end
