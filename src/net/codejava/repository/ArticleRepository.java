package net.codejava.repository;

import org.springframework.data.repository.CrudRepository;

import net.codejava.model.Article;

public interface ArticleRepository extends CrudRepository<Article, Integer>{

}
