/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.dao;

import static camans.dao.WorkerDAO.retrieveWorkerbyFinNumber;
import camans.entity.*;
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
 * @author Nyein Su
 */
public class CaseManagementDAO {

    public static ArrayList<Problem> retrieveUnassignedCases() {
        ArrayList<Problem> problemList = new ArrayList<Problem>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            //sql = "SELECT T1.Prob_key FROM tbl_problem AS T1 LEFT OUTER JOIN tbl_lead_case_worker AS T2 ON (T1.Worker_FIN_number = T2.Worker_FIN_number AND T1.Job_key = T2.Job_key AND T1.Prob_key = T2.Prob_key) WHERE T2.Lead_case_worker IS NULL";

            sql = "SELECT DISTINCT t1.Prob_key FROM tbl_problem AS t1 LEFT OUTER JOIN tbl_lead_case_worker AS t2 ON (T1.Worker_FIN_number = T2.Worker_FIN_number AND T1.Job_key = T2.Job_key AND t1.Prob_key = t2.Prob_key) WHERE (t1.Entry_date > ( NOW() - INTERVAL 1 MONTH ) OR  t2.Entry_date > ( NOW() - INTERVAL 1 MONTH )) AND t1.Referred_to IS NULL AND t1.Referred_by IS NOT NULL";
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
            sql = "UPDATE tbl_problem SET Referred_to = ? WHERE Worker_FIN_number = ? AND Job_key = ? AND Prob_key = ?";

            pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, userlogin.getUsername());
            pstmt.setString(2, problem.getWorkerFinNum());
            pstmt.setInt(3, problem.getJobKey());
            pstmt.setInt(4, problem.getProbKey());

            pstmt.executeUpdate();
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "Case: " + userlogin + "}");
        } finally {
            ConnectionManager.close(conn, pstmt);
        }
    }

    public static ArrayList<Problem> retrieveRecentAssignedCases(String userloginName) {
        ArrayList<Problem> problemList = new ArrayList<Problem>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT t1.Prob_key FROM tbl_problem AS t1 JOIN tbl_lead_case_worker AS t2 ON t1.Prob_key = t2.Prob_key WHERE Lead_case_worker = ? AND Referred_to = ? and t2.Entry_date > ( NOW() - INTERVAL 1 MONTH ) ";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userloginName);
            pstmt.setString(2, userloginName);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int probKey = rs.getInt(1);
                Problem problemTemp = ProblemDAO.retrieveProblemByProblemId(probKey);
                problemList.add(problemTemp);
            }
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemList={" + problemList + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }

        return problemList;
    }

    public static void referCase(String workerFin, int jobKey, int probKey, Date referredDate, String referredBy, String description) {
        Connection conn = null;
        PreparedStatement stmt = null;
        String sql = "";

        try {
            
            Problem problem_temp = ProblemDAO.retrieveProblemByProblemId(probKey);
            ArrayList<Integer> leadCaseWorkerList = ProblemComplementsDAO.retrieveLeadCaseWorkerIdsOfProblem(problem_temp);
            User referredBy_user = UserDAO.retrieveUserByNRIC(referredBy);
            String referredBy_username = referredBy_user.getUsername();

            //add lead case end date if the current lead case worker is referring back
            //set current lead case worker as null
            for (int i = 0; i < leadCaseWorkerList.size(); i++) {
                ProblemLeadCaseWorker leadCaseWorker = ProblemComplementsDAO.retrieveProblemLeadCaseWorkerById(leadCaseWorkerList.get(i));
                int lcwId = leadCaseWorker.getId();
                String lcwName = leadCaseWorker.getLeadCaseWorker();
                if (lcwName.equals(referredBy_username)) {
                    java.sql.Date lcwStart = leadCaseWorker.getLeadStart();
                    java.util.Date endDate = new java.util.Date();
                    java.sql.Date lcwEnd = new java.sql.Date(endDate.getTime());

                    leadCaseWorker = new ProblemLeadCaseWorker(lcwId, workerFin, jobKey, probKey, lcwName, lcwStart, lcwEnd);
                    ProblemComplementsDAO.updateProblemLeadCaseWorker(leadCaseWorker);
                    
                }
            }

            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_problem SET Referred_by = ?, Referred_date = ?, Description = ?, Referred_to = null WHERE Worker_FIN_number = ? AND Job_key = ? AND Prob_key = ?";

            stmt = conn.prepareStatement(sql);

            stmt.setString(1, referredBy_username);
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

    private static void handleSQLException(SQLException ex, String sql, String... parameters) {
        String msg = "Unable to access data; SQL=" + sql + "\n";
        for (String parameter : parameters) {
            msg += "," + parameter + ex.getMessage();
        }
        Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, msg, ex);
        throw new RuntimeException(msg, ex);
    }
}
