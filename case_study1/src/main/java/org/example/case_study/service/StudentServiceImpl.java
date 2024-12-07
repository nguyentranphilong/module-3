package org.example.case_study.service;
import org.example.case_study.model.Class;
import org.example.case_study.model.Student;
import org.example.case_study.repository.studentRepo.IStudentRepo;
import org.example.case_study.repository.studentRepo.StudentRepoImpl;

import java.sql.SQLException;
import java.util.List;

public class StudentServiceImpl implements IStudentService{
    private final IStudentRepo iStudentRepo = new StudentRepoImpl();
//    @Override


    @Override
    public List<Student> findAll() {
        return iStudentRepo.findAll();
    }

    @Override
    public List<Class> findAllClass() {
        return iStudentRepo.findAllClass();
    }

    @Override
    public void addNewStudent(Student student) {
        iStudentRepo.addNewStudent(student);
    }

    @Override
    public void deleteStudent(int id) {
        iStudentRepo.deleteStudent(id);
    }

    @Override
    public Student getStudentById(int id) {
        return iStudentRepo.getStudentById(id);
    }

    @Override
    public void save(Student student) {
        iStudentRepo.save(student);
    }

    @Override
    public List<Student> searchByName(String name) {
        return iStudentRepo.searchByName(name);
    }

    @Override
    public boolean checkEmailForUpdate(int id, String email) throws SQLException {
        return iStudentRepo.checkEmailForUpdate(id, email);
    }

    @Override
    public boolean checkEmailForCreate(String email) throws SQLException {
        return iStudentRepo.checkEmailForCreate(email);
    }

    @Override
    public List<Student> filterStudents(String name, String className, String email) {
        return iStudentRepo.filterStudents(name, className, email);
    }

}
