<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/lib/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login - The News</title>

<!-- Bootstrap 5 CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Font Awesome -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<!-- MDBootstrap CSS -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.4.2/mdb.min.css" rel="stylesheet">

<style>
  body {
    background-color: #508bfc;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  }

  .title {
    text-align: center;
    color: white;
    font-weight: bold;
    margin-bottom: 30px;
    font-size: 2.5rem;
  }

  .card {
    border-radius: 1rem;
    background-color: #fff;
  }

  .form-label {
    color: #333;
  }

  .btn-primary {
    transition: all 0.3s ease-in-out;
  }

  .btn-primary:hover {
    background-color: #3b6fd6;
  }

  .signup-link {
    margin-top: 20px;
  }

  .signup-link a {
    text-decoration: none;
    color: #508bfc;
    font-weight: 500;
  }

  .signup-link a:hover {
    text-decoration: underline;
  }
</style>
</head>
<body>
<section class="vh-100 d-flex align-items-center justify-content-center">
  <div class="container">
    <h1 class="title">THE NEWS</h1>
    <div class="row justify-content-center">
      <div class="col-md-6 col-lg-5">
        <div class="card shadow">
          <div class="card-body p-5 text-center">

            <h3 class="mb-4">Sign in</h3>

            <form action="login" method="post">
              <div class="form-outline mb-4">
                <input type="email" id="typeEmail" name="email" class="form-control form-control-lg" required />
                <label class="form-label" for="typeEmail">Email</label>
              </div>

              <div class="form-outline mb-4">
                <input type="password" id="typePassword" name="password" class="form-control form-control-lg" required />
                <label class="form-label" for="typePassword">Password</label>
              </div>

              <button class="btn btn-primary btn-lg btn-block w-100" type="submit">Login</button>
            </form>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger" role="alert">
                      ${error}
                    </div>
                  </c:if>
            <div class="signup-link">
              <p class="mt-4">Don't have an account? <a href="${pageContext.request.contextPath}/register">Sign up here</a></p>
            </div>

          </div>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- MDBootstrap JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.4.2/mdb.min.js"></script>
</body>
</html>
