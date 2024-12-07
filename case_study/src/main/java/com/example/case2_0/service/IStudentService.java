package com.example.case2_0.service;

import com.example.case2_0.model.Class;
import com.example.case2_0.model.Student;

import java.sql.SQLException;
import java.util.List;

public interface IStudentService {
    List<Student> findAll();
    List<Class> findAllClass();
    void addNewStudent(Student student);
    void deleteStudent(int id);
    Student getStudentById( int id);
    void save(Student student);
    List<Student> searchByName(String name);
    boolean checkEmailForCreate(String email) throws SQLException;
    boolean checkEmailForUpdate(int id, String email) throws SQLException;
    List<Student> filterStudents(String name, String className , String email);

}
