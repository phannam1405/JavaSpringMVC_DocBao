<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="layout/header.jsp"%>

<div class="page2">
	<div class="news" id="searchResults">
		<div class="title">
			<h2>Kết quả tìm kiếm cho: "${searchQuery}"</h2>
		</div>

		<c:choose>
			<c:when test="${not empty searchResults && searchResults.size() > 0}">
				<div class="newsBox">
					<c:forEach items="${searchResults}" var="article">
						<div class="newsCard">
							<div class="img">
								<c:if test="${not empty article.image}">
									<img
										src="${pageContext.request.contextPath}/uploads/${article.image}"
										alt="${article.title}">
								</c:if>
							</div>
							<div class="text">
								<div class="title">
									<a
										href="${pageContext.request.contextPath}/detail?id=${article.article_id}">
										<p>${article.title}</p>
									</a>
								</div>
								<div class="details">
									<div class="author">Tác giả: ${article.admin.fullName}</div>
									<div class="date">
										Ngày đăng:
										<fmt:formatDate value="${article.createdAt}"
											pattern="dd/MM/yyyy" />
									</div>
								</div>


							</div>
						</div>
					</c:forEach>
				</div>
			</c:when>
			<c:otherwise>
				<div class="no-results">
					<p>Không tìm thấy bài viết nào phù hợp với từ khóa
						"${searchQuery}"</p>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
</div>

<%@ include file="layout/footer.jsp"%>