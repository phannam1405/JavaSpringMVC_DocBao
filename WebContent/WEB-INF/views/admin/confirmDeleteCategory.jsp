<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/lib/taglib.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>    
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Confirm Delete Category</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        .confirm-container {
            max-width: 600px;
            margin: 50px auto;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        .warning-icon {
            font-size: 3rem;
            color: #dc3545;
        }
        .category-info {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            border-left: 4px solid #dc3545;
        }
    </style>
</head>
<body class="bg-light">
    <div class="container">
        <div class="confirm-container bg-white text-center">
            <div class="warning-icon mb-4">
                <i class="bi bi-exclamation-triangle-fill"></i>
            </div>
            
            <h2 class="text-danger mb-4">Xác nhận xóa Category</h2>
            
            <div class="category-info mb-4 text-start">
                <h5 class="text-primary mb-3">
                    <i class="bi bi-folder"></i> Thông tin Category
                </h5>
                <p><strong>Tên Category:</strong> ${category.categoryName}</p>
                <p><strong>Mô tả:</strong> ${category.description}</p>
                <p class="mb-0">
                    <strong>Số bài viết liên quan:</strong> 
                    <span class="badge bg-danger fs-6">${articleCount} bài viết</span>
                </p>
            </div>
            
            <div class="alert alert-warning text-start" role="alert">
                <i class="bi bi-info-circle-fill me-2"></i>
                <strong>Cảnh báo quan trọng:</strong><br>
                Khi bạn xóa category này trước tiên phải xóa ộ <strong>toàn bộ ${articleCount} bài viết</strong> thuộc category này 
               trước .
            </div>
            
            <!-- Hiển thị danh sách bài viết sẽ bị xóa -->
            <c:if test="${articleCount > 0}">
                <div class="alert alert-info text-start" role="alert">
                    <h6 class="alert-heading">
                        <i class="bi bi-list-ul me-2"></i>
                        Danh sách bài viết cần xóa để thực hiện thao tác này :
                    </h6>
                    <div class="mt-3" style="max-height: 200px; overflow-y: auto;">
                        <c:forEach var="article" items="${articles}" varStatus="status">
                            <div class="d-flex align-items-start mb-2 p-2 bg-light rounded">
                                <span class="badge bg-secondary me-2">${status.index + 1}</span>
                                <div class="flex-grow-1">
                                    <div class="fw-bold text-dark">${article.title}</div>
                                    <small class="text-muted">
                                        <i class="bi bi-calendar3"></i> 
                                        <fmt:formatDate value="${article.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                                        <c:if test="${not empty article.admin}">
                                            | <i class="bi bi-person"></i> ${article.admin.fullName}
                                        </c:if>
                                    </small>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </c:if>
            
            <div class="d-grid gap-2 d-md-flex justify-content-md-center mt-4">
                <a href="${pageContext.request.contextPath}/admin/deleteCategory?id=${category.category_id}&confirm=true" 
                   class="btn btn-danger btn-lg me-md-3 px-4"
                   onclick="return confirmFinalDelete();">
                    <i class="bi bi-trash-fill"></i> 
                    Xác nhận xóa Category 
                </a>
                
                <a href="${pageContext.request.contextPath}/admin/newCategory" 
                   class="btn btn-secondary btn-lg px-4">
                    <i class="bi bi-arrow-left"></i> 
                    Hủy bỏ và quay lại
                </a>
            </div>
        </div>
    </div>
    
    <!-- Bootstrap 5 JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        function confirmFinalDelete() {
            return confirm(
                'BẠN CÓ CHẮC CHẮN MUỐN XÓA?\n\n' +
                'Category: ${category.categoryName}\n' +             
                'Hành động này KHÔNG THỂ HOÀN TÁC!\n\n' +
                'Nhấn OK để xác nhận xóa, Cancel để hủy bỏ.'
            );
        }
        
        // Auto focus vào nút Cancel để tránh xóa nhầm
        document.addEventListener('DOMContentLoaded', function() {
            document.querySelector('.btn-secondary').focus();
        });
    </script>
</body>
</html>