package net.codejava.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import net.codejava.model.Article;
import net.codejava.repository.ArticleRepository;

@Controller
public class MainController {
    
    @Autowired
    private ArticleRepository articleRepository;
    
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
        
        mav.addObject("mess", "hello");
        mav.addObject("topHeadlines", topHeadlines);
        mav.addObject("breakingNews", breakingNews);
        
        return mav;
    }
}