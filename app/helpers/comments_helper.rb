module CommentsHelper
    def cache_key_for_comment_row(comment)
        "comment-#{comment.id}-#{comment.updated_at}"
    end
    def cache_key_for_comments_table(restaurant)
        "comments-table-#{restaurant.id}-#{restaurant.comments.maximum(:updated_at)}"
    end
end
