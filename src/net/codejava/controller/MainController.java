package net.codejava.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MainController {
	@RequestMapping("/")
	public ModelAndView home() {
		ModelAndView mav = new ModelAndView("web/index");
		mav.addObject("mess", "hello");
		
		return mav;
	}
}	
