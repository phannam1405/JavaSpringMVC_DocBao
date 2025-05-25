<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="/WEB-INF/lib/taglib.jsp"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý bài viết - Admin Panel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <style>
        .search-card {
            background-color: #f8f9fa;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .table-responsive {
            overflow-x: auto;
        }
        .img-thumbnail {
            max-width: 100px;
            height: auto;
        }
        .badge {
            font-size: 0.85em;
            padding: 5px 8px;
        }
        .pagination .page-item.active .page-link {
            background-color: #0d6efd;
            border-color: #0d6efd;
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">
                <i class="fas fa-tachometer-alt me-2"></i>Admin Panel
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="#">
                            <i class="fas fa-home me-1"></i> Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/newArticle">
                            <i class="fas fa-plus-circle me-1"></i> Bài viết mới
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/newCategory">
                            <i class="fas fa-tags me-1"></i> Danh mục mới
                        </a>
                    </li>
                </ul>

                <ul class="navbar-nav ms-auto">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown">
                            <i class="fas fa-user-circle me-1"></i> ${not empty admin ? admin.fullName : 'Admin'}
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                            <li><a class="dropdown-item" href="#"><i class="fas fa-user-cog me-2"></i> Tài khoản</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li>
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/logout">
                                    <i class="fas fa-sign-out-alt me-2"></i> Đăng xuất
                                </a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container-fluid mt-4">
        <div class="row mb-4">
            <div class="col-12">
<div class="card mb-4">
    <div class="card-header">
        <h4>Tìm kiếm bài viết</h4>
    </div>
    <div class="card-body">
        <form action="${pageContext.request.contextPath}/admin/searchArticles" method="get" class="row g-3">
            <div class="col-md-3">
                <label for="title" class="form-label">Tiêu đề</label>
                <input type="text" class="form-control" id="title" name="title" 
                       value="${param.title}" placeholder="Nhập tiêu đề...">
            </div>
            <div class="col-md-2">
                <label for="createdAt" class="form-label">Ngày tạo</label>
                <input type="date" class="form-control" id="createdAt" name="createdAt" 
                       value="${param.createdAt}">
            </div>
            <div class="col-md-2">
                <label for="adminId" class="form-label">Tác giả</label>
                <select class="form-select" id="adminId" name="adminId">
                    <option value="">-- Tất cả --</option>
                    <c:forEach items="${admins}" var="admin">
                        <option value="${admin.admin_id}" 
                                ${param.adminId == admin.admin_id ? 'selected' : ''}>
                            ${admin.fullName}
                        </option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-2">
                <label for="categoryId" class="form-label">Danh mục</label>
                <select class="form-select" id="categoryId" name="categoryId">
                    <option value="">-- Tất cả --</option>
                    <c:forEach items="${categories}" var="category">
                        <option value="${category.category_id}" 
                                ${param.categoryId == category.category_id ? 'selected' : ''}>
                            ${category.categoryName}
                        </option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-2 d-flex align-items-end">
                <button type="submit" class="btn btn-primary w-100">
                    <i class="fas fa-search me-1"></i> Tìm kiếm
                </button>
            </div>
            <div class="col-md-1 d-flex align-items-end">
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-secondary w-100">
                    <i class="fas fa-sync-alt"></i>
                </a>
            </div>
        </form>
    </div>
</div>
            </div>
        </div>

        <!-- Articles Table -->
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-header bg-white d-flex justify-content-between align-items-center">
                        <h5 class="mb-0"><i class="fas fa-newspaper me-2"></i>Danh sách bài viết</h5>

                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle">
                                <thead class="table-light">
                                    <tr>
                                        <th width="5%">#</th>
                                        <th width="20%">Tiêu đề</th>
                                        <th width="15%">Tóm tắt</th>
                                        <th width="10%">Ảnh</th>
                                        <th width="10%">Danh mục</th>
                                        <th width="10%">Tác giả</th>
                                        <th width="8%">Tin hot</th>
                                        <th width="8%">Tiêu điểm</th>
                                        <th width="10%">Ngày tạo</th>
                                        <th width="14%">Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${not empty articles && articles.size() > 0}">
                                            <c:forEach items="${articles}" var="article" varStatus="loop">
                                                <tr>
                                                    <td>${loop.index + 1}</td>
                                                    <td class="text-truncate" style="max-width: 200px;" title="${article.title}">
                                                        ${article.title}
                                                    </td>
                                                    <td class="text-truncate" style="max-width: 150px;" title="${article.shortContent}">
                                                        ${article.shortContent}
                                                    </td>
                                                    <td>
                                                        <c:if test="${not empty article.image}">
                                                            <img src="${pageContext.request.contextPath}/uploads/${article.image}" 
                                                                 class="img-thumbnail" alt="${article.title}">
                                                        </c:if>
                                                    </td>
                                                    <td>${article.category.categoryName}</td>
                                                    <td>${article.admin.fullName}</td>
                                                    <td>
                                                        <span class="badge ${article.breakingNews == 1 ? 'bg-success' : 'bg-secondary'}">
                                                            ${article.breakingNews == 1 ? 'Có' : 'Không'}
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <span class="badge ${article.headLine == 1 ? 'bg-primary' : 'bg-secondary'}">
                                                            ${article.headLine == 1 ? 'Có' : 'Không'}
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <fmt:formatDate value="${article.createdAt}" pattern="dd/MM/yyyy" />
                                                    </td>
                                                    <td>
                                                        <div class="d-flex gap-2">
                                                            <a href="${pageContext.request.contextPath}/admin/editArticle/${article.article_id}" 
                                                               class="btn btn-sm btn-warning" title="Sửa">
                                                                <i class="fas fa-edit"></i>
                                                            </a>
                                                            <a href="${pageContext.request.contextPath}/admin/deleteArticle/${article.article_id}"
                                                               class="btn btn-sm btn-danger" title="Xóa"
                                                               onclick="return confirm('Bạn có chắc chắn muốn xóa bài viết này?');">
                                                                <i class="fas fa-trash-alt"></i>
                                                            </a>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="10" class="text-center text-muted py-4">
                                                    <i class="fas fa-info-circle me-2"></i>Không tìm thấy bài viết nào
                                                </td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>


                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>