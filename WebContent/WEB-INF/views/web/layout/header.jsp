<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/lib/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.css"
	integrity="sha512-HHsOC+h3najWR7OKiGZtfhFIEzg5VRIPde0kB0bG2QRidTQqf+sbfcxCTB16AcFB93xMjnBIKE29/MjdzXE+qw=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/style.css">

<title>News Website</title>
<style>
	nav {
		display: flex;
		align-items: center;
		justify-content: space-between;
		flex-wrap: wrap;
	}
	
	nav ul {
		display: flex;
		list-style: none;
		margin: 0;
		padding: 0;
	}
	
	nav ul li {
		margin-right: 20px;
	}
	
	.search-form {
		display: flex;
		align-items: center;
	}
	
	.search-form input[type="text"] {
		padding: 5px 10px;
		border: 1px solid #ccc;
		border-radius: 3px 0 0 3px;
	}
	
	.search-form button {
		padding: 5px 10px;
		background-color: #333;
		color: white;
		border: none;
		border-radius: 0 3px 3px 0;
		cursor: pointer;
	}
	
	.user-menu {
		margin-left: 20px;
	}
	
	.login-btn {
		padding: 8px 12px;
		background-color: #333;
		color: white;
		text-decoration: none;
		border-radius: 4px;
	}
	
	.dropdown {
		position: relative;
		display: inline-block;
	}
	
	.dropbtn {
		background-color: #333;
		color: white;
		padding: 8px 12px;
		font-size: 14px;
		border: none;
		cursor: pointer;
		border-radius: 4px;
	}
	
	.dropdown-content {
		display: none;
		position: absolute;
		background-color: white;
		min-width: 160px;
		box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2);
		z-index: 1;
		right: 0;
	}
	
	.dropdown-content a {
		color: black;
		padding: 10px 14px;
		text-decoration: none;
		display: block;
	}
	
	.dropdown-content a:hover {
		background-color: #f1f1f1;
	}
	
	.dropdown:hover .dropdown-content {
		display: block;
	}

}
</style>
</head>
<body>
	<div class="header">
		<div class="logo">THE NEWS</div>
		<nav>
			<ul>
				<li><a href="#">Home</a></li>
				<li><a href="#sportsNews">Sports</a></li>
				<li><a href="#businessNews">Business</a></li>
				<li><a href="#techNews">Technology</a></li>
			</ul>
			<form action="${pageContext.request.contextPath}/search" method="get"
				class="search-form">
				<input type="text" name="query" placeholder="Tìm kiếm..." required>
				<button type="submit">
					<i class="fa fa-search"></i>
				</button>
			</form>

			<div class="bar">
				<i class="open fa-solid fa-bars-staggered"></i> <i
					class="close fa-solid fa-xmark"></i>
			</div>
			<div class="user-menu">
				<c:choose>
					<c:when test="${not empty sessionScope.user}">
						<div class="dropdown">
							<button class="dropbtn">${sessionScope.user.fullName}
								<i class="fa fa-caret-down"></i>
							</button>
							<div class="dropdown-content">
								<a href="${pageContext.request.contextPath}/logout">Đăng
									xuất</a>
							</div>
						</div>
					</c:when>
					<c:otherwise>
						<a href="${pageContext.request.contextPath}/login"
							class="login-btn">Đăng nhập</a>
					</c:otherwise>
				</c:choose>
			</div>

		</nav>
	</div>