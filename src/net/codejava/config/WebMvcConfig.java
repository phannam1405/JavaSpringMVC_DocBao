package net.codejava.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;  
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

@Configuration //Ä�Ã¡nh dáº¥u Ä‘Ã¢y lÃ  má»™t class Java dÃ¹ng Ä‘á»ƒ cáº¥u hÃ¬nh Spring (thay cho file xml).
@EnableWebMvc // Báº­t Spring MVC.Cho phÃ©p xá»­ lÃ½ controller, view, vÃ  cÃ¡c config khÃ¡c cá»§a Spring Web MVC 
@ComponentScan("net.codejava") //Spring sáº½ quÃ©t cÃ¡c class trong package net.codejava Ä‘á»ƒ tÃ¬m nhá»¯ng class cÃ³ annotation nhÆ° @Controller, @Service, @Repository,.. vÃ  tá»± Ä‘á»™ng Ä‘Æ°a vÃ o Spring container
public class WebMvcConfig implements WebMvcConfigurer {  

	//Bean Ä‘Ã¡nh dáº¥u má»™t phÆ°Æ¡ng thá»©c tráº£ vá»� má»™t bean (Ä‘á»‘i tÆ°á»£ng) sáº½ Ä‘Æ°á»£c quáº£n lÃ½ bá»Ÿi Spring container
    @Bean
    public InternalResourceViewResolver viewResolver() {
    	//InternalResourceViewResolver LÃ  class giÃºp Spring biáº¿t Ä‘Æ°á»�ng dáº«n Ä‘á»ƒ tÃ¬m tá»›i file JSP
        InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
        viewResolver.setPrefix("/WEB-INF/views/");  //CÃ¡c file JSP sáº½ náº±m trong thÆ° má»¥c /WEB-INF/views/
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