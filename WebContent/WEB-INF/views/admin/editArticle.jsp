<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/lib/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa bài viết</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.ckeditor.com/4.16.2/standard/ckeditor.js"></script>
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
    </style>
</head>
<body class="bg-light">
    <div class="container">
        <div class="form-container bg-white">
            <h2 class="form-title">Chỉnh sửa bài viết</h2>

            <form action="${pageContext.request.contextPath}/admin/updateArticle" method="post" enctype="multipart/form-data">
                <input type="hidden" name="article_id" value="${article.article_id}" />

                <!-- Tiêu đề -->
                <div class="mb-3">
                    <label for="title" class="form-label">Tiêu đề</label>
                    <input type="text" class="form-control" id="title" name="title" value="${article.title}" required>
                </div>

                <!-- Tác giả -->
                <div class="mb-3">
                    <label for="admin_id" class="form-label">Tác giả</label>
                    <select class="form-select" id="admin_id" name="admin_id" required>
                        <c:forEach items="${admins}" var="admin">
                            <option value="${admin.admin_id}" ${admin.admin_id == article.admin.admin_id ? 'selected' : ''}>
                                ${admin.fullName} (${admin.email})
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <!-- Danh mục -->
                <div class="mb-3">
                    <label for="category_id" class="form-label">Danh mục</label>
                    <select class="form-select" id="category_id" name="category_id" required>
                        <c:forEach items="${categories}" var="category">
                            <option value="${category.category_id}" ${category.category_id == article.category.category_id ? 'selected' : ''}>
                                ${category.categoryName}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <!-- Mô tả ngắn -->
                <div class="mb-3">
                    <label for="short_content" class="form-label">Mô tả ngắn</label>
                    <textarea class="form-control" id="short_content" name="short_content" required>${article.shortContent}</textarea>
                </div>

                <!-- Nội dung chi tiết -->
                <div class="mb-3">
                    <label for="content" class="form-label">Nội dung chi tiết</label>
                    <textarea class="form-control" id="content" name="content" required>${article.content}</textarea>
                    <script>
                        CKEDITOR.replace('content', {
                            toolbar: [
                                { name: 'basicstyles', items: ['Bold', 'Italic', 'Underline'] },
                                { name: 'paragraph', items: ['NumberedList', 'BulletedList'] },
                                { name: 'insert', items: ['Image', 'Table', 'HorizontalRule'] },
                                { name: 'styles', items: ['Styles', 'Format'] },
                                { name: 'tools', items: ['Maximize'] },
                                { name: 'document', items: ['Source'] }
                            ],
                            language: 'vi',
                            height: 300
                        });
                    </script>
                </div>

                <!-- Hình ảnh -->
                <div class="mb-3">
                    <label for="image" class="form-label">Hình ảnh bài viết</label>
                    <input type="file" class="form-control" id="image" name="image" accept="image/*">
                    <c:if test="${not empty article.image}">
                        <p class="mt-2">Ảnh hiện tại:</p>
                        <img src="${pageContext.request.contextPath}/uploads/${article.image}" alt="Hình ảnh hiện tại" width="150">
                    </c:if>
                </div>

                <!-- Tin nóng & đầu trang -->
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="breaking_news" class="form-label">Tin nóng</label>
                        <select class="form-select" id="breaking_news" name="breaking_news">
                            <option value="0" ${article.breakingNews == 0 ? 'selected' : ''}>Không</option>
                            <option value="1" ${article.breakingNews == 1 ? 'selected' : ''}>Có</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label for="headline" class="form-label">Tin đầu trang</label>
                        <select class="form-select" id="headline" name="headline">
                            <option value="0" ${article.headLine == 0 ? 'selected' : ''}>Không</option>
                            <option value="1" ${article.headLine == 1 ? 'selected' : ''}>Có</option>
                        </select>
                    </div>
                </div>

                <!-- Ngày tạo -->
                <div class="mb-4">
                    <label for="created_at" class="form-label">Ngày đăng</label>
                    <input type="date" class="form-control" id="created_at" name="created_at" value="${article.createdAt}" required>
                </div>

                <!-- Nút -->
                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                    <button type="submit" class="btn btn-success px-4">
                        <i class="bi bi-check2-circle"></i> Cập nhật
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-secondary px-4">
                        <i class="bi bi-arrow-left"></i> Hủy
                    </a>
                </div>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</body>
</html>
