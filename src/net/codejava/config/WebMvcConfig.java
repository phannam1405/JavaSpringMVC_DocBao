package net.codejava.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;  
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

@Configuration //Đánh dấu đây là một class Java dùng để cấu hình Spring (thay cho file xml).
@EnableWebMvc // Bật Spring MVC.Cho phép xử lý controller, view, và các config khác của Spring Web MVC 
@ComponentScan("net.codejava") //Spring sẽ quét các class trong package net.codejava để tìm những class có annotation như @Controller, @Service, @Repository,.. và tự động đưa vào Spring container
public class WebMvcConfig implements WebMvcConfigurer {  

	//Bean đánh dấu một phương thức trả về một bean (đối tượng) sẽ được quản lý bởi Spring container
    @Bean
    public InternalResourceViewResolver viewResolver() {
    	//InternalResourceViewResolver Là class giúp Spring biết đường dẫn để tìm tới file JSP
        InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
        viewResolver.setPrefix("/WEB-INF/views/");  //Các file JSP sẽ nằm trong thư mục /WEB-INF/views/
        viewResolver.setSuffix(".jsp");            
        return viewResolver;
    }
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        
        registry.addResourceHandler("/resources/**")
                .addResourceLocations("/resources/");
        registry.addResourceHandler("/uploads/**")
        .addResourceLocations("file:/D:/java_web_doc_bao/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/TheNews/resources/uploads/");
    }
    
    
    @Bean
    public CommonsMultipartResolver multipartResolver() {
        CommonsMultipartResolver resolver = new CommonsMultipartResolver();
        resolver.setMaxUploadSize(15 * 1024 * 1024); // 15MB
        return resolver;
    }
}