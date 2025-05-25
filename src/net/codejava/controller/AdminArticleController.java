package net.codejava.controller;

import java.io.IOException;
import java.nio.file.*;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
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
	public ModelAndView saveArticle(@RequestParam("title") String title,
			@RequestParam("short_content") String shortContent, @RequestParam("content") String content,
			@RequestParam(value = "image", required = false) MultipartFile imageFile,
			@RequestParam("breaking_news") int breakingNews, @RequestParam("headline") int headline,
			@RequestParam("created_at") String createdAt, @RequestParam("admin_id") int adminId,
			@RequestParam("category_id") int categoryId, HttpSession session, HttpServletRequest request)
			throws IOException {

		// Kiểm tra đăng nhập
		if (session.getAttribute("admin") == null) {
			return new ModelAndView("redirect:/admin/login");
		}

		// Xử lý upload ảnh
		String imagePath = null;
		if (imageFile != null && !imageFile.isEmpty()) {
			try {
				// 1. Xác định thư mục lưu trữ 
				String uploadDir = "/resources/uploads/";
				String physicalPath = request.getServletContext().getRealPath(uploadDir);

				// 2. Đảm bảo thư mục tồn tại
				Path uploadPath = Paths.get(physicalPath);
				if (!Files.exists(uploadPath)) {
					Files.createDirectories(uploadPath);
				}

				// 3. Tạo tên file an toàn
				String originalFilename = StringUtils.cleanPath(imageFile.getOriginalFilename());
				String fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));
				String newFilename = UUID.randomUUID().toString() + fileExtension;

				// 4. Lưu file
				Path filePath = uploadPath.resolve(newFilename);
				imageFile.transferTo(filePath.toFile());

				// 5. Lưu đường dẫn ảo (truy cập qua web)
				imagePath = newFilename;

				System.out.println("Ảnh được lưu tại: " + physicalPath);
				System.out.println("Truy cập qua URL: " + imagePath);

			} catch (Exception e) {
				throw new IOException("Lỗi khi lưu ảnh: " + e.getMessage());
			}
		}

		// Tạo và lưu bài viết
		Article article = new Article();
		article.setTitle(title);
		article.setShortContent(shortContent);
		article.setContent(content);
		article.setImage(imagePath);
		article.setBreakingNews(breakingNews);
		article.setHeadLine(headline);
		article.setCreatedAt(java.sql.Date.valueOf(createdAt));

		// Thiết lập quan hệ
		article.setAdmin(adminService.getAdminById(adminId));
		article.setCategory(categoryService.getCategoryById(categoryId));

		articleService.save(article);

		return new ModelAndView("redirect:/admin/dashboard");
	}
	
	
	@GetMapping("/deleteArticle/{id}")
	public ModelAndView deleteArticle(@PathVariable("id") int id, HttpSession session) {
	    if (session.getAttribute("admin") == null) {
	        return new ModelAndView("redirect:/admin/login");
	    }

	    articleService.deleteById(id);
	    return new ModelAndView("redirect:/admin/dashboard");
	}
	
	
	// Thêm vào AdminArticleController.java

	@GetMapping("/editArticle/{id}")
	public ModelAndView showEditArticlePage(@PathVariable("id") int id, HttpSession session) {
	    if (session.getAttribute("admin") == null) {
	        return new ModelAndView("redirect:/admin/login");
	    }
	    
	    ModelAndView mav = new ModelAndView("admin/editArticle");
	    Article article = articleService.get(id);
	    
	    mav.addObject("article", article);
	    mav.addObject("admins", adminService.getAllAdmins());
	    mav.addObject("categories", categoryService.getAllCategories());
	    
	    return mav;
	}

	@PostMapping("/updateArticle")
	public ModelAndView updateArticle(@RequestParam("article_id") int articleId,
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

	    // Kiểm tra đăng nhập
	    if (session.getAttribute("admin") == null) {
	        return new ModelAndView("redirect:/admin/login");
	    }

	    // Lấy bài viết hiện tại
	    Article existingArticle = articleService.get(articleId);
	    
	    // Xử lý upload ảnh nếu có
	    if (imageFile != null && !imageFile.isEmpty()) {
	        try {
	            // 1. Xác định thư mục lưu trữ
	            String uploadDir = "/resources/uploads/";
	            String physicalPath = request.getServletContext().getRealPath(uploadDir);

	            // 2. Đảm bảo thư mục tồn tại
	            Path uploadPath = Paths.get(physicalPath);
	            if (!Files.exists(uploadPath)) {
	                Files.createDirectories(uploadPath);
	            }

	            // 3. Xóa ảnh cũ nếu tồn tại
	            if (existingArticle.getImage() != null && !existingArticle.getImage().isEmpty()) {
	                Path oldFilePath = uploadPath.resolve(existingArticle.getImage());
	                try {
	                    Files.deleteIfExists(oldFilePath);
	                } catch (IOException e) {
	                    System.err.println("Không thể xóa ảnh cũ: " + e.getMessage());
	                }
	            }

	            // 4. Tạo tên file mới
	            String originalFilename = StringUtils.cleanPath(imageFile.getOriginalFilename());
	            String fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));
	            String newFilename = UUID.randomUUID().toString() + fileExtension;

	            // 5. Lưu file mới
	            Path filePath = uploadPath.resolve(newFilename);
	            imageFile.transferTo(filePath.toFile());

	            // 6. Cập nhật đường dẫn ảnh
	            existingArticle.setImage(newFilename);

	        } catch (Exception e) {
	            throw new IOException("Lỗi khi lưu ảnh: " + e.getMessage());
	        }
	    }

	    // Cập nhật thông tin bài viết
	    existingArticle.setTitle(title);
	    existingArticle.setShortContent(shortContent);
	    existingArticle.setContent(content);
	    existingArticle.setBreakingNews(breakingNews);
	    existingArticle.setHeadLine(headline);
	    existingArticle.setCreatedAt(java.sql.Date.valueOf(createdAt));

	    // Cập nhật quan hệ
	    existingArticle.setAdmin(adminService.getAdminById(adminId));
	    existingArticle.setCategory(categoryService.getCategoryById(categoryId));

	    // Lưu bài viết
	    articleService.save(existingArticle);

	    return new ModelAndView("redirect:/admin/dashboard");
	}
	
	//tìm kiếm
	// Thêm vào AdminArticleController.java
	@GetMapping("/searchArticles")
	public ModelAndView searchArticles(
	        @RequestParam(value = "title", required = false) String title,
	        @RequestParam(value = "createdAt", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date createdAt,
	        @RequestParam(value = "adminId", required = false) Integer adminId,
	        @RequestParam(value = "categoryId", required = false) Integer categoryId,
	        HttpSession session) {
	    
	    if (session.getAttribute("admin") == null) {
	        return new ModelAndView("redirect:/admin/login");
	    }
	    
	    List<Article> searchResults = articleService.searchArticles(title, createdAt, adminId, categoryId);
	    
	    ModelAndView mav = new ModelAndView("admin/dashboard");
	    mav.addObject("articles", searchResults);
	    mav.addObject("admins", adminService.getAllAdmins());
	    mav.addObject("categories", categoryService.getAllCategories());
	    // Giữ lại các giá trị tìm kiếm
	    mav.addObject("searchTitle", title);
	    mav.addObject("searchCreatedAt", createdAt);
	    mav.addObject("searchAdminId", adminId);
	    mav.addObject("searchCategoryId", categoryId);
	    
	    return mav;
	}

}