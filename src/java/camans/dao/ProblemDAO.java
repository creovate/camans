/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.dao;

import camans.entity.Job;
import camans.entity.Problem;
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
public class ProblemDAO {

    public static ArrayList<Integer> retrieveProblemsIdsOfWorkerAndJob(Worker worker, Job job) {
        ArrayList<Integer> probIds = new ArrayList<Integer>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Prob_key FROM tbl_problem where Worker_FIN_number = ? AND Job_key = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, worker.getFinNumber());
            pstmt.setInt(2, job.getJobKey());
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int probKey = rs.getInt(1);
                probIds.add(probKey);
            }
            
        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }        
        
        return probIds;
    }
    
    public static Problem retrieveProblemByProblemId(int problemId) {
        Problem problem = null;
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Worker_FIN_number, Job_key, Prob_key, Chief_problem_date, Chief_problem, Chief_problem_more, Chief_problem_remarks, Referred_by, Referred_to, Referred_date, Description "
                    + " FROM tbl_problem where Prob_key=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, problemId);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String workerFinNumber = rs.getString(1);
                int jobKey = rs.getInt(2);
                int probKey = rs.getInt(3);
                Date problemRegisteredDate = rs.getDate(4);
                String problemStr = rs.getString(5);
                String problemMore = rs.getString(6);
                String problemRemark = rs.getString(7);
                String referredBy = rs.getString(8);
                String referredTo = rs.getString(9);
                Date referredDate = rs.getDate(10);
                String refDescription = rs.getString(11);

                problem = new Problem(workerFinNumber, jobKey, probKey, problemRegisteredDate, 
                        problemStr, problemMore, problemRemark, referredBy, referredTo, referredDate, refDescription);
            }

           
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "Problem={" + problem + "}");           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return problem;
    }
    
    public static void addProblem(Worker worker, Job job, Problem problem) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "INSERT INTO tbl_problem (Worker_FIN_number, Job_key, Prob_key, Chief_problem_date, "
                    + "Chief_problem, Chief_problem_more, Chief_problem_remarks) "
                    + "VALUES (?,?,?,?,?,?, ?)";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, worker.getFinNumber());
            pstmt.setInt(2, job.getJobKey());
            pstmt.setInt(3, problem.getProbKey());
            pstmt.setDate(4, problem.getProblemRegisteredDate());
            pstmt.setString(5, problem.getProblem());
            pstmt.setString(6, problem.getProblemMore());
            pstmt.setString(7, problem.getProblemRemark());           
            pstmt.executeUpdate();
            
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "Worker={" + worker + "} Job={" + job + "} Problem={" + problem);
        } finally {
            ConnectionManager.close(conn, pstmt);
        }    
    }
      
    private static void handleSQLException(SQLException ex, String sql, String... parameters) {
      String msg = "Unable to access data; SQL=" + sql + "\n";
      for (String parameter : parameters) {
        msg += "," + parameter + ex.getMessage();
      }
      Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, msg, ex);
      throw new RuntimeException(msg, ex);
    }
        
    public static void updateProblem(Problem problem) {
        Connection conn = null;
        PreparedStatement stmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_problem SET Chief_problem_date = ?, Chief_problem = ? , Chief_problem_more = ?, Chief_problem_remarks = ? WHERE Worker_FIN_number = ? AND Job_key = ? AND Prob_key = ?";
            
            stmt = conn.prepareStatement(sql);
            
            stmt.setDate(1, problem.getProblemRegisteredDate());
            stmt.setString(2, problem.getProblem());
            stmt.setString(3, problem.getProblemMore());
            stmt.setString(4, problem.getProblemRemark());
            stmt.setString(5, problem.getWorkerFinNum());
            stmt.setInt(6, problem.getJobKey());
            stmt.setInt(7, problem.getProbKey());
            
            stmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "problem={" + problem + "}");
        } finally {
            ConnectionManager.close(conn, stmt, null);
        }        
    }
    
    public static void referCase(String workerFin, int jobKey, int probKey, Date referredDate, String referredBy, String description){
        Connection conn = null;
        PreparedStatement stmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_problem SET Referred_by = ?, Referred_date = ?, Description = ? WHERE Worker_FIN_number = ? AND Job_key = ? AND Prob_key = ?";
            
            stmt = conn.prepareStatement(sql);
            
            stmt.setString(1, referredBy);
            stmt.setDate(2, referredDate);
            stmt.setString(3, description);
            stmt.setString(4, workerFin);
            stmt.setInt(5, jobKey);
            stmt.setInt(6, probKey);
            
            stmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "case referral={" + probKey + "}");
        } finally {
            ConnectionManager.close(conn, stmt, null);
        }
    }
}
