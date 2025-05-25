<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/lib/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tạo bài viết mới</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- CKEditor CDN -->
    <script src="https://cdn.ckeditor.com/4.16.2/standard/ckeditor.js"></script>
    <!-- CSS tùy chỉnh -->
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
            <h2 class="form-title">Tạo bài viết mới</h2>

            <form action="${pageContext.request.contextPath}/admin/saveArticle" method="post" enctype="multipart/form-data">
                <!-- Tiêu đề -->
                <div class="mb-3">
                    <label for="title" class="form-label">Tiêu đề</label>
                    <input type="text" class="form-control" id="title" name="title" required>
                </div>

                <!-- Tác giả (Admin) -->
                <div class="mb-3">
                    <label for="admin_id" class="form-label">Tác giả</label>
                    <select class="form-select" id="admin_id" name="admin_id" required>
                        <option value="">-- Chọn tác giả --</option>
                        <c:forEach items="${admins}" var="admin">
                            <option value="${admin.admin_id}">${admin.fullName} (${admin.email})</option>
                        </c:forEach>
                    </select>
                </div>

                <!-- Danh mục -->
                <div class="mb-3">
                    <label for="category_id" class="form-label">Danh mục</label>
                    <select class="form-select" id="category_id" name="category_id" required>
                        <option value="">-- Chọn danh mục --</option>
                        <c:forEach items="${categories}" var="category">
                            <option value="${category.category_id}">${category.categoryName}</option>
                        </c:forEach>
                    </select>
                </div>

                <!-- Nội dung ngắn -->
                <div class="mb-3">
                    <label for="short_content" class="form-label">Mô tả ngắn</label>
                    <textarea class="form-control" id="short_content" name="short_content" required></textarea>
                </div>

                <!-- Nội dung chính (CKEditor) -->
                <div class="mb-3">
                    <label for="content" class="form-label">Nội dung chi tiết</label>
                    <textarea class="form-control" id="content" name="content" required></textarea>
                    <script>
                        // Khởi tạo CKEditor cho textarea có id="content"
                        CKEDITOR.replace('content', {
                            // Cấu hình thêm nếu cần
                            toolbar: [
                                { name: 'basicstyles', items: ['Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript'] },
                                { name: 'paragraph', items: ['NumberedList', 'BulletedList', 'Blockquote'] },
                                { name: 'links', items: ['Link', 'Unlink'] },
                                { name: 'insert', items: ['Image', 'Table', 'HorizontalRule'] },
                                { name: 'styles', items: ['Styles', 'Format'] },
                                { name: 'colors', items: ['TextColor', 'BGColor'] },
                                { name: 'tools', items: ['Maximize'] },
                                { name: 'document', items: ['Source'] }
                            ],
                            // Ngôn ngữ tiếng Việt
                            language: 'vi',
                            // Chiều cao editor
                            height: 300
                        });
                    </script>
                </div>

                <!-- Hình ảnh -->
                <div class="mb-3">
                    <label for="image" class="form-label">Hình ảnh bài viết</label>
                    <input type="file" class="form-control" id="image" name="image" accept="image/*">
                </div>

                <!-- Tin nóng & Tin đầu trang -->
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="breaking_news" class="form-label">Tin nóng</label>
                        <select class="form-select" id="breaking_news" name="breaking_news">
                            <option value="0">Không</option>
                            <option value="1">Có</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label for="headline" class="form-label">Tin đầu trang</label>
                        <select class="form-select" id="headline" name="headline">
                            <option value="0">Không</option>
                            <option value="1">Có</option>
                        </select>
                    </div>
                </div>

                <!-- Ngày tạo -->
                <div class="mb-4">
                    <label for="created_at" class="form-label">Ngày đăng</label>
                    <input type="date" class="form-control" id="created_at" name="created_at" required>
                </div>

                <!-- Nút gửi/đặt lại -->
                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                    <button type="submit" class="btn btn-primary me-md-2 px-4">
                        <i class="bi bi-save"></i> Lưu bài viết
                    </button>
                    <button type="reset" class="btn btn-outline-secondary px-4">
                        <i class="bi bi-arrow-counterclockwise"></i> Đặt lại
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Bootstrap 5 JS Bundle với Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</body>
</html>