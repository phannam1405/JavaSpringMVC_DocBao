package net.codejava.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "comment")
public class Comment{
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "comment_id")
	private Integer comment_id;

	@ManyToOne
	@JoinColumn(name = "article_id")
	private Article articleID;
	
	@ManyToOne
	@JoinColumn(name = "user_id")
	private User userID;

	@Column(name = "content")
	private String content;

	@Column(name = "created_at")
	private Date createdAt;

	public Comment(Integer comment_id, Article articleID, User userID, String content, Date createdAt) {
		this.comment_id = comment_id;
		this.articleID = articleID;
		this.userID = userID;
		this.content = content;
		this.createdAt = createdAt;
	}

	public Integer getComment_id() {
		return comment_id;
	}

	public void setComment_id(Integer comment_id) {
		this.comment_id = comment_id;
	}

	public Article getArticleID() {
		return articleID;
	}

	public void setArticleID(Article articleID) {
		this.articleID = articleID;
	}

	public User getUserID() {
		return userID;
	}

	public void setUserID(User userID) {
		this.userID = userID;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	
	
}