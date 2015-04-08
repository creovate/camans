/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.dao;

import au.com.bytecode.opencsv.CSVReader;
import camans.entity.*;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author soemyatmyat
 */
public class ProblemComplementsDAO {

    /*Problem Aggravating Issue*/
    /**
     * retrieve aggravating issue ids
     * @param problem problem
     * @return a list of aggravating issue ids
     */
    public static ArrayList<Integer> retrieveAggravatingIssueIdsOfProblem(Problem problem) {
        ArrayList<Integer> ids = new ArrayList<Integer>();

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID FROM tbl_aggravating_issue where Worker_FIN_number = ? AND Job_key =? "
                    + "AND Prob_key=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, problem.getWorkerFinNum());
            pstmt.setInt(2, problem.getJobKey());
            pstmt.setInt(3, problem.getProbKey());
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                ids.add(id);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }

        return ids;
    }

    /**
     * retrieve aggravating issue with id
     * @param id aggravating issue id
     * @return aggravating issue with id
     */
    public static ProblemAggravatingIssue retrieveProblemAggravatingIssueById(int id) {
        ProblemAggravatingIssue problemAggravatingIssue = null;

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Aggra_issue, Aggra_issue_more,"
                    + " Aggra_loss, Aggra_remarks,"
                    + "Worker_FIN_number, Job_key, Prob_key"
                    + " FROM tbl_aggravating_issue where ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String aggraIssue = rs.getString(1);
                String aggraIssueMore = rs.getString(2);
                double aggraLoss = rs.getDouble(3);
                String aggraRemarks = rs.getString(4);
                String workerFinNumber = rs.getString(5);
                int jobKey = rs.getInt(6);
                int probKey = rs.getInt(7);
                problemAggravatingIssue = new ProblemAggravatingIssue(id, workerFinNumber, jobKey, probKey,
                        aggraIssue, aggraIssueMore, aggraLoss, aggraRemarks);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemAggravatingIssue={" + problemAggravatingIssue + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return problemAggravatingIssue;
    }

    /**
     * add aggravating issue
     * @param problemAggravatingIssue aggravating issue of problem
     */
    public static void addProblemAggravatingIssue(ProblemAggravatingIssue problemAggravatingIssue) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "INSERT INTO tbl_aggravating_issue (Aggra_issue, Aggra_issue_more, "
                    + "Aggra_loss, Aggra_remarks, "
                    + "Worker_FIN_number, Job_key, Prob_key) "
                    + "VALUES (?,?,?,?,?,?,?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, problemAggravatingIssue.getAggravatingIssue());
            pstmt.setString(2, problemAggravatingIssue.getAggravatingIssueMore());
            pstmt.setDouble(3, problemAggravatingIssue.getAggravatingLoss());
            pstmt.setString(4, problemAggravatingIssue.getAggravatingRemark());
            pstmt.setString(5, problemAggravatingIssue.getWorkerFinNumber());
            pstmt.setInt(6, problemAggravatingIssue.getJobKey());
            pstmt.setInt(7, problemAggravatingIssue.getProblemKey());
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemAggravatingIssue: " + problemAggravatingIssue + "}");
        } finally {
            ConnectionManager.close(conn, pstmt);
        }
    }

    /**
     * update aggravating issue
     * @param problemAggravatingIssue aggravating issue of problem
     */
    public static void updateProblemAggravatingIssue(ProblemAggravatingIssue problemAggravatingIssue) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_aggravating_issue SET Aggra_issue = ? , Aggra_issue_more = ?,"
                    + "Aggra_loss =?, Aggra_remarks=? "
                    + "WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, problemAggravatingIssue.getAggravatingIssue());
            pstmt.setString(2, problemAggravatingIssue.getAggravatingIssueMore());
            pstmt.setDouble(3, problemAggravatingIssue.getAggravatingLoss());
            pstmt.setString(4, problemAggravatingIssue.getAggravatingRemark());
            pstmt.setInt(5, problemAggravatingIssue.getId());

            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemAggravatingIssue={" + problemAggravatingIssue + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }

    /**
     * delete aggravating issue with id
     * @param id aggravating issue id
     */
    public static void deleteProblemAggravatingIssue(int id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "DELETE FROM tbl_aggravating_issue WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemAggravatingIssue ID={" + id + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }
    
    /**
     * delete all aggravating issues of problem
     */
    public static void deleteAllProblemAggravatingIssues() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            
            sql = "DELETE FROM tbl_aggravating_issue";
            pstmt = conn.prepareStatement(sql);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "not able to delete data from Problem-Aggravating Issue Table. ");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }     
    }
       
    /*Problem Lead Case Worker*/
    /**
     * retrieve lead caseworker ids
     * @param problem problem
     * @return a list of lead caseworker ids
     */
    public static ArrayList<Integer> retrieveLeadCaseWorkerIdsOfProblem(Problem problem) {
        ArrayList<Integer> ids = new ArrayList<Integer>();

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID FROM tbl_lead_case_worker where Worker_FIN_number = ? AND Job_key =? "
                    + "AND Prob_key=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, problem.getWorkerFinNum());
            pstmt.setInt(2, problem.getJobKey());
            pstmt.setInt(3, problem.getProbKey());
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                ids.add(id);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }

        return ids;
    }

    /**
     * retrieve lead caseworker with id
     * @param id lead caseworker id
     * @return lead caseworker with id
     */
    public static ProblemLeadCaseWorker retrieveProblemLeadCaseWorkerById(int id) {
        ProblemLeadCaseWorker problemLeadCaseWorker = null;

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Lead_case_worker, Lead_start,"
                    + " Lead_end,"
                    + "Worker_FIN_number, Job_key, Prob_key"
                    + " FROM tbl_lead_case_worker where ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String leadCaseWorker = rs.getString(1);
                Date leadStart = rs.getDate(2);
                Date leadEnd = rs.getDate(3);
                String workerFinNumber = rs.getString(4);
                int jobKey = rs.getInt(5);
                int probKey = rs.getInt(6);
                problemLeadCaseWorker = new ProblemLeadCaseWorker(id, workerFinNumber, jobKey, probKey,
                        leadCaseWorker, leadStart, leadEnd);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemLeadCaseWorker={" + problemLeadCaseWorker + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return problemLeadCaseWorker;
    }

    /**
     * add lead caseworker
     * @param problemLeadCaseWorker lead caseworker of problem
     */
    public static void addProblemLeadCaseWorker(ProblemLeadCaseWorker problemLeadCaseWorker) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "INSERT INTO tbl_lead_case_worker (Lead_case_worker, Lead_start, "
                    + "Lead_end, "
                    + "Worker_FIN_number, Job_key, Prob_key) "
                    + "VALUES (?,?,?,?,?,?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, problemLeadCaseWorker.getLeadCaseWorker());
            pstmt.setDate(2, problemLeadCaseWorker.getLeadStart());
            pstmt.setDate(3, problemLeadCaseWorker.getLeadEnd());
            pstmt.setString(4, problemLeadCaseWorker.getWorkerFinNumber());
            pstmt.setInt(5, problemLeadCaseWorker.getJobKey());
            pstmt.setInt(6, problemLeadCaseWorker.getProblemKey());
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemLeadCaseWorker: " + problemLeadCaseWorker + "}");
        } finally {
            ConnectionManager.close(conn, pstmt);
        }
    }

    /**
     * update lead caseworker
     * @param problemLeadCaseWorker lead caseworker of problem
     */
    public static void updateProblemLeadCaseWorker(ProblemLeadCaseWorker problemLeadCaseWorker) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_lead_case_worker SET Lead_case_worker = ? , Lead_start = ?,"
                    + "Lead_end =? "
                    + "WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, problemLeadCaseWorker.getLeadCaseWorker());
            pstmt.setDate(2, problemLeadCaseWorker.getLeadStart());
            pstmt.setDate(3, problemLeadCaseWorker.getLeadEnd());
            pstmt.setInt(4, problemLeadCaseWorker.getId());

            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemLeadCaseWorker={" + problemLeadCaseWorker + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }

    /**
     * delete lead caseworker with id
     * @param id lead caseworker id
     */
    public static void deleteProblemLeadCaseWorker(int id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "DELETE FROM tbl_lead_case_worker WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "Problem Lead Case Worker ID={" + id + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }
    
    /**
     * delete all lead caseworkers of problem
     */
    public static void deleteAllProblemLeadCaseWorkers() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            
            sql = "DELETE FROM tbl_lead_case_worker";
            pstmt = conn.prepareStatement(sql);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "not able to delete data from Problem-tbl_lead_case_worker Table. ");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }     
    }
    
    /*Problem Auxiliary CaseWorker*/
    /**
     * retrieve auxiliary caseworker ids
     * @param problem problem
     * @return a list of auxiliary caseworker ids
     */
    public static ArrayList<Integer> retrieveProblemAuxiliaryCaseWorkerIdsOfProblem(Problem problem) {
        ArrayList<Integer> ids = new ArrayList<Integer>();

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID FROM tbl_auxillarycaseworker where Worker_FIN_number = ? AND Job_key =? "
                    + "AND Prob_key=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, problem.getWorkerFinNum());
            pstmt.setInt(2, problem.getJobKey());
            pstmt.setInt(3, problem.getProbKey());
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                ids.add(id);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }

        return ids;
    }

    /**
     * retrieve auxiliary caseworker with id
     * @param id auxiliary caseworker id
     * @return auxiliary caseworker with id
     */
    public static ProblemAuxiliaryCaseWorker retrieveProblemAuxiliaryCaseWorkerById(int id) {
        ProblemAuxiliaryCaseWorker problemAuxiliaryCaseWorker = null;

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Aux_name, Aux_start,"
                    + " Aux_end,"
                    + "Worker_FIN_number, Job_key, Prob_key"
                    + " FROM tbl_auxillarycaseworker where ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String auxName = rs.getString(1);
                Date auxStart = rs.getDate(2);
                Date auxEnd = rs.getDate(3);
                String workerFinNumber = rs.getString(4);
                int jobKey = rs.getInt(5);
                int probKey = rs.getInt(6);
                problemAuxiliaryCaseWorker = new ProblemAuxiliaryCaseWorker(id, workerFinNumber,
                        jobKey, probKey,
                        auxName, auxStart, auxEnd);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemAuxiliaryCaseWorker={" + problemAuxiliaryCaseWorker + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return problemAuxiliaryCaseWorker;
    }

    /**
     * add auxiliary caseworker
     * @param problemAuxiliaryCaseWorker auxiliary caseworker of problem
     */
    public static void addProblemAuxiliaryCaseWorker(ProblemAuxiliaryCaseWorker problemAuxiliaryCaseWorker) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "INSERT INTO tbl_auxillarycaseworker (Aux_name, Aux_start, "
                    + "Aux_end, "
                    + "Worker_FIN_number, Job_key, Prob_key) "
                    + "VALUES (?,?,?,?,?,?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, problemAuxiliaryCaseWorker.getAuxName());
            pstmt.setDate(2, problemAuxiliaryCaseWorker.getAuxStart());
            pstmt.setDate(3, problemAuxiliaryCaseWorker.getAuxEnd());
            pstmt.setString(4, problemAuxiliaryCaseWorker.getWorkerFinNumber());
            pstmt.setInt(5, problemAuxiliaryCaseWorker.getJobKey());
            pstmt.setInt(6, problemAuxiliaryCaseWorker.getProblemKey());
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemAuxiliaryCaseWorker: " + problemAuxiliaryCaseWorker + "}");
        } finally {
            ConnectionManager.close(conn, pstmt);
        }
    }

    /**
     * update auxiliary caseworker
     * @param problemAuxiliaryCaseWorker auxiliary caseworker of problem
     */
    public static void updateProblemAuxiliaryCaseWorker(ProblemAuxiliaryCaseWorker problemAuxiliaryCaseWorker) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_auxillarycaseworker SET Aux_name = ? , Aux_start = ?,"
                    + "Aux_end =? "
                    + "WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, problemAuxiliaryCaseWorker.getAuxName());
            pstmt.setDate(2, problemAuxiliaryCaseWorker.getAuxStart());
            pstmt.setDate(3, problemAuxiliaryCaseWorker.getAuxEnd());
            pstmt.setInt(4, problemAuxiliaryCaseWorker.getId());

            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemAuxiliaryCaseWorker={" + problemAuxiliaryCaseWorker + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }

    /**
     * delete auxiliary caseworker with id
     * @param id auxiliary caseworker id
     */
    public static void deleteProblemAuxiliaryCaseWorker(int id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "DELETE FROM tbl_auxillarycaseworker WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "Problem Auxiliary Case Worker ID={" + id + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }
    
    /**
     * delete all auxiliary caseworkers of problem
     */
    public static void deleteAllProblemAuxiliaryCaseWorkers() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            
            sql = "DELETE FROM tbl_auxillarycaseworker";
            pstmt = conn.prepareStatement(sql);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "not able to delete data from tbl_auxillarycaseworker Table. ");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }     
    }
    
    /*Problem Salary Related History*/
    /**
     * retrieve salary related history ids
     * @param problem problem
     * @return a list of salary related history ids
     */
    public static ArrayList<Integer> retrieveProblemSalaryRelatedHistoryIdsOfProblem(Problem problem) {
        ArrayList<Integer> ids = new ArrayList<Integer>();

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID FROM tbl_salary_history where Worker_FIN_number = ? AND Job_key =? "
                    + "AND Prob_key=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, problem.getWorkerFinNum());
            pstmt.setInt(2, problem.getJobKey());
            pstmt.setInt(3, problem.getProbKey());
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                ids.add(id);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }

        return ids;
    }

    /**
     * retrieve salary related history with id
     * @param id salary related history id
     * @return salary related history with id
     */
    public static ProblemSalaryRelatedHistory retrieveProblemSalaryRelatedHistoryById(int id) {
        ProblemSalaryRelatedHistory problemSalaryRelatedHistory = null;

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Sal_hist_basic, Sal_hist_ot,"
                    + " Sal_hist_allowances,Sal_hist_deductions,Sal_hist_kickbacks,"
                    + "Sal_hist_other,Sal_mode,Sal_mode_more, Sal_loss_total,"
                    + "Sal_loss_1_year,Sal_his_remarks,"
                    + "Worker_FIN_number, Job_key, Prob_key"
                    + " FROM tbl_salary_history where ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String salHistBasic = rs.getString(1);
                String salHistOt = rs.getString(2);
                String salHistAllowances = rs.getString(3);
                String salHistDeductions = rs.getString(4);
                String salHistKickbacks = rs.getString(5);
                String salHistOther = rs.getString(6);
                String salMode = rs.getString(7);
                String salModeMore = rs.getString(8);
                double salLossTotal = rs.getDouble(9);
                double salLoss1Year = rs.getDouble(10);
                String salHisRemarks = rs.getString(11);
                String workerFinNumber = rs.getString(12);
                int jobKey = rs.getInt(13);
                int probKey = rs.getInt(14);

                problemSalaryRelatedHistory = new ProblemSalaryRelatedHistory(id, workerFinNumber, jobKey, probKey,
                        salHistBasic, salHistOt, salHistAllowances, salHistDeductions, salHistKickbacks, salHistOther, salMode,
                        salModeMore, salLossTotal, salLoss1Year, salHisRemarks);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemSalaryRelatedHistory={" + problemSalaryRelatedHistory + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return problemSalaryRelatedHistory;
    }

    /**
     * add salary related history
     * @param problemSalaryRelatedHistory salary related history of problem
     */
    public static void addProblemSalaryRelatedHistory(ProblemSalaryRelatedHistory problemSalaryRelatedHistory) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "INSERT INTO tbl_salary_history (Sal_hist_basic, Sal_hist_ot, "
                    + "Sal_hist_allowances,Sal_hist_deductions,Sal_hist_kickbacks,"
                    + "Sal_hist_other,Sal_mode, Sal_mode_more,Sal_loss_total,"
                    + "Sal_loss_1_year,Sal_his_remarks,"
                    + "Worker_FIN_number, Job_key, Prob_key) "
                    + "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, problemSalaryRelatedHistory.getSalHistBasic());
            pstmt.setString(2, problemSalaryRelatedHistory.getSalHistOt());
            pstmt.setString(3, problemSalaryRelatedHistory.getSalHistAllowances());
            pstmt.setString(4, problemSalaryRelatedHistory.getSalHistDeductions());
            pstmt.setString(5, problemSalaryRelatedHistory.getSalHistKickbacks());
            pstmt.setString(6, problemSalaryRelatedHistory.getSalHistOther());
            pstmt.setString(7, problemSalaryRelatedHistory.getSalMode());
            pstmt.setString(8, problemSalaryRelatedHistory.getSalModeMore());
            pstmt.setDouble(9, problemSalaryRelatedHistory.getSalLossTotal());
            pstmt.setDouble(10, problemSalaryRelatedHistory.getSalLoss1Year());
            pstmt.setString(11, problemSalaryRelatedHistory.getSalHisRemarks());
            pstmt.setString(12, problemSalaryRelatedHistory.getWorkerFinNumber());
            pstmt.setInt(13, problemSalaryRelatedHistory.getJobKey());
            pstmt.setInt(14, problemSalaryRelatedHistory.getProblemKey());
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemSalaryRelatedHistory: " + problemSalaryRelatedHistory + "}");
        } finally {
            ConnectionManager.close(conn, pstmt);
        }
    }

    /**
     * update salary related history
     * @param problemSalaryRelatedHistory salary related history of problem
     */
    public static void updateProblemSalaryRelatedHistory(ProblemSalaryRelatedHistory problemSalaryRelatedHistory) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_salary_history SET Sal_hist_basic = ? , Sal_hist_ot = ?,"
                    + "Sal_hist_allowances =?,Sal_hist_deductions = ?, Sal_hist_kickbacks =?,"
                    + "Sal_hist_other=?, Sal_mode=?,Sal_mode_more=?,Sal_loss_total=?,"
                    + "Sal_loss_1_year=?,Sal_his_remarks=? "
                    + "WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, problemSalaryRelatedHistory.getSalHistBasic());
            pstmt.setString(2, problemSalaryRelatedHistory.getSalHistOt());
            pstmt.setString(3, problemSalaryRelatedHistory.getSalHistAllowances());
            pstmt.setString(4, problemSalaryRelatedHistory.getSalHistDeductions());
            pstmt.setString(5, problemSalaryRelatedHistory.getSalHistKickbacks());
            pstmt.setString(6, problemSalaryRelatedHistory.getSalHistOther());
            pstmt.setString(7, problemSalaryRelatedHistory.getSalMode());
            pstmt.setString(8, problemSalaryRelatedHistory.getSalModeMore());
            pstmt.setDouble(9, problemSalaryRelatedHistory.getSalLossTotal());
            pstmt.setDouble(10, problemSalaryRelatedHistory.getSalLoss1Year());
            pstmt.setString(11, problemSalaryRelatedHistory.getSalHisRemarks());
            pstmt.setInt(12, problemSalaryRelatedHistory.getId());

            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemSalaryRelatedHistory={" + problemSalaryRelatedHistory + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }

    /**
     * delete salary related history with id
     * @param id salary related history id
     */
    public static void deleteProblemSalaryRelatedHistory(int id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "DELETE FROM tbl_salary_history WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "Problem Salary Related History ID={" + id + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }
    
    /**
     * delete all salary related histories of problem
     */
    public static void deleteAllProblemSalaryRelatedHistories() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            
            sql = "DELETE FROM tbl_salary_history";
            pstmt = conn.prepareStatement(sql);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "not able to delete data from Problem-tbl_salary_history Table. ");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }     
    }

    /*Problem Injury*/
    /**
     * retrieve injury ids
     * @param problem problem
     * @return a list of injury ids
     */
    public static ArrayList<Integer> retrieveProblemInjuryIdsOfProblem(Problem problem) {
        ArrayList<Integer> ids = new ArrayList<Integer>();

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID FROM tbl_injury where Worker_FIN_number = ? AND Job_key =? "
                    + "AND Prob_key=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, problem.getWorkerFinNum());
            pstmt.setInt(2, problem.getJobKey());
            pstmt.setInt(3, problem.getProbKey());
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                ids.add(id);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }

        return ids;
    }

     /**
     * retrieve injury with id
     * @param id injury id
     * @return injury with id
     */
    public static ProblemInjury retrieveProblemInjuryById(int id) {
        ProblemInjury problemInjury = null;

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Injury_date, Injury_time,"
                    + " Injury_location, Injury_death,"
                    + "Injury_body_part,Injury_how,"
                    + "Injury_ambulance,Injury_initial_treatment,"
                    + "Injury_initial_treatment_more,Injury_work_related,Injury_remarks,"
                    + "Worker_FIN_number, Job_key, Prob_key"
                    + " FROM tbl_injury where ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Date injuryDate = rs.getDate(1);
                String injuryTime = rs.getString(2);
                String injuryLocation = rs.getString(3);
                String injuryDeath = rs.getString(4);
                String injuryBodyPart = rs.getString(5);
                String injuryHow = rs.getString(6);
                String injuryAmbulance = rs.getString(7);
                String injuryInitialTreatment = rs.getString(8);
                String injuryInitialTreatmentMore = rs.getString(9);
                String injuryWorkRelated = rs.getString(10);
                String injuryRemarks = rs.getString(11);
                String workerFinNumber = rs.getString(12);
                int jobKey = rs.getInt(13);
                int probKey = rs.getInt(14);
                problemInjury = new ProblemInjury(id, workerFinNumber, jobKey, probKey,
                        injuryDate, injuryTime, injuryLocation, injuryDeath, injuryBodyPart,
                        injuryHow, injuryAmbulance, injuryInitialTreatment, injuryInitialTreatmentMore,
                        injuryWorkRelated, injuryRemarks);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemInjury={" + problemInjury + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return problemInjury;
    }

    /**
     * add injury
     * @param problemInjury injury of problem
     */
    public static void addProblemInjury(ProblemInjury problemInjury) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "INSERT INTO tbl_injury (Injury_date, Injury_time,"
                    + " Injury_location, Injury_death,"
                    + "Injury_body_part,Injury_how,"
                    + "Injury_ambulance,Injury_initial_treatment,"
                    + "Injury_initial_treatment_more,Injury_work_related,Injury_remarks,"
                    + "Worker_FIN_number, Job_key, Prob_key) "
                    + "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setDate(1, problemInjury.getInjuryDate());
            pstmt.setString(2, problemInjury.getInjuryTime());
            pstmt.setString(3, problemInjury.getInjuryLocation());
            pstmt.setString(4, problemInjury.getInjuryDeath());
            pstmt.setString(5, problemInjury.getInjuryBodyPart());
            pstmt.setString(6, problemInjury.getInjuryHow());
            pstmt.setString(7, problemInjury.getInjuryAmbulance());
            pstmt.setString(8, problemInjury.getInitialTreatment());
            pstmt.setString(9, problemInjury.getInitialTreatmentMore());
            pstmt.setString(10, problemInjury.getInjuryWorkRelated());
            pstmt.setString(11, problemInjury.getInjuryRemarks());
            pstmt.setString(12, problemInjury.getWorkerFinNumber());
            pstmt.setInt(13, problemInjury.getJobKey());
            pstmt.setInt(14, problemInjury.getProblemKey());
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemInjury: " + problemInjury + "}");
        } finally {
            ConnectionManager.close(conn, pstmt);
        }
    }

    /**
     * update injury
     * @param problemInjury injury of problem
     */
    public static void updateProblemInjury(ProblemInjury problemInjury) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_injury SET Injury_date=?, Injury_time=?,"
                    + " Injury_location=?, Injury_death=?,"
                    + "Injury_body_part=?,Injury_how=?,"
                    + "Injury_ambulance=?,Injury_initial_treatment=?,"
                    + "Injury_initial_treatment_more=?,Injury_work_related=?,Injury_remarks=? "
                    + "WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setDate(1, problemInjury.getInjuryDate());
            pstmt.setString(2, problemInjury.getInjuryTime());
            pstmt.setString(3, problemInjury.getInjuryLocation());
            pstmt.setString(4, problemInjury.getInjuryDeath());
            pstmt.setString(5, problemInjury.getInjuryBodyPart());
            pstmt.setString(6, problemInjury.getInjuryHow());
            pstmt.setString(7, problemInjury.getInjuryAmbulance());
            pstmt.setString(8, problemInjury.getInitialTreatment());
            pstmt.setString(9, problemInjury.getInitialTreatmentMore());
            pstmt.setString(10, problemInjury.getInjuryWorkRelated());
            pstmt.setString(11, problemInjury.getInjuryRemarks());
            pstmt.setInt(12, problemInjury.getId());

            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemInjury={" + problemInjury + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }

    /**
     * delete all injuries of problem
     */
    public static void deleteAllProblemInjuries() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            
            sql = "DELETE FROM tbl_injury";
            pstmt = conn.prepareStatement(sql);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "not able to delete data from Problem-tbl_injury. ");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }     
    }

    /**
     * delete injury with id
     * @param id injury id
     */
    public static void deleteProblemInjury(int id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "DELETE FROM tbl_injury WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "Problem Injury ID={" + id + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }
    
    /*Problem Illness*/
    /**
     * retrieve illness ids
     * @param problem problem
     * @return a list of illness ids
     */
    public static ArrayList<Integer> retrieveIllnessIdsOfProblem(Problem problem) {
        ArrayList<Integer> ids = new ArrayList<Integer>();

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID FROM tbl_illness where Worker_FIN_number = ? AND Job_key =? "
                    + "AND Prob_key=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, problem.getWorkerFinNum());
            pstmt.setInt(2, problem.getJobKey());
            pstmt.setInt(3, problem.getProbKey());
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                ids.add(id);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }

        return ids;
    }

     /**
     * retrieve illness with id
     * @param id illness id
     * @return illness with id
     */
    public static ProblemIllness retrieveProblemIllnesseById(int id) {
        ProblemIllness problemIllness = null;

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Illness_start_when, Illness_diag_when,"
                    + " Illness_diag_who, Illness_nature,"
                    + "Illness_work_related,Illness_why,Illness_rem,"
                    + "Worker_FIN_number, Job_key, Prob_key"
                    + " FROM tbl_illness where ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String illnessStart = rs.getString(1);
                String illnessDiagWhen = rs.getString(2);
                String illnessDaigWho = rs.getString(3);
                String illnessNature = rs.getString(4);
                String illnessWorkRelated = rs.getString(5);
                String illnessWhy = rs.getString(6);
                String illnessRemark = rs.getString(7);
                String workerFinNumber = rs.getString(8);
                int jobKey = rs.getInt(9);
                int probKey = rs.getInt(10);
                problemIllness = new ProblemIllness(id, workerFinNumber, jobKey, probKey,
                        illnessStart, illnessDiagWhen, illnessDaigWho, illnessNature,
                        illnessWorkRelated, illnessWhy, illnessRemark);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql, "problemIllness={" + problemIllness + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return problemIllness;
    }

    /**
     * add illness
     * @param problemIllness illness of problem
     */
    public static void addProblemIllness(ProblemIllness problemIllness) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "INSERT INTO tbl_illness (Illness_start_when, Illness_diag_when,"
                    + " Illness_diag_who, Illness_nature,"
                    + "Illness_work_related,Illness_why,Illness_rem,"
                    + "Worker_FIN_number, Job_key, Prob_key) "
                    + "VALUES (?,?,?,?,?,?,?,?,?,?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, problemIllness.getIllnessStart());
            pstmt.setString(2, problemIllness.getIllnessDiagWhen());
            pstmt.setString(3, problemIllness.getIllnessDiagWho());
            pstmt.setString(4, problemIllness.getIllnessNature());
            pstmt.setString(5, problemIllness.getIllnessWorkRelated());
            pstmt.setString(6, problemIllness.getIllnessWhy());
            pstmt.setString(7, problemIllness.getIllnessRemark());
            pstmt.setString(8, problemIllness.getWorkerFinNumber());
            pstmt.setInt(9, problemIllness.getJobKey());
            pstmt.setInt(10, problemIllness.getProblemKey());
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemIllness: " + problemIllness + "}");
        } finally {
            ConnectionManager.close(conn, pstmt);
        }
    }

    /**
     * update illness
     * @param problemIllness illness of problem
     */
    public static void updateProblemIllness(ProblemIllness problemIllness) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_illness SET Illness_start_when=?, Illness_diag_when=?,"
                    + " Illness_diag_who=?, Illness_nature=?,"
                    + "Illness_work_related=?,Illness_why=?,Illness_rem=? "
                    + "WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, problemIllness.getIllnessStart());
            pstmt.setString(2, problemIllness.getIllnessDiagWhen());
            pstmt.setString(3, problemIllness.getIllnessDiagWho());
            pstmt.setString(4, problemIllness.getIllnessNature());
            pstmt.setString(5, problemIllness.getIllnessWorkRelated());
            pstmt.setString(6, problemIllness.getIllnessWhy());
            pstmt.setString(7, problemIllness.getIllnessRemark());
            pstmt.setInt(8, problemIllness.getId());

            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemIllness={" + problemIllness + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }

    /**
     * delete illness with id
     * @param id illness id
     */
    public static void deleteProblemIllness(int id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "DELETE FROM tbl_illness WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "Problem Illness ID={" + id + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }
    
    /**
     * delete all illnesses of problem
     */
    public static void deleteAllProblemIllness() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            
            sql = "DELETE FROM tbl_illness";
            pstmt = conn.prepareStatement(sql);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "not able to delete data from Problem-tbl_illness Table. ");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }     
    }
    
    /*Problem Other Problem*/
    /**
     * retrieve other problem ids
     * @param problem problem
     * @return a list of other problem ids
     */
    public static ArrayList<Integer> retrieveOtherProblemIdsOfProblem(Problem problem) {
        ArrayList<Integer> ids = new ArrayList<Integer>();

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID FROM tbl_other_problems where Worker_FIN_number = ? AND Job_key =? "
                    + "AND Prob_key=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, problem.getWorkerFinNum());
            pstmt.setInt(2, problem.getJobKey());
            pstmt.setInt(3, problem.getProbKey());
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                ids.add(id);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }

        return ids;
    }

    /**
     * retrieve other problem with id
     * @param id other problem id
     * @return other problem with id
     */
    public static ProblemOtherProblems retrieveProblemOtherProblemsById(int id) {
        ProblemOtherProblems problemOtherProblems = null;

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Oth_problem_desc, Oth_problem_loss,"
                    + " Oth_problem_rem,"
                    + "Worker_FIN_number, Job_key, Prob_key"
                    + " FROM tbl_other_problems where ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String otherProblemDesc = rs.getString(1);
                Double otherProblemLoss = rs.getDouble(2);
                String otherProblemRemark = rs.getString(3);
                String workerFinNumber = rs.getString(4);
                int jobKey = rs.getInt(5);
                int probKey = rs.getInt(6);
                problemOtherProblems = new ProblemOtherProblems(id, workerFinNumber, jobKey, probKey,
                        otherProblemDesc, otherProblemLoss, otherProblemRemark);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemOtherProblems={" + problemOtherProblems + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return problemOtherProblems;
    }

    /**
     * add other problem
     * @param problemOtherProblems other problem of problem
     */
    public static void addProblemOtherProblems(ProblemOtherProblems problemOtherProblems) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "INSERT INTO tbl_other_problems (Oth_problem_desc, Oth_problem_loss, "
                    + "Oth_problem_rem,"
                    + "Worker_FIN_number, Job_key, Prob_key) "
                    + "VALUES (?,?,?,?,?,?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, problemOtherProblems.getOtherProblemDesc());
            pstmt.setDouble(2, problemOtherProblems.getOtherProblemLoss());
            pstmt.setString(3, problemOtherProblems.getOtherProblemRemark());
            pstmt.setString(4, problemOtherProblems.getWorkerFinNumber());
            pstmt.setInt(5, problemOtherProblems.getJobKey());
            pstmt.setInt(6, problemOtherProblems.getProblemKey());
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "problemOtherProblems: " + problemOtherProblems + "}");
        } finally {
            ConnectionManager.close(conn, pstmt);
        }
    }

    /**
     * update other problem
     * @param problemOtherProblems other problem of problem
     */
    public static void updateProblemOtherProblems(ProblemOtherProblems problemOtherProblems) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_other_problems SET Oth_problem_desc = ? , Oth_problem_loss = ?,"
                    + "Oth_problem_rem =? "
                    + "WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, problemOtherProblems.getOtherProblemDesc());
            pstmt.setDouble(2, problemOtherProblems.getOtherProblemLoss());
            pstmt.setString(3, problemOtherProblems.getOtherProblemRemark());
            pstmt.setInt(4, problemOtherProblems.getId());

            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "problemOtherProblems={" + problemOtherProblems + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }

    /**
     * delete other problem with id
     * @param id other problem id
     */
    public static void deleteProblemOtherProblem(int id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "DELETE FROM tbl_other_problems WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "Problem Other Problem ID={" + id + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }
    
    /**
     * delete all other problems of problem
     */
    public static void deleteAllProblemtherProblems() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            
            sql = "DELETE FROM tbl_other_problems";
            pstmt = conn.prepareStatement(sql);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "not able to delete data from Problem-Other problems Table. ");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }     
    }
    
    /*Problem salary claim Issue*/
    /**
     * retrieve salary claim ids
     * @param problem problem
     * @return a list of salary claim ids
     */
    public static ArrayList<Integer> retrieveSalaryClaimIdsOfProblem(Problem problem) {
        ArrayList<Integer> ids = new ArrayList<Integer>();

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID FROM tbl_salary_claim_lodged where Worker_FIN_number = ? AND Job_key =? "
                    + "AND Prob_key=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, problem.getWorkerFinNum());
            pstmt.setInt(2, problem.getJobKey());
            pstmt.setInt(3, problem.getProbKey());
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                ids.add(id);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }

        return ids;
    }

    /**
     * retrieve salary claim with id
     * @param id salary claim id
     * @return salary claim with id
     */
    public static ProblemSalaryClaim retrieveProblemSalaryClaimById(int id) {
        ProblemSalaryClaim problemSalaryClaim = null;

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Sal_claim_date, Sal_claim_loss,"
                    + " Sal_claim_basis,"
                    + "Worker_FIN_number, Job_key, Prob_key"
                    + " FROM tbl_salary_claim_lodged where ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Date salClaimDate = rs.getDate(1);
                double salCliamLoss = rs.getDouble(2);
                String salClaimBasis = rs.getString(3);
                String workerFinNumber = rs.getString(4);
                int jobKey = rs.getInt(5);
                int probKey = rs.getInt(6);
                problemSalaryClaim = new ProblemSalaryClaim(id, workerFinNumber, jobKey, probKey,
                        salClaimDate, salCliamLoss, salClaimBasis);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemSalaryClaim={" + problemSalaryClaim + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return problemSalaryClaim;
    }

     /**
     * add salary claim
     * @param problemSalaryClaim salary claim of problem
     */
    public static void addProblemSalaryClaim(ProblemSalaryClaim problemSalaryClaim) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "INSERT INTO tbl_salary_claim_lodged (Sal_claim_date, Sal_claim_loss, "
                    + "Sal_claim_basis, "
                    + "Worker_FIN_number, Job_key, Prob_key) "
                    + "VALUES (?,?,?,?,?,?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setDate(1, problemSalaryClaim.getSalaryClaimDate());
            pstmt.setDouble(2, problemSalaryClaim.getSalaryClaimLoss());
            pstmt.setString(3, problemSalaryClaim.getSalaryClaimBasis());
            pstmt.setString(4, problemSalaryClaim.getWorkerFinNumber());
            pstmt.setInt(5, problemSalaryClaim.getJobKey());
            pstmt.setInt(6, problemSalaryClaim.getProblemKey());
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemSalaryClaim: " + problemSalaryClaim + "}");
        } finally {
            ConnectionManager.close(conn, pstmt);
        }
    }

    /**
     * update salary claim
     * @param problemSalaryClaim salary claim of problem
     */
    public static void updateProblemSalaryClaim(ProblemSalaryClaim problemSalaryClaim) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_salary_claim_lodged SET Sal_claim_date = ? , Sal_claim_loss = ?,"
                    + "Sal_claim_basis = ?"
                    + "WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setDate(1, problemSalaryClaim.getSalaryClaimDate());
            pstmt.setDouble(2, problemSalaryClaim.getSalaryClaimLoss());
            pstmt.setString(3, problemSalaryClaim.getSalaryClaimBasis());
            pstmt.setInt(4, problemSalaryClaim.getId());

            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemSalaryClaim={" + problemSalaryClaim + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }

    /**
     * delete salary claim with id
     * @param id salary claim id
     */
    public static void deleteProblemSalaryClaim(int id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "DELETE FROM tbl_salary_claim_lodged WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "Problem Salary Claim ID={" + id + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }
    
    /**
     * delete all salary claims of problem
     */
    public static void deleteAllProblemSalaryClaims() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            
            sql = "DELETE FROM tbl_salary_claim_lodged";
            pstmt = conn.prepareStatement(sql);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "not able to delete data from "
                    + "Problem-tbl_salary_claim_lodged Table. ");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }     
    }
    
        /*Problem wica */
    /**
     * retrieve wica ids
     * @param problem problem
     * @return a list of wica ids
     */
    public static ArrayList<Integer> retrieveWicaIdsOfProblem(Problem problem) {
        ArrayList<Integer> ids = new ArrayList<Integer>();

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID FROM tbl_wica where Worker_FIN_number = ? AND Job_key =? "
                    + "AND Prob_key=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, problem.getWorkerFinNum());
            pstmt.setInt(2, problem.getJobKey());
            pstmt.setInt(3, problem.getProbKey());
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                ids.add(id);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }

        return ids;
    }

     /**
     * retrieve wica with id
     * @param id wica id
     * @return
     */
    public static ProblemWica retrieveProblemWicaById(int id) {
        ProblemWica problemWica = null;

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Wicamon_update, Wicamon_status, Wicamon_status_more, Wicamon_points, "
                    + " Wicamon_dollars, Wicamon_remarks,"
                    + "Worker_FIN_number, Job_key, Prob_key"
                    + " FROM tbl_wica where ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Date wicaMonthlyUpdate = rs.getDate(1);
                String wicaMonthlyStatus = rs.getString(2);
                String wicaMonthlyStatusMore = rs.getString(3);
                double wicaMonthlyPoints = rs.getDouble(4);
                double wicaMonthlyDollars = rs.getDouble(5);
                String wicaMonthlyRemarks = rs.getString(6);
                String workerFinNumber = rs.getString(7);
                int jobKey = rs.getInt(8);
                int probKey = rs.getInt(9);
                problemWica = new ProblemWica(id, workerFinNumber, jobKey, probKey,
                        wicaMonthlyUpdate, wicaMonthlyStatus, wicaMonthlyStatusMore, wicaMonthlyPoints,
                        wicaMonthlyDollars, wicaMonthlyRemarks);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemWica={" + problemWica + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return problemWica;
    }

     /**
     * add wica
     * @param problemWica wica of problem
     */
    public static void addProblemWica(ProblemWica problemWica) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "INSERT INTO tbl_wica (Wicamon_update, Wicamon_status, Wicamon_status_more, "
                    + "Wicamon_points,  "
                    + "Wicamon_dollars, Wicamon_remarks, "
                    + "Worker_FIN_number, Job_key, Prob_key) "
                    + "VALUES (?,?,?,?,?,?,?,?,?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setDate(1, problemWica.getWicaMonthlyUpdate());
            pstmt.setString(2, problemWica.getWicaMonthlyStatus());
            pstmt.setString(3, problemWica.getWicaMonthlyStatusMore());
            pstmt.setDouble(4, problemWica.getWicaMonthlyPoints());
            pstmt.setDouble(5, problemWica.getWicaMonthlyDollars());
            pstmt.setString(6, problemWica.getWicaMonthlyRemarks());
            pstmt.setString(7, problemWica.getWorkerFinNumber());
            pstmt.setInt(8, problemWica.getJobKey());
            pstmt.setInt(9, problemWica.getProblemKey());
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemWica: " + problemWica + "}");
        } finally {
            ConnectionManager.close(conn, pstmt);
        }
    }

    /**
     * update wica
     * @param problemWica wica of problem
     */
    public static void updateProblemWica(ProblemWica problemWica) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_wica SET Wicamon_update=?, Wicamon_status=?, Wicamon_status_more=?, "
                    + "Wicamon_points=?, Wicamon_dollars=?, Wicamon_remarks=? "
                    + "WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setDate(1, problemWica.getWicaMonthlyUpdate());
            pstmt.setString(2, problemWica.getWicaMonthlyStatus());
            pstmt.setString(3, problemWica.getWicaMonthlyStatusMore());
            pstmt.setDouble(4, problemWica.getWicaMonthlyPoints());
            pstmt.setDouble(5, problemWica.getWicaMonthlyDollars());
            pstmt.setString(6, problemWica.getWicaMonthlyRemarks());
            pstmt.setInt(7,problemWica.getId());
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemWica={" + problemWica + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }

    /**
     * delete wica with id
     * @param id wica id
     */
    public static void deleteProblemWica(int id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "DELETE FROM tbl_wica WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "Problem Wica ID={" + id + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }
    
    /**
     * delete all wicas of problem
     */
    public static void deleteAllProblemWicas() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            
            sql = "DELETE FROM tbl_wica";
            pstmt = conn.prepareStatement(sql);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "not able to delete data from Problem-tbl_wica Table. ");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }     
    }
    
    /*Problem wica claim Issue*/
    /**
     * retrieve wica claim ids
     * @param problem problem
     * @return a list of wica claim ids
     */
    public static ArrayList<Integer> retrieveWicaClaimIdsOfProblem(Problem problem) {
        ArrayList<Integer> ids = new ArrayList<Integer>();

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID FROM tbl_wica_claim where Worker_FIN_number = ? AND Job_key =? "
                    + "AND Prob_key=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, problem.getWorkerFinNum());
            pstmt.setInt(2, problem.getJobKey());
            pstmt.setInt(3, problem.getProbKey());
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                ids.add(id);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }

        return ids;
    }

    /**
     * retrieve wica claim with id
     * @param id wica claim id
     * @return wica claim with id
     */
    public static ProblemWicaClaim retrieveProblemWicaClaimById(int id) {
        ProblemWicaClaim problemWicaClaim = null;

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Wica_claim_date, Wica_ref_nbr, Wica_insurer, "
                    + " Wica_policy_nbr,Wica_claim_reason, Wica_claim_rem,"
                    + "Worker_FIN_number, Job_key, Prob_key"
                    + " FROM tbl_wica_claim where ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Date wicaClaimDate = rs.getDate(1);
                String wicaReferenceNumber = rs.getString(2);
                String wicaInsurer = rs.getString(3);
                String wicaPolicyNumber = rs.getString(4);
                String wicaClaimReason = rs.getString(5);
                String wicaClaimRemark = rs.getString(6);
                String workerFinNumber = rs.getString(7);
                int jobKey = rs.getInt(8);
                int probKey = rs.getInt(9);
                problemWicaClaim = new ProblemWicaClaim(id, workerFinNumber, jobKey, probKey,
                        wicaClaimDate, wicaReferenceNumber, wicaInsurer, wicaPolicyNumber,
                        wicaClaimReason, wicaClaimRemark);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemSalaryClaim={" + problemWicaClaim + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return problemWicaClaim;
    }

     /**
     * add wica claim
     * @param problemWicaClaim wica claim of problem
     */
    public static void addProblemWicaClaim(ProblemWicaClaim problemWicaClaim) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "INSERT INTO tbl_wica_claim (Wica_claim_date, Wica_ref_nbr, Wica_insurer, "
                    + "Wica_policy_nbr, Wica_claim_reason, Wica_claim_rem, "
                    + "Worker_FIN_number, Job_key, Prob_key) "
                    + "VALUES (?,?,?,?,?,?,?,?,?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setDate(1, problemWicaClaim.getWicaClaimDate());
            pstmt.setString(2, problemWicaClaim.getWicaReferenceNumber());
            pstmt.setString(3, problemWicaClaim.getWicaInsurer());
            pstmt.setString(4, problemWicaClaim.getWicaPolicyNumber());
            pstmt.setString(5, problemWicaClaim.getWicaClaimReason());
            pstmt.setString(6, problemWicaClaim.getWicaClaimRemark());
            pstmt.setString(7, problemWicaClaim.getWorkerFinNumber());
            pstmt.setInt(8, problemWicaClaim.getJobKey());
            pstmt.setInt(9, problemWicaClaim.getProblmeKey());
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemWicaClaim: " + problemWicaClaim + "}");
        } finally {
            ConnectionManager.close(conn, pstmt);
        }
    }

    /**
     * update wica claim
     * @param problemWicaClaim wica claim of problem
     */
    public static void updateProblemWicaClaim(ProblemWicaClaim problemWicaClaim) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_wica_claim SET Wica_claim_date = ? , Wica_ref_nbr = ?,Wica_insurer=?, "
                    + "Wica_policy_nbr=?, Wica_claim_reason=?, Wica_claim_rem=? "
                    + "WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setDate(1, problemWicaClaim.getWicaClaimDate());
            pstmt.setString(2, problemWicaClaim.getWicaReferenceNumber());
            pstmt.setString(3, problemWicaClaim.getWicaInsurer());
            pstmt.setString(4, problemWicaClaim.getWicaPolicyNumber());
            pstmt.setString(5, problemWicaClaim.getWicaClaimReason());
            pstmt.setString(6, problemWicaClaim.getWicaClaimRemark());
            pstmt.setInt(7, problemWicaClaim.getId());
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemWicaClaim={" + problemWicaClaim + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }

    /**
     * delete wica claim with id
     * @param id wica claim id
     */
    public static void deleteProblemWicaClaim(int id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "DELETE FROM tbl_wica_claim WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "Problem Wica Claim ID={" + id + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }
    
    /**
     * delte all wica claims of problem
     */
    public static void deleteAllProblemWicaClaims() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            
            sql = "DELETE FROM tbl_wica_claim";
            pstmt = conn.prepareStatement(sql);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "not able to delete data from Problem-tbl_wica_claim Table. ");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }     
    }
    
    /*Problem non-wica claim Issue*/
     /**
     * retrieve non-wica claim ids
     * @param problem problem
     * @return a list of non-wica claim ids
     */
    public static ArrayList<Integer> retrieveNonWicaClaimIdsOfProblem(Problem problem) {
        ArrayList<Integer> ids = new ArrayList<Integer>();

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID FROM tbl_non_wica_claim where Worker_FIN_number = ? AND Job_key =? "
                    + "AND Prob_key=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, problem.getWorkerFinNum());
            pstmt.setInt(2, problem.getJobKey());
            pstmt.setInt(3, problem.getProbKey());
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                ids.add(id);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }

        return ids;
    }

     /**
     * retrieve non-wica claim with id
     * @param id non-wica claim id
     * @return non-wica claim with id
     */
    public static ProblemNonWicaClaim retrieveProblemNonWicaClaimById(int id) {
        ProblemNonWicaClaim problemNonWicaClaim = null;

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Med_claim_date, Med_claim_loss, Med_claim_insurer, Med_claim_policy_nbr, "
                    + "Med_claim_basis,"
                    + "Worker_FIN_number, Job_key, Prob_key, Med_claim_rem"
                    + " FROM tbl_non_wica_claim where ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Date medicalClaimDate = rs.getDate(1);
                double medicalClaimLoss = rs.getDouble(2);
                String medicalClaimInsurer = rs.getString(3);
                String medicalClaimPolicyNumber = rs.getString(4);
                String medicalClaimBasis = rs.getString(5);
                String workerFinNumber = rs.getString(6);
                int jobKey = rs.getInt(7);
                int probKey = rs.getInt(8);
                String remark = rs.getString(9);
                problemNonWicaClaim = new ProblemNonWicaClaim(id, workerFinNumber, jobKey, probKey,
                        medicalClaimDate, medicalClaimLoss, medicalClaimInsurer, medicalClaimPolicyNumber,
                        medicalClaimBasis, remark);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql, "problemNonWicaClaim={" + problemNonWicaClaim + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return problemNonWicaClaim;
    }

    /**
     * add non-wica claim
     * @param problemNonWicaClaim non-wica claim of problem
     */
    public static void addProblemNonWicaClaim(ProblemNonWicaClaim problemNonWicaClaim) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "INSERT INTO tbl_non_wica_claim (Med_claim_date, Med_claim_loss, Med_claim_insurer, "
                    + "Med_claim_policy_nbr, Med_claim_basis, Med_claim_rem,"
                    + "Worker_FIN_number, Job_key, Prob_key) "
                    + "VALUES (?,?,?,?,?,?,?,?,?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setDate(1, problemNonWicaClaim.getMedicalClaimDate());
            pstmt.setDouble(2, problemNonWicaClaim.getMedicalClaimLoss());
            pstmt.setString(3, problemNonWicaClaim.getMedicalClaimInsurer());
            pstmt.setString(4, problemNonWicaClaim.getMedicalClaimPolicyNumber());
            pstmt.setString(5, problemNonWicaClaim.getMedicalClaimBasis());
            pstmt.setString(6, problemNonWicaClaim.getRemark());
            pstmt.setString(7, problemNonWicaClaim.getWorkerFinNumber());
            pstmt.setInt(8, problemNonWicaClaim.getJobKey());
            pstmt.setInt(9, problemNonWicaClaim.getProblemKey());
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "problemNonWicaClaim: " + problemNonWicaClaim + "}");
        } finally {
            ConnectionManager.close(conn, pstmt);
        }
    }

    /**
     * update non-wica claim
     * @param problemNonWicaClaim non-wica claim of problem
     */
    public static void updateProblemNonWicaClaim(ProblemNonWicaClaim problemNonWicaClaim) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_non_wica_claim SET Med_claim_date=?, Med_claim_loss=?, Med_claim_insurer=?,"
                    + "Med_claim_policy_nbr=?, Med_claim_basis=?,Med_claim_rem=? "
                    + "WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setDate(1, problemNonWicaClaim.getMedicalClaimDate());
            pstmt.setDouble(2, problemNonWicaClaim.getMedicalClaimLoss());
            pstmt.setString(3, problemNonWicaClaim.getMedicalClaimInsurer());
            pstmt.setString(4, problemNonWicaClaim.getMedicalClaimPolicyNumber());
            pstmt.setString(5, problemNonWicaClaim.getMedicalClaimBasis());
            pstmt.setString(6, problemNonWicaClaim.getRemark());
            pstmt.setInt(7, problemNonWicaClaim.getId());
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemNonWicaClaim={" + problemNonWicaClaim + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }

     /**
     * delete non-wica claim with id
     * @param id non-wica claim id
     */
    public static void deleteProblemNonWicaClaim(int id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "DELETE FROM tbl_non_wica_claim WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "Problem Non Wica Claim ID={" + id + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }
    
     /**
     * delte all non-wica claims of problem
     */
    public static void deleteAllProblemNonWicaClaims() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            
            sql = "DELETE FROM tbl_non_wica_claim";
            pstmt = conn.prepareStatement(sql);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "not able to delete data from Problem-tbl_non_wica_claim Table. ");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }     
    }
    
    /*Problem police report*/
    /**
     * retrieve police report ids
     * @param problem problem
     * @return a list of police report ids
     */
    public static ArrayList<Integer> retrievePoliceReportIdsOfProblem(Problem problem) {
        ArrayList<Integer> ids = new ArrayList<Integer>();

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID FROM tbl_police_report where Worker_FIN_number = ? AND Job_key =? "
                    + "AND Prob_key=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, problem.getWorkerFinNum());
            pstmt.setInt(2, problem.getJobKey());
            pstmt.setInt(3, problem.getProbKey());
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                ids.add(id);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }

        return ids;
    }

     /**
     * retrieve police report with id
     * @param id police report id
     * @return police report with id
     */
    public static ProblemPoliceReport retrieveProblemPoliceReportById(int id) {
        ProblemPoliceReport problemPoliceReport = null;

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Police_rpt_date, Police_rpt_station, Police_rpt_pers, Police_rpt_ref_nbr,"
                    + "Police_rpt_details, Police_rpt_rem,"
                    + "Worker_FIN_number, Job_key, Prob_key"
                    + " FROM tbl_police_report where ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Date policeReportDate = rs.getDate(1);
                String policeReportStation = rs.getString(2);
                String policeReportPerson = rs.getString(3);
                String policeReportReferenceNumber = rs.getString(4);
                String policeRerpotDetails = rs.getString(5);
                String policeRerpotRemark = rs.getString(6);
                String workerFinNumber = rs.getString(7);
                int jobKey = rs.getInt(8);
                int probKey = rs.getInt(9);
                problemPoliceReport = new ProblemPoliceReport(id, workerFinNumber, jobKey, probKey,
                        policeReportDate, policeReportStation, policeReportPerson, policeReportReferenceNumber,
                        policeRerpotDetails, policeRerpotRemark);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemPoliceReport={" + problemPoliceReport + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return problemPoliceReport;
    }

     /**
     * add police report
     * @param problemPoliceReport police report of problem
     */
    public static void addProblemPoliceReport(ProblemPoliceReport problemPoliceReport) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "INSERT INTO tbl_police_report (Police_rpt_date, Police_rpt_station, "
                    + "Police_rpt_pers, "
                    + "Police_rpt_ref_nbr, Police_rpt_details, Police_rpt_rem, "
                    + "Worker_FIN_number, Job_key, Prob_key) "
                    + "VALUES (?,?,?,?,?,?,?,?,?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setDate(1, problemPoliceReport.getPoliceReportDate());
            pstmt.setString(2, problemPoliceReport.getPoliceReportStation());
            pstmt.setString(3, problemPoliceReport.getPoliceReportPerson());
            pstmt.setString(4, problemPoliceReport.getPoliceReportReferenceNumber());
            pstmt.setString(5, problemPoliceReport.getPoliceReportDetails());
            pstmt.setString(6, problemPoliceReport.getPoliceReportRemark());
            pstmt.setString(7, problemPoliceReport.getWorkerFinNumber());
            pstmt.setInt(8, problemPoliceReport.getJobKey());
            pstmt.setInt(9, problemPoliceReport.getProblemKey());
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemPoliceReport: " + problemPoliceReport + "}");
        } finally {
            ConnectionManager.close(conn, pstmt);
        }
    }

     /**
     * update police report
     * @param problemPoliceReport police report of problem
     */
    public static void updateProblemPoliceReport(ProblemPoliceReport problemPoliceReport) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_police_report SET Police_rpt_date=?, Police_rpt_station=?, Police_rpt_pers=?,"
                    + "Police_rpt_ref_nbr=?, Police_rpt_details=?, Police_rpt_rem=? "
                    + "WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setDate(1, problemPoliceReport.getPoliceReportDate());
            pstmt.setString(2, problemPoliceReport.getPoliceReportStation());
            pstmt.setString(3, problemPoliceReport.getPoliceReportPerson());
            pstmt.setString(4, problemPoliceReport.getPoliceReportReferenceNumber());
            pstmt.setString(5, problemPoliceReport.getPoliceReportDetails());
            pstmt.setString(6, problemPoliceReport.getPoliceReportRemark());
            pstmt.setInt(7, problemPoliceReport.getId());
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemPoliceReport={" + problemPoliceReport + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }

    /**
     * delete police report with id
     * @param id police report id
     */
    public static void deleteProblemPoliceReport(int id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "DELETE FROM tbl_police_report WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "Problem Police Report ID={" + id + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }
    
     /**
     * delete all police reports of problem
     */
    public static void deleteAllProblemPoliceReports() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            
            sql = "DELETE FROM tbl_police_report";
            pstmt = conn.prepareStatement(sql);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "not able to delete data from Problem-tbl_police_report Table. ");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }     
    }
    
    /*Problem other complaint*/
    
    /**
     * retrieve other complaint ids
     * @param problem problem
     * @return a list of other complaint ids
     */
    public static ArrayList<Integer> retrieveOtherComplaintIdsOfProblem(Problem problem) {
        ArrayList<Integer> ids = new ArrayList<Integer>();

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID FROM tbl_other_complaint where Worker_FIN_number = ? AND Job_key =? "
                    + "AND Prob_key=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, problem.getWorkerFinNum());
            pstmt.setInt(2, problem.getJobKey());
            pstmt.setInt(3, problem.getProbKey());
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                ids.add(id);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }

        return ids;
    }

    /**
     * retrieve other complaint with id
     * @param id other complaint id
     * @return other complaint with id
     */
    public static ProblemOtherComplaint retrieveProblemOtherComplaintById(int id) {
        ProblemOtherComplaint problemOtherComplaint = null;

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Other_plaint_date, Other_plaint_agency, Other_plaint_who, Other_plaint_who_more, "
                    + "Other_plaint_mode, Other_plaint_mode_more, Other_plaint_details, Other_plaint_rem, "
                    + "Worker_FIN_number, Job_key, Prob_key"
                    + " FROM tbl_other_complaint where ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Date otherComplaintDate = rs.getDate(1);
                String otherCompalaintAgency = rs.getString(2);
                String otherCompalaintWho = rs.getString(3);
                String otherCompalaintWhoMore = rs.getString(4);
                String otherCompalaintMode = rs.getString(5);
                String otherCompalaintModeMore = rs.getString(6);
                String otherCompalaintDetails = rs.getString(7);
                String otherCompalaintRemark = rs.getString(8);
                String workerFinNumber = rs.getString(9);
                int jobKey = rs.getInt(10);
                int probKey = rs.getInt(11);
                problemOtherComplaint = new ProblemOtherComplaint(id, workerFinNumber, jobKey, probKey,
                        otherComplaintDate, otherCompalaintAgency, otherCompalaintWho, otherCompalaintWhoMore,
                        otherCompalaintMode, otherCompalaintModeMore, otherCompalaintDetails, otherCompalaintRemark);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemOtherComplaint={" + problemOtherComplaint + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return problemOtherComplaint;
    }

     /**
     * add other complaint
     * @param problemOtherComplaint other complaint of problem
     */
    public static void addProblemOtherComplaint(ProblemOtherComplaint problemOtherComplaint) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "INSERT INTO tbl_other_complaint (Other_plaint_date, Other_plaint_agency, "
                    + "Other_plaint_who,  "
                    + "Other_plaint_who_more, Other_plaint_mode, Other_plaint_mode_more, "
                    + "Other_plaint_details, Other_plaint_rem,  "
                    + "Worker_FIN_number, Job_key, Prob_key) "
                    + "VALUES (?,?,?,?,?,?,?,?,?,?,?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setDate(1, problemOtherComplaint.getOtherComplaintDate());
            pstmt.setString(2, problemOtherComplaint.getOtherComplaintAgency());
            pstmt.setString(3, problemOtherComplaint.getOtherComplaintWho());
            pstmt.setString(4, problemOtherComplaint.getOtherComplaintWhoMore());
            pstmt.setString(5, problemOtherComplaint.getOtherComplaintMode());
            pstmt.setString(6, problemOtherComplaint.getOtherComplaintModeMore());
            pstmt.setString(7, problemOtherComplaint.getOtherComplaintDetails());
            pstmt.setString(8, problemOtherComplaint.getOtherComplaintRemark());
            pstmt.setString(9, problemOtherComplaint.getWorkerFinNumber());
            pstmt.setInt(10, problemOtherComplaint.getJobKey());
            pstmt.setInt(11, problemOtherComplaint.getProblemKey());
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemOtherComplaint: " + problemOtherComplaint + "}");
        } finally {
            ConnectionManager.close(conn, pstmt);
        }
    }

     /**
     * update other complaint
     * @param problemOtherComplaint other complaint of problem
     */
    public static void updateProblemOtherComplaint(ProblemOtherComplaint problemOtherComplaint) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_other_complaint SET Other_plaint_date=?, Other_plaint_agency=?, Other_plaint_who=?, "
                    + "Other_plaint_who_more=?, Other_plaint_mode=?, Other_plaint_mode_more=?, "
                    + "Other_plaint_details=?, Other_plaint_rem=? "
                    + "WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setDate(1, problemOtherComplaint.getOtherComplaintDate());
            pstmt.setString(2, problemOtherComplaint.getOtherComplaintAgency());
            pstmt.setString(3, problemOtherComplaint.getOtherComplaintWho());
            pstmt.setString(4, problemOtherComplaint.getOtherComplaintWhoMore());
            pstmt.setString(5, problemOtherComplaint.getOtherComplaintMode());
            pstmt.setString(6, problemOtherComplaint.getOtherComplaintModeMore());
            pstmt.setString(7, problemOtherComplaint.getOtherComplaintDetails());
            pstmt.setString(8, problemOtherComplaint.getOtherComplaintRemark());
            pstmt.setInt(9, problemOtherComplaint.getId());
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemOtherComplaint={" + problemOtherComplaint + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }
 
     /**
     * delete other complaint with id
     * @param id other complaint id
     */
    public static void deleteProblemOtherComplaint(int id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "DELETE FROM tbl_other_complaint WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "Problem Other Compliant ID={" + id + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }
    
     /**
     * delete all other complaints of problem
     */
    public static void deleteAllProblemOtherComplaints() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            
            sql = "DELETE FROM tbl_other_complaint";
            pstmt = conn.prepareStatement(sql);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "not able to delete data from Problem-tbl_other_complaint Table. ");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }     
    }
    
    /*Problem case discussion*/
     /**
     * retrieve case discussion ids
     * @param problem problem
     * @return a list of case discussion ids
     */
    public static ArrayList<Integer> retrieveCaseDiscussionIdsOfProblem(Problem problem) {
        ArrayList<Integer> ids = new ArrayList<Integer>();

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID FROM tbl_case_discussion where Worker_FIN_number = ? AND Job_key =? "
                    + "AND Prob_key=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, problem.getWorkerFinNum());
            pstmt.setInt(2, problem.getJobKey());
            pstmt.setInt(3, problem.getProbKey());
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                ids.add(id);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }

        return ids;
    }

     /**
     * retrieve case discussion with id
     * @param id case discussion id
     * @return case discussion with id
     */
    public static ProblemCaseDiscussion retrieveProblemCaseDiscussionById(int id) {
        ProblemCaseDiscussion problemCaseDiscussion = null;

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Discuss_date, Discuss_time, Discuss_where, Discuss_where_more, "
                    + "Discuss_worker_present, Discuss_TWC2_pers1, Discuss_TWC2_pers2, Discuss_oth_pers, "
                    + "Discuss_translator, Discuss_topic, Discuss_gist, Discuss_assist, Discuss_calculate, Discuss_action, Discuss_rem, "
                    + "Worker_FIN_number, Job_key, Prob_key"
                    + " FROM tbl_case_discussion where ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Date discussDate = rs.getDate(1);
                String discussTime = rs.getString(2);
                String discussWhere = rs.getString(3);
                String discussWhereMore = rs.getString(4);
                String discussWorkerPresent = rs.getString(5);
                String discussTWC2Person1 = rs.getString(6);
                String discussTWC2Person2 = rs.getString(7);
                String discussOtherPerson = rs.getString(8);
                String discussTranslator = rs.getString(9);
                String discussTopic = rs.getString(10);
                String discussGist = rs.getString(11);
                String discussAssist = rs.getString(12);
                String discussCalculate = rs.getString(13);
                String discussAction = rs.getString(14);
                String discussRemark = rs.getString(15);
                String workerFinNumber = rs.getString(16);
                int jobKey = rs.getInt(17);
                int probKey = rs.getInt(18);
                problemCaseDiscussion = new ProblemCaseDiscussion(id, workerFinNumber, jobKey, probKey,
                        discussDate, discussTime, discussWhere, discussWhereMore, discussWorkerPresent,
                        discussTWC2Person1, discussTWC2Person2, discussOtherPerson, discussTranslator,
                        discussTopic, discussGist, discussAssist, discussCalculate, discussAction, discussRemark);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemCaseDiscussion={" + problemCaseDiscussion + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return problemCaseDiscussion;
    }

     /**
     * add case discussion
     * @param problemCaseDiscussion case discussion of problem
     */
    public static void addProblemCaseDiscussion(ProblemCaseDiscussion problemCaseDiscussion) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "INSERT INTO tbl_case_discussion (Discuss_date, Discuss_time, Discuss_where, Discuss_where_more, "
                    + "Discuss_worker_present, Discuss_TWC2_pers1, Discuss_TWC2_pers2, Discuss_oth_pers, Discuss_translator, "
                    + "Discuss_topic, Discuss_gist, Discuss_assist, Discuss_calculate, Discuss_action, Discuss_rem, "
                    + "Worker_FIN_number, Job_key, Prob_key) "
                    + "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setDate(1, problemCaseDiscussion.getCaseDiscussionDate());
            pstmt.setString(2, problemCaseDiscussion.getCaseDiscussionTime());
            pstmt.setString(3, problemCaseDiscussion.getCaseDiscussionWhere());
            pstmt.setString(4, problemCaseDiscussion.getCaseDiscussionWhereMore());
            pstmt.setString(5, problemCaseDiscussion.getCaseDiscussionWorkerPresent());
            pstmt.setString(6, problemCaseDiscussion.getCaseDiscussionTWC2Person1());
            pstmt.setString(7, problemCaseDiscussion.getCaseDiscussionTWC2Person2());
            pstmt.setString(8, problemCaseDiscussion.getCaseDiscussionOtherPerson());
            pstmt.setString(9, problemCaseDiscussion.getCaseDiscussionTranslator());
            pstmt.setString(10, problemCaseDiscussion.getCaseDiscussionTopic());
            pstmt.setString(11, problemCaseDiscussion.getCaseDiscussionGist());
            pstmt.setString(12, problemCaseDiscussion.getCaseDiscussionAssist());
            pstmt.setString(13, problemCaseDiscussion.getCaseDiscussionCalculate());
            pstmt.setString(14, problemCaseDiscussion.getCaseDiscussionAction());
            pstmt.setString(15, problemCaseDiscussion.getCaseDiscussionRemark());
            pstmt.setString(16, problemCaseDiscussion.getWorkerFinNumber());
            pstmt.setInt(17, problemCaseDiscussion.getJobKey());
            pstmt.setInt(18, problemCaseDiscussion.getProblemKey());
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemCaseDiscussion: " + problemCaseDiscussion + "}");
        } finally {
            ConnectionManager.close(conn, pstmt);
        }
    }

     /**
     * update case discussion
     * @param problemCaseDiscussion case discussion of problem
     */
    public static void updateProblemCaseDiscussion(ProblemCaseDiscussion problemCaseDiscussion) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_case_discussion SET Discuss_date=?, Discuss_time=?, Discuss_where=?, Discuss_where_more=?, "
                    + "Discuss_worker_present=?, Discuss_TWC2_pers1=?, Discuss_TWC2_pers2=?, "
                    + "Discuss_oth_pers=?, Discuss_translator=?, Discuss_topic=?, Discuss_gist=?, Discuss_assist=?, "
                    + "Discuss_calculate=?, Discuss_action=?, Discuss_rem=? "
                    + "WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setDate(1, problemCaseDiscussion.getCaseDiscussionDate());
            pstmt.setString(2, problemCaseDiscussion.getCaseDiscussionTime());
            pstmt.setString(3, problemCaseDiscussion.getCaseDiscussionWhere());
            pstmt.setString(4, problemCaseDiscussion.getCaseDiscussionWhereMore());
            pstmt.setString(5, problemCaseDiscussion.getCaseDiscussionWorkerPresent());
            pstmt.setString(6, problemCaseDiscussion.getCaseDiscussionTWC2Person1());
            pstmt.setString(7, problemCaseDiscussion.getCaseDiscussionTWC2Person2());
            pstmt.setString(8, problemCaseDiscussion.getCaseDiscussionOtherPerson());
            pstmt.setString(9, problemCaseDiscussion.getCaseDiscussionTranslator());
            pstmt.setString(10, problemCaseDiscussion.getCaseDiscussionTopic());
            pstmt.setString(11, problemCaseDiscussion.getCaseDiscussionGist());
            pstmt.setString(12, problemCaseDiscussion.getCaseDiscussionAssist());
            pstmt.setString(13, problemCaseDiscussion.getCaseDiscussionCalculate());
            pstmt.setString(14, problemCaseDiscussion.getCaseDiscussionAction());
            pstmt.setString(15, problemCaseDiscussion.getCaseDiscussionRemark());
            pstmt.setInt(16,problemCaseDiscussion.getId());
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemCaseDiscussion={" + problemCaseDiscussion + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }

     /**
     * delete case discussion with id
     * @param id case discussion id
     */
    public static void deleteProblemCaseDiscussion(int id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "DELETE FROM tbl_case_discussion WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "Problem Case Discussion ID={" + id + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }
    
      /**
     * delete all case discussions of problem
     */
    public static void deleteAllProblemCaseDiscussions() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            
            sql = "DELETE FROM tbl_case_discussion";
            pstmt = conn.prepareStatement(sql);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "not able to delete data from Problem-tbl_case_discussion Table. ");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }     
    }
    
    /*Problem Hospital*/
    /**
     * retrieve hospital ids
     * @param problem problem
     * @return a list of hospital ids
     */
    public static ArrayList<Integer> retrieveProblemHospitalIdsOfProblem(Problem problem) {
        ArrayList<Integer> ids = new ArrayList<Integer>();

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID FROM tbl_hospital where Worker_FIN_number = ? AND Job_key =? "
                    + "AND Prob_key=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, problem.getWorkerFinNum());
            pstmt.setInt(2, problem.getJobKey());
            pstmt.setInt(3, problem.getProbKey());
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                ids.add(id);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }

        return ids;
    }

    /**
     * retrieve hospital with id
     * @param id hospital id
     * @return hospital with id
     */
    public static ProblemHospital retrieveProblemHospitalById(int id) {
        ProblemHospital problemHospital = null;

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Hosp_update, Hosp_name,"
                    + " Hosp_name_more, Hosp_doctor, Hosp_remark, "
                    + "Worker_FIN_number, Job_key, Prob_key"
                    + " FROM tbl_hospital where ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Date hospitalUpdate = rs.getDate(1);
                String hospitalName = rs.getString(2);
                String hospitalNameMore = rs.getString(3);
                String hospitalDoctor = rs.getString(4);
                String hospitalRemark = rs.getString(5);
                String workerFinNumber = rs.getString(6);
                int jobKey = rs.getInt(7);
                int probKey = rs.getInt(8);
                problemHospital = new ProblemHospital(id, workerFinNumber, jobKey, probKey,
                        hospitalUpdate, hospitalName, hospitalNameMore, hospitalDoctor,
                        hospitalRemark);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemHospital={" + problemHospital + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return problemHospital;
    }

     /**
     * add hospital
     * @param problemHospital hospital of problem
     */
    public static void addProblemHospital(ProblemHospital problemHospital) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "INSERT INTO tbl_hospital (Hosp_update,Hosp_name, "
                    + "Hosp_name_more, Hosp_doctor, Hosp_remark,"
                    + "Worker_FIN_number, Job_key, Prob_key) "
                    + "VALUES (?,?,?,?,?,?,?,?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setDate(1, problemHospital.getHospitalUpdate());
            pstmt.setString(2, problemHospital.getHospitalName());
            pstmt.setString(3, problemHospital.getHospitalNameMore());
            pstmt.setString(4, problemHospital.getHospitalDoctor());
            pstmt.setString(5, problemHospital.getHospitalRemark());
            pstmt.setString(6, problemHospital.getWorkerFinNumber());
            pstmt.setInt(7, problemHospital.getJobKey());
            pstmt.setInt(8, problemHospital.getProblemKey());
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemHospital: " + problemHospital + "}");
        } finally {
            ConnectionManager.close(conn, pstmt);
        }
    }

     /**
     * update hospital
     * @param problemHospital hospital of problem
     */
    public static void updateProblemHospital(ProblemHospital problemHospital) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_hospital SET Hosp_update = ? , Hosp_name = ?,"
                    + "Hosp_name_more =?, Hosp_doctor =?, Hosp_remark=? "
                    + "WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setDate(1, problemHospital.getHospitalUpdate());
            pstmt.setString(2, problemHospital.getHospitalName());
            pstmt.setString(3, problemHospital.getHospitalNameMore());
            pstmt.setString(4, problemHospital.getHospitalDoctor());
            pstmt.setString(5, problemHospital.getHospitalRemark());
            pstmt.setInt(6, problemHospital.getId());

            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemHospital={" + problemHospital + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }
    
     /**
     * delete hospital with id
     * @param id hospital id
     */
    public static void deleteProblemHospital(int id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "DELETE FROM tbl_hospital WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "Problem Hospital ID={" + id + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }
    
    /**
     * delete all hospitals of problem
     */
    public static void deleteAllProblemHospitals() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            
            sql = "DELETE FROM tbl_hospital";
            pstmt = conn.prepareStatement(sql);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "not able to delete data from Problem-tbl_hospital Table. ");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }     
    }
    
    /*Problem MC_status*/
    /**
     * retrieve MC status ids
     * @param problem problem
     * @return a list of MC status ids
     */
    public static ArrayList<Integer> retrieveProblemMCStatusIdsOfProblem(Problem problem) {
        ArrayList<Integer> ids = new ArrayList<Integer>();

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID FROM tbl_MC_status where Worker_FIN_number = ? AND Job_key =? "
                    + "AND Prob_key=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, problem.getWorkerFinNum());
            pstmt.setInt(2, problem.getJobKey());
            pstmt.setInt(3, problem.getProbKey());
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                ids.add(id);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }

        return ids;
    }

      /**
     * retrieve MC status with id
     * @param id MC status id
     * @return MC status with id
     */
    public static ProblemMCStatus retrieveProblemMCStatusById(int id) {
        ProblemMCStatus problemMCStatus = null;

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT MC_update, MC_status,"
                    + " MC_status_more, MC_exp_date,"
                    + " MC_days_cumul, MC_rem,"
                    + "Worker_FIN_number, Job_key, Prob_key"
                    + " FROM tbl_MC_status where ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Date MCUpdate = rs.getDate(1);
                String MCStatus = rs.getString(2);
                String MCStatusMore = rs.getString(3);
                Date MCExpDate = rs.getDate(4);
                int MCDaysCumul = rs.getInt(5);
                String MCRem = rs.getString(6);
                String workerFinNumber = rs.getString(7);
                int jobKey = rs.getInt(8);
                int probKey = rs.getInt(9);
                problemMCStatus = new ProblemMCStatus(id, workerFinNumber, jobKey, probKey,
                        MCUpdate, MCStatus, MCStatusMore, MCExpDate, MCDaysCumul, MCRem);
            }
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemMCStatus={" + problemMCStatus + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return problemMCStatus;
    }

    /**
     * add MC status
     * @param problemMCStatus MC status of problem
     */
    public static void addProblemMCStatus(ProblemMCStatus problemMCStatus) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "INSERT INTO tbl_MC_status (MC_update, MC_status, "
                    + "MC_status_more,MC_exp_date, "
                    + "MC_days_cumul,MC_rem, "
                    + "Worker_FIN_number, Job_key, Prob_key) "
                    + "VALUES (?,?,?,?,?,?,?,?,?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setDate(1, problemMCStatus.getMCUpdate());
            pstmt.setString(2, problemMCStatus.getMCStatus());
            pstmt.setString(3, problemMCStatus.getMCStatusMore());
            pstmt.setDate(4, problemMCStatus.getMCExpDate());
            pstmt.setInt(5, problemMCStatus.getMCDaysCumul());
            pstmt.setString(6, problemMCStatus.getMCRem());
            pstmt.setString(7, problemMCStatus.getWorkerFinNumber());
            pstmt.setInt(8, problemMCStatus.getJobKey());
            pstmt.setInt(9, problemMCStatus.getProblemKey());
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemMCStatus: " + problemMCStatus + "}");
        } finally {
            ConnectionManager.close(conn, pstmt);
        }
    }

     /**
     * update MC status
     * @param problemMCStatus MC status of problem
     */
    public static void updateProblemMCStatus(ProblemMCStatus problemMCStatus) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_MC_status SET MC_update = ? , MC_status = ?,"
                    + "MC_status_more =?, MC_exp_date =? , MC_days_cumul =?, MC_rem =? "
                    + "WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setDate(1, problemMCStatus.getMCUpdate());
            pstmt.setString(2, problemMCStatus.getMCStatus());
            pstmt.setString(3, problemMCStatus.getMCStatusMore());
            pstmt.setDate(4, problemMCStatus.getMCExpDate());
            pstmt.setInt(5, problemMCStatus.getMCDaysCumul());
            pstmt.setString(6, problemMCStatus.getMCRem());
            pstmt.setInt(7, problemMCStatus.getId());

            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemMCStatus={" + problemMCStatus + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }

     /**
     * delete MC status with id
     * @param id MC status id
     */
    public static void deleteProblemMCStatus(int id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "DELETE FROM tbl_MC_status WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "Problem MC Status ID={" + id + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }
    
     /**
     * delete all MC status of problem
     */
    public static void deleteAllProblemMCStatus() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            
            sql = "DELETE FROM tbl_MC_status";
            pstmt = conn.prepareStatement(sql);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "not able to delete data from Problem-tbl_MC_status Table. ");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }     
    }
    
    /*Problem R2R*/
    /**
     * retrieve R2R dates ids
     * @param start start date of R2R
     * @param end end date of R2R
     * @return a list of R2R dates ids
     */
    public static ArrayList<Integer> retrieveProblemR2rIdsBetDates(java.util.Date start, java.util.Date end){
        ArrayList<Integer> ids = new ArrayList<Integer>();

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            java.sql.Date startDate = new java.sql.Date(start.getTime());
            java.sql.Date endDate = new java.sql.Date(end.getTime());
            
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID FROM tbl_R2R WHERE R2R_date BETWEEN ? AND ? ORDER BY R2R_date DESC";
            pstmt = conn.prepareStatement(sql);
            pstmt.setDate(1, startDate);
            pstmt.setDate(2, endDate);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                ids.add(id);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }

        return ids;
    }
    
     /**
     * retrieve R2R ids
     * @param problem problem
     * @return a list of R2R ids
     */
    public static ArrayList<Integer> retrieveProblemR2RIdsOfProblem(Problem problem) {
        ArrayList<Integer> ids = new ArrayList<Integer>();

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID FROM tbl_R2R where Worker_FIN_number = ? AND Job_key =? "
                    + "AND Prob_key=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, problem.getWorkerFinNum());
            pstmt.setInt(2, problem.getJobKey());
            pstmt.setInt(3, problem.getProbKey());
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                ids.add(id);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }

        return ids;
    }

     /**
     * retrieve R2R with id
     * @param id R2R id
     * @return R2R with id
     */
    public static ProblemR2R retrieveProblemR2RById(int id) {
        ProblemR2R problemR2R = null;

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT R2R_date, R2R_time,"
                    + " R2R_hosp, R2R_dept,"
                    + " R2R1, R2R2, R2R_purpose,"
                    + "R2R_pre_appt_notes, R2R_post_appt_notes,"
                    + "R2R_feedback, R2R_med_cost, R2R_outlay,"
                    + "Worker_FIN_number, Job_key, Prob_key"
                    + " FROM tbl_R2R where ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Date R2Rdate = rs.getDate(1);
                String R2RTime = rs.getString(2);
                String R2RHosp = rs.getString(3);
                String R2RDept = rs.getString(4);
                String R2R1 = rs.getString(5);
                String R2R2 = rs.getString(6);
                String R2RPurpose = rs.getString(7);
                String R2RPreApptNotes = rs.getString(8);
                String R2RPostApptNotes = rs.getString(9);
                String R2RFeedback = rs.getString(10);
                double R2RMedCost = rs.getFloat(11);
                double R2ROutlay = rs.getFloat(12);
                String workerFinNumber = rs.getString(13);
                int jobKey = rs.getInt(14);
                int probKey = rs.getInt(15);
                problemR2R = new ProblemR2R(id, workerFinNumber, jobKey, probKey,
                        R2Rdate, R2RTime, R2RHosp, R2RDept, R2R1, R2R2, R2RPurpose,
                        R2RPreApptNotes, R2RPostApptNotes, R2RFeedback, R2RMedCost, R2ROutlay);
            }
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemR2R={" + problemR2R + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return problemR2R;
    }
 
    /**
     * add R2R
     * @param problemR2R R2R of problem
     */
    public static void addProblemR2R(ProblemR2R problemR2R) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "INSERT INTO tbl_R2R (R2R_date, R2R_time,"
                    + " R2R_hosp, R2R_dept,"
                    + " R2R1, R2R2, R2R_purpose,"
                    + "R2R_pre_appt_notes, R2R_post_appt_notes,"
                    + "R2R_feedback, R2R_med_cost, R2R_outlay, "
                    + "Worker_FIN_number, Job_key, Prob_key) "
                    + "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setDate(1, problemR2R.getR2RDate());
            pstmt.setString(2, problemR2R.getR2RTime());
            pstmt.setString(3, problemR2R.getR2RHosp());
            pstmt.setString(4, problemR2R.getR2RDept());
            pstmt.setString(5, problemR2R.getR2R1());
            pstmt.setString(6, problemR2R.getR2R2());
            pstmt.setString(7, problemR2R.getR2RPurpose());
            pstmt.setString(8, problemR2R.getR2RPreApptNotes());
            pstmt.setString(9, problemR2R.getR2RPostApptNotes());
            pstmt.setString(10, problemR2R.getR2RFeedback());
            pstmt.setDouble(11, problemR2R.getR2RMedCost());
            pstmt.setDouble(12, problemR2R.getR2ROutlay());
            pstmt.setString(13, problemR2R.getWorkerFinNumber());
            pstmt.setInt(14, problemR2R.getJobKey());
            pstmt.setInt(15,problemR2R.getProblemKey());
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemR2R: " + problemR2R + "}");
        } finally {
            ConnectionManager.close(conn, pstmt);
        }
    }

     /**
     * update R2R
     * @param problemR2R R2R of problem
     */
    public static void updateProblemR2R(ProblemR2R problemR2R) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_R2R SET R2R_date = ? , R2R_time = ?, R2R_hosp = ?, R2R_dept = ?, "
                    + "R2R1 = ?, R2R2= ?, R2R_purpose = ?,"
                    + "R2R_pre_appt_notes =?, R2R_post_appt_notes =? , R2R_feedback =?, "
                    + "R2R_med_cost =?, R2R_outlay= ? "
                    + "WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setDate(1, problemR2R.getR2RDate());
            pstmt.setString(2, problemR2R.getR2RTime());
            pstmt.setString(3, problemR2R.getR2RHosp());
            pstmt.setString(4, problemR2R.getR2RDept());
            pstmt.setString(5, problemR2R.getR2R1());
            pstmt.setString(6, problemR2R.getR2R2());
            pstmt.setString(7, problemR2R.getR2RPurpose());
            pstmt.setString(8, problemR2R.getR2RPreApptNotes());
            pstmt.setString(9, problemR2R.getR2RPostApptNotes());
            pstmt.setString(10, problemR2R.getR2RFeedback());
            pstmt.setDouble(11, problemR2R.getR2RMedCost());
            pstmt.setDouble(12, problemR2R.getR2ROutlay());
            pstmt.setInt(13, problemR2R.getId());
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemR2R={" + problemR2R + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }
    
     /**
     * delete R2R with id
     * @param id R2R id
     */
    public static void deleteProblemR2R(int id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "DELETE FROM tbl_R2R WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "Problem R2R ID={" + id + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }
    
     /**
     * delete all R2Rs of problem
     */
    public static void deleteAllProblemR2Rs() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            
            sql = "DELETE FROM tbl_R2R";
            pstmt = conn.prepareStatement(sql);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "not able to delete data from Problem-tbl_R2R Table. ");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }     
    }
    
    /*Problem Lawyer*/
     /**
     * retrieve lawyer ids
     * @param problem problem
     * @return a list of lawyer ids
     */
    public static ArrayList<Integer> retrieveProblemLawyerIdsOfProblem(Problem problem) {
        ArrayList<Integer> ids = new ArrayList<Integer>();

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID FROM tbl_lawyer where Worker_FIN_number = ? AND Job_key =? "
                    + "AND Prob_key=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, problem.getWorkerFinNum());
            pstmt.setInt(2, problem.getJobKey());
            pstmt.setInt(3, problem.getProbKey());
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                ids.add(id);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }

        return ids;
    }

    /**
     * retrieve lawyer with id
     * @param id lawyer id
     * @return lawyer with id
     */
    public static ProblemLawyer retrieveProblemLawyerById(int id) {
        ProblemLawyer problemLawyer = null;

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Lawyer_update,"
                    + " Lawyer_firm, Lawyer_firm_more, Lawyer_Name, Lawyer_remarks,"
                    + "Worker_FIN_number, Job_key, Prob_key"
                    + " FROM tbl_lawyer where ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                java.sql.Date LawyerUpdate = rs.getDate(1);
                String LawyerFirm = rs.getString(2);
                String LawyerFirmMore = rs.getString(3);
                String LawyerName = rs.getString(4);
                String LawyerRemark = rs.getString(5);
                String workerFinNumber = rs.getString(6);
                int jobKey = rs.getInt(7);
                int probKey = rs.getInt(8);
                problemLawyer = new ProblemLawyer(id, workerFinNumber, jobKey, probKey,
                        LawyerUpdate, LawyerFirm, LawyerFirmMore, LawyerName,LawyerRemark );
            }
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemLawyer={" + problemLawyer + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return problemLawyer;
    }

     /**
     * add lawyer
     * @param problemLawyer lawyer of problem
     */
    public static void addProblemLawyer(ProblemLawyer problemLawyer) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "INSERT INTO tbl_lawyer (Lawyer_update,"
                    + " Lawyer_firm, Lawyer_firm_more, Lawyer_Name, Lawyer_remarks,"
                    + "Worker_FIN_number, Job_key, Prob_key) "
                    + "VALUES (?,?,?,?,?,?,?,?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setDate(1, problemLawyer.getLawyerUpdate());
            pstmt.setString(2, problemLawyer.getLawyerFirm());
            pstmt.setString(3, problemLawyer.getLawyerFirmMore());
            pstmt.setString(4, problemLawyer.getLawyerName());
            pstmt.setString(5, problemLawyer.getLawyerRemarks());
            pstmt.setString(6, problemLawyer.getWorkerFinNumber());
            pstmt.setInt(7, problemLawyer.getJobKey());
            pstmt.setInt(8, problemLawyer.getProblemKey());
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemLawyer: " + problemLawyer + "}");
        } finally {
            ConnectionManager.close(conn, pstmt);
        }
    }

    /**
     * update lawyer
     * @param problemLawyer lawyer of problem
     */
    public static void updateProblemLawyer(ProblemLawyer problemLawyer) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_lawyer SET Lawyer_update = ? , Lawyer_firm = ?,"
                    + "Lawyer_firm_more = ?, Lawyer_Name = ?, Lawyer_remarks = ? WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setDate(1, problemLawyer.getLawyerUpdate());
            //pstmt.setString(2, problemLawyer.getLawyerHave());
            pstmt.setString(2, problemLawyer.getLawyerFirm());
            pstmt.setString(3, problemLawyer.getLawyerFirmMore());
            pstmt.setString(4, problemLawyer.getLawyerName());
            pstmt.setString(5, problemLawyer.getLawyerRemarks());
            pstmt.setInt(6, problemLawyer.getId());

            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemLawyer={" + problemLawyer + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }

     /**
     * delete lawyer with id
     * @param id lawyer id
     */
    public static void deleteProblemLawyer(int id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "DELETE FROM tbl_lawyer WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "Problem Lawyer ID={" + id + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }
    
     /**
     * delete all lawyers of problem
     */
    public static void deleteAllProblemLawyers() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            
            sql = "DELETE FROM tbl_lawyer";
            pstmt = conn.prepareStatement(sql);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "not able to delete data from Problem-tbl_lawyer Table. ");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }     
    }
    
    /*Problem Case Milestone Non criminal*/
     /**
     * retrieve case milestone non-critical ids
     * @param problem problem
     * @return a list of case milestone non-critical ids
     */
    public static ArrayList<Integer> retrieveProblemCaseMilestoneNCIdsOfProblem(Problem problem) {
        ArrayList<Integer> ids = new ArrayList<Integer>();

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID FROM tbl_casemilestone_noncriminal where Worker_FIN_number = ? "
                    + "AND Job_key =? "
                    + "AND Prob_key=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, problem.getWorkerFinNum());
            pstmt.setInt(2, problem.getJobKey());
            pstmt.setInt(3, problem.getProbKey());
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                ids.add(id);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }

        return ids;
    }

     /**
     * retrieve case milestone non-critical with id
     * @param id case milestone non-critical id
     * @return case milestone non-critical with id
     */
    public static ProblemCaseMilestoneNC retrieveProblemCaseMilestoneNCById(int id) {
        ProblemCaseMilestoneNC problemCaseMilestoneNC = null;

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Miles_nc_date, Miles_nc_reached,"
                    + " Miles_nc_reached_more, Miles_nc_rem,"
                    + "Worker_FIN_number, Job_key, Prob_key"
                    + " FROM tbl_casemilestone_noncriminal where ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Date MilesNCDate = rs.getDate(1);
                String MilesNCReached = rs.getString(2);
                String MilesNCReachedMore = rs.getString(3);
                String MilesNCRem = rs.getString(4);
                String workerFinNumber = rs.getString(5);
                int jobKey = rs.getInt(6);
                int probKey = rs.getInt(7);
                problemCaseMilestoneNC = new ProblemCaseMilestoneNC(id, workerFinNumber, jobKey, probKey,
                        MilesNCDate, MilesNCReached, MilesNCReachedMore, MilesNCRem);
            }
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemCaseMilestoneNC={" + problemCaseMilestoneNC + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return problemCaseMilestoneNC;
    }

    /**
     * add case milestone non-critical
     * @param problemCaseMilestoneNC case milestone non-critical of problem
     */
    public static void addProblemCaseMilestoneNC(ProblemCaseMilestoneNC problemCaseMilestoneNC) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "INSERT INTO tbl_casemilestone_noncriminal (Miles_nc_date, Miles_nc_reached,"
                    + " Miles_nc_reached_more, Miles_nc_rem,"
                    + "Worker_FIN_number, Job_key, Prob_key) "
                    + "VALUES (?,?,?,?,?,?,?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setDate(1, problemCaseMilestoneNC.getMilesNCDate());
            pstmt.setString(2, problemCaseMilestoneNC.getMilesNCReached());
            pstmt.setString(3, problemCaseMilestoneNC.getMilesNCReachedMore());
            pstmt.setString(4, problemCaseMilestoneNC.getMilesNCRem());
            pstmt.setString(5, problemCaseMilestoneNC.getWorkerFinNumber());
            pstmt.setInt(6, problemCaseMilestoneNC.getJobKey());
            pstmt.setInt(7, problemCaseMilestoneNC.getProblemKey());
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemCaseMilestoneNC: " + problemCaseMilestoneNC + "}");
        } finally {
            ConnectionManager.close(conn, pstmt);
        }
    }

    /**
     * update case milestone non-critical
     * @param problemCaseMilestoneNC case milestone non-critical of problem
     */
    public static void updateProblemCaseMilestoneNC(ProblemCaseMilestoneNC problemCaseMilestoneNC) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_casemilestone_noncriminal SET Miles_nc_date = ? , Miles_nc_reached = ?,"
                    + "Miles_nc_reached_more = ?, Miles_nc_rem = ? "
                    + "WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setDate(1, problemCaseMilestoneNC.getMilesNCDate());
            pstmt.setString(2, problemCaseMilestoneNC.getMilesNCReached());
            pstmt.setString(3, problemCaseMilestoneNC.getMilesNCReachedMore());
            pstmt.setString(4, problemCaseMilestoneNC.getMilesNCRem());
            pstmt.setInt(5, problemCaseMilestoneNC.getId());
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemCaseMilestoneNC={" + problemCaseMilestoneNC + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }
    
     /**
     * delete case milestone non-critical with id
     * @param id case milestone non-critical id
     */
    public static void deleteProblemCaseMilestoneNC(int id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "DELETE FROM tbl_casemilestone_noncriminal WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "Problem CaseMilestone NCR ID={" + id + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }

     /**
     * delete all case milestones non-critical of problem
     */
    public static void deleteAllProblemCaseMilestoneNCs() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            
            sql = "DELETE FROM tbl_casemilestone_noncriminal";
            pstmt = conn.prepareStatement(sql);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "not able to delete data from Problem-tbl_casemilestone_noncriminal Table.");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }     
    }
    
    /*Problem Case Milestone Criminal*/
     /**
     * retrieve case milestone critical ids
     * @param problem problem
     * @return a list of case milestone critical ids
     */
    public static ArrayList<Integer> retrieveProblemCaseMilestoneCRIdsOfProblem(Problem problem) {
        ArrayList<Integer> ids = new ArrayList<Integer>();

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID FROM tbl_casemilestone_criminal where Worker_FIN_number = ? AND Job_key =? "
                    + "AND Prob_key=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, problem.getWorkerFinNum());
            pstmt.setInt(2, problem.getJobKey());
            pstmt.setInt(3, problem.getProbKey());
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                ids.add(id);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }

        return ids;
    }

     /**
     * retrieve case milestone critical with id
     * @param id case milestone critical id
     * @return case milestone critical with id
     */
    public static ProblemCaseMilestoneCR retrieveProblemCaseMilestoneCRById(int id) {
        ProblemCaseMilestoneCR problemCaseMilestoneCR = null;

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Miles_cr_date, Miles_cr_reached,"
                    + " Miles_cr_reached_more, Miles_cr_charges, Miles_cr_sentence, Miles_cr_rem,"
                    + "Worker_FIN_number, Job_key, Prob_key"
                    + " FROM tbl_casemilestone_criminal where ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Date MilesCRDate = rs.getDate(1);
                String MilesCRReached = rs.getString(2);
                String MilesCRReachedMore = rs.getString(3);
                String MilesCRCharges = rs.getString(4);
                String MilesCRSentence = rs.getString(5);
                String MilesCRRem = rs.getString(6);
                String workerFinNumber = rs.getString(7);
                int jobKey = rs.getInt(8);
                int probKey = rs.getInt(9);
                problemCaseMilestoneCR = new ProblemCaseMilestoneCR(id, workerFinNumber, jobKey, probKey,
                        MilesCRDate, MilesCRReached, MilesCRReachedMore, MilesCRCharges, MilesCRSentence, MilesCRRem);
            }
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemCaseMilestoneCR={" + problemCaseMilestoneCR + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return problemCaseMilestoneCR;
    }

    /**
     * add case milestone critical
     * @param problemCaseMilestoneCR case milestone critical of problem
     */
    public static void addProblemCaseMilestoneCR(ProblemCaseMilestoneCR problemCaseMilestoneCR) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "INSERT INTO tbl_casemilestone_criminal (Miles_cr_date, Miles_cr_reached,"
                    + " Miles_cr_reached_more, Miles_cr_charges, Miles_cr_sentence, Miles_cr_rem,"
                    + "Worker_FIN_number, Job_key, Prob_key) "
                    + "VALUES (?,?,?,?,?,?,?,?,?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setDate(1, problemCaseMilestoneCR.getMilesCRDate());
            pstmt.setString(2, problemCaseMilestoneCR.getMilesCRReached());
            pstmt.setString(3, problemCaseMilestoneCR.getMilesCRReachedMore());
            pstmt.setString(4, problemCaseMilestoneCR.getMilesCRCharges());
            pstmt.setString(5, problemCaseMilestoneCR.getMilesCRSentence());
            pstmt.setString(6, problemCaseMilestoneCR.getMilesCRRem());
            pstmt.setString(7, problemCaseMilestoneCR.getWorkerFinNumber());
            pstmt.setInt(8, problemCaseMilestoneCR.getJobKey());
            pstmt.setInt(9, problemCaseMilestoneCR.getProblemKey());
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemCaseMilestoneCR: " + problemCaseMilestoneCR + "}");
        } finally {
            ConnectionManager.close(conn, pstmt);
        }
    }

     /**
     * update case milestone critical
     * @param problemCaseMilestoneCR case milestone critical of problem
     */
    public static void updateProblemCaseMilestoneCR(ProblemCaseMilestoneCR problemCaseMilestoneCR) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_casemilestone_criminal SET Miles_cr_date = ? , Miles_cr_reached = ?,"
                    + "Miles_cr_reached_more = ?, Miles_cr_charges = ?, Miles_cr_sentence= ?, Miles_cr_rem = ? "
                    + "WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setDate(1, problemCaseMilestoneCR.getMilesCRDate());
            pstmt.setString(2, problemCaseMilestoneCR.getMilesCRReached());
            pstmt.setString(3, problemCaseMilestoneCR.getMilesCRReachedMore());
            pstmt.setString(4, problemCaseMilestoneCR.getMilesCRCharges());
            pstmt.setString(5, problemCaseMilestoneCR.getMilesCRSentence());
            pstmt.setString(6, problemCaseMilestoneCR.getMilesCRRem());
            pstmt.setInt(7, problemCaseMilestoneCR.getId());
            
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemCaseMilestoneCR={" + problemCaseMilestoneCR + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }
    
    /**
     * delete case milestone critical with id
     * @param id case milestone critical id
     */
    public static void deleteProblemCaseMilestoneCR(int id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "DELETE FROM tbl_casemilestone_criminal WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemCaseMileStone CR ID={" + id + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }

     /**
     * delete all case milestones critical of problem
     */ 
    public static void deleteAllProblemCaseMilestoneCRs() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            
            sql = "DELETE FROM tbl_casemilestone_criminal";
            pstmt = conn.prepareStatement(sql);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "not able to delete data from Problem-tbl_casemilestone_criminal Table.");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }     
    }
    
    /*Problem TTR*/
    /**
     * retrieve TTR ids
     * @param problem problem
     * @return a list of TTR ids
     */
    public static ArrayList<Integer> retrieveProblemTTRIdsOfProblem(Problem problem) {
        ArrayList<Integer> ids = new ArrayList<Integer>();

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID FROM tbl_ttr where Worker_FIN_number = ? AND Job_key =? "
                    + "AND Prob_key=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, problem.getWorkerFinNum());
            pstmt.setInt(2, problem.getJobKey());
            pstmt.setInt(3, problem.getProbKey());
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                ids.add(id);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }

        return ids;
    }

     /**
     * retrieve TTR with id
     * @param id TTR id
     * @return TTR with id
     */
    public static ProblemTTR retrieveProblemTTRById(int id) {
        ProblemTTR problemTTR = null;

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Ttr_update, Ttr_status,"
                    + " Ttr_status_more, departure_date,"
                    + " Name_new_employer, new_job, Ttr_rem,"
                    + "Worker_FIN_number, Job_key, Prob_key"
                    + " FROM tbl_ttr where ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Date TTRUpdate = rs.getDate(1);
                String TTRStatus = rs.getString(2);
                String TTRStatusMore = rs.getString(3);
                String departureDate = rs.getString(4);
                String newEmployerName = rs.getString(5);
                String newJob = rs.getString(6);
                String TTRRem = rs.getString(7);
                String workerFinNumber = rs.getString(8);
                int jobKey = rs.getInt(9);
                int probKey = rs.getInt(10);
                problemTTR = new ProblemTTR(id, workerFinNumber, jobKey, probKey,
                        TTRUpdate, TTRStatus, TTRStatusMore, departureDate,
                        newEmployerName, newJob, TTRRem);
            }
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemTTR={" + problemTTR + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return problemTTR;
    }

    /**
     * add TTR
     * @param problemTTR TTR of problem
     */
    public static void addProblemTTR(ProblemTTR problemTTR) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "INSERT INTO tbl_ttr (Ttr_update, Ttr_status,"
                    + " Ttr_status_more, departure_date,"
                    + " Name_new_employer, new_job, Ttr_rem,"
                    + "Worker_FIN_number, Job_key, Prob_key) "
                    + "VALUES (?,?,?,?,?,?,?,?,?,?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setDate(1, problemTTR.getTTRUpdate());
            pstmt.setString(2, problemTTR.getTTRStatus());
            pstmt.setString(3, problemTTR.getTTRStatusMore());
            pstmt.setString(4, problemTTR.getDepartureDate());
            pstmt.setString(5, problemTTR.getNewEmployerName());
            pstmt.setString(6, problemTTR.getNewJob());
            pstmt.setString(7, problemTTR.getTTRRem());
            pstmt.setString(8, problemTTR.getWorkerFinNumber());
            pstmt.setInt(9, problemTTR.getJobKey());
            pstmt.setInt(10, problemTTR.getProblemKey());
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemTTR: " + problemTTR + "}");
        } finally {
            ConnectionManager.close(conn, pstmt);
        }
    }

     /**
     * update TTR
     * @param problemTTR TTR of problem
     */
    public static void updateProblemTTR(ProblemTTR problemTTR) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_ttr SET Ttr_update = ? , Ttr_status = ?,"
                    + "Ttr_status_more =?, Departure_date =? , Name_new_employer =?, "
                    + "New_job =?, Ttr_rem =? "
                    + "WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setDate(1, problemTTR.getTTRUpdate());
            pstmt.setString(2, problemTTR.getTTRStatus());
            pstmt.setString(3, problemTTR.getTTRStatusMore());
            pstmt.setString(4, problemTTR.getDepartureDate());
            pstmt.setString(5, problemTTR.getNewEmployerName());
            pstmt.setString(6, problemTTR.getNewJob());
            pstmt.setString(7, problemTTR.getTTRRem());
            pstmt.setInt(8, problemTTR.getId());

            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemTTR={" + problemTTR + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }

     /**
     * delete TTR with id
     * @param id TTR id
     */
    public static void deleteProblemTTR(int id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "DELETE FROM tbl_ttr WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "Problem TTR ID={" + id + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }
    
     /**
     * delete all TTRs of problem
     */
    public static void deleteAllProblemTTRs() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            
            sql = "DELETE FROM tbl_ttr";
            pstmt = conn.prepareStatement(sql);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "not able to delete data from Problem-tbl_ttr Table. ");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }     
    }

    /*general*/
    /**
     * delete all complements of problem
     */
    public static void deleteAll() {
        deleteAllProblemAggravatingIssues();
        deleteAllProblemLeadCaseWorkers();
        deleteAllProblemAuxiliaryCaseWorkers();
        deleteAllProblemSalaryRelatedHistories();
        deleteAllProblemInjuries();
        deleteAllProblemIllness();
        deleteAllProblemtherProblems();
        deleteAllProblemSalaryClaims();
        deleteAllProblemWicas();
        deleteAllProblemWicaClaims();
        deleteAllProblemNonWicaClaims();
        deleteAllProblemPoliceReports();
        deleteAllProblemOtherComplaints();
        deleteAllProblemCaseDiscussions();
        deleteAllProblemHospitals();
        deleteAllProblemMCStatus();
        deleteAllProblemR2Rs();
        deleteAllProblemLawyers();
        deleteAllProblemCaseMilestoneNCs();
        deleteAllProblemCaseMilestoneCRs();
        deleteAllProblemTTRs();
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
