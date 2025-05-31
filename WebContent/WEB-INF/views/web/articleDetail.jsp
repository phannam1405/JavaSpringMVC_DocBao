<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
        box-sizing: border-box;
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
    
    .comment-form button:disabled {
        background-color: #6c757d;
        cursor: not-allowed;
    }
    
    /* Comment list */
    .comment-item {
        border-bottom: 1px solid #dee2e6;
        padding-bottom: 15px;
        margin-bottom: 15px;
        background-color: #fff;
        padding: 15px;
        border-radius: 5px;
        box-shadow: 0 1px 3px rgba(0,0,0,0.1);
    }
    
    .comment-author {
        font-weight: bold;
        color: #333;
        margin-bottom: 5px;
    }
    
    .comment-text {
        margin: 8px 0;
        line-height: 1.6;
        color: #555;
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
    
    /* Alert styling */
    .alert {
        padding: 10px 15px;
        border-radius: 5px;
        margin-bottom: 15px;
        font-size: 14px;
    }
    
    .alert-warning {
        background-color: #fff3cd;
        border: 1px solid #ffeaa7;
        color: #856404;
    }
    
    .alert-success {
        background-color: #d4edda;
        border: 1px solid #c3e6cb;
        color: #155724;
    }
    
    .alert-danger {
        background-color: #f8d7da;
        border: 1px solid #f5c6cb;
        color: #721c24;
    }
    
    .alert a {
        color: #007bff;
        text-decoration: none;
        font-weight: bold;
    }
    
    .alert a:hover {
        text-decoration: underline;
    }
    
    .no-comments {
        text-align: center;
        color: #666;
        font-style: italic;
        padding: 20px;
        background-color: #fff;
        border-radius: 5px;
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
        <div class="comment-title">Bình luận (${fn:length(comments)})</div>
        
        <!-- Hiển thị thông báo -->
        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        
        <!-- Comment Form -->
        <div class="comment-form">
            <c:choose>
                <c:when test="${empty sessionScope.user}">
                    <div class="alert alert-warning">
                        Bạn cần <a href="${pageContext.request.contextPath}/login">đăng nhập</a> để có thể bình luận.
                    </div>
                    <textarea rows="4" placeholder="Đăng nhập để bình luận..." disabled></textarea>
                    <button type="button" disabled>Đăng nhập để bình luận</button>
                </c:when>
                <c:otherwise>
                    <form action="${pageContext.request.contextPath}/detail/comment" method="post">
                        <input type="hidden" name="articleId" value="${article.article_id}">
                        <textarea name="content" rows="4" placeholder="Viết bình luận của bạn..." required></textarea>
                        <button type="submit">Gửi bình luận</button>
                    </form>
                </c:otherwise>
            </c:choose>
        </div>
        
        <!-- Existing Comments -->
        <div class="comment-list">
            <c:choose>
                <c:when test="${not empty comments}">
                    <c:forEach items="${comments}" var="comment">
                        <div class="comment-item">
                            <div class="comment-author">${comment.userID.fullName}</div>
                            <div class="comment-text">${comment.content}</div>
                            <div class="comment-time">
                                <fmt:formatDate value="${comment.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="no-comments">
                        Chưa có bình luận nào. Hãy là người đầu tiên bình luận!
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<%@ include file="layout/footer.jsp"%>