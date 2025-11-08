class UsersController < ApplicationController
  def index
    @users = User.page(params[:page]).per(5).reverse_order
  end
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(8).reverse_order
    @following_users = @user.following_user
    @follower_users = @user.follower_user

    # 相互フォロー判定
    @is_mutual_follow = current_user.following_user.include?(@user) && 
                        @user.following_user.include?(current_user)
    # DM機能
    if @is_mutual_follow 
      @current_entry = Entry.where(user_id: current_user.id)
      @another_entry = Entry.where(user_id: @user.id)
      @is_room_id = false
      
      @current_entry.each do |current|
         @another_entry.each do |another|
           if current.room_id == another.room_id then
             @is_room_id = true
             @room_id = current.room_id
           end
         end
        end
        
        unless @is_room_id
          @room = Room.new
          @entry = Entry.new
          @room_id = @room.id
        end
      
        @message = Message.new if @is_mutual_follow
    end
  end
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to users_path(@user)
  end

  def follows
    user = User.find(params[:id])
    @users = user.following_user.page(params[:page]).per(3).reverse_order
  end
  
  def followers
    user = User.find(params[:id])
    @users = user.follower_user.page(params[:page]).per(3).reverse_order
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :profile, :profile_image)
  end
end
