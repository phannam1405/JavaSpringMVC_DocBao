package net.codejava.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.codejava.model.Admin;
import net.codejava.model.User;
import net.codejava.repository.UserRepository;

@Service
@Transactional
public class UserService {
    @Autowired
    private UserRepository userRepo;
    
    public User login(String email, String password) {
     
    	return userRepo.findByEmailAndPassword(email, password);
    }
    
    
    public boolean phoneExists(String phone) {
        return userRepo.findByPhone(phone) != null;
    }
    public boolean emailExists(String email) {
        return userRepo.findByEmail(email) != null;
    }
    public void register(User user) {
    	userRepo.save(user);
    }
    
}
