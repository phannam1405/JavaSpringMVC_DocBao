package net.codejava.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import net.codejava.repository.CommentRepository;
import net.codejava.model.Comment;
import net.codejava.model.Article;
import net.codejava.model.User;
import java.util.List;
import java.util.Date;

@Service
@Transactional
public class CommentService {
    @Autowired
    private CommentRepository commentRepo;
    
    // Lấy tất cả comment theo article_id
    public List<Comment> getCommentsByArticleId(int articleId) {
        return commentRepo.findByArticleID_ArticleIdOrderByCreatedAtDesc(articleId);
    }
    
    // Thêm comment mới
    public Comment addComment(Article article, User user, String content) {
        Comment comment = new Comment();
        comment.setArticleID(article);
        comment.setUserID(user);
        comment.setContent(content);
        comment.setCreatedAt(new Date());
        return commentRepo.save(comment);
    }
    
    // Lấy comment theo ID
    public Comment get(Integer id) {
        return commentRepo.findById(id).orElse(null);
    }
    
    // Xóa comment
    public void delete(Integer id) {
        commentRepo.deleteById(id);
    }
}