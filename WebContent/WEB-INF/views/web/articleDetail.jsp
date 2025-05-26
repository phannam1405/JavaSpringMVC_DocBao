<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="layout/header.jsp"%>

<style>
    /* Container chính */
    .article-container {
        max-width: 1200px;
        margin: 20px auto;
        border: 2px solid #333;
        background-color: #fff;
    }
    
    /* Main content area - 2 cột */
    .content-wrapper {
        display: flex;
        min-height: 500px;
    }
    
    /* Nội dung bài báo - cột trái */
    .main-content {
        flex: 2;
        padding: 30px;
        border-right: 2px solid #333;
        background-color: #ffffff;
    }
    
    /* Sidebar - cột phải */
    .sidebar {
        flex: 1;
        padding: 30px;
        background-color: #f8f9fa;
    }
    
    /* Comment section - full width */
    .comment-section {
        border-top: 2px solid #333;
        padding: 30px;
        background-color: #f8f9fa;
    }
    
    /* Typography */
    .content-title {
        font-size: 24px;
        font-weight: bold;
        margin-bottom: 15px;
        color: #333;
    }
    
    .content-subtitle {
        font-size: 16px;
        color: #666;
        font-style: italic;
        margin-bottom: 20px;
        text-align: center;
        padding: 10px;
        background-color: #e9ecef;
        border-left: 4px solid #007bff;
    }
    
    .sidebar-title {
        font-size: 20px;
        font-weight: bold;
        margin-bottom: 20px;
        color: #333;
        border-bottom: 2px solid #333;
        padding-bottom: 10px;
    }
    
    .comment-title {
        font-size: 22px;
        font-weight: bold;
        margin-bottom: 20px;
        color: #333;
    }
    
    /* Article content */
    .article-content {
        line-height: 1.8;
        font-size: 16px;
    }
    
    .article-content p {
        margin-bottom: 15px;
        text-align: justify;
    }
    
    /* Sidebar links */
    .sidebar-item {
        margin-bottom: 15px;
        padding: 10px;
        border: 1px solid #dee2e6;
        background-color: #fff;
        transition: background-color 0.3s;
    }
    
    .sidebar-item:hover {
        background-color: #e9ecef;
    }
    
    .sidebar-item a {
        text-decoration: none;
        color: #333;
        font-weight: 500;
        display: block;
    }
    
    .sidebar-item a:hover {
        color: #007bff;
    }
    
    /* Comment form */
    .comment-form {
        margin-bottom: 30px;
    }
    
    .comment-form textarea {
        width: 100%;
        padding: 15px;
        border: 2px solid #dee2e6;
        border-radius: 5px;
        font-size: 14px;
        resize: vertical;
    }
    
    .comment-form button {
        margin-top: 10px;
        padding: 10px 20px;
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-weight: bold;
    }
    
    .comment-form button:hover {
        background-color: #0056b3;
    }
    
    /* Comment list */
    .comment-item {
        border-bottom: 1px solid #dee2e6;
        padding-bottom: 15px;
        margin-bottom: 15px;
    }
    
    .comment-author {
        font-weight: bold;
        color: #333;
    }
    
    .comment-text {
        margin: 8px 0;
        line-height: 1.6;
    }
    
    .comment-time {
        font-size: 12px;
        color: #666;
    }
    
	    .main-content, 
	.main-content * {
	    color: #333 !important;
	    line-height: 1.6 !important;
	}
	
	.main-content img {
	    max-width: 100%;
	    height: auto;
	}
    
    /* Responsive */
    @media (max-width: 768px) {
        .content-wrapper {
            flex-direction: column;
        }
        
        .main-content {
            border-right: none;
            border-bottom: 2px solid #333;
        }
        
        .article-container {
            margin: 10px;
        }
        
        .main-content, .sidebar, .comment-section {
            padding: 20px;
        }
    }
</style>

<!-- Main Content Container -->
<div class="article-container">
    <!-- Content Wrapper - 2 columns -->
    <div class="content-wrapper">
        <!-- Nội dung bài báo - Left Column -->
		<div class="main-content">
		    <p style='font-size:32px'>${article.title}</p>
		    <div style="max-height: 500px; overflow-y: auto;">
		        ${article.content}
		    </div>
		</div>
        
        <!-- Các bài báo khác - Right Column -->
        <div class="sidebar">
		    <div class="sidebar-title">Các bài báo cùng chuyên mục</div>
		    <c:forEach items="${relatedArticles}" var="related">
		        <div class="sidebar-item">
		            <a href="detail?id=${related.article_id}">
		                📰 ${related.title}
		            </a>
		        </div>
		    </c:forEach>
		    
		    <c:if test="${empty relatedArticles}">
		        <div class="sidebar-item">
		            <p>Không có bài viết nào khác trong chuyên mục này</p>
		        </div>
		    </c:if>
		</div>
    </div>
    
    <!-- Comment Section - Full Width -->
    <div class="comment-section">
        <div class="comment-title">Comment</div>
        
        <!-- Comment Form -->
        <div class="comment-form">
            <textarea rows="4" placeholder="Viết bình luận của bạn..."></textarea>
            <button type="button">Gửi bình luận</button>
        </div>
        
        <!-- Existing Comments -->
        <div class="comment-list">
            <div class="comment-item">
                <div class="comment-author">Nguyễn Văn A</div>
                <div class="comment-text">Bài viết rất hay và bổ ích! Cảm ơn tác giả đã chia sẻ những thông tin quý giá.</div>
                <div class="comment-time">2 giờ trước</div>
            </div>
            <div class="comment-item">
                <div class="comment-author">Trần Thị B</div>
                <div class="comment-text">Thông tin rất hữu ích, tôi đã học được nhiều điều mới từ bài viết này.</div>
                <div class="comment-time">1 giờ trước</div>
            </div>
            <div class="comment-item">
                <div class="comment-author">Lê Văn C</div>
                <div class="comment-text">Rất mong được đọc thêm những bài viết tương tự trong tương lai.</div>
                <div class="comment-time">30 phút trước</div>
            </div>
        </div>
    </div>
</div>

<%@ include file="layout/footer.jsp"%>