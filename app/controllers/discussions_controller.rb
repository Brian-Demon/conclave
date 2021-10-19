class DiscussionsController < ApplicationController
  before_action :set_category, except: :destroy
  
  def show
    @discussion = Discussion.find(params[:id])
  end

  def new
    @discussion = @category.discussions.build(user: current_user)
  end

  def create
    @discussion = @category.discussions.build(discussion_params)
    @discussion.user = current_user
    
    respond_to do |format|
      if can?(:create, @discussion) && @discussion.save
        format.html { redirect_to [@category, @discussion], notice: "Discussion was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy 
    @discussion = Discussion.find(params[:id])
    @category = @discussion.category

    respond_to do |format|
      if can?(:delete, @discussion) && @discussion.destroy
        format.html { redirect_to @category, notice: "Discussion was successfully deleted." }
      else
        format.html { render @discussion, status: :unprocessable_entity }
      end
    end
  end

  def set_category
    @category = Category.find(params[:category_id])
  end

  private

  def discussion_params
    params.require(:discussion).permit(:title, :body)
  end
end
