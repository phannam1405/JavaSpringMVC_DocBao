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
@Table(name = "article")
public class Article {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "article_id")
	private Integer article_id;
	
	@ManyToOne
	@JoinColumn(name = "category_id")
	private Category category;  // đổi từ categoryID

	@ManyToOne
	@JoinColumn(name = "admin_id")
	private Admin admin;

	@Column(name = "title")
	private String title;
	
	@Column(name = "short_content")
	private String shortContent;

	@Column(name = "content")
	private String content;
	
	@Column(name = "image")
	private String image;
	
	@Column(name = "breaking_news")
	private Integer breakingNews;
	
	@Column(name = "headline")
	private Integer headLine;
	
	@Column(name = "created_at")
	private Date createdAt;
	
	public Article() {
		
	}

	public Integer getArticle_id() {
		return article_id;
	}

	public void setArticle_id(Integer article_id) {
		this.article_id = article_id;
	}

	public Category getCategory() {
		return category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}

	public Admin getAdmin() {
		return admin;
	}

	public void setAdmin(Admin admin) {
		this.admin = admin;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getShortContent() {
		return shortContent;
	}

	public void setShortContent(String shortContent) {
		this.shortContent = shortContent;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public Integer getBreakingNews() {
		return breakingNews;
	}

	public void setBreakingNews(Integer breakingNews) {
		this.breakingNews = breakingNews;
	}

	public Integer getHeadLine() {
		return headLine;
	}

	public void setHeadLine(Integer headLine) {
		this.headLine = headLine;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	public Article(Integer article_id, Category category, Admin admin, String title, String shortContent,
			String content, String image, Integer breakingNews, Integer headLine, Date createdAt) {
		this.article_id = article_id;
		this.category = category;
		this.admin = admin;
		this.title = title;
		this.shortContent = shortContent;
		this.content = content;
		this.image = image;
		this.breakingNews = breakingNews;
		this.headLine = headLine;
		this.createdAt = createdAt;
	}

	
	
}
