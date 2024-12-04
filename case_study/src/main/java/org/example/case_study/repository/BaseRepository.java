package org.example.case_study.repository;

import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.SQLException;

public class BaseRepository {
    private final Connection connection;
    private static final String URL = "jdbc:mysql://localhost:3306/testcase";

    private static final String USERNAME = "root";
    private static final String PASSWORD = "codegym";

    public BaseRepository() throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.jdbc.Driver");
        this.connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
        System.out.println("Ket noi thanh cong..");
    }
    public Connection getConnection() {
        return connection;
    }

}
