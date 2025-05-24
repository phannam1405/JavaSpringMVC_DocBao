package net.codejava.service;

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
}
