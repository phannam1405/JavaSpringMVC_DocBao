package net.codejava.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import java.util.List;
import net.codejava.model.Article;
import net.codejava.service.ArticleService;

@Controller
public class ClientArticleDetailController {
    
    @Autowired
    private ArticleService articleService;
    
    @GetMapping("/detail")
    public ModelAndView showArticleDetail(@RequestParam("id") int id) {
        ModelAndView mav = new ModelAndView("web/articleDetail");
        
        // Lấy bài viết chính
        Article mainArticle = articleService.get(id);
        mav.addObject("article", mainArticle);
        
        // Lấy các bài viết cùng category (trừ bài hiện tại)
        List<Article> relatedArticles = articleService.findByCategoryId(
            mainArticle.getCategory().getCategory_id(), 
            id 
        );
        mav.addObject("relatedArticles", relatedArticles);
        
        return mav;
    }
}