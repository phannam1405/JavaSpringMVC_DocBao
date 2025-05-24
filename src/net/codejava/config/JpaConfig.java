package net.codejava.config;

import javax.persistence.EntityManagerFactory;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.orm.jpa.LocalEntityManagerFactoryBean;

@Configuration
@EnableJpaRepositories(basePackages = "net.codejava.repository") //Cho phép quét các interface repository trong net.codejava.repository
public class JpaConfig {
	
	@Bean
	public LocalEntityManagerFactoryBean entityManagerFactory() {
		//EntityManagerFactory – là trung tâm để JPA kết nối tới cơ sở dữ liệu, dựa vào cấu hình trong persistence.xml
		LocalEntityManagerFactoryBean factoryBean = new LocalEntityManagerFactoryBean();
		factoryBean.setPersistenceUnitName("TheNews"); //"TheNews" phải khớp với tên persistence-unit trong file persistence.xml
		return factoryBean;
	}
	
	//transactionManager() được cấu hình để Spring làm việc, giao dịch với database bằng JPA một cách tự động
	@Bean
	public JpaTransactionManager transactionManager(EntityManagerFactory entityManager) {
		JpaTransactionManager transactionManager = new JpaTransactionManager();
		transactionManager.setEntityManagerFactory(entityManager);
		return transactionManager;
	}
}