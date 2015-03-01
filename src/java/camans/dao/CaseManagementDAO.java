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

            sql = "SELECT Prob_key FROM tbl_problem WHERE Referred_by IS NOT NULL AND Referred_to IS NULL";
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
        ResultSet rs = null;
        String sql = "";
        try {

            conn = ConnectionManager.getConnection();

            sql = "SELECT Referred_by FROM tbl_problem WHERE Prob_key = ?";

            pstmt = conn.prepareStatement(sql);

            pstmt.setInt(1, problem.getProbKey());

            rs = pstmt.executeQuery();
            boolean is_referred_case = true;
            while (rs.next()) {
                String referredBy = rs.getString(1);
                if (referredBy == null) {
                    is_referred_case = false;
                }

            }

            if (is_referred_case) {
                sql = "UPDATE tbl_problem SET Referred_to = ? WHERE Worker_FIN_number = ? AND Job_key = ? AND Prob_key = ?";

                pstmt = conn.prepareStatement(sql);

                pstmt.setString(1, userlogin.getUsername());
                pstmt.setString(2, problem.getWorkerFinNum());
                pstmt.setInt(3, problem.getJobKey());
                pstmt.setInt(4, problem.getProbKey());

                pstmt.executeUpdate();
            } else {
                //editing from problem complements

                //1. update in tbl problem
                sql = "UPDATE tbl_problem SET Referred_to = ?, Referred_date = ?, Referred_by = ?, Description = ? WHERE Worker_FIN_number = ? AND Job_key = ? AND Prob_key = ?";

                pstmt = conn.prepareStatement(sql);

                pstmt.setString(1, userlogin.getUsername());
                pstmt.setDate(2, null);
                pstmt.setString(3, null);
                pstmt.setString(4, null);
                pstmt.setString(5, problem.getWorkerFinNum());
                pstmt.setInt(6, problem.getJobKey());
                pstmt.setInt(7, problem.getProbKey());

                pstmt.executeUpdate();

                //2. update tbl_lead_case_worker
                sql = "UPDATE tbl_lead_case_worker SET Lead_end = CURDATE( ) WHERE Prob_key =? AND Lead_end IS NULL";
                pstmt = conn.prepareStatement(sql);

                pstmt.setInt(1, problem.getProbKey());
                pstmt.executeUpdate();

            }


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
            sql = "SELECT Prob_key FROM tbl_problem where Referred_to = ? and Referred_date > (NOW() - INTERVAL 1 MONTH)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userloginName);
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

    public static void terminateLeadCaseWorker(int probKey) {
        Problem problem_temp = ProblemDAO.retrieveProblemByProblemId(probKey);
        String workerFin = problem_temp.getWorkerFinNum();
        int jobKey = problem_temp.getJobKey();

        ArrayList<Integer> leadCaseWorkerList = ProblemComplementsDAO.retrieveLeadCaseWorkerIdsOfProblem(problem_temp);

        if (leadCaseWorkerList != null && leadCaseWorkerList.size() > 0) {
            int lcw_id = leadCaseWorkerList.get(leadCaseWorkerList.size() - 1);
            ProblemLeadCaseWorker leadCaseWorker = ProblemComplementsDAO.retrieveProblemLeadCaseWorkerById(lcw_id);
            java.sql.Date lcwEnd = leadCaseWorker.getLeadEnd();
            if (lcwEnd == null) {
                String lcwName = leadCaseWorker.getLeadCaseWorker();
                java.sql.Date lcwStart = leadCaseWorker.getLeadStart();
                java.util.Date endDate = new java.util.Date();
                lcwEnd = new java.sql.Date(endDate.getTime());

                leadCaseWorker = new ProblemLeadCaseWorker(lcw_id, workerFin, jobKey, probKey, lcwName, lcwStart, lcwEnd);
                ProblemComplementsDAO.updateProblemLeadCaseWorker(leadCaseWorker);
            }
        
        }
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
            terminateLeadCaseWorker(probKey);


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
