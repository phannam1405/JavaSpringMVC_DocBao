- đầu tiên vào persistence.xml trong src/META-INF để sửa các thông tin csdl tương ứng của máy đang sử dụng, cụ thể là mật khẩu, và tên tài khoản(nếu không dùng mysql)
- vào src ở packet net.codejava.config tìm class WebMvcConfig, ở dòng registry.addResourceHandler("/uploads/**")
        .addResourceLocations("file:/D:/java_web_doc_bao/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/TheNews/resources/uploads/");
  => sửa lại ổ đĩa mà máy đang sử dụng lưu file, hãy đi tới thư mục như trong đường dẫn trên nhưng là đường dẫn của máy bạn và copy đường dẫn và format theo đoạn code đó để thay thế
- vào resources lấy tất cả các ảnh và vào thư mục bạn vừa đi tới(uploads) sau đó paste vào 
- vào thư mục WebContent để tìm file sql sau đó vào mysql để chạy file đó
- Chạy dự án
- muốn truy cập admin thì đường dẫn gốc/admin/login
