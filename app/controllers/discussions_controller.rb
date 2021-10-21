class DiscussionsController < ApplicationController
  before_action :set_category, except: [:destroy, :lock, :unlock, :pin, :unpin]
  
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

  def lock
    @discussion = Discussion.find(params[:id])
    @category = @discussion.category

    respond_to do |format|
      if can?(:lock, @discussion)
        if @discussion.lock
          format.html { redirect_to [@category, @discussion], notice: "Discussion was successfully locked." }
        else
          format.html { redirect_to [@category, @discussion], notice: "Discussion could not be locked.", status: :unprocessable_entity }
        end
      else
        format.html { redirect_to [@category, @discussion], status: 403 }
      end
    end
  end

  def unlock
    @discussion = Discussion.find(params[:id])
    @category = @discussion.category

    respond_to do |format|
      if can?(:unlock, @discussion)
        if @discussion.unlock
          format.html { redirect_to [@category, @discussion], notice: "Discussion was successfully unlocked." }
        else
          format.html { redirect_to [@category, @discussion], notice: "Discussion could not be unlocked.", status: :unprocessable_entity }
        end
      else
        format.html { redirect_to [@category, @discussion], status: 403 }
      end
    end
  end

  def pin
    @discussion = Discussion.find(params[:id])
    @category = @discussion.category

    respond_to do |format|
      if can?(:pin, @discussion)
        if @discussion.pin
          format.html { redirect_to [@category, @discussion], notice: "Discussion was successfully pinned." }
        else
          format.html { redirect_to [@category, @discussion], notice: "Discussion could not be pinned.", status: :unprocessable_entity }
        end
      else
        format.html { redirect_to [@category, @discussion], status: 403 }
      end
    end
  end

  def unpin
    @discussion = Discussion.find(params[:id])
    @category = @discussion.category

    respond_to do |format|
      if can?(:unpin, @discussion)
        if @discussion.unpin
          format.html { redirect_to [@category, @discussion], notice: "Discussion was successfully unpinned." }
        else
          format.html { redirect_to [@category, @discussion], notice: "Discussion could not be unpinned.", status: :unprocessable_entity }
        end
      else
        format.html { redirect_to [@category, @discussion], status: 403 }
      end
    end
  end

  private

  def discussion_params
    params.require(:discussion).permit(:title, :body)
  end
end
