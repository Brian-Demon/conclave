class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @discussion = @comment.discussion
    @category = @discussion.category

    respond_to do |format|
      if can?(:create, @comment) && @comment.save
        format.html { redirect_to [@category, @discussion], notice: "Comment posted!" }
      else
        format.html { render "discussions/show", error: "Comment could not be posted.", status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @discussion = @comment.discussion
    @category = @discussion.category

    respond_to do |format|
      if can?(:delete, @comment) && @comment.destroy
        format.html { redirect_to [@category, @discussion], notice: "Comment deleted" }
        format.json { render json: { message: "Comment deleted" }  }
      else
        format.html { render "discussions/show", status: :unprocessable_entity }
        format.json { render json: { message: "Comment could not be deleted" }, status: :unprocessable_entity  }
      end
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    @discussion = @comment.discussion
    unless can? :update, @comment
      redirect_back(fallback_location: root_url)
    end
  end

  def update
    @comment = Comment.find(params[:id])
    @discussion = @comment.discussion
    @category = @discussion.category

    respond_to do |format|
      if can?(:update, @comment) && @comment.update(comment_params)
        format.html { redirect_to [@category, @discussion], notice: "Comment was successfully updated." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def preview
    markdown = MarkdownRenderer.render(params["content"])
    render json: { preview: markdown }
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :discussion_id)
  end
end
