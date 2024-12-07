package com.example.case2_0.model;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;


public class Student {
    private int id;
    private String name;
    private Date birthday;
    private int gender;
    private String email;
    private double point;;
    private Class clazz;

    private static final SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");


    public Student(int id, String name, Date birthday, int gender, String email, double point, Class clazz) {
        this.id = id;
        this.name = name;
        this.birthday = birthday;
        this.gender = gender;
        this.point = point;
        this.email = email;
        this.clazz = clazz;
    }

    public Student(String name, Date birthday, int gender, String email, double point, Class clazz) {
        this.name = name;
        this.birthday = birthday;
        this.gender = gender;
        this.point = point;
        this.email = email;
        this.clazz = clazz;
    }




    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public String getDateFormat() throws ParseException {
        return dateFormat.format(birthday);
    }

    public void setDateFormat(Date dob) {
        this.birthday = Date.valueOf(dateFormat.format(dob));
    }

    public int getGender() {
        return gender;
    }

    public void setGender(int gender) {
        this.gender = gender;
    }

    public double getPoint() {
        return point;
    }

    public void setPoint(double point) {
        this.point = point;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Class getClazz() {
        return clazz;
    }

    public void setClazz(Class clazz) {
        this.clazz = clazz;
    }


}