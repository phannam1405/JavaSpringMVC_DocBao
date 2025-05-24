package net.codejava.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import net.codejava.model.Admin;
import net.codejava.service.AdminService;

@Controller
@RequestMapping("/admin") //url phải /admin trước
public class AdminLoginController {
    
    @Autowired
    private AdminService adminService;
    
    // Hiển thị trang đăng nhập
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public ModelAndView showLoginPage(HttpSession session) {
        // Nếu đã đăng nhập thì redirect thẳng đến dashboard
        if (session.getAttribute("admin") != null) {
            return new ModelAndView("redirect:/admin/dashboard");
        }
        
        ModelAndView mav = new ModelAndView("admin/login");
        return mav;
    }
    
    // Xử lý đăng nhập
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public ModelAndView processLogin(
            @RequestParam String email,
            @RequestParam String password,
            HttpSession session) {
        
        Admin admin = adminService.login(email, password);
        
        if (admin != null) {
            // Lưu thông tin admin vào session
            session.setAttribute("admin", admin);
            return new ModelAndView("redirect:/admin/dashboard");
        } else {
            ModelAndView mav = new ModelAndView("admin/login");
            mav.addObject("error", "Invalid email or password");
            return mav;
        }
    }
    
    // Trang dashboard sau khi đăng nhập thành công
    @RequestMapping(value = "/dashboard", method = RequestMethod.GET)
    public ModelAndView showDashboard(HttpSession session) {
        // Kiểm tra đăng nhập
        Admin admin = (Admin) session.getAttribute("admin");
        if (admin == null) {
            return new ModelAndView("redirect:/admin/login");
        }
        
        ModelAndView mav = new ModelAndView("admin/dashboard");
        mav.addObject("message", "Hello " + admin.getFullName());
        return mav;
    }
    
    // Đăng xuất
    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public ModelAndView logout(HttpSession session) {
        // Hủy session
        session.removeAttribute("admin");
        session.invalidate();
        return new ModelAndView("redirect:/admin/login");
    }
}