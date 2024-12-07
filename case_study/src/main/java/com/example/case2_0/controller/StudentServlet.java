package com.example.case2_0.controller;

import com.example.case2_0.model.Class;
import com.example.case2_0.model.Student;
import com.example.case2_0.service.IStudentService;
import com.example.case2_0.service.StudentServiceImpl;

import java.io.*;
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.Period;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.*;


@WebServlet(name = "StudentServlet", value = "/student-servlet")
public class StudentServlet extends HttpServlet {
    private final IStudentService iStudentService = new StudentServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            action = "";
        }
        switch (action) {
            case "create":
                showCreateForm(request, response);
                break;
            case "edit":
                showUpdateForm(request, response);
                break;
            case "delete":
                deleteStudent(request, response);
                break;
            case "filter":
                filterStudents(request, response);
                break;
            default:
                findAll(request, response);
        }
    }

    public void filterStudents(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, ServletException {
        String name = request.getParameter("name");
        String className = request.getParameter("className");
        String email = request.getParameter("email");
        if(className.equals("all")) className = null;


        List<Student> students = iStudentService.filterStudents(name, className, email);
        request.setAttribute("students", students);

        List<Class> classList = iStudentService.findAllClass();
        request.setAttribute("listClass", classList);

        request.getRequestDispatcher("list.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "create":
                try {
                    addNewStudent(request, response);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                break;
            case "edit":
                try {
                    save(request, response);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                break;

            default:
                findAll(request, response);
        }
    }

    private void showCreateForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Class> list = iStudentService.findAllClass();
        request.setAttribute("listCr", list);
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("create.jsp");
        requestDispatcher.forward(request, response);
    }

    private void addNewStudent(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        String name = request.getParameter("name");
        Date birthday = Date.valueOf((request.getParameter("birthday")));
        int gender = Integer.parseInt(request.getParameter("gender"));
        String email = (request.getParameter("email"));
        double point = Double.parseDouble(request.getParameter("point"));
        int classId = Integer.parseInt(request.getParameter("classId"));

        if (regaxName(name)) {
            request.setAttribute("errorMessage", "Tên không chứa số và kí tự đặc biệt.");
            forwardCreateForm(request, response, name, birthday, gender, email, point, classId);
            return;
        }

        if (regaxDob(birthday)) {
            request.setAttribute("errorMessage", "Độ tuổi phù hợp từ 15 đến 45 tuổi.");
            forwardCreateForm(request, response, name, birthday, gender, email, point, classId);
            return;
        }

        if (iStudentService.checkEmailForCreate(email)) {
            request.setAttribute("errorMessage", "Email đã tồn tại. Vui lòng nhập lại.");
            forwardCreateForm(request, response, name, birthday, gender, email, point, classId);
            return;
        }

        if (point < 0 || point > 10) {
            request.setAttribute("errorMessage", "Điểm chỉ nằm trong khoảng 0 đến 10.");
            forwardCreateForm(request, response, name, birthday, gender, email, point, classId);
            return;
        }
        iStudentService.addNewStudent(new Student(name, birthday, gender, email, point, new Class(classId)));
        response.sendRedirect("student-servlet");
    }

    public void forwardCreateForm(HttpServletRequest request, HttpServletResponse response, String name, Date birthday, int gender, String email, double point, int classId) throws ServletException, IOException {
        Student student = new Student(name, birthday, gender, email, point, new Class(classId));
        request.setAttribute("students", student);
        List<Class> classList = iStudentService.findAllClass();
        request.setAttribute("listCr", classList);
        request.getRequestDispatcher("create.jsp").forward(request, response);
    }

    private void showUpdateForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("sid"));
        Student studentList = iStudentService.getStudentById(id);
        List<Class> classList = iStudentService.findAllClass();
        request.setAttribute("st", studentList);
        request.setAttribute("listU", classList);
        // Điều hướng đến trang JSP hiển thị chi tiết sinh viên
        RequestDispatcher dispatcher = request.getRequestDispatcher("update.jsp");
        dispatcher.forward(request, response);
    }

    private void save(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException, ServletException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        Date birthday = Date.valueOf(request.getParameter("birthday"));
        int gender = Integer.parseInt(request.getParameter("gender"));
        String email = request.getParameter("email");
        double point = Double.parseDouble(request.getParameter("point"));
        int classId = Integer.parseInt(request.getParameter("classId"));

        if (regaxName(name)) {
            request.setAttribute("errorMessage", "Tên không chứa số và kí tự đặc biệt.");
            forwardToEditForm(request, response, id, name, birthday, gender, email, point, classId);
            return;
        }
        if (regaxDob(birthday)) {
            request.setAttribute("errorMessage", "Độ tuổi phù hợp từ 15 đến 45 tuổi.");
            forwardToEditForm(request, response, id, name, birthday, gender, email, point, classId);
            return;
        }
        Student currentStudent = iStudentService.getStudentById(id);
        if (!email.equals(currentStudent.getEmail())){
            if (iStudentService.checkEmailForCreate(email)){
                request.setAttribute("errorMessage", "Email đã tồn tại. Vui lòng nhập lại.");
                forwardToEditForm(request, response, id, name, birthday, gender, email, point, classId);
                return;
            }
        }

        if (point < 0 || point > 10) {
            request.setAttribute("errorMessage", "Điểm chỉ nằm trong khoảng 0 đến 10.");
            forwardToEditForm(request, response, id, name, birthday, gender, email, point, classId);
            return;
        }
        iStudentService.save(new Student(id, name, birthday, gender, email, point, new Class(classId)));
        response.sendRedirect("student-servlet");

    }

    public void forwardToEditForm(HttpServletRequest request, HttpServletResponse response, int id, String name, Date birthday, int gender, String email, double point, int classId) throws ServletException, IOException {
        Student student = new Student(id, name, birthday, gender, email, point, new Class(classId));
        request.setAttribute("st", student);
        List<Class> classList = iStudentService.findAllClass();
        request.setAttribute("listU", classList);
        request.getRequestDispatcher("update.jsp").forward(request, response);
    }

    private void searchByName(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("search");
        // Kiểm tra ô tìm kiếm không được rỗng
        if (name == null || name.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Vui lòng nhập tên cần tìm kiếm.");
            findAll(request, response); // Hoặc redirect về trang danh sách
            return;
        }
        // Nếu không rỗng, thực hiện tìm kiếm
        List<Student> students = iStudentService.searchByName(name);
        request.setAttribute("students", students);

        RequestDispatcher requestDispatcher = request.getRequestDispatcher("list.jsp");
        requestDispatcher.forward(request, response);
    }

    private void deleteStudent(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("sid"));
        iStudentService.deleteStudent(id);
        response.sendRedirect("student-servlet");
    }

    private void findAll(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("students", iStudentService.findAll());
        request.setAttribute("listClass", iStudentService.findAllClass());
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("list.jsp");
        requestDispatcher.forward(request, response);
    }


    private boolean regaxName(String name) {
        return !name.matches("^[\\p{L}\\s]{1,150}$");
    }

    private boolean regaxDob(Date birthday) {
        LocalDate currentDate = LocalDate.now();
        LocalDate birthDate = birthday.toLocalDate();
        int age = Period.between(birthDate, currentDate).getYears();
        return !(age >= 15 && age <= 45);
    }
}