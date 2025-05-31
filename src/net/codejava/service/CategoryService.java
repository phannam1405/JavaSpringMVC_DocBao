package net.codejava.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import net.codejava.model.Category;
import net.codejava.model.Article;
import net.codejava.repository.CategoryRepository;
import net.codejava.repository.ArticleRepository;

@Service
@Transactional
public class CategoryService {
    
    @Autowired
    private CategoryRepository categoryRepository;
    
    @Autowired
    private ArticleRepository articleRepository;
    
    public void saveCategory(Category category) {
        categoryRepository.save(category);
    }
    
    @Transactional(readOnly = true)
    public List<Category> getAllCategories() {
        return categoryRepository.findAll();
    }
    
    @Transactional(readOnly = true)
    public List<Category> getTop3CategoriesByArticleCount() {
        return categoryRepository.findTop3CategoriesByArticleCount();
    }
    
    @Transactional(readOnly = true)
    public Category getCategoryById(Integer id) {
        return categoryRepository.findById(id).orElse(null);
    }
    
    /**
     * Method 1: Using JPA Cascade (Recommended)
     * This should work if the entity relationships are configured correctly
     */
    @Transactional
    public void deleteCategoryById(Integer id) {
        try {
            Category category = categoryRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Category not found with id: " + id));
            
            // Force initialization of the articles collection to ensure cascade works
            int articleCount = category.getArticles().size();
            System.out.println("Deleting category '" + category.getCategoryName() + 
                             "' with " + articleCount + " articles");
            
            // Delete the category - cascade should handle articles
            categoryRepository.delete(category);
            
            System.out.println("Category deleted successfully via cascade");
            
        } catch (Exception e) {
            System.err.println("Cascade deletion failed: " + e.getMessage());
            e.printStackTrace();
            
            // Fallback to manual deletion
            System.out.println("Attempting manual deletion as fallback...");
            deleteCategoryManually(id);
        }
    }
    
    /**
     * Method 2: Manual deletion with explicit article removal
     * Use this as fallback or primary method if cascade doesn't work
     */
    @Transactional
    public void deleteCategoryManually(Integer id) {
        try {
            // Check if category exists
            Category category = categoryRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Category not found with id: " + id));
            
            String categoryName = category.getCategoryName();
            
            // Get all articles in this category
            List<Article> articles = articleRepository.findArticlesByCategoryId(id);
            int articleCount = articles.size();
            
            System.out.println("Manually deleting " + articleCount + 
                             " articles from category '" + categoryName + "'");
            
            // Delete articles first (to avoid constraint violation)
            for (Article article : articles) {
                // Break the relationship explicitly
                article.setCategory(null);
                articleRepository.delete(article);
            }
            
            // Now delete the category
            categoryRepository.delete(category);
            
            System.out.println("Category '" + categoryName + "' and " + 
                             articleCount + " articles deleted manually");
            
        } catch (Exception e) {
            System.err.println("Manual deletion failed: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Failed to delete category: " + e.getMessage(), e);
        }
    }
    
    /**
     * Method 3: Using custom repository method with JPQL
     * Most reliable method for complex deletion scenarios
     */
    @Transactional
    public void deleteCategoryWithJPQL(Integer id) {
        try {
            // Verify category exists and get info for logging
            Category category = categoryRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Category not found with id: " + id));
            
            String categoryName = category.getCategoryName();
            int articleCount = getArticleCountByCategory(id);
            
            // Delete articles first using JPQL
            if (articleCount > 0) {
                articleRepository.deleteArticlesByCategoryId(id);
                System.out.println("Deleted " + articleCount + " articles using JPQL");
            }
            
            // Delete category
            categoryRepository.deleteById(id);
            
            System.out.println("Category '" + categoryName + "' deleted using JPQL method");
            
        } catch (Exception e) {
            System.err.println("JPQL deletion failed: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Failed to delete category with JPQL: " + e.getMessage(), e);
        }
    }
    
    /**
     * Method 4: Using native SQL with foreign key handling
     * For databases with strict foreign key constraints
     */
    @Transactional
    public void deleteCategoryWithNativeSQL(Integer id) {
        try {
            
            Category category = categoryRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Category not found with id: " + id));
            
            String categoryName = category.getCategoryName();
            int articleCount = getArticleCountByCategory(id);
               
            
            if (articleCount > 0) {
                articleRepository.deleteArticlesByCategoryIdNative(id);
            }
            
            // Delete category
            categoryRepository.deleteById(id);
            
            
        } catch (Exception e) {
            System.err.println("Native SQL deletion failed, trying with FK checks disabled: " + e.getMessage());
            
        
            try {
                deleteCategoryWithFKDisabled(id);
            } catch (Exception e2) {
                System.err.println("FK disabled deletion also failed: " + e2.getMessage());
                throw new RuntimeException("All native SQL deletion methods failed: " + e2.getMessage(), e2);
            }
        }
    }
    
 
    @Transactional
    public void deleteCategoryWithFKDisabled(Integer id) {
        try {
            // Get category info before deletion
            Category category = categoryRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Category not found with id: " + id));
            
            String categoryName = category.getCategoryName();
            int articleCount = getArticleCountByCategory(id);
            
            System.out.println("Attempting deletion with FK checks disabled");
            
            // Disable foreign key checks
            articleRepository.disableForeignKeyChecks();
            
            try {
                // Delete articles
                if (articleCount > 0) {
                    articleRepository.batchDeleteArticlesByCategory(id);
                }
                
                // Delete category
                categoryRepository.deleteById(id);
                
                System.out.println("Successfully deleted category with FK checks disabled");
                
            } finally {
                // Always re-enable foreign key checks
                articleRepository.enableForeignKeyChecks();
            }
            
        } catch (Exception e) {
            // Make sure to re-enable FK checks even if deletion fails
            try {
                articleRepository.enableForeignKeyChecks();
            } catch (Exception fkException) {
                System.err.println("Failed to re-enable FK checks: " + fkException.getMessage());
            }
            
            throw new RuntimeException("Failed to delete with FK disabled: " + e.getMessage(), e);
        }
    }
    
    /**
     * Method 6: Individual entity deletion (safest but slowest)
     */
    @Transactional
    public void deleteCategoryIndividually(Integer id) {
        try {
            // Get category with all articles
            Category category = categoryRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Category not found with id: " + id));
            
            String categoryName = category.getCategoryName();
            List<Article> articles = getArticlesByCategory(id);
            
            System.out.println("Deleting " + articles.size() + " articles individually");
            
            // Delete each article individually
            for (Article article : articles) {
                try {
                    // Clear the relationship first
                    article.setCategory(null);
                    articleRepository.save(article); // Save the null relationship
                    articleRepository.delete(article); // Then delete
                    System.out.println("Deleted article: " + article.getTitle());
                } catch (Exception e) {
                    System.err.println("Failed to delete article " + article.getArticle_id() + ": " + e.getMessage());
                    // Continue with other articles
                }
            }
            
            // Now delete the category
            categoryRepository.delete(category);
            
            System.out.println("Category '" + categoryName + "' deleted individually");
            
        } catch (Exception e) {
            System.err.println("Individual deletion failed: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Failed to delete category individually: " + e.getMessage(), e);
        }
    }
    
    @Transactional(readOnly = true)
    public int getArticleCountByCategory(Integer categoryId) {
        return articleRepository.countByCategoryCategoryId(categoryId);
    }
    
    @Transactional(readOnly = true)
    public List<Article> getArticlesByCategory(Integer categoryId) {
        return articleRepository.findArticlesByCategoryId(categoryId);
    }
    

    @Transactional(readOnly = true)
    public Category getCategoryWithArticles(Integer id) {
        Category category = categoryRepository.findById(id).orElse(null);
        if (category != null) {
            // Force lazy loading
            int size = category.getArticles().size();
            System.out.println("Loaded category with " + size + " articles");
        }
        return category;
    }
    

    @Transactional
    public void safeDeletionCategory(Integer id) {
        System.out.println("Starting safe deletion for category ID: " + id);
        
        // Try methods in order of preference (safest to most aggressive)
        String[] methods = {"individual", "manual", "native", "jpql", "cascade", "fk-disabled"};
        
        for (String method : methods) {
            try {
                System.out.println("Attempting deletion method: " + method);
                
                switch (method) {
                    case "individual":
                        deleteCategoryIndividually(id);
                        System.out.println("SUCCESS: Individual deletion method worked!");
                        return;
                        
                    case "manual":
                        deleteCategoryManually(id);
                        System.out.println("SUCCESS: Manual deletion method worked!");
                        return;
                        
                    case "native":
                        deleteCategoryWithNativeSQL(id);
                        System.out.println("SUCCESS: Native SQL deletion method worked!");
                        return;
                        
                    case "jpql":
                        deleteCategoryWithJPQL(id);
                        System.out.println("SUCCESS: JPQL deletion method worked!");
                        return;
                        
                    case "cascade":
                        deleteCategoryById(id);
                        System.out.println("SUCCESS: Cascade deletion method worked!");
                        return;
                        
                    case "fk-disabled":
                        deleteCategoryWithFKDisabled(id);
                        System.out.println("SUCCESS: FK-disabled deletion method worked!");
                        return;
                }
                
            } catch (Exception e) {
                System.err.println("Method '" + method + "' failed: " + e.getMessage());
                // Continue to next method
            }
        }
        
        // If we get here, all methods failed
        throw new RuntimeException("All deletion methods failed for category ID: " + id + 
                                 ". Please check database constraints and entity relationships.");
    }
}