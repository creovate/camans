/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.dao;

import static camans.dao.WorkerDAO.retrieveWorkerbyFinNumber;
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
public class WorkerDAO {
    
    public static Worker retrieveWorkerbyFinNumber(String finNumber) {
        Worker worker = null;
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Name_of_worker, Worker_registration_date, Created_by, Create_for, Gender,"
                    + "Nationality, Nationality_more, Date_of_birth"
                    + " FROM tbl_worker where FIN_number = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, finNumber);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String name = rs.getString(1);
                Date registeredDate = rs.getDate(2);
                String createdBy = rs.getString(3);
                String createdFor = rs.getString(4);
                String gender = rs.getString(5);
                String nationality = rs.getString(6);
                String nationalityMore = rs.getString(7);
                Date dob = rs.getDate(8);
                worker = new Worker(finNumber, name, registeredDate, createdBy, createdFor, gender,
                        nationality, nationalityMore, dob);
            }
            
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "Worker={" + worker + "}");           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return worker;
    }
    
    public static void addWorker(Worker worker) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "INSERT INTO tbl_worker (FIN_number, Name_of_Worker, Worker_registration_date, "
                    + "Created_by, Create_for, Gender, Nationality, Nationality_more, Date_of_birth) "
                    + "VALUES (?,?,?,?,?,?,?,?,?)";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, worker.getFinNumber());
            pstmt.setString(2, worker.getName());
            pstmt.setDate(3, worker.getRegistrationDate());
            pstmt.setString(4, worker.getCreatedBy());
            pstmt.setString(5, worker.getCreatedFor());
            pstmt.setString(6, worker.getGender());
            pstmt.setString(7, worker.getNationality());
            pstmt.setString(8, worker.getNationalityMore());
            pstmt.setDate(9, worker.getDateOfBirth());
            
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "Worker={" + worker + "}");
        } finally {
            ConnectionManager.close(conn, pstmt);
        }    
    }
    
    public static ArrayList<Worker> retrieveLatestWorkers() {
        ArrayList<Worker> workerList = new ArrayList<Worker>();
                Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT FIN_number, Name_of_worker, Worker_registration_date, Created_by, "
                    + "Create_for, Gender,"
                    + "Nationality, Nationality_more, Date_of_birth"
                    + " FROM tbl_worker order by Entry_date DESC limit 12;";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String finNumber = rs.getString(1);
                String name = rs.getString(2);
                Date registeredDate = rs.getDate(3);
                String createdBy = rs.getString(4);
                String createdFor = rs.getString(5);
                String gender = rs.getString(6);
                String nationality = rs.getString(7);
                String nationalityMore = rs.getString(8);
                Date dob = rs.getDate(9);
                Worker worker = new Worker(finNumber, name, registeredDate, createdBy, createdFor, gender,
                        nationality, nationalityMore, dob);
                workerList.add(worker);
            }
            
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "WorkerList={" + workerList + "}");           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }

        return workerList;
    }
 
    public static ArrayList<Worker> retrieveWorkersBySearchFilter(String sql) {
        ArrayList<Worker> workerList = new ArrayList<Worker>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = ConnectionManager.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String finNumber = rs.getString(1);
                
                Worker worker = retrieveWorkerbyFinNumber(finNumber);
                workerList.add(worker);
            }
            
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "WorkerList={" + workerList + "}");           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return workerList;
    }

    public static ArrayList<Worker> retrieveWorkersByUser(String username) {
        ArrayList<Worker> workerList = new ArrayList<Worker>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT distinct Worker_FIN_number from tbl_lead_case_worker where Lead_case_worker = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String finNumber = rs.getString(1);
                Worker worker = retrieveWorkerbyFinNumber(finNumber);
                workerList.add(worker);
            }
            sql = "SELECT distinct Worker_FIN_number from tbl_auxillarycaseworker where Aux_name = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String finNumber = rs.getString(1);
                Worker worker = retrieveWorkerbyFinNumber(finNumber);
                workerList.add(worker);
            } 
            
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "WorkerList={" + workerList + "}");           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        
        return workerList;
    }
      
    private static void handleSQLException(SQLException ex, String sql, String... parameters) {
      String msg = "Unable to access data; SQL=" + sql + "\n";
      for (String parameter : parameters) {
        msg += "," + parameter + ex.getMessage();
      }
      Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, msg, ex);
      throw new RuntimeException(msg, ex);
    }

    public static void updateWorkerProfile(Worker worker) {
        Connection conn = null;
        PreparedStatement stmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_worker SET Name_of_Worker = ?, Worker_registration_date = ? , Created_by = ?, Create_for = ?, Gender = ?, Nationality = ?, Nationality_more = ?, Date_of_birth = ? WHERE FIN_number = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1,worker.getName());
            stmt.setDate(2,worker.getRegistrationDate());
            stmt.setString(3, worker.getCreatedBy());
            stmt.setString(4, worker.getCreatedFor());
            stmt.setString(5, worker.getGender());
            stmt.setString(6, worker.getNationality());
            stmt.setString(7, worker.getNationalityMore());
            stmt.setDate(8, worker.getDateOfBirth());
            stmt.setString(9, worker.getFinNumber());
            
            stmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "worker={" + worker + "}");
        } finally {
            ConnectionManager.close(conn, stmt, null);
        }        
    }
}
