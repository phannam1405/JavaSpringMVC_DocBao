package net.codejava.repository;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import net.codejava.model.Article;

public interface ArticleRepository extends CrudRepository<Article, Integer>{
	List<Article> findAll(); 
	
	
	@Query("SELECT a FROM Article a WHERE " +
	       "(:title IS NULL OR a.title LIKE %:title%) AND " +
	       "(:createdAt IS NULL OR a.createdAt = :createdAt) AND " +
	       "(:adminId IS NULL OR a.admin.admin_id = :adminId) AND " +
	       "(:categoryId IS NULL OR a.category.category_id = :categoryId)")
	List<Article> searchArticles(
	        @Param("title") String title,
	        @Param("createdAt") Date createdAt,
	        @Param("adminId") Integer adminId,
	        @Param("categoryId") Integer categoryId);
}
