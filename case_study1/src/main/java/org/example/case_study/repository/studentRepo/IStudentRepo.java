package org.example.case_study.repository.studentRepo;
import org.example.case_study.model.Class;
import org.example.case_study.model.Student;

import java.sql.SQLException;
import java.util.List;

public interface IStudentRepo {
    List<Student> findAll();
    List<Class> findAllClass();

    void addNewStudent(Student student);
    void deleteStudent(int id);
    Student getStudentById( int id);
    void save(Student student);
    boolean checkEmailForCreate(String email) throws SQLException;
    boolean checkEmailForUpdate(int id, String email) throws SQLException;
    List<Student> searchByName(String name);

    List<Student> filterStudents(String name, String className, String email);
}
