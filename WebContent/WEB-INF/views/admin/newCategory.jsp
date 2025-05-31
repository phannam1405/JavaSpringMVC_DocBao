<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/lib/taglib.jsp"%>    
<!DOCTYPE html>
<html>
<head>
     <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>New Category</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <!-- Custom CSS -->
    <style>
        .form-container {
            max-width: 800px;
            margin: 30px auto;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }
        .form-title {
            margin-bottom: 25px;
            text-align: center;
            color: #0d6efd;
        }
        .form-label {
            font-weight: 500;
        }
        textarea.form-control {
            min-height: 120px;
        }
        .table-container {
            max-width: 1000px;
            margin: 30px auto;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body class="bg-light">
    <div class="container">
        <!-- Form thêm category -->
        <div class="form-container bg-white">
            <h2 class="form-title">Create New Category</h2>
            
            <!-- Hiển thị thông báo -->
            <c:if test="${not empty message}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    ${message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            
            <form action="${pageContext.request.contextPath}/admin/saveCategory" method="post">
                <!-- Category Name -->
                <div class="mb-3">
                    <label for="category_name" class="form-label">Category Name</label>
                    <input type="text" class="form-control" id="category_name" name="category_name" required>
                </div>
                
                <!-- Description -->
                <div class="mb-3">
                    <label for="description" class="form-label">Description</label>
                    <input type="text" class="form-control" id="description" name="description" required>
                </div>
                
                <!-- Submit Button -->
                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                    <button type="submit" class="btn btn-primary me-md-2 px-4">
                        <i class="bi bi-save"></i> Submit
                    </button>
                    <button type="reset" class="btn btn-outline-secondary px-4">
                        <i class="bi bi-arrow-counterclockwise"></i> Reset
                    </button>
                </div>
            </form>
        </div>
        
        <!-- Bảng hiển thị danh sách categories -->
        <div class="table-container bg-white">
            <h3 class="text-center mb-4 text-primary">
                <i class="bi bi-list-ul"></i> All Categories
            </h3>
            
            <c:choose>
                <c:when test="${not empty categories}">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
                            <thead class="table-dark">
                                <tr>
                                    <th scope="col" class="text-center">#</th>
                                    <th scope="col">Category Name</th>
                                    <th scope="col">Description</th>
                                    <th scope="col" class="text-center">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="category" items="${categories}" varStatus="status">
                                    <tr>
                                        <td class="text-center">${status.index + 1}</td>
                                        <td class="fw-bold text-primary">${category.categoryName}</td>
                                        <td>${category.description}</td>
                                        <td class="text-center">
                                            <button class="btn btn-sm btn-outline-danger" 
                                                    onclick="deleteCategory(${category.category_id}, '${category.categoryName}')">
                                                <i class="bi bi-trash"></i> Delete
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    
                    <div class="text-muted text-center mt-3">
                        <small>Total categories: ${categories.size()}</small>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="text-center py-5">
                        <i class="bi bi-inbox display-1 text-muted"></i>
                        <h5 class="text-muted mt-3">No categories found</h5>
                        <p class="text-muted">Add your first category using the form above.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    
    <!-- Bootstrap 5 JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Hàm delete category
        function deleteCategory(id, name) {
            if (confirm('Are you sure you want to delete category "' + name + '"?')) {
                // Redirect to delete URL
                window.location.href = '${pageContext.request.contextPath}/admin/deleteCategory?id=' + id;
            }
        }
    </script>
</body>
</html>