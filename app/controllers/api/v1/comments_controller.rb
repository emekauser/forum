module Api
    module V1
       class CommentsController < ApplicationController
         before_action :set_post , only: [:create, :destroy, :update]
         before_action :set_comment, only: [:show, :update, :destroy]
         def create
            comment=Comment.new;
            comment.message=params[:message];
            comment.post_id=params[:post_id]
            if !@post
                render json: {status:"Error",message:"Wrong post id"}, status: :unprocessable_entity 
            end
            if !@post.comment_count
              @post.comment_count=0;
            end
            @post.comment_count=@post.comment_count+1
            @post.save
            if comment.save
                render json: {status:"OK",message:"created post", data:comment}, status: :ok 
            else
                render json: {status:"Error",message:comment.errors.full_messages.to_sentence}, status: :unprocessable_entity 
            end 
         end

          def index
            comments=Comment.order('created_at DESC');
            render json: {status:"OK",message:"loaded comments", data:comments}, status: :ok
          end 

          def show
            render json: {status:"OK",message:"loaded comment", data:@comment}, status: :ok 
            
          end
        
          def update
               @comment.message=params[:message];
               if @comment.save
                  render json: {status:"OK",message:"updated comment", data:@comment}, status: :ok 
               else
                  render json: {status:"Error",message:@comment.errors.full_messages.to_sentence}, status: :unprocessable_entity 
              
              end
           end

           def destroy
            @comment.destroy
            @post.comment_count=@post.comment_count-1
            @post.save
            render json: {status:"OK",message:"Comment deleted", data:@comment}, status: :ok 
           end


           def set_post
            @post = Post.find(params[:post_id])
            rescue ActiveRecord::RecordNotFound => e
              render json: {status:"Error",message:e.to_s}, status: :not_found
           end
        
           def set_comment
             @comment = Comment.find_by!(id: params[:id]) 
            rescue ActiveRecord::RecordNotFound => e
              render json: {status:"Error",message:e.to_s}, status: :not_found
           end

       end
    end
end