package net.codejava.model;

import java.util.ArrayList;
import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "category")
public class Category {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "category_id")
    private Integer category_id;
    
    @Column(name = "category_name")
    private String categoryName;
    
    @Column(name = "description")
    private String description;
    
    // FIXED: Proper cascade configuration for JPA
    @OneToMany(
        mappedBy = "category",           
        cascade = CascadeType.ALL,       
        orphanRemoval = true,           
        fetch = FetchType.LAZY         
    )
    private List<Article> articles = new ArrayList<>();
    
    // Default constructor
    public Category() {
    }
    
    // Constructor with parameters
    public Category(Integer category_id, String categoryName, String description) {
        this.category_id = category_id;
        this.categoryName = categoryName;
        this.description = description;
    }
    
    // Helper methods to manage bidirectional relationship properly
    public void addArticle(Article article) {
        if (!articles.contains(article)) {
            articles.add(article);
            article.setCategory(this);
        }
    }
    
    public void removeArticle(Article article) {
        if (articles.contains(article)) {
            articles.remove(article);
            article.setCategory(null);
        }
    }
    
    // Method to clear all articles (useful for deletion)
    public void clearArticles() {
        for (Article article : new ArrayList<>(articles)) {
            removeArticle(article);
        }
    }
    
    // Getters and Setters
    public Integer getCategory_id() {
        return category_id;
    }
    
    public void setCategory_id(Integer category_id) {
        this.category_id = category_id;
    }
    
    public String getCategoryName() {
        return categoryName;
    }
    
    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public List<Article> getArticles() {
        return articles;
    }
    
    public void setArticles(List<Article> articles) {
        this.articles = articles;
    }
    
    @Override
    public String toString() {
        return "Category{" +
                "category_id=" + category_id +
                ", categoryName='" + categoryName + '\'' +
                ", description='" + description + '\'' +
                ", articlesCount=" + (articles != null ? articles.size() : 0) +
                '}';
    }
}