package net.codejava.repository;

import org.springframework.data.repository.CrudRepository;

import net.codejava.model.Admin;
import net.codejava.model.User;

public interface UserRepository extends CrudRepository<User, Integer>{
	 User findByEmail(String email);
	 User findByPhone(String phone);
}
