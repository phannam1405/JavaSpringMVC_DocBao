package net.codejava.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;


import net.codejava.model.User;

import net.codejava.service.UserService;

@Controller
public class ClientLoginController {
	
    @Autowired
    private UserService userService;
	
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public ModelAndView showLoginPage(HttpSession session) {

        if (session.getAttribute("user") != null) {
            return new ModelAndView("redirect:/");
        }

        return new ModelAndView("web/login");
    }
    
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public ModelAndView processLogin(
            @RequestParam String email,
            @RequestParam String password,
            HttpSession session) {

     

        User user = userService.login(email, password);

        if (user != null) {
            session.setAttribute("user", user);
            return new ModelAndView("redirect:/");
        } else {
            System.out.println("Đăng nhập thất bại với email: " + email);
            ModelAndView mav = new ModelAndView("web/login");
            mav.addObject("error", "Invalid email or password");
            return mav;
        }
    }
    
    //đăng ký
    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public ModelAndView showRegisterPage(HttpSession session) {
  
        if (session.getAttribute("user") != null) {
            return new ModelAndView("redirect:/");
        }
        return new ModelAndView("web/register");
    }

    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public ModelAndView processRegister(
            @RequestParam String fullname,
            @RequestParam String email,
            @RequestParam String password,
            @RequestParam String confirmPassword,
            @RequestParam String phone,  
            HttpSession session) {



        if (!password.equals(confirmPassword)) {
            System.out.println("Mật khẩu không khớp");
            ModelAndView mav = new ModelAndView("web/register");
            mav.addObject("error", "Password and Confirm Password do not match");
            return mav;
        }

        if (userService.emailExists(email)) {
            System.out.println("Email đã tồn tại: " + email);
            ModelAndView mav = new ModelAndView("web/register");
            mav.addObject("error", "Email already exists");
            return mav;
        }

        if (userService.phoneExists(phone)) {  
        	System.out.println("Số điện thoại đã tồn tại: " + phone);
            ModelAndView mav = new ModelAndView("web/register");
            mav.addObject("error", "Phone number already exists");
            return mav;
        }
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
     // Mã hóa mật khẩu
        String hashedPassword = passwordEncoder.encode(password);
        
        User user = new User();
        user.setFullName(fullname);
        user.setEmail(email);
        user.setPassword(hashedPassword);
        user.setPhone(phone); 


        userService.register(user);
        System.out.println("Đăng ký thành công cho: " + email);

        session.setAttribute("user", user);
        return new ModelAndView("redirect:/");
    }

    
    @RequestMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }

}
