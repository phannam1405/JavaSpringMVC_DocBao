package net.codejava.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import net.codejava.model.Article;
import net.codejava.repository.ArticleRepository;

@Controller
public class ClientSearchController {
    @Autowired
    private ArticleRepository articleRepository;
    
    @RequestMapping("/search")
    public ModelAndView search(@RequestParam("query") String keyword) {
        ModelAndView mav = new ModelAndView("web/search");
        
        // Tìm kiếm theo cả 3 tiêu chí
        List<Article> searchResults = articleRepository.searchAllFields(keyword);
        
        mav.addObject("searchResults", searchResults);
        mav.addObject("searchQuery", keyword);
        
        return mav;
    }
}
