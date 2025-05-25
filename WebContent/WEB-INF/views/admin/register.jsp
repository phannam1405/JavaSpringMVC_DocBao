<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<%@ include file="/WEB-INF/lib/taglib.jsp"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.4.2/mdb.min.css" rel="stylesheet">
    <style>
        .error-message {
            color: #dc3545;
            font-size: 0.875em;
            margin-top: 0.25rem;
        }
    </style>
</head>
<body>

<section class="vh-100" style="background-color: #9A616D;">
  <div class="container py-5 h-100">
    <div class="row d-flex justify-content-center align-items-center h-100">
      <div class="col col-xl-10">
        <div class="card" style="border-radius: 1rem;">
          <div class="row g-0">
            <div class="col-md-6 col-lg-5 d-none d-md-block">
              <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-login-form/img2.webp"
                alt="register form" class="img-fluid" style="border-radius: 1rem 0 0 1rem;" />
            </div>
            <div class="col-md-6 col-lg-7 d-flex align-items-center">
              <div class="card-body p-4 p-lg-5 text-black">

                <form action="${pageContext.request.contextPath}/admin/register" method="post" id="registerForm">
                  <div class="d-flex align-items-center mb-3 pb-1">
                    <i class="fas fa-user-plus fa-2x me-3" style="color: #ff6219;"></i>
                    <span class="h1 fw-bold mb-0">THE NEWS</span>
                  </div>

                  <h5 class="fw-normal mb-3 pb-3" style="letter-spacing: 1px;">Admin Register</h5>

                  <div class="form-outline mb-4">
                    <input type="text" id="fullname" class="form-control form-control-lg" name="fullname" required />
                    <label class="form-label" for="fullname">Full Name</label>
                    <div id="fullnameError" class="error-message"></div>
                  </div>

                  <div class="form-outline mb-4">
                    <input type="email" id="email" class="form-control form-control-lg" name="email" required />
                    <label class="form-label" for="email">Email address</label>
                    <div id="emailError" class="error-message"></div>
                  </div>

                  <div class="form-outline mb-4">
                    <input type="password" id="password" class="form-control form-control-lg" name="password" required minlength="6" />
                    <label class="form-label" for="password">Password</label>
                    <div id="passwordError" class="error-message"></div>
                  </div>
                  
                  

                  <div class="form-outline mb-4">
                    <input type="password" id="confirmPassword" class="form-control form-control-lg" name="confirmPassword" required />
                    <label class="form-label" for="confirmPassword">Confirm Password</label>
                    <div id="confirmPasswordError" class="error-message"></div>
                  </div>
                  
                  <div class="form-outline mb-4">
					  <input type="tel" id="phone" class="form-control form-control-lg" name="phone" required pattern="[0-9]{10,15}" />
					  <label class="form-label" for="phone">Phone Number</label>
					  <div id="phoneError" class="error-message"></div>
				  </div>
 
                  <div class="pt-1 mb-4">
                    <button class="btn btn-success btn-lg btn-block" type="submit">Register</button>
                  </div>

                  <c:if test="${not empty error}">
                    <div class="alert alert-danger" role="alert">
                      ${error}
                    </div>
                  </c:if>

                  <p class="mb-2 text-muted">Already have an account?
                    <a href="${pageContext.request.contextPath}/admin/login" class="text-primary fw-bold">Login here</a>
                  </p>
                </form>

              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.4.2/mdb.min.js"></script>
<script>
document.getElementById('registerForm').addEventListener('submit', function(event) {
    let isValid = true;
    const password = document.getElementById('password').value;
    const confirmPassword = document.getElementById('confirmPassword').value;
    
    // Clear previous errors
    document.querySelectorAll('.error-message').forEach(el => el.textContent = '');
    
    // Validate password match
    if (password !== confirmPassword) {
        document.getElementById('confirmPasswordError').textContent = 'Passwords do not match';
        isValid = false;
    }
    
    // Validate password length
    if (password.length < 6) {
        document.getElementById('passwordError').textContent = 'Password must be at least 6 characters';
        isValid = false;
    }
    
    if (!isValid) {
        event.preventDefault();
    }
});
</script>

</body>
</html>