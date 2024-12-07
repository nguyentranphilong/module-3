<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách học viên</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap5.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"> <!-- link bootrap icon kính lúp -->
    <link rel="stylesheet" type="text/css" href="css/lists.css"> <!-- Liên kết đến file CSS -->
</head>

<body>


<div class="container mt-4">
    <h1 class="page-title">Danh sách học viên trường chuyên ban</h1>
<%--    <c:if test="${not empty errorMessage}">--%>
<%--        <div class="alert alert-danger mt-2" role="alert" id="errorAlert">--%>
<%--                ${errorMessage}--%>
<%--        </div>--%>
<%--    </c:if>--%>
    <!-- Hàng cho nút thêm và ô tìm kiếm -->
<%--    <div class="row mb-4 align-items-center">--%>
<%--        <div class="col-auto">--%>
<%--            <a href="?action=create" class="btn btn-success">Thêm mới học viên</a>--%>
<%--        </div>--%>
<%--        <div class="col">--%>
<%--            <form action="student-servlet" method="get" class="form-inline d-flex">--%>
<%--                <input type="hidden" name="action" value="search">--%>
<%--                <input type="text" name="search" class="form-control flex-grow-1" placeholder="Nhập tên học viên cần tìm..." id="searchInput">--%>
<%--                <button type="submit" class="btn btn-primary ml-2 align-self-center">--%>
<%--                    <i class="fas fa-search"></i>--%>
<%--                </button>--%>
<%--            </form>--%>
<%--        </div>--%>
<%--    </div>--%>
    <div class="row mb-4 align-items-center">
        <div class="col-auto">
            <a href="?action=create" class="btn btn-success">Thêm mới học viên</a>
        </div>
        <div class="col">
            <form action="?action=filter" method="get" class="form-inline d-flex">
                <input type="hidden" name="action" value="filter"> <!-- Đảm bảo action là filter -->
                <input type="text" name="name" class="form-control flex-grow-1" placeholder="Nhập tên học viên...">
                <input type="text" name="email" class="form-control flex-grow-1 ml-2" placeholder="Nhập email học viên...">

                <label>
                    <select name="className" class="form-control ml-2">
                        <option value="all" id="className" name="className">Tất cả lớp học</option> <!-- Tùy chọn mặc định -->
                        <c:forEach items="${listClass}" var="c">
                            <option value="${c.className}">${c.className}</option> <!-- Đảm bảo hiển thị tên lớp -->
                        </c:forEach>
                    </select>
                </label>
                <button type="submit" class="btn btn-primary ml-2">
                    <i class="fas fa-search"></i> <!-- Biểu tượng tìm kiếm -->
                </button>
            </form>
        </div>
    </div>

    <table id="mainTable" class="table  table-bordered">
        <thead class="thead-pascal">
        <tr>
            <th>STT</th>
            <th>Tên</th>
            <th>Ngày sinh</th>
            <th>Giới tính</th>
            <th>Email</th>
            <th>Điểm</th>
            <th>Xếp loại</th>
            <th>Lớp</th>
            <th class="text-center">Chức năng</th> <!-- Không gộp thành hai ô -->
        </tr>
        </thead>
        <tbody class="tbody-pascal" >
        <c:choose>
            <c:when test="${not empty students}">
                <c:forEach items="${students}" var="s" varStatus="status">
                    <tr>
<%--                        <td>${s.id}</td>--%>
                        <td>${status.index + 1}</td>
                        <td>${s.name}</td>
                        <td>${s.getDateFormat()}</td>
                        <td>
                            <c:choose>
                                <c:when test="${s.gender == 1}">Nam</c:when>
                                <c:otherwise>Nữ</c:otherwise>
                            </c:choose>
                        </td>
                        <td>${s.email}</td>
                        <td>${s.point}</td>
                        <td>
                            <c:choose>
                                <c:when test="${s.point > 8.9}">Loại Giỏi</c:when>
                                <c:when test="${s.point > 7.9}">Loại Khá</c:when>
                                <c:when test="${s.point > 6.9}">Loại TB</c:when>
                                <c:otherwise>Loại Yếu</c:otherwise>
                            </c:choose>
                        </td>
                        <td>${s.clazz.className}</td>
                        <td class="text-center">
                            <div class="d-flex justify-content-center">
                                <a href="?action=edit&sid=${s.id}" class="btn btn-warning btn-sm mr-2" >Sửa</a>
                                <button type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#deleteModal" data-id="${s.id}" data-name="${s.name}">Xóa</button>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tr>
                    <td colspan="10" class="text-center">Không có sinh viên nào được tìm thấy</td>
                </tr>
            </c:otherwise>
        </c:choose>
        </tbody>
    </table>

    <!-- Modal xác nhận action delete -->
    <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="deleteModalLabel">Xác nhận xóa</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    Bạn có chắc chắn muốn xóa học viên <span id="studentName"></span> không?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <a id="confirmDelete" href="#" class="btn btn-danger">Xóa</a>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>


<script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
<script>
    $(document).ready(function() {
        $('#mainTable').DataTable({
            "dom" : 'lrtip',
            "lengthChange": false,
            "pageLength": 5,
            "columnDefs": [
                { "orderable": false, "targets": 7 }
            ]
        })
    });
</script>

<script>
    $('#deleteModal').on('show.bs.modal', function (event) {
        let button = $(event.relatedTarget); // Nút kích hoạt modal
        let studentId = button.data('id'); // Lấy giá trị ID từ nút
        let studentName = button.data('name'); // Lấy giá trị tên từ nút
        let modal = $(this);
        let deleteUrl = "?action=delete&sid=" + studentId; // Tạo URL xóa
        modal.find('#studentName').text(studentName); // Cập nhật tên học viên trong modal
        modal.find('#confirmDelete').attr('href', deleteUrl);   // Cập nhật liên kết "Xóa" trong modal
    });
</script>
<script>
    document.getElementById('searchInput').addEventListener('focus', function() {
        const errorAlert = document.getElementById('errorAlert');
        if (errorAlert) {
            errorAlert.style.display = 'none'; // Ẩn thanh thông báo lỗi
        }
    });
</script>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        var successAlert = document.querySelector('.alert-success'); // Chọn thông báo thành công
        if (successAlert) {
            successAlert.style.display = 'block'; // Hiển thị thông báo
            setTimeout(function () {
                successAlert.style.opacity = 0; // Tạo hiệu ứng mờ dần
                setTimeout(function () {
                    successAlert.style.display = 'none'; // Ẩn thông báo hoàn toàn sau khi mờ dần
                }, 500); // Thời gian cho hiệu ứng mờ dần (0.5 giây)
            }, 2000); // Thời gian hiển thị thông báo (2 giây)
        }
    });


</script>

</body>
</html>
