package org.example.case_study.repository.studentRepo;
import org.example.case_study.model.Class;
import org.example.case_study.model.Student;
import org.example.case_study.repository.BaseRepository;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StudentRepoImpl implements IStudentRepo {
        private final BaseRepository baseRepository;
        {
            try {
                baseRepository = new BaseRepository();
            } catch (ClassNotFoundException | SQLException e) {
                throw new RuntimeException(e);
            }
        }
    private static final String CALL_GET_ALL_STUDENTS = "CALL GetAllStudents()";
    private static final String FIND_ALL_CLASS = "select * from class";
    private static final String CALL_INSERT_STUDENT = "CALL InsertStudent(?,?,?,?,?,?)";
    private static final String DELETE_STUDENT = "delete from student where student_id = ?";
    private static final String CALL_GET_BY_ID = "CALL GetStudentById(?)";
    private static final String CALL_UPDATE_STUDENT = "CALL UpdateStudent(?, ?, ?, ?, ?, ?, ?)";
    private static final String CALL_SEARCH_BY_NAME = "CALL SearchStudentByName(?)";

    @Override
    public List<Student> findAll() {
        Connection connection = baseRepository.getConnection();
        List<Student> studentList = new ArrayList<>();
        try {
            CallableStatement callableStatement = connection.prepareCall(CALL_GET_ALL_STUDENTS);
            ResultSet resultSet = callableStatement.executeQuery();
            studentList = toList(resultSet);
        } catch (SQLException e) {
            System.err.println(e.getMessage());;
        }
        return studentList;
    }

    @Override
    public List<Class> findAllClass() {
        Connection connection = baseRepository.getConnection();
        List<Class> list = new ArrayList<>();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(FIND_ALL_CLASS);
            ResultSet result = preparedStatement.executeQuery();
            while(result.next()) {
                int classId = result.getInt("class_id");
                String className = result.getString("class_name");
                list.add(new Class(classId, className));
            }
        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }
        return list;
    }

    @Override
    public void addNewStudent(Student student) {
        Connection connection = baseRepository.getConnection();
        try {
            CallableStatement callableStatement = connection.prepareCall(CALL_INSERT_STUDENT);
            callableStatement.setString(1, student.getName());
            callableStatement.setDate(2, student.getBirthday());
            callableStatement.setInt(3, student.getGender());
            callableStatement.setString(4, student.getEmail());
            callableStatement.setDouble(5, student.getPoint());
            callableStatement.setInt(6, student.getClazz().getClassId());
            callableStatement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    @Override
    public void deleteStudent(int id) {
        Connection connection = baseRepository.getConnection();
        try {
            PreparedStatement ps = connection.prepareStatement(DELETE_STUDENT);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
    }
    @Override
    public Student getStudentById(int id) {
        Connection connection = baseRepository.getConnection();
        Student students = null;
        try {
            CallableStatement callableStatement = connection.prepareCall(CALL_GET_BY_ID);
            callableStatement.setInt(1, id);
            ResultSet resultSet = callableStatement.executeQuery();

            List<Student> list = toList(resultSet);
            if(!list.isEmpty()) {
                students = list.get(0);
            }
        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }
        return students;
    }
    private List<Student> toList(ResultSet resultSet) throws SQLException {
        List<Student> list = new ArrayList<>();
        while (resultSet.next()){
            int id = resultSet.getInt("student_id");
            String name = resultSet.getString("student_name");
            Date birthday = resultSet.getDate("student_birthday");
            int gender = resultSet.getInt("student_gender");
            String email = resultSet.getString("student_email");
            double point = resultSet.getDouble("student_point");
            int classId = resultSet.getInt("class_id");
            String className = resultSet.getString("class_name");
            Class clazz = new Class(classId, className);
            list.add(new Student(id, name, birthday, gender, email, point, clazz));

        }
        return list;

    }
    @Override
    public void save(Student student) {
        Connection connection = baseRepository.getConnection();
        try {
            CallableStatement callableStatement = connection.prepareCall(CALL_UPDATE_STUDENT);
            callableStatement.setString(1, student.getName());
            callableStatement.setDate(2, new Date(student.getBirthday().getTime()));
            callableStatement.setInt(3, student.getGender());
            callableStatement.setString(4, student.getEmail());
            callableStatement.setDouble(5, student.getPoint());
            callableStatement.setInt(6, student.getClazz().getClassId());
            callableStatement.setInt(7, student.getId());
            callableStatement.executeUpdate();
        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }
    }

    @Override
    public boolean checkEmailForCreate(String email) throws SQLException {
        String sql = "SELECT COUNT(*) FROM student WHERE student_email = ?";
        Connection connection = baseRepository.getConnection();
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, email);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return resultSet.getInt(1) > 0;
                }
            }
        }
        return false;
    }
public boolean checkEmailForUpdate(int id, String email) throws SQLException {
    String sql = "SELECT COUNT(*) FROM student WHERE student_email = ? AND student_id != ?";
    Connection connection = baseRepository.getConnection();
    try (PreparedStatement statement = connection.prepareStatement(sql)) {
        statement.setString(1, email);
        statement.setInt(2, id);  // Bỏ qua học viên với ID hiện tại
        try (ResultSet resultSet = statement.executeQuery()) {
            if (resultSet.next()) {
                return resultSet.getInt(1) > 0;  // Trả về true nếu có email trùng lặp
            }
        }
    }
    return false;
}

    @Override
    public List<Student> searchByName(String name) {
        Connection connection = baseRepository.getConnection();
        List<Student> studentList = new ArrayList<>();
        try {
            CallableStatement callableStatement = connection.prepareCall(CALL_SEARCH_BY_NAME);
            callableStatement.setString(1, "%" + name + "%");  // Sử dụng LIKE để tìm kiếm tên có chứa chuỗi ký tự
            ResultSet resultSet = callableStatement.executeQuery();
            studentList = toList(resultSet);
            }
        catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return studentList;
    }

    @Override
    public List<Student> filterStudents(String name, String className, String email) {
            List<Student> students = new ArrayList<>();
        StringBuilder sql = getStringBuilder(name, className, email);

        Connection connection = baseRepository.getConnection();
            try (PreparedStatement preparedStatement = connection.prepareStatement(sql.toString())) {
                int index = 1;

                // Đặt giá trị cho tham số tìm kiếm tên học viên
                if (name != null && !name.isEmpty()) {
                    preparedStatement.setString(index++, "%" + name + "%");
                }
                if(email != null && !email.isEmpty()){
                    preparedStatement.setString(index++, "%" + email + "%");
                }

                // Đặt giá trị cho tham số tìm kiếm tên lớp
                if (className != null && !className.isEmpty()) {
                    preparedStatement.setString(index, "%" + className + "%");
                }

                ResultSet resultSet = preparedStatement.executeQuery();
                students = toList(resultSet); // Chuyển đổi ResultSet thành danh sách học viên
            } catch (SQLException e) {
            System.err.println(e.getMessage());
            }
            return students;
        }

    private static StringBuilder getStringBuilder(String name, String className, String email) {
        StringBuilder sql = new StringBuilder("SELECT s.*, c.class_name FROM student s JOIN class c ON s.class_id = c.class_id WHERE 1=1");

        // Kiểm tra nếu name không rỗng và thêm điều kiện tìm kiếm
        if (name != null && !name.isEmpty()) {
            sql.append(" AND s.student_name LIKE ?");
        }
        if (email != null && !email.isEmpty()){
            sql.append(" AND s.student_email LIKE ?");
        }
        // Kiểm tra nếu className không rỗng và thêm điều kiện tìm kiếm
        if (className != null && !className.isEmpty()) {
            sql.append(" AND c.class_name LIKE ?");
        }
        sql.append(" ORDER BY s.student_id");
        return sql;
    }

}
