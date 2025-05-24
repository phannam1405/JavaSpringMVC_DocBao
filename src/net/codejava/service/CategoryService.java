package net.codejava.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.codejava.model.Category;
import net.codejava.repository.CategoryRepository;

@Service
@Transactional
public class CategoryService {
    @Autowired
    private CategoryRepository categoryRepo;
    
    public void saveCategory(Category category) {
        categoryRepo.save(category);
    }
    
    
    public List<Category> getAllCategories() {
        return (List<Category>) categoryRepo.findAll();
    }
    
    public Category getCategoryById(Integer id) {
        return categoryRepo.findById(id).orElse(null);
    }
}