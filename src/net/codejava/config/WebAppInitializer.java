package net.codejava.config;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRegistration;

import org.springframework.web.WebApplicationInitializer;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
import org.springframework.web.servlet.DispatcherServlet;

//WebAppInitializer: là một interface trong Spring, thay thế cho việc cấu hình trong web.xml
public class WebAppInitializer implements WebApplicationInitializer{

	//Khi ứng dụng khởi động, Spring sẽ tự động gọi phương thức onStartup() để khởi tạo ứng dụng.
	@Override
	public void onStartup(ServletContext servletContext) throws ServletException {
		//AnnotationConfigWebApplicationContext dùng để cấu hình Spring thông qua các class đánh dấu @Configuration.
		AnnotationConfigWebApplicationContext appContext = new AnnotationConfigWebApplicationContext();
		appContext.register(WebMvcConfig.class); // dùng class WebMvcConfig (được đánh dấu @Configuration) để lấy tất cả các cấu hình và bean trong đó.
		
		//DispatcherServlet: Là trung tâm điều phối trong Spring MVC, tiếp nhận tất cả request từ người dùng rồi phân phối đến controller phù hợp.
		//Đăng ký servlet với tên "SpringDispatcher" và truyền vào DispatcherServlet dùng appContext
		ServletRegistration.Dynamic dispatcher = servletContext.addServlet
				("SpringDispatcher", new DispatcherServlet(appContext));
		dispatcher.setLoadOnStartup(1); //Servlet sẽ được load khi server khởi động, thay vì đợi khi có request đầu tiên.
		dispatcher.addMapping("/"); //tất cả các request (/) đều được DispatcherServlet xử lý hay dùng để chỉ định URL pattern là /
	}

}
