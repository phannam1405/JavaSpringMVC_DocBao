<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="layout/header.jsp"%>

<div class="topHeadlines">
	
	<!-- Tin nổi bật -->
	<div class="left">
		<div class="title">
			<h2>Breaking News</h2>
		</div>
		<div class="img" id="breakingImg">
			<c:choose>
				<c:when test="${breakingNews != null and not empty breakingNews.image}">
					<c:choose>
						<c:when test="${breakingNews.image.startsWith('http')}">
							<!-- Đường dẫn URL đầy đủ -->
							<img src="${breakingNews.image}" alt="breaking news image">
						</c:when>
						<c:otherwise>
							<!-- Đường dẫn tương đối từ thư mục uploads -->
							<img src="${pageContext.request.contextPath}/uploads/${breakingNews.image}" alt="breaking news image">
						</c:otherwise>
					</c:choose>
				</c:when>
			</c:choose>
		</div>
		
		<div class="text" id="breakingNews">
			<div class="title">
				<c:choose>
					<c:when test="${breakingNews != null}">
						<a href="detail?id=${breakingNews.article_id}" 
						   style="color: white; text-decoration: none">
						   ${breakingNews.title}
						</a>
					</c:when>
					<c:otherwise>
						Tiêu đề
					</c:otherwise>
				</c:choose>
			</div>
			<div class="description">
				<c:choose>
					<c:when test="${breakingNews != null}">
						${breakingNews.shortContent}
					</c:when>
					<c:otherwise>
						Mô tả ngắn
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
	
	<!-- Tin hot -->
	<div class="right">
		<div class="title">
			<h2>Top Headlines</h2>
		</div>
		<div class="topNews">
			<c:choose>
				<c:when test="${not empty topHeadlines}">
					<c:forEach var="article" items="${topHeadlines}">
						<div class="news">
							<div class="img">
								<c:choose>
									<c:when test="${not empty article.image}">
										<c:choose>
											<c:when test="${article.image.startsWith('http')}">
												<!-- Đường dẫn URL đầy đủ -->
												<img src="${article.image}" alt="${article.title}">
											</c:when>
											<c:otherwise>
												<!-- Đường dẫn tương đối từ thư mục uploads -->
												<img src="${pageContext.request.contextPath}/uploads/${article.image}" alt="${article.title}">
											</c:otherwise>
										</c:choose>
									</c:when>
									<c:otherwise>
										<!-- Ảnh mặc định nếu không có ảnh -->
										<img src="${pageContext.request.contextPath}/resources/images/default-news.jpg" alt="default image">
									</c:otherwise>
								</c:choose>
							</div>
							<div class="text">
								<div class="title">
									<a href="detail?id=${article.article_id}" style="color: white; text-decoration: none">
										${article.title}
									</a>
								</div>
							</div>
						</div>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<!-- Fallback content nếu không có dữ liệu -->
					<div class="news">
						<div class="img">
							<img src="${pageContext.request.contextPath}/resources/images/no-news.jpg" alt="no news">
						</div>
						<div class="text">
							<div class="title">Không có tin tức nổi bật</div>
						</div>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</div>

<div class="page2">
	<!-- Hiển thị động 3 thể loại có nhiều bài nhất -->
	<c:forEach var="category" items="${topCategories}">
		<c:set var="categoryKey" value="${fn:toLowerCase(fn:replace(category.categoryName, ' ', ''))}" />
		<div class="news" id="${categoryKey}News">
			<div class="title">
				<h2>${category.categoryName} News</h2>
			</div>
			<div class="newsBox">
				<c:choose>
					<c:when test="${not empty categoryArticles[categoryKey]}">
						<c:forEach var="article" items="${categoryArticles[categoryKey]}">
							<div class="newsCard">
								<div class="img">
									<c:choose>
										<c:when test="${not empty article.image}">
											<c:choose>
												<c:when test="${article.image.startsWith('http')}">
													<img src="${article.image}" alt="${article.title}">
												</c:when>
												<c:otherwise>
													<img src="${pageContext.request.contextPath}/uploads/${article.image}" alt="${article.title}">
												</c:otherwise>
											</c:choose>
										</c:when>
										<c:otherwise>
											<img src="${pageContext.request.contextPath}/resources/images/default-news.jpg" alt="default image">
										</c:otherwise>
									</c:choose>
								</div>
								<div class="text">
									<div class="title">
										<a href="detail?id=${article.article_id}" target="_blank">
											<p>${article.title}</p>
										</a>
									</div>
								</div>
							</div>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<div class="newsCard">
							<div class="img">
								<img src="${pageContext.request.contextPath}/resources/images/no-news.jpg" alt="no news">
							</div>
							<div class="text">
								<div class="title">
									<p>Chưa có bài viết trong thể loại này</p>
								</div>
							</div>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</c:forEach>
</div>

<%@ include file="layout/footer.jsp"%>