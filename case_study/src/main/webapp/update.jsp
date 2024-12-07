<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa thông tin học viên</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="css/update.css"> <!-- Liên kết đến file CSS tùy chỉnh -->
</head>
<body>
<div class="form-container">
    <h1 class="header-title">Cập nhật thông tin học viên</h1>
    <form action="?action=edit" method="post">
        <div class="form-group">
            <label for="id"></label>
            <input type="hidden" class="form-control" id="id" name="id" readonly value="${st.id}">
        </div>
        <div class="form-group">
            <label for="name">Tên:</label>
            <input type="text" class="form-control" id="name" name="name" value="${st.name}">
        </div>
        <div class="form-group">
            <label for="birthday">Ngày sinh:</label>
            <input type="date" class="form-control" id="birthday" name="birthday" value="${st.birthday}">
        </div>
        <div class="form-group">
            <label>Giới tính:</label><br>
            <input type="radio" name="gender" value="1" ${st.gender == 1 ? "checked" : ""}> Nam
            <input type="radio" name="gender" value="0" ${st.gender == 0 ? "checked" : ""}> Nữ
        </div>
        <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" class="form-control" id="email" name="email" value="${st.email}">
        </div>
        <div class="form-group">
            <label for="point">Điểm:</label>
            <input type="number" class="form-control" id="point" name="point" step="0.01" value="${st.point}">
        </div>
        <div class="form-group">
            <label for="classId">Lớp học</label>
            <select class="form-select" name="classId" id="classId" required>
                <c:forEach var="c" items="${listU}">
                    <option value="${c.classId}" ${c.classId == st.clazz.classId ? 'selected' : ''}>
                            ${c.className}
                    </option>
                </c:forEach>
            </select>
        </div>
        <button type="submit" class="btn btn-primary btn-lg btn-block">Cập nhật</button>
    </form>
</div>
<%-- Modal for email validation error --%>
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
<!-- Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

<script>
    <% if (request.getAttribute("errorMessage") != null) { %>
    let emailErrorModal = new bootstrap.Modal(document.getElementById('emailErrorModal'));
    emailErrorModal.show();
    <% } %>
</script>
</body>
</html>