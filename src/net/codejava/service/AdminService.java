package net.codejava.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.codejava.model.Admin;
import net.codejava.model.Article;
import net.codejava.repository.AdminRepository;

@Service
@Transactional
public class AdminService {
    @Autowired
    private AdminRepository adminRepo;
    
    public boolean emailExists(String email) {
        return adminRepo.findByEmail(email) != null;
    }
    
    public void register(Admin admin) {
    	adminRepo.save(admin);
    }
    
    public List<Admin> listAll() {
        return adminRepo.findAll();
    }
    
    public boolean phoneExists(String phone) {
        return adminRepo.findByPhone(phone) != null;
    }
    
    public Admin login(String email, String password) {
        return adminRepo.findByEmailAndPassword(email, password);
    }
    
    public List<Admin> getAllAdmins() {
        return (List<Admin>) adminRepo.findAll();
    }
    
    public Admin getAdminById(Integer id) {
        return adminRepo.findById(id).orElse(null);
    }
}