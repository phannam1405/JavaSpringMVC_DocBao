package net.codejava.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import net.codejava.model.Category;
import net.codejava.service.CategoryService;

@Controller
@RequestMapping("/admin")
public class AdminCategoryController {
    @Autowired
    private CategoryService categoryService;
    
    
    @RequestMapping(value = "/newCategory", method = RequestMethod.GET)
    public ModelAndView showNewArticlePage(HttpSession session) {
        if (session.getAttribute("admin") == null) {
            return new ModelAndView("redirect:/admin/login");
        }
        
        ModelAndView mav = new ModelAndView("admin/newCategory");
        return mav;
    }
    
    @RequestMapping(value = "/saveCategory", method = RequestMethod.POST)
    public ModelAndView saveCategory(
            @RequestParam("category_name") String categoryName,
            @RequestParam("description") String description,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        
        if (session.getAttribute("admin") == null) {
            return new ModelAndView("redirect:/admin/login");
        }
        
        Category category = new Category();
        category.setCategoryName(categoryName);
        category.setDescription(description);
        
        categoryService.saveCategory(category);
        
        redirectAttributes.addFlashAttribute("message", "Category added successfully!");
        return new ModelAndView("redirect:/admin/newCategory");
    }
}