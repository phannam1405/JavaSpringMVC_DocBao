package net.codejava.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import javax.servlet.http.HttpSession;
import java.util.List;
import net.codejava.model.Article;
import net.codejava.model.Comment;
import net.codejava.model.User;
import net.codejava.service.ArticleService;
import net.codejava.service.CommentService;

@Controller
public class ClientArticleDetailController {
    
    @Autowired
    private ArticleService articleService;
    
    @Autowired
    private CommentService commentService;
    
    @GetMapping("/detail")
    public ModelAndView showArticleDetail(@RequestParam("id") int id) {
        ModelAndView mav = new ModelAndView("web/articleDetail");
        
        try {
            // Lấy bài viết chính
            Article mainArticle = articleService.get(id);
            if (mainArticle == null) {
                mav.setViewName("error/404");
                return mav;
            }
            mav.addObject("article", mainArticle);
            
            // Lấy các bài viết cùng category (trừ bài hiện tại)
            List<Article> relatedArticles = articleService.findByCategoryId(
                mainArticle.getCategory().getCategory_id(), 
                id 
            );
            mav.addObject("relatedArticles", relatedArticles);
            
            // Lấy danh sách comment của bài viết
            List<Comment> comments = commentService.getCommentsByArticleId(id);
            mav.addObject("comments", comments);
            
        } catch (Exception e) {
            e.printStackTrace();
            mav.setViewName("error/500");
        }
        
        return mav;
    }
    
    @PostMapping("/detail/comment")
    public ModelAndView addComment(
            @RequestParam("articleId") int articleId,
            @RequestParam("content") String content,
            HttpSession session) {
        
        ModelAndView mav = new ModelAndView("web/articleDetail"); // Giữ nguyên view
        
        try {
            // Kiểm tra đăng nhập
            User user = (User) session.getAttribute("user");
            if (user == null) {
                mav.addObject("error", "Bạn cần đăng nhập để bình luận!");
                return mav;
            }
            
            // Kiểm tra nội dung
            if (content == null || content.trim().isEmpty()) {
                mav.addObject("error", "Nội dung bình luận không được để trống!");
                return mav;
            }
            
            // Lưu comment
            Article article = articleService.get(articleId);
            commentService.addComment(article, user, content.trim());
            mav.addObject("success", "Bình luận đã được thêm thành công!");
            
            // Load lại toàn bộ dữ liệu
            mav.addObject("article", article);
            mav.addObject("relatedArticles", articleService.findByCategoryId(article.getCategory().getCategory_id(), articleId));
            mav.addObject("comments", commentService.getCommentsByArticleId(articleId));
            
        } catch (Exception e) {
            mav.addObject("error", "Có lỗi xảy ra khi thêm bình luận!");
        }
        
        return mav;
    }
}