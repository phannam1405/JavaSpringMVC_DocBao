<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký tài khoản</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(to right, #ffdde1, #ee9ca7);
            min-height: 100vh;
        }
        .register-container {
            background-color: #fff;
            border-radius: 20px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.15);
            padding: 40px 30px;
            max-width: 550px;
            width: 100%;
        }
        .register-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .register-header img {
            width: 80px;
        }
        .form-control {
            border-radius: 10px;
        }
        .input-group-text {
            border-radius: 10px 0 0 10px;
        }
        .btn-register {
            background: #6c757d;
            color: #fff;
            font-weight: 600;
            border-radius: 10px;
            transition: background 0.3s;
        }
        .btn-register:hover {
            background: #5a6268;
        }
        .login-link {
            color: #6c757d;
            font-weight: 500;
            text-decoration: none;
        }
        .login-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container d-flex justify-content-center align-items-center min-vh-100">
        <div class="register-container">
            <div class="register-header">
                <img src="https://cdn-icons-png.flaticon.com/512/6681/6681204.png" alt="Register Icon">
                <h3 class="mt-2">Đăng ký tài khoản</h3>
                <p class="text-muted">Tạo tài khoản để bắt đầu trải nghiệm</p>
            </div>
            <form action="${pageContext.request.contextPath}/register" method="post">
                <div class="mb-3">
                    <label for="fullName" class="form-label">Họ và tên</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-user"></i></span>
                        <input type="text" class="form-control" id="fullName" name="fullname" placeholder="Nhập họ và tên" required>
                    </div>
                </div>
                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                        <input type="email" class="form-control" id="email" name="email" placeholder="Nhập email" required>
                    </div>
                </div>
                <div class="mb-3">
                    <label for="phone" class="form-label">Số điện thoại</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-phone"></i></span>
                        <input type="tel" class="form-control" id="phone" name="phone" placeholder="Nhập số điện thoại" required>
                    </div>
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Mật khẩu</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-lock"></i></span>
                        <input type="password" class="form-control" id="password" name="password" placeholder="Nhập mật khẩu" required>
                        <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                            <i class="fas fa-eye"></i>
                        </button>
                    </div>
                    <div class="form-text">Mật khẩu phải có ít nhất 8 ký tự</div>
                </div>
                <div class="mb-4">
                    <label for="confirmPassword" class="form-label">Xác nhận mật khẩu</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-lock"></i></span>
                        <input type="password" class="form-control" name="confirmPassword" id="confirmPassword" placeholder="Nhập lại mật khẩu" required>
                    </div>
                </div>
                <button type="submit" class="btn btn-register w-100 mb-3">Đăng ký</button>
                <div class="text-center">
                    <p>Đã có tài khoản? <a href="${pageContext.request.contextPath}/login" class="login-link">Đăng nhập ngay</a></p>
                </div>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Toggle hiển thị mật khẩu
        document.getElementById('togglePassword').addEventListener('click', function () {
            const passwordInput = document.getElementById('password');
            const icon = this.querySelector('i');
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                icon.classList.replace('fa-eye', 'fa-eye-slash');
            } else {
                passwordInput.type = 'password';
                icon.classList.replace('fa-eye-slash', 'fa-eye');
            }
        });

        // Kiểm tra mật khẩu khớp
        document.querySelector('form').addEventListener('submit', function (e) {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            if (password !== confirmPassword) {
                e.preventDefault();
                alert('Mật khẩu không trùng khớp!');
            }
        });
    </script>
</body>
</html>
