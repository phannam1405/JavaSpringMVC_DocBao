package net.codejava.repository;

import org.springframework.data.repository.CrudRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import net.codejava.model.Comment;
import java.util.List;

public interface CommentRepository extends CrudRepository<Comment, Integer> {
    
    // Tìm comment theo article_id và sắp xếp theo thời gian tạo (mới nhất trước)
    @Query("SELECT c FROM Comment c WHERE c.articleID.article_id = :articleId ORDER BY c.createdAt DESC")
    List<Comment> findByArticleID_ArticleIdOrderByCreatedAtDesc(@Param("articleId") int articleId);
    
}