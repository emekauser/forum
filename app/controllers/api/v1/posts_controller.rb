module Api
    module V1
       class PostsController < ApplicationController
         def create
            post=Post.new;
            title=params[:title]
            post.title=title;
            post.content=params[:content]
            post.title_link=title.split(" ").join("_")
            #post.created_by=1

            if post.save
                render json: {status:"OK",message:"created post", data:post}, status: :ok 
            else
                render json: {status:"Error",message:post.errors.full_messages.to_sentence}, status: :unprocessable_entity 
            end 
         end

          def index
            posts=Post.order('created_at DESC');
            render json: {status:"OK",message:"loaded post", data:posts}, status: :ok
          end 

          def show
            post=Post.find(params[:id]);
            render json: {status:"OK",message:"loaded post", data:post}, status: :ok 
            
            rescue ActiveRecord::RecordNotFound => e
              render json: {status:"Error",message:e.to_s}, status: :not_found
            
          end
        
          def update
               post=Post.find(params[:id]);
               title=params[:title]
               if title!=nil
                 post.title=title;
                 post.title_link=title.split(" ").join("_")
               end
               if params[:content]!=nil
                 post.content=params[:content]
               end

               if post.save
                  render json: {status:"OK",message:"updated post", data:post}, status: :ok 
               else
                  render json: {status:"Error",message:post.errors.full_messages.to_sentence}, status: :unprocessable_entity 
              
              end
           end

       end
    end
end