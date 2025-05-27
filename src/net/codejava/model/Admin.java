package net.codejava.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.PrePersist;
import javax.persistence.Table;

@Entity
@Table(name = "admin")
public class Admin {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "admin_id")
	private Integer admin_id;

	@Column(name = "email", unique = true)	
	private String email;

	@Column(name = "password")
	private String password;

	@Column(name = "full_name")
	private String fullName;

	@Column(name = "phone")
	private String phone;
	
	@Column(name = "created_at")
	private Date createdAt;
	
    @PrePersist
    protected void onCreate() {
        this.createdAt = new Date(System.currentTimeMillis());
    }
	
	public Admin() {
		
	}

	public Admin(Integer admin_id, String email, String password, String fullName, String phone, Date createdAt) {

		this.admin_id = admin_id;
		this.email = email;
		this.password = password;
		this.fullName = fullName;
		this.phone = phone;
		this.createdAt = createdAt;
	}

	public Integer getAdmin_id() {
		return admin_id;
	}

	public void setAdmin_id(Integer admin_id) {
		this.admin_id = admin_id;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}


}
