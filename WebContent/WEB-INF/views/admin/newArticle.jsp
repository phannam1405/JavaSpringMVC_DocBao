<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/lib/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>New article</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
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
    </style>
</head>
<body class="bg-light">
    <div class="container">
        <div class="form-container bg-white">
            <h2 class="form-title">Create New Article</h2>
<form action="${pageContext.request.contextPath}/admin/saveArticle" method="post" enctype="multipart/form-data">                <!-- Title -->
                <div class="mb-3">
                    <label for="title" class="form-label">Title</label>
                    <input type="text" class="form-control" id="title" name="title" required>
                </div>
                <!-- Thêm vào form, sau trường Title -->
<div class="mb-3">
    <label for="admin_id" class="form-label">Author (Admin)</label>
    <select class="form-select" id="admin_id" name="admin_id" required>
        <option value="">-- Select Admin --</option>
        <c:forEach items="${admins}" var="admin">
            <option value="${admin.admin_id}">${admin.fullName} (${admin.email})</option>
        </c:forEach>
    </select>
</div>

<div class="mb-3">
    <label for="category_id" class="form-label">Category</label>
    <select class="form-select" id="category_id" name="category_id" required>
        <option value="">-- Select Category --</option>
        <c:forEach items="${categories}" var="category">
            <option value="${category.category_id}">${category.categoryName}</option>
        </c:forEach>
    </select>
</div>
                <!-- Short Content -->
                <div class="mb-3">
                    <label for="short_content" class="form-label">Short Content</label>
                    <textarea class="form-control" id="short_content" name="short_content" required></textarea>
                </div>
                
                <!-- Content -->
                <div class="mb-3">
                    <label for="content" class="form-label">Content</label>
                    <textarea class="form-control" id="content" name="content" required></textarea>
                </div>
                
                <!-- Image URL -->
<div class="mb-3">
    <label for="image" class="form-label">Article Image</label>
    <input type="file" class="form-control" id="image" name="image" accept="image/*">
</div>
                
                <!-- Breaking News & Headline -->
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="breaking_news" class="form-label">Breaking News</label>
                        <select class="form-select" id="breaking_news" name="breaking_news">
                            <option value="0">No</option>
                            <option value="1">Yes</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label for="headline" class="form-label">Headline</label>
                        <select class="form-select" id="headline" name="headline">
                            <option value="0">No</option>
                            <option value="1">Yes</option>
                        </select>
                    </div>
                </div>
                
                <!-- Created Date -->
                <div class="mb-4">
                    <label for="created_at" class="form-label">Created Date</label>
                    <input type="date" class="form-control" id="created_at" name="created_at" required>
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
    </div>

    <!-- Bootstrap 5 JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</body>
</html>