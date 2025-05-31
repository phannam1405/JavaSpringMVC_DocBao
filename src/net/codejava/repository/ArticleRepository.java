package net.codejava.repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;
import net.codejava.model.Article;

public interface ArticleRepository extends CrudRepository<Article, Integer> {
    
    List<Article> findAll(); 
    
    @Query("SELECT a FROM Article a WHERE a.category.category_id = :categoryId AND a.article_id != :excludeId ORDER BY a.createdAt DESC")
    List<Article> findByCategoryId(@Param("categoryId") int categoryId, 
                                 @Param("excludeId") int excludeId);
    
    @Query("SELECT a FROM Article a WHERE a.headLine = 1 ORDER BY a.createdAt DESC")
    List<Article> findTopHeadlines();
    
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
    
    @Query("SELECT a FROM Article a WHERE " +
            "(LOWER(a.title) LIKE LOWER(CONCAT('%', :keyword, '%'))) OR " +
            "(LOWER(a.category.categoryName) LIKE LOWER(CONCAT('%', :keyword, '%'))) OR " +
            "(LOWER(a.admin.fullName) LIKE LOWER(CONCAT('%', :keyword, '%')))")
    List<Article> searchAllFields(@Param("keyword") String keyword);
    
    @Query("SELECT a FROM Article a WHERE a.category.category_id = :categoryId ORDER BY a.createdAt DESC")
    List<Article> findByCategoryIdOrderByCreatedAtDesc(@Param("categoryId") int categoryId);
    
    @Query("SELECT a FROM Article a WHERE a.category.category_id = :categoryId ORDER BY a.createdAt DESC")
    List<Article> findTopArticleByCategory(@Param("categoryId") int categoryId);
    
    // Count articles by category
    @Query("SELECT COUNT(a) FROM Article a WHERE a.category.category_id = :categoryId")
    int countByCategoryCategoryId(@Param("categoryId") Integer categoryId);
    
    // Find articles by category ID
    @Query("SELECT a FROM Article a WHERE a.category.category_id = :categoryId ORDER BY a.createdAt DESC")
    List<Article> findArticlesByCategoryId(@Param("categoryId") Integer categoryId);
    
    // ADDED: Method to delete articles by category ID using JPQL
    @Modifying
    @Transactional
    @Query("DELETE FROM Article a WHERE a.category.category_id = :categoryId")
    void deleteArticlesByCategoryId(@Param("categoryId") Integer categoryId);
    
    // ADDED: Alternative method using native SQL if JPQL doesn't work
    @Modifying
    @Transactional
    @Query(value = "DELETE FROM article WHERE category_id = :categoryId", nativeQuery = true)
    void deleteArticlesByCategoryIdNative(@Param("categoryId") Integer categoryId);
    
    // ADDED: Method to update articles to set category to null before deletion
    @Modifying
    @Transactional
    @Query("UPDATE Article a SET a.category = NULL WHERE a.category.category_id = :categoryId")
    void nullifyCategoryReferences(@Param("categoryId") Integer categoryId);
    
    // ADDED: Native SQL method to disable/enable foreign key checks (MySQL specific)
    @Modifying
    @Transactional
    @Query(value = "SET FOREIGN_KEY_CHECKS = 0", nativeQuery = true)
    void disableForeignKeyChecks();
    
    @Modifying
    @Transactional
    @Query(value = "SET FOREIGN_KEY_CHECKS = 1", nativeQuery = true)
    void enableForeignKeyChecks();
    
    // ADDED: Batch delete method for better performance
    @Modifying
    @Transactional
    @Query(value = "DELETE FROM article WHERE category_id = :categoryId ORDER BY article_id", nativeQuery = true)
    void batchDeleteArticlesByCategory(@Param("categoryId") Integer categoryId);
}