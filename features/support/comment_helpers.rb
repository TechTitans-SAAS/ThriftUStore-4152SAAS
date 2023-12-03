# features/support/comment_helpers.rb

module CommentHelpers
  def create_comment(text)
    Comment.create(body: text, user: current_user)
  end
end

World(CommentHelpers)
