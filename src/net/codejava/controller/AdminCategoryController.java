package net.codejava.controller;

import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import net.codejava.model.Article;
import net.codejava.model.Category;
import net.codejava.service.CategoryService;

@Controller
@RequestMapping("/admin")
public class AdminCategoryController {
    
    @Autowired
    private CategoryService categoryService;
    
    @RequestMapping(value = "/newCategory", method = RequestMethod.GET)
    public ModelAndView showNewCategoryPage(HttpSession session) {
        if (session.getAttribute("admin") == null) {
            return new ModelAndView("redirect:/admin/login");
        }
        
        ModelAndView mav = new ModelAndView("admin/newCategory");
        
        // Get all categories to display
        List<Category> categories = categoryService.getAllCategories();
        mav.addObject("categories", categories);
        
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
        
        try {
            Category category = new Category();
            category.setCategoryName(categoryName);
            category.setDescription(description);
            
            categoryService.saveCategory(category);
            
            redirectAttributes.addFlashAttribute("message", "Category added successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error adding category: " + e.getMessage());
        }
        
        return new ModelAndView("redirect:/admin/newCategory");
    }
    
    @RequestMapping(value = "/deleteCategory", method = RequestMethod.GET)
    public ModelAndView deleteCategory(
            @RequestParam("id") Integer categoryId,
            @RequestParam(value = "confirm", defaultValue = "false") boolean confirm,
            @RequestParam(value = "method", defaultValue = "safe") String deletionMethod,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        
        if (session.getAttribute("admin") == null) {
            return new ModelAndView("redirect:/admin/login");
        }
        
        try {
            if (confirm) {
                // Get information before deletion for success message
                Category category = categoryService.getCategoryById(categoryId);
                if (category == null) {
                    redirectAttributes.addFlashAttribute("error", "Category not found!");
                    return new ModelAndView("redirect:/admin/newCategory");
                }
                
                String categoryName = category.getCategoryName();
                int articleCount = categoryService.getArticleCountByCategory(categoryId);
                
                // Choose deletion method based on parameter
                switch (deletionMethod.toLowerCase()) {
                    case "cascade":
                        categoryService.deleteCategoryById(categoryId);
                        break;
                    case "manual":
                        categoryService.deleteCategoryManually(categoryId);
                        break;
                    case "jpql":
                        categoryService.deleteCategoryWithJPQL(categoryId);
                        break;
                    default:
                        // Safe deletion tries multiple methods
                        categoryService.safeDeletionCategory(categoryId);
                        break;
                }
                
                redirectAttributes.addFlashAttribute("message", 
                    "Category '" + categoryName + "' and " + articleCount + 
                    " related articles deleted successfully using " + deletionMethod + " method!");
                    
            } else {
                // Show confirmation page
                Category category = categoryService.getCategoryById(categoryId);
                
                if (category == null) {
                    redirectAttributes.addFlashAttribute("error", "Category not found!");
                    return new ModelAndView("redirect:/admin/newCategory");
                }
                
                int articleCount = categoryService.getArticleCountByCategory(categoryId);
                List<Article> articles = categoryService.getArticlesByCategory(categoryId);
                
                ModelAndView mav = new ModelAndView("admin/confirmDeleteCategory");
                mav.addObject("category", category);
                mav.addObject("articleCount", articleCount);
                mav.addObject("articles", articles);
                return mav;
            }
        } catch (Exception e) {
            System.err.println("Error in deleteCategory controller: " + e.getMessage());
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", 
                "Error deleting category: " + e.getMessage() + 
                ". Please try a different deletion method.");
        }
        
        return new ModelAndView("redirect:/admin/newCategory");
    }
    
    // View category details
    @RequestMapping(value = "/viewCategory", method = RequestMethod.GET)
    public ModelAndView viewCategoryDetails(
            @RequestParam("id") Integer categoryId,
            HttpSession session) {
        
        if (session.getAttribute("admin") == null) {
            return new ModelAndView("redirect:/admin/login");
        }
        
        try {
            Category category = categoryService.getCategoryById(categoryId);
            
            if (category == null) {
                return new ModelAndView("redirect:/admin/newCategory");
            }
            
            List<Article> articles = categoryService.getArticlesByCategory(categoryId);
            int articleCount = categoryService.getArticleCountByCategory(categoryId);
            
            ModelAndView mav = new ModelAndView("admin/categoryDetails");
            mav.addObject("category", category);
            mav.addObject("articles", articles);
            mav.addObject("articleCount", articleCount);
            
            return mav;
        } catch (Exception e) {
            return new ModelAndView("redirect:/admin/newCategory");
        }
    }
    
    // Edit category
    @RequestMapping(value = "/editCategory", method = RequestMethod.GET)
    public ModelAndView showEditCategoryPage(
            @RequestParam("id") Integer categoryId,
            HttpSession session) {
        
        if (session.getAttribute("admin") == null) {
            return new ModelAndView("redirect:/admin/login");
        }
        
        Category category = categoryService.getCategoryById(categoryId);
        
        if (category == null) {
            return new ModelAndView("redirect:/admin/newCategory");
        }
        
        ModelAndView mav = new ModelAndView("admin/editCategory");
        mav.addObject("category", category);
        
        return mav;
    }
    
    @RequestMapping(value = "/updateCategory", method = RequestMethod.POST)
    public ModelAndView updateCategory(
            @RequestParam("category_id") Integer categoryId,
            @RequestParam("category_name") String categoryName,
            @RequestParam("description") String description,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        
        if (session.getAttribute("admin") == null) {
            return new ModelAndView("redirect:/admin/login");
        }
        
        try {
            Category category = categoryService.getCategoryById(categoryId);
            
            if (category == null) {
                redirectAttributes.addFlashAttribute("error", "Category not found!");
                return new ModelAndView("redirect:/admin/newCategory");
            }
            
            category.setCategoryName(categoryName);
            category.setDescription(description);
            
            categoryService.saveCategory(category);
            
            redirectAttributes.addFlashAttribute("message", "Category updated successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error updating category: " + e.getMessage());
        }
        
        return new ModelAndView("redirect:/admin/newCategory");
    }
    
    // Quick delete method with method selection
    @RequestMapping(value = "/deleteCategoryQuick", method = RequestMethod.POST)
    public ModelAndView deleteCategoryQuick(
            @RequestParam("id") Integer categoryId,
            @RequestParam(value = "method", defaultValue = "safe") String deletionMethod,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        
        if (session.getAttribute("admin") == null) {
            return new ModelAndView("redirect:/admin/login");
        }
        
        try {
            Category category = categoryService.getCategoryById(categoryId);
            
            if (category == null) {
                redirectAttributes.addFlashAttribute("error", "Category not found!");
                return new ModelAndView("redirect:/admin/newCategory");
            }
            
            String categoryName = category.getCategoryName();
            int articleCount = categoryService.getArticleCountByCategory(categoryId);
            
            // Use the specified deletion method
            switch (deletionMethod.toLowerCase()) {
                case "cascade":
                    categoryService.deleteCategoryById(categoryId);
                    break;
                case "manual":
                    categoryService.deleteCategoryManually(categoryId);
                    break;
                case "jpql":
                    categoryService.deleteCategoryWithJPQL(categoryId);
                    break;
                default:
                    categoryService.safeDeletionCategory(categoryId);
                    break;
            }
            
            redirectAttributes.addFlashAttribute("message", 
                "Category '" + categoryName + "' and " + articleCount + 
                " related articles deleted successfully using " + deletionMethod + " method!");
                
        } catch (Exception e) {
            System.err.println("Error in quick delete: " + e.getMessage());
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", 
                "Error deleting category: " + e.getMessage());
        }
        
        return new ModelAndView("redirect:/admin/newCategory");
    }
}