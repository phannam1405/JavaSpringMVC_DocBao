package net.codejava.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import net.codejava.model.Article;
import net.codejava.model.Category;
import net.codejava.repository.ArticleRepository;
import net.codejava.repository.CategoryRepository;

@Controller
public class MainController {
    
    @Autowired
    private ArticleRepository articleRepository;
    
    @Autowired
    private CategoryRepository categoryRepository;
    
    @RequestMapping("/")
    public ModelAndView home() {
        ModelAndView mav = new ModelAndView("web/index");
        
        // Lấy 5 bài viết có headline = 1
        List<Article> topHeadlines = articleRepository.findTopHeadlines();
        if (topHeadlines.size() > 5) {
            topHeadlines = topHeadlines.subList(0, 5);
        }
        
        // Lấy bài viết breaking news
        List<Article> breakingNewsList = articleRepository.findBreakingNews();
        Article breakingNews = null;
        if (!breakingNewsList.isEmpty()) {
            breakingNews = breakingNewsList.get(0); 
        }
        
        // Lấy 3 thể loại có nhiều bài viết nhất
        List<Category> topCategories = categoryRepository.findTop3CategoriesByArticleCount();
        if (topCategories.size() > 3) {
            topCategories = topCategories.subList(0, 3);
        }
        
        // Lấy bài viết cho mỗi thể loại
        Map<String, List<Article>> categoryArticles = new HashMap<>();
        for (Category category : topCategories) {
            List<Article> articles = articleRepository.findByCategoryIdOrderByCreatedAtDesc(category.getCategory_id());
            // Lấy tối đa 6 bài cho mỗi thể loại
            if (articles.size() > 6) {
                articles = articles.subList(0, 6);
            }
            categoryArticles.put(category.getCategoryName().toLowerCase().replace(" ", ""), articles);
        }
        
        mav.addObject("mess", "hello");
        mav.addObject("topHeadlines", topHeadlines);
        mav.addObject("breakingNews", breakingNews);
        mav.addObject("topCategories", topCategories);
        mav.addObject("categoryArticles", categoryArticles);
        
        return mav;
    }
}