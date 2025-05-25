package net.codejava.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.codejava.model.Article;
import net.codejava.repository.ArticleRepository;

@Service
@Transactional
public class ArticleService {
    @Autowired
    private ArticleRepository articleRepo;
    
    public void save(Article article) {
        articleRepo.save(article);
    }
    
    public List<Article> listAll() {
        return articleRepo.findAll();
    }
    
    public void deleteById(int id) {
        articleRepo.deleteById(id);
    }

    public Article get(int id) {
        return articleRepo.findById(id).get();
    }
    
 
    public List<Article> searchArticles(String title, Date createdAt, Integer adminId, Integer categoryId) {
        return articleRepo.searchArticles(title, createdAt, adminId, categoryId);
    }
}
