package net.codejava.repository;

import org.springframework.data.repository.CrudRepository;

import net.codejava.model.Admin;



public interface AdminRepository extends CrudRepository<Admin, Integer>{
	 Admin findByEmailAndPassword(String email, String password);
}
