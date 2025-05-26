package net.codejava.repository;

import java.util.List;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import net.codejava.model.Article;

public interface ArticleRepository extends CrudRepository<Article, Integer>{
    List<Article> findAll(); 
    
    @Query("SELECT a FROM Article a WHERE a.category.category_id = :categoryId AND a.article_id != :excludeId ORDER BY a.createdAt DESC")
    List<Article> findByCategoryId(@Param("categoryId") int categoryId, 
                                 @Param("excludeId") int excludeId);
    
    // Lấy các bài viết có headline = 1, sắp xếp theo thời gian tạo mới nhất
    @Query("SELECT a FROM Article a WHERE a.headLine = 1 ORDER BY a.createdAt DESC")
    List<Article> findTopHeadlines();
    
    // Lấy bài viết breaking news (breaking_news = 1)
    @Query("SELECT a FROM Article a WHERE a.breakingNews = 1 ORDER BY a.createdAt DESC")
    List<Article> findBreakingNews();
    
    @Query("SELECT a FROM Article a WHERE " +
           "(:title IS NULL OR a.title LIKE %:title%) AND " +
           "(:createdAt IS NULL OR a.createdAt = :createdAt) AND " +
           "(:adminId IS NULL OR a.admin.admin_id = :adminId) AND " +
           "(:categoryId IS NULL OR a.category.category_id = :categoryId)")
    List<Article> searchArticles(
            @Param("title") String title,
            @Param("createdAt") java.util.Date createdAt,
            @Param("adminId") Integer adminId,
            @Param("categoryId") Integer categoryId);
}