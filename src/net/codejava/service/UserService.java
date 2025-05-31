package net.codejava.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.codejava.model.User;
import net.codejava.repository.UserRepository;

@Service
@Transactional
public class UserService {
    @Autowired
    private UserRepository userRepo;
    
    @Autowired
    private BCryptPasswordEncoder passwordEncoder;
    
    public User login(String email, String password) {
        User user = userRepo.findByEmail(email);
        if (user != null && passwordEncoder.matches(password, user.getPassword())) {
            return user;
        }
        return null;
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