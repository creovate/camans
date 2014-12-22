/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.dao;

import camans.entity.User;
import camans.entity.Worker;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author soemyatmyat
 */
public class UserDAO {
    
    public static User retrieveUserByUsername(String username) {
        User user = null;
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT NRIC_number, Full_Name, Alias, Password, Email_Address,"
                    + "Phone_number, Gender, Role, Photo, Status "
                    + " FROM tbl_user where Username = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String nricNumber = rs.getString(1);
                String fullName = rs.getString(2);
                String alias = rs.getString(3);
                String password = rs.getString(4);
                String emailAddress = rs.getString(5);
                String phoneNumber = rs.getString(6);
                String gender = rs.getString(7);
                String role = rs.getString(8);
                String photoPath = rs.getString(9);
                String status = rs.getString(10);
                user = new User(nricNumber, fullName, alias, username, password,
                        emailAddress, phoneNumber, gender, role, photoPath, status);
            }
            
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "User={" + user + "}");           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return user;
    }
    
    public static User retrieveUserByNRIC(String nricNumber) {
        User user = null;
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Username, Full_Name, Alias, Password, Email_Address,"
                    + "Phone_number, Gender, Role, Photo, Status "
                    + " FROM tbl_user where NRIC_number = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, nricNumber);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String username = rs.getString(1);
                String fullName = rs.getString(2);
                String alias = rs.getString(3);
                String password = rs.getString(4);
                String emailAddress = rs.getString(5);
                String phoneNumber = rs.getString(6);
                String gender = rs.getString(7);
                String role = rs.getString(8);
                String photoPath = rs.getString(9);
                String status = rs.getString(10);
                user = new User(nricNumber, fullName, alias, username, password,
                        emailAddress, phoneNumber, gender, role, photoPath, status);
            }
            
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "User={" + user + "}");           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return user;
    }
        
    public static void addUser(User user) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "INSERT INTO tbl_user (NRIC_number, Full_name, Alias, Username, Password, Email_Address,"
                    + "Phone_number, Gender, Role, Photo, Status) VALUES (?,?,?,?,?,?,?,?,?,?,?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user.getNricNumber());
            pstmt.setString(2, user.getFullName());
            pstmt.setString(3, user.getAlias());
            pstmt.setString(4, user.getUsername());
            pstmt.setString(5, user.getPassword());
            pstmt.setString(6, user.getEmailAddress());
            pstmt.setString(7, user.getPhoneNumber());
            pstmt.setString(8, user.getGender());
            pstmt.setString(9, user.getRole());
            pstmt.setString(10, user.getPhotoPath());
            pstmt.setString(11, user.getStatus());
            
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "User={" + user + "}");
        } finally {
            ConnectionManager.close(conn, pstmt);
        }    
    }
    
    public static void updateUser(User user) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_user SET NRIC_number=?, Full_name=?, Alias=?,"
                    + "Email_Address=?,Phone_number=?, Gender=?, "
                    + "Role=?, Photo=? WHERE Username=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user.getNricNumber());
            pstmt.setString(2, user.getFullName());
            pstmt.setString(3, user.getAlias());
            pstmt.setString(4, user.getEmailAddress());
            pstmt.setString(5, user.getPhoneNumber());
            pstmt.setString(6, user.getGender());
            pstmt.setString(7, user.getRole());
            pstmt.setString(8, user.getPhotoPath());
            pstmt.setString(9, user.getUsername());
            
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "User={" + user + "}");
        } finally {
            ConnectionManager.close(conn, pstmt);
        }  
    }
    
    public static void updatePassword(User user) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_user SET Password=? WHERE Username=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user.getPassword());
            pstmt.setString(2, user.getUsername());
            
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "User={" + user + "}");
        } finally {
            ConnectionManager.close(conn, pstmt);
        }         
    }
    
    public static void updateStatus(User user) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_user SET Status=? WHERE Username=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user.getStatus());
            pstmt.setString(2, user.getUsername());
            
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "User={" + user + "}");
        } finally {
            ConnectionManager.close(conn, pstmt);
        } 
    }
    
    public static void deleteUser (String username) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "Delete from tbl_user WHERE Username=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "User={" + username + "}");
        } finally {
            ConnectionManager.close(conn, pstmt);
        } 
    }
    
    public static ArrayList<User> retrieveAllUsers() {
        ArrayList<User> userList = new ArrayList<User>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT NRIC_number, Full_name, Alias, Username,"
                    + "Email_address,Phone_number,Gender,Role,Photo, Status"
                    + " FROM tbl_user order by Entry_date DESC";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String nricNum = rs.getString(1);
                String fullName = rs.getString(2);
                //Date registeredDate = rs.getDate(3);
                String alias = rs.getString(3);
                String username = rs.getString(4);
                String emailAddress = rs.getString(5);
                String phoneNum = rs.getString(6);
                String gender = rs.getString(7);
                String role = rs.getString(8);
                String photoPath = rs.getString(9);
                String status = rs.getString(10);
                //Date dob = rs.getDate(9);
                User user = new User(nricNum, fullName, alias, username, emailAddress, phoneNum,
                        gender, role, photoPath, status);
                userList.add(user);
            }
            
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "UserList={" + userList + "}");           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return userList;
    }
    
    public static Date retrieveRegisteredDate(User user) {
        Date registeredDate = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Entry_date FROM tbl_user where NRIC_number = ?;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user.getNricNumber());
            rs = pstmt.executeQuery();
            while (rs.next()) {
                registeredDate = rs.getDate(1);
            }
            return registeredDate;
            
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "User={" + user + "}");           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
    
        
        return registeredDate;
    }
    
    private static void handleSQLException(SQLException ex, String sql, String... parameters) {
      String msg = "Unable to access data; SQL=" + sql + "\n";
      for (String parameter : parameters) {
        msg += "," + parameter + ex.getMessage();
      }
      Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, msg, ex);
      throw new RuntimeException(msg, ex);
    }
}
