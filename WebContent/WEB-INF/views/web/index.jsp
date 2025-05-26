<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
				<c:otherwise>
					<!-- Ảnh mặc định -->
					<img src="${pageContext.request.contextPath}/resources/images/default-news.jpg" alt="default image">
				</c:otherwise>
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
									<a href="detail?id=${article.article_id}"  style="color: white; text-decoration: none">
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
	<div class="news" id="sportsNews">
		<div class="title">
			<h2>Sports News</h2>
		</div>
		<div class="newsBox">
			<div class="newsCard">
				<div class="img">
					<img
						src="https://i.tribune.com.pk/media/images/macron1739300215-0/macron1739300215-0.jpg"
						alt="top news image">
				</div>
				<div class="text">
					<div class="title">
						<a
							href="https://tribune.com.pk/story/2545818/eu-preparing-new-sanctions-against-russia-sanctions-french-president"
							target="_blank"><p>EU preparing new sanctions against
								Russia: French president</p></a>
					</div>
				</div>
			</div>
			<div class="newsCard">
				<div class="img">
					<img
						src="https://i.tribune.com.pk/media/images/macron1739300215-0/macron1739300215-0.jpg"
						alt="top news image">
				</div>
				<div class="text">
					<div class="title">
						<a
							href="https://tribune.com.pk/story/2545818/eu-preparing-new-sanctions-against-russia-sanctions-french-president"
							target="_blank"><p>EU preparing new sanctions against
								Russia: French president</p></a>
					</div>
				</div>
			</div>
			<div class="newsCard">
				<div class="img">
					<img
						src="https://i.tribune.com.pk/media/images/macron1739300215-0/macron1739300215-0.jpg"
						alt="top news image">
				</div>
				<div class="text">
					<div class="title">
						<a
							href="https://tribune.com.pk/story/2545818/eu-preparing-new-sanctions-against-russia-sanctions-french-president"
							target="_blank"><p>EU preparing new sanctions against
								Russia: French president</p></a>
					</div>
				</div>
			</div>
			<div class="newsCard">
				<div class="img">
					<img
						src="https://i.tribune.com.pk/media/images/macron1739300215-0/macron1739300215-0.jpg"
						alt="top news image">
				</div>
				<div class="text">
					<div class="title">
						<a
							href="https://tribune.com.pk/story/2545818/eu-preparing-new-sanctions-against-russia-sanctions-french-president"
							target="_blank"><p>EU preparing new sanctions against
								Russia: French president</p></a>
					</div>
				</div>
			</div>
			<div class="newsCard">
				<div class="img">
					<img
						src="https://i.tribune.com.pk/media/images/macron1739300215-0/macron1739300215-0.jpg"
						alt="top news image">
				</div>
				<div class="text">
					<div class="title">
						<a
							href="https://tribune.com.pk/story/2545818/eu-preparing-new-sanctions-against-russia-sanctions-french-president"
							target="_blank"><p>EU preparing new sanctions against
								Russia: French president</p></a>
					</div>
				</div>
			</div>
			<div class="newsCard">
				<div class="img">
					<img
						src="https://i.tribune.com.pk/media/images/macron1739300215-0/macron1739300215-0.jpg"
						alt="top news image">
				</div>
				<div class="text">
					<div class="title">
						<a
							href="https://tribune.com.pk/story/2545818/eu-preparing-new-sanctions-against-russia-sanctions-french-president"
							target="_blank"><p>EU preparing new sanctions against
								Russia: French president</p></a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="news" id="businessNews">
		<div class="title">
			<h2>Business News</h2>
		</div>
		<div class="newsBox">
			<div class="newsCard">
				<div class="img">
					<img
						src="https://i.tribune.com.pk/media/images/macron1739300215-0/macron1739300215-0.jpg"
						alt="top news image">
				</div>
				<div class="text">
					<div class="title">
						<a
							href="https://tribune.com.pk/story/2545818/eu-preparing-new-sanctions-against-russia-sanctions-french-president"
							target="_blank"><p>EU preparing new sanctions against
								Russia: French president</p></a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="news" id="techNews">
		<div class="title">
			<h2>Technology News</h2>
		</div>
		<div class="newsBox">
			<div class="newsCard">
				<div class="img">
					<img
						src="https://i.tribune.com.pk/media/images/macron1739300215-0/macron1739300215-0.jpg"
						alt="top news image">
				</div>
				<div class="text">
					<div class="title">
						<a
							href="https://tribune.com.pk/story/2545818/eu-preparing-new-sanctions-against-russia-sanctions-french-president"
							target="_blank"><p>EU preparing new sanctions against
								Russia: French president</p></a>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="layout/footer.jsp"%>