package net.codejava.controller;

import java.sql.Date;

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
@RequestMapping("/admin")
public class AdminLoginController {
    
    @Autowired
    private AdminService adminService;

    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public ModelAndView showRegisterPage(HttpSession session) {
        System.out.println("GET /admin/register");

        if (session.getAttribute("admin") != null) {
            System.out.println("Admin đã đăng nhập, chuyển hướng đến dashboard");
            return new ModelAndView("redirect:/admin/dashboard");
        }
        return new ModelAndView("admin/register");
    }

    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public ModelAndView processRegister(
            @RequestParam String fullname,
            @RequestParam String email,
            @RequestParam String password,
            @RequestParam String confirmPassword,
            @RequestParam String phone,  // Thêm tham số phone
            HttpSession session) {

        System.out.println("POST /admin/register");
        System.out.println("Fullname: " + fullname);
        System.out.println("Email: " + email);
        System.out.println("Phone: " + phone);

        if (!password.equals(confirmPassword)) {
            System.out.println("Mật khẩu không khớp");
            ModelAndView mav = new ModelAndView("admin/register");
            mav.addObject("error", "Password and Confirm Password do not match");
            return mav;
        }

        if (adminService.emailExists(email)) {
            System.out.println("Email đã tồn tại: " + email);
            ModelAndView mav = new ModelAndView("admin/register");
            mav.addObject("error", "Email already exists");
            return mav;
        }

        if (adminService.phoneExists(phone)) {  // Thêm kiểm tra số điện thoại
            System.out.println("Số điện thoại đã tồn tại: " + phone);
            ModelAndView mav = new ModelAndView("admin/register");
            mav.addObject("error", "Phone number already exists");
            return mav;
        }

        Admin admin = new Admin();
        admin.setFullName(fullname);
        admin.setEmail(email);
        admin.setPassword(password);
        admin.setPhone(phone);  // Thiết lập số điện thoại


        adminService.register(admin);
        System.out.println("Đăng ký thành công cho: " + email);

        session.setAttribute("admin", admin);
        return new ModelAndView("redirect:/admin/dashboard");
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public ModelAndView showLoginPage(HttpSession session) {
        System.out.println("GET /admin/login");

        if (session.getAttribute("admin") != null) {
            System.out.println("Admin đã đăng nhập, chuyển hướng đến dashboard");
            return new ModelAndView("redirect:/admin/dashboard");
        }

        return new ModelAndView("admin/login");
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public ModelAndView processLogin(
            @RequestParam String email,
            @RequestParam String password,
            HttpSession session) {

        System.out.println("POST /admin/login");
        System.out.println("Email: " + email);

        Admin admin = adminService.login(email, password);

        if (admin != null) {
            System.out.println("Đăng nhập thành công: " + admin.getFullName());
            session.setAttribute("admin", admin);
            return new ModelAndView("redirect:/admin/dashboard");
        } else {
            System.out.println("Đăng nhập thất bại với email: " + email);
            ModelAndView mav = new ModelAndView("admin/login");
            mav.addObject("error", "Invalid email or password");
            return mav;
        }
    }

    @RequestMapping(value = "/dashboard", method = RequestMethod.GET)
    public ModelAndView showDashboard(HttpSession session) {
        System.out.println("GET /admin/dashboard");

        Admin admin = (Admin) session.getAttribute("admin");
        if (admin == null) {
            System.out.println("Chưa đăng nhập, chuyển hướng đến login");
            return new ModelAndView("redirect:/admin/login");
        }

        System.out.println("Đã đăng nhập với: " + admin.getFullName());
        ModelAndView mav = new ModelAndView("admin/dashboard");
        mav.addObject("message", "Hello " + admin.getFullName());
        return mav;
    }

    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public ModelAndView logout(HttpSession session) {
        System.out.println("GET /admin/logout - Đăng xuất");

        session.removeAttribute("admin");
        session.invalidate();
        return new ModelAndView("redirect:/admin/login");
    }
}
