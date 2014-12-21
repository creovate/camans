/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.dao;

import camans.entity.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Nyein Su
 */
public class CaseManagementDAO {
    
    public static ArrayList<Problem> getUnassignedCases(){
        ArrayList<Problem> problemList = new ArrayList<Problem>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT T1.Prob_key FROM tbl_problem AS T1 LEFT OUTER JOIN tbl_lead_case_worker AS T2 ON (T1.Worker_FIN_number = T2.Worker_FIN_number AND T1.Job_key = T2.Job_key AND T1.Prob_key = T2.Prob_key) WHERE T2.Lead_case_worker IS NULL";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int probKey = rs.getInt(1);
                Problem problem = ProblemDAO.retrieveProblemByProblemId(probKey);
                problemList.add(problem);
            }
            
        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }  
        
        return problemList;
    }
    
    public static void assignCase(User userlogin, Problem problem) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "INSERT INTO tbl_benefit (Bene_date, Bene_giver, Bene_type,Bene_type_more,"
                    + "Bene_serial, Bene_purpose,Bene_rem,Bene_value, "
                    + "Worker_FIN_number, Job_key, Prob_key) "
                    + "VALUES (?,?,?,?,?,?,?,?,?,?,?)";

            pstmt = conn.prepareStatement(sql);
            
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "Case: " + userlogin + "}");
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
}
