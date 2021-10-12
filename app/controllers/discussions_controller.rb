class DiscussionsController < ApplicationController
  before_action :set_category
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
      if @discussion.save
        format.html { redirect_to [@category, @discussion], notice: "Discussion was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
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
