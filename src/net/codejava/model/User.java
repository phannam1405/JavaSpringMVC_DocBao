package net.codejava.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.PrePersist;
import javax.persistence.Table;

@Entity
@Table(name = "user")
public class User {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "user_id")
	private Integer user_id;

	@Column(name = "email")
	private String email;

	@Column(name = "password")
	private String password;

	@Column(name = "full_name")
	private String fullName;

	@Column(name = "phone")
	private String phone;
	
	@Column(name = "created_at")
	private Date createdAt;

	public Integer getUser_id() {
		return user_id;
	}

	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
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
	
    @PrePersist
    protected void onCreate() {
        this.createdAt = new Date(System.currentTimeMillis());
    }

	public User(Integer user_id, String email, String password, String fullName, String phone, Date createdAt) {
		this.user_id = user_id;
		this.email = email;
		this.password = password;
		this.fullName = fullName;
		this.phone = phone;
		this.createdAt = createdAt;
	}

	public User() {
		
	}
	
	
}
