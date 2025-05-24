package net.codejava.controller;

import java.io.IOException;
import java.nio.file.*;
import java.util.Date;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import net.codejava.model.*;
import net.codejava.service.*;

@Controller
@RequestMapping("/admin")
public class AdminArticleController {
    @Autowired
    private AdminService adminService;
    @Autowired
    private CategoryService categoryService;
    @Autowired
    private ArticleService articleService;

    @GetMapping("/newArticle")
    public ModelAndView showNewArticlePage(HttpSession session) {
        if (session.getAttribute("admin") == null) {
            return new ModelAndView("redirect:/admin/login");
        }
        
        ModelAndView mav = new ModelAndView("admin/newArticle");
        mav.addObject("admins", adminService.getAllAdmins());
        mav.addObject("categories", categoryService.getAllCategories());
        return mav;
    }

    @PostMapping("/saveArticle")
    public ModelAndView saveArticle(
            @RequestParam("title") String title,
            @RequestParam("short_content") String shortContent,
            @RequestParam("content") String content,
            @RequestParam(value = "image", required = false) MultipartFile imageFile,
            @RequestParam("breaking_news") int breakingNews,
            @RequestParam("headline") int headline,
            @RequestParam("created_at") String createdAt,
            @RequestParam("admin_id") int adminId,
            @RequestParam("category_id") int categoryId,
            HttpSession session,
            HttpServletRequest request) throws IOException {
        
        if (session.getAttribute("admin") == null) {
            return new ModelAndView("redirect:/admin/login");
        }

        // Xử lý upload ảnh
        String imagePath = null;
        if (!imageFile.isEmpty()) {
            String uploadDir = request.getServletContext().getRealPath("/resources/uploads/");
            String originalFilename = imageFile.getOriginalFilename();
            String fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));
            String newFilename = System.currentTimeMillis() + fileExtension;
            
            Path uploadPath = Paths.get(uploadDir);
            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath);
            }
            
            Path filePath = uploadPath.resolve(newFilename);
            imageFile.transferTo(filePath.toFile());
            imagePath = "/resources/uploads/" + newFilename;
        }

        // Tạo đối tượng Article và lưu vào database
        Article article = new Article();
        article.setTitle(title);
        article.setShortContent(shortContent);
        article.setContent(content);
        article.setImage(imagePath);
        article.setBreakingNews(breakingNews);
        article.setHeadLine(headline);
        article.setCreatedAt(java.sql.Date.valueOf(createdAt));
        
        // Lấy Admin và Category từ ID
        Admin admin = adminService.getAdminById(adminId);
        Category category = categoryService.getCategoryById(categoryId);
        
       
        article.setAdmin(adminService.getAdminById(adminId));
        article.setCategory(categoryService.getCategoryById(categoryId));
        System.out.println("Title: " + title);
        System.out.println("Short Content: " + shortContent);
        System.out.println("url: " + imagePath);
        // Log các tham số khác...
        
        articleService.save(article);
        
        return new ModelAndView("redirect:/admin/dashboard");
    }
}