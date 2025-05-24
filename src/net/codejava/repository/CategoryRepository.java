package net.codejava.repository;

import org.springframework.data.repository.CrudRepository;


import net.codejava.model.Category;

public interface CategoryRepository extends CrudRepository<Category, Integer>{

}
