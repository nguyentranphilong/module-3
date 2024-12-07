<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm mới học viên</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="css/create.css">
</head>
<body>
<div class="container mt-5">
    <div class="form-container">
        <h1 class="header-title">Thêm Mới Học Viên</h1>
        <form action="student-servlet?action=create" method="post">
            <div class="form-group">
                <label for="name">Tên:</label>
                <input type="text" class="form-control form-control-lg" id="name" name="name" value="${students.name}" required>
            </div>

            <div class="form-group">
                <label for="birthday">Ngày sinh:</label>
                <input type="date" class="form-control form-control-lg" id="birthday" name="birthday" value="${students.birthday}" required>
            </div>

            <div class="form-group">
                <label>Giới tính:</label><br>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" id="genderMale" name="gender" value="1" ${students.gender == '1' ? 'checked' : ''} required>
                    <label class="form-check-label" for="genderMale">Nam</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" id="genderFemale" name="gender" value="0" ${students.gender == '0' ? 'checked' : ''} required>
                    <label class="form-check-label" for="genderFemale">Nữ</label>
                </div>
            </div>

            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" class="form-control form-control-lg" id="email" name="email" value="${students.email}" required>
            </div>

            <div class="form-group">
                <label for="point">Điểm:</label>
                <input type="number" class="form-control form-control-lg" id="point" name="point" step="0.01" value="${students.point}" required>
            </div>

            <div class="form-group">
                <label for="classId">Lớp học</label> <br>
                <select class="form-select" name="classId" id="classId" required>
                    <option value="" disabled selected>Chọn lớp</option> <!-- Thêm option mặc định -->
                    <c:forEach var="c" items="${listCr}">
                        <option value="${c.classId}" ${c.classId == students.clazz.classId ? 'selected' : ''}>${c.className}</option>
                    </c:forEach>
                </select>
            </div>



            <button type="submit" class="btn btn-primary btn-lg btn-block">Thêm mới</button>
        </form>
    </div>
</div>

<div class="modal fade" id="emailErrorModal" tabindex="-1" aria-labelledby="emailErrorModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="emailErrorModalLabel">Lỗi</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                ${errorMessage}
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>


<!-- js hiển thị các thông báo lỗi có "errorMessage" -->
<script>
    <% if (request.getAttribute("errorMessage") != null) { %>
    let emailErrorModal = new bootstrap.Modal(document.getElementById('emailErrorModal'));
    emailErrorModal.show();
    <% } %>
</script>

</body>
</html>
