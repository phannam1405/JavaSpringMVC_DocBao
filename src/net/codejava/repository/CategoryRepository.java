package net.codejava.repository;

import java.util.List;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import net.codejava.model.Category;

public interface CategoryRepository extends CrudRepository<Category, Integer> {
    List<Category> findAll();
    
    // Lấy 3 thể loại có nhiều bài viết nhất
    @Query("SELECT c FROM Category c " +
           "LEFT JOIN Article a ON c.category_id = a.category.category_id " +
           "GROUP BY c.category_id, c.categoryName, c.description " +
           "ORDER BY COUNT(a.article_id) DESC")
    List<Category> findTop3CategoriesByArticleCount();
    
    
}