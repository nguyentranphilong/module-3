package com.example.case2_0.model;

public class Class {
    private int classId;
    private String className;

    public Class(int id, String className) {
        this.classId = id;
        this.className = className;
    }

    public Class(int classId) {
        this.classId = classId;
    }

    public int getClassId() {
        return classId;
    }

    public void setClassId(int classId) {
        this.classId = classId;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }
}