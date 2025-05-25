package net.codejava.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import net.codejava.model.Admin;
import net.codejava.model.Article;



public interface AdminRepository extends CrudRepository<Admin, Integer>{
	List<Admin> findAll(); 
	 Admin findByEmailAndPassword(String email, String password);
	 Admin findByEmail(String email);
	 Admin findByPhone(String phone);
}
