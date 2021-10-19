require "test_helper"

class CommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup 
    @category = Category.new(name: "Test Category")
    @user = User.new
    @discussion = @category.discussions.build(user: @user, body: "Test Discussion")
  end

  def teardown
    Comment.delete_all
  end

  test "is valid" do
    @comment = Comment.new(discussion: @discussion, user: @user, body: "Lol comments")

    assert @comment.valid?
  end
  
  test "is invalid when no User is present" do
    @comment = Comment.new(discussion: @discussion, user: nil, body: "Lol comments")
    
    refute @comment.valid?
    assert_not_nil @comment.errors[:user], 'no validation error for user present'
  end

  test "is invalid when no Discussion is present" do
    @comment = Comment.new(discussion: nil, user: @user, body: "Lol comments")
    
    refute @comment.valid?
    assert_not_nil @comment.errors[:discussion], 'no validation error for discussion present'
  end
  
  test "is invalid when no body is present" do
    @comment = Comment.new(discussion: @discussion, user: @user, body: nil)
    
    refute @comment.valid?
    assert_not_nil @comment.errors[:body], 'no validation error for body present'
  end

  test "save creates Markdown formatted body" do
    @comment = Comment.new(discussion: @discussion, user: @user, body: "Lol comments")

    assert_nil @comment.formatted_body
    @comment.save
    assert_equal "<p>Lol comments</p>\n", @comment.formatted_body
  end

  test "save updates existing Markdown formatted body" do
    @comment = Comment.new(discussion: @discussion, user: @user, body: "Lol comments")
    @comment.assign_formatted_body
    refute_nil @comment.formatted_body
    @comment.body = "Something new"
    @comment.save
    assert_equal "<p>Something new</p>\n", @comment.formatted_body
  end
end
