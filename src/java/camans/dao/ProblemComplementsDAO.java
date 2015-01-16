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
       
    public static ArrayList<String> validateAndAddProblemAggravatingIsssue(String probAggravFile) 
            throws IOException{
        
        // Attributes
        ArrayList<String> errList = new ArrayList<String>();
        CSVReader csvReader = null;
        try {
            csvReader = new CSVReader(new FileReader(probAggravFile));
            String[] header = csvReader.readNext();
            String[] fields;
            int lineNum = 1;
            String errorMsg = "";

            // Loops through each line of the csv with an array of String
            while ((fields = csvReader.readNext()) != null) {
                lineNum++;
                // Assigning each field with its appropriate name
                String finNum = fields[0].trim();
                String jobKeyStr = fields[1].trim();
                String probKeyStr = fields[2].trim();
                String aggraIssue = fields[3].trim();
                String aggraIssueMore = fields[4].trim();
                String aggraLossStr = fields[5].trim();
                String aggraRemark = fields[6].trim();
                
                int jobKey = 0;
                int probKey = 0;
                double aggraLoss = 0;
                /**
                 * Validations for empty fields
                 */
                boolean pass = true; //assume validation pass first;
                if (finNum.equals("")) {
                    errorMsg += header[0] + " is blank,";
                    pass = false;
                }
                
                if (jobKeyStr.equals("")) {
                    errorMsg += header[1] + " is blank,";
                    pass = false;
                }
                if (probKeyStr.equals("")) {
                    errorMsg += header[2] + " is blank,";
                    pass = false;
                }
                if (aggraIssue.equals("")) {
                    errorMsg += header[3] + " is blank,";
                    pass = false;
                }

                //proceed only after empty fields validation is passed
                if (pass) { 

                    // check for any existing worker  with the same finNum. 
                    Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                    if (worker == null) {
                        errorMsg += "invalid FinNumber, ";
                    }
                    
                    try {
                        jobKey = Integer.parseInt(jobKeyStr);
                        Job job = JobDAO.retrieveJobByJobId(jobKey);
                        if (job == null) {
                            errorMsg += "invalid job key, ";
                        } else {
                            if (worker != null && 
                                    !(worker.getFinNumber().equals(job.getWorkerFinNum()))) {
                                errorMsg += "invalid finNumber for this job key, ";
                            }
                        }
                    } catch (Exception ex) {
                        errorMsg += "invalid job key, ";
                    }
                    
                    try {
                        probKey = Integer.parseInt(probKeyStr);
                        Problem problem = ProblemDAO.retrieveProblemByProblemId(probKey);
                        if (problem == null) {
                            errorMsg += "invalid problem key, ";
                        } else {
                            if (worker != null && 
                                    !(worker.getFinNumber().equals(problem.getWorkerFinNum()))) {
                                errorMsg += "invalid finNumber for this problem key, ";
                            }
                        }
                    } catch (Exception ex) {
                        errorMsg += "invalid problem key, ";
                    }
                    
                    ArrayList<String> list = DropdownDAO.retrieveAllDropdownListOfProblems();
                    boolean exit = false;
                    for (String tmp: list) {
                        if (tmp.equalsIgnoreCase(aggraIssue)) {
                            exit = true;
                            break;
                        }
                    }
                    
                    if (!exit) {
                        errorMsg += "invalid Aggravating Issue Type, ";
                    }
                    
                    if (!aggraIssueMore.equals("") && aggraIssueMore.length() > 50){
                        errorMsg += header[4] + " cannot be more than 50 characters,";
                    }
                    
                    if (!aggraLossStr.equals("") && !aggraLossStr.matches("^[0-9]+(//.[0-9]{1,2})?$")) {
                        errorMsg += header[5] + " must have maximum 2 decimal places,";
                    } else {
                        try {
                            aggraLoss = Double.parseDouble(aggraLossStr);
                        } catch (Exception ex) {
                            errorMsg += header[5] + " - invalid format,";
                        }
                    }
                    
                    if (!aggraRemark.equals("") && aggraRemark.length() > 200) {
                        errorMsg += header[6] + " cannot be longer than 200 characters,";
                    }

                }   //pass 

                // if there is an error, the line number of the error and its relevant message is 
                // added into the errorList
                if (!errorMsg.equals("")) {
                    errList.add(lineNum + ":" + errorMsg);
                    errorMsg = ""; // reset errorMsg variable
                } // if there is no error, a new Worker object is created and added to the workerList
                else {
                    errorMsg = ""; // reset errorMsg variable
                    ProblemAggravatingIssue problemAggravatingIssue = new ProblemAggravatingIssue
                            (finNum, jobKey, probKey, aggraIssue, aggraIssueMore, aggraLoss, aggraRemark);
                    addProblemAggravatingIssue(problemAggravatingIssue);
                }    
            }
            csvReader.close();
        } catch (FileNotFoundException ex) {
            //fileNotFoundExcepton
        }
        return errList;
    }
     
    /*Problem Lead Case Worker*/
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
     *
     * @param problemLeadCaseWorker
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
    
    public static ArrayList<String> validateAndAddLeadCaseWorker(String leadCaseWorkerFile) throws IOException {
        //attributes
        ArrayList<String> errList = new ArrayList<String>();
        CSVReader csvReader = null;
        
        try {
            csvReader = new CSVReader(new FileReader(leadCaseWorkerFile));
            String[] header = csvReader.readNext();
            String[] fields;
            int lineNum = 1;
            String errorMsg = "";
            
            //loop through each line of the csv with an array of String
            while ((fields=csvReader.readNext()) != null) {
                lineNum++;
                //assigning each field with its approriate name
                String finNum = fields[0].trim();
                String jobKeyStr = fields[1].trim();
                String probKeyStr = fields[2].trim();
                String leadName = fields[3].trim();
                String leadStartStr = fields[4].trim();
                String leadEndStr = fields[5].trim();
                
                int jobKey = 0;
                int probKey = 0;
                java.sql.Date leadStart = null;
                java.sql.Date leadEnd = null;
                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                
                //validations for emplty fields
                boolean pass = true;
                if(finNum.equals("")) {
                    errorMsg += header[0]+" is blank,";
                    pass = false;
                }
                
                if (jobKeyStr.equals("")) {
                    errorMsg += header[1]+" is blank,";
                    pass = false;
                }
                
                if (probKeyStr.equals("")) {
                    errorMsg += header[2]+" is blank,";
                    pass = false;
                }
                
                if (leadName.equals("")) {
                    errorMsg += header[3]+" is blank,";
                    pass = false;
                }
                
                //proceed only after empty fields validation is passed
                if (pass) {
                    //check for any existing worker with the same finNum
                    Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                    if (worker==null) {
                        errorMsg += "invalid FinNumber,";
                    }
                    
                    try {
                        jobKey = Integer.parseInt(jobKeyStr);
                        Job job = JobDAO.retrieveJobByJobId(jobKey);
                        if (job==null) {
                            errorMsg += "invalid job key,";
                        } else {
                            if(worker!=null &&
                            !(worker.getFinNumber().equals(job.getWorkerFinNum()))) {
                                errorMsg += "invalid FinNumber for this job key,";
                            }
                        }
                    } catch (Exception ex) {
                        errorMsg += "invalid job key,";
                    }
                    
                    try {
                        probKey = Integer.parseInt(probKeyStr);
                        Problem problem = ProblemDAO.retrieveProblemByProblemId(probKey);
                        if(problem==null) {
                            errorMsg += "invalid problem key,";
                        } else {
                            if(worker!=null &&
                            !(worker.getFinNumber().equals(problem.getWorkerFinNum()))) {
                                errorMsg += "invalid finNumber for this problem key,";
                            }
                        }
                    } catch (Exception ex) {
                        errorMsg += "invalid problem key,";
                    }
                
                    //dropdown list of existing users
                    ArrayList<String> list = DropdownDAO.retrieveAllDropdownListOfCaseworkers();
                    boolean exit = false;
                    for(String tmp:list) {
                        if (tmp.equalsIgnoreCase(leadName)) {
                            exit=true;
                            break;
                        }
                    }
                    
                    if(!exit) {
                        errorMsg += "invalid job key,";
                    }
                    
                    if (!leadStartStr.equals("")) {
                        try {
                            java.util.Date tmp = sdf.parse(leadStartStr);
                            leadStart = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                            errorMsg += "Invalid leadStart Date Format,";
                        } 
                    }
                    
                    if (!leadEndStr.equals("")) {
                        try {
                            java.util.Date tmp = sdf.parse(leadEndStr);
                            leadEnd = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                            errorMsg += "Invalid leadEnd Date Format,";
                        } 
                    }
                } //pass
                
                // if there is an error, the line number of the error and its relevant message is added into the errorList
                
                if (!errorMsg.equals("")) {
                    errList.add(lineNum + ":" + errorMsg);
                    errorMsg = ""; // reset errorMsg variable
                } // if there is no error, a new Worker object is created and added to the workerList
                else {
                    errorMsg = ""; // reset errorMsg variable
                    ProblemLeadCaseWorker problemLeadCaseWorker = new ProblemLeadCaseWorker
                            (finNum, jobKey, probKey, leadName, leadStart, leadEnd );
                    addProblemLeadCaseWorker(problemLeadCaseWorker);
                }    
            }
            csvReader.close();
        } catch (FileNotFoundException ex) {
            //fileNotFoundExcepton
        }
        return errList;
    }
    
    /*Problem Auxiliary CaseWorker*/
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
    
    public static ArrayList<String> validateAndAddAuxiliaryCaseWorker(String auxiliaryCaseWorkerFile) throws IOException {
        //attributes
        ArrayList<String> errList = new ArrayList<String>();
        CSVReader csvReader = null;
        
        try {
            csvReader = new CSVReader(new FileReader(auxiliaryCaseWorkerFile));
            String[] header = csvReader.readNext();
            String[] fields;
            int lineNum = 1;
            String errorMsg = "";
            
            //loop through each line of the csv with an array of String
            while ((fields=csvReader.readNext()) != null) {
                lineNum++;
                //assigning each field with its approriate name
                String finNum = fields[0].trim();
                String jobKeyStr = fields[1].trim();
                String probKeyStr = fields[2].trim();
                String auxName = fields[3].trim();
                String auxStartStr = fields[4].trim();
                String auxEndStr = fields[5].trim();
                
                int jobKey = 0;
                int probKey = 0;
                java.sql.Date auxStart = null;
                java.sql.Date auxEnd = null;
                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                
                //validations for emplty fields
                boolean pass = true;
                if(finNum.equals("")) {
                    errorMsg += header[0]+" is blank,";
                    pass = false;
                }
                
                if (jobKeyStr.equals("")) {
                    errorMsg += header[1]+" is blank,";
                    pass = false;
                }
                
                if (probKeyStr.equals("")) {
                    errorMsg += header[2]+" is blank,";
                    pass = false;
                }
                
                if (auxName.equals("")) {
                    errorMsg += header[3]+" is blank,";
                    pass = false;
                }
                
                //proceed only after empty fields validation is passed
                if (pass) {
                    //check for any existing worker with the same finNum
                    Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                    if (worker==null) {
                        errorMsg += "invalid FinNumber,";
                    }
                    
                    try {
                        jobKey = Integer.parseInt(jobKeyStr);
                        Job job = JobDAO.retrieveJobByJobId(jobKey);
                        if (job==null) {
                            errorMsg += "invalid job key,";
                        } else {
                            if(worker!=null &&
                            !(worker.getFinNumber().equals(job.getWorkerFinNum()))) {
                                errorMsg += "invalid FinNumber for this job key,";
                            }
                        }
                    } catch (Exception ex) {
                        errorMsg += "invalid job key,";
                    }
                    
                    try {
                        probKey = Integer.parseInt(probKeyStr);
                        Problem problem = ProblemDAO.retrieveProblemByProblemId(probKey);
                        if(problem==null) {
                            errorMsg += "invalid problem key,";
                        } else {
                            if(worker!=null &&
                            !(worker.getFinNumber().equals(problem.getWorkerFinNum()))) {
                                errorMsg += "invalid finNumber for this problem key,";
                            }
                        }
                    } catch (Exception ex) {
                        errorMsg += "invalid problem key,";
                    }
                
                    //dropdown list of existing users
                    ArrayList<String> list = DropdownDAO.retrieveAllDropdownListOfCaseworkers();
                    boolean exit = false;
                    for(String tmp:list) {
                        if (tmp.equalsIgnoreCase(auxName)) {
                            exit=true;
                            break;
                        }
                    }
                    
                    if(!exit) {
                        errorMsg += "invalid job key,";
                    }
                    
                    if (!auxStartStr.equals("")) {
                        try {
                            java.util.Date tmp = sdf.parse(auxStartStr);
                            auxStart = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                            errorMsg += "Invalid auxStart Date Format,";
                        } 
                    }
                    
                    if (!auxEndStr.equals("")) {
                        try {
                            java.util.Date tmp = sdf.parse(auxEndStr);
                            auxEnd = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                            errorMsg += "Invalid auxEnd Date Format,";
                        } 
                    }
                } //pass
                
                // if there is an error, the line number of the error and its relevant message is added into the errorList
                
                if (!errorMsg.equals("")) {
                    errList.add(lineNum + ":" + errorMsg);
                    errorMsg = ""; // reset errorMsg variable
                } // if there is no error, a new Worker object is created and added to the workerList
                else {
                    errorMsg = ""; // reset errorMsg variable
                    ProblemAuxiliaryCaseWorker problemAuxiliaryCaseWorker = new ProblemAuxiliaryCaseWorker
                            (finNum, jobKey, probKey, auxName, auxStart, auxEnd );
                    addProblemAuxiliaryCaseWorker(problemAuxiliaryCaseWorker);
                }    
            }
            csvReader.close();
        } catch (FileNotFoundException ex) {
            //fileNotFoundExcepton
        }
        return errList;
    }
    
    /*Problem Salary Related History*/
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

    public static ArrayList<String> validateAndAddProblemSalaryRelatedHistory(String probSalaryRelatedHistoryFile) 
    throws IOException {
        // Attributes
        ArrayList<String> errList = new ArrayList<String>();
        CSVReader csvReader = null;
        try {
            csvReader = new CSVReader(new FileReader(probSalaryRelatedHistoryFile));
            String[] header = csvReader.readNext();
            String[] fields;
            int lineNum = 1;
            String errorMsg = "";

            // Loops through each line of the csv with an array of String
            while ((fields = csvReader.readNext()) != null) {
                lineNum++;
                // Assigning each field with its appropriate name
                String finNum = fields[0].trim();
                String jobKeyStr = fields[1].trim();
                String probKeyStr = fields[2].trim();
                String salHistBasic = fields[3].trim();
                String salHistOT = fields[4].trim();
                String salHistAllowances = fields[5].trim();
                String salHistDeductions = fields[6].trim();
                String salHistKickbacks = fields[7].trim();
                String salHistOther = fields[8].trim();
                String salMode = fields[9].trim();
                String salModeMore = fields[10].trim();
                String salLossTotalStr = fields[11].trim();
                String salLoss1YrStr = fields[12].trim();
                String salHistRem = fields[13].trim();
                
                int jobKey = 0;
                int probKey = 0;
                double salLossTotal = 0;
                double salLoss1Yr = 0;
                /**
                 * Validations for empty fields
                 */
                boolean pass = true; //assume validation pass first;
                if (finNum.equals("")) {
                    errorMsg += header[0] + " is blank,";
                    pass = false;
                }
                
                if (jobKeyStr.equals("")) {
                    errorMsg += header[1] + " is blank,";
                    pass = false;
                }
                
                if (probKeyStr.equals("")) {
                    errorMsg += header[2] + " is blank,";
                    pass = false;
                }
                
                if (salHistBasic.equals("")) {
                    errorMsg += header[3] + " is blank,";
                    pass = false;
                }
                
                //proceed only after empty fields validation is passed
                if (pass) { 

                    // check for any existing worker  with the same finNum. 
                    Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                    if (worker == null) {
                        errorMsg += "invalid FinNumber, ";
                    }
                    
                    try {
                        jobKey = Integer.parseInt(jobKeyStr);
                        Job job = JobDAO.retrieveJobByJobId(jobKey);
                        if (job == null) {
                            errorMsg += "invalid job key, ";
                        } else {
                            if (worker != null && 
                                    !(worker.getFinNumber().equals(job.getWorkerFinNum()))) {
                                errorMsg += "invalid finNumber for this job key, ";
                            }
                        }
                    } catch (Exception ex) {
                        errorMsg += "invalid job key, ";
                    }
                    
                    try {
                        probKey = Integer.parseInt(probKeyStr);
                        Problem problem = ProblemDAO.retrieveProblemByProblemId(probKey);
                        if (problem == null) {
                            errorMsg += "invalid problem key, ";
                        } else {
                            if (worker != null && 
                                    !(worker.getFinNumber().equals(problem.getWorkerFinNum()))) {
                                errorMsg += "invalid finNumber for this problem key, ";
                            }
                        }
                    } catch (Exception ex) {
                        errorMsg += "invalid problem key, ";
                    }
                    
                    ArrayList<String> list = DropdownDAO.retrieveAllDropdownListOfSalaryMode();
                    boolean exit = false;
                    for (String tmp: list) {
                        if (tmp.equalsIgnoreCase(salMode)) {
                            exit = true;
                            break;
                        }
                    }
                    
                    if (!exit) {
                        errorMsg += "invalid salary payment mode, ";
                    }
                    
                    if (!salHistOT.equals("") && salHistOT.length() > 500){
                        errorMsg += header[4] + " cannot be more than 500 characters,";
                    }
                    
                    if (!salHistAllowances.equals("") && salHistAllowances.length() > 500){
                        errorMsg += header[5] + " cannot be more than 500 characters,";
                    }
                    
                    if (!salHistDeductions.equals("") && salHistDeductions.length() > 500){
                        errorMsg += header[6] + " cannot be more than 500 characters,";
                    }
                    
                    if (!salHistKickbacks.equals("") && salHistKickbacks.length() > 500){
                        errorMsg += header[7] + " cannot be more than 500 characters,";
                    }
                    
                    if (!salHistOther.equals("") && salHistOther.length() > 500){
                        errorMsg += header[8] + " cannot be more than 500 characters,";
                    }
                    
                    if (!salModeMore.equals("") && salModeMore.length() > 50){
                        errorMsg += header[10] + " cannot be more than 50 characters,";
                    }
                    
                    if (!salLossTotalStr.equals("") && salLossTotalStr.matches("^[0-9]+(//.[0-9]{1,2})?$")){
                        errorMsg += header[11] + " must have maximum 2 decimal places,";
                    } else {
                        try {
                            salLossTotal = Double.parseDouble(salLossTotalStr);
                        } catch (Exception ex) {
                            errorMsg += header[11] + " - invalid format,";
                        }
                    }
                    
                    if (!salLoss1YrStr.equals("") && salLoss1YrStr.matches("^[0-9]+(//.[0-9]{1,2})?$")){
                        errorMsg += header[12] + " must have maximum 2 decimal places,";
                    } else {
                        try {
                            salLoss1Yr = Double.parseDouble(salLoss1YrStr);
                        } catch (Exception ex) {
                            errorMsg += header[12] + " - invalid format,";
                        }
                    }
                    
                    if (!salHistRem.equals("") && salHistRem.length() > 200){
                        errorMsg += header[13] + " cannot be more than 200 characters,";
                    }
                } //pass
                
                // if there is an error, the line number of the error and its relevant message is 
                // added into the errorList
                if (!errorMsg.equals("")) {
                    errList.add(lineNum + ":" + errorMsg);
                    errorMsg = ""; // reset errorMsg variable
                } // if there is no error, a new Worker object is created and added to the workerList
                else {
                    errorMsg = ""; // reset errorMsg variable
                    ProblemSalaryRelatedHistory problemSalaryRelatedHistory = new ProblemSalaryRelatedHistory
                            (finNum, jobKey, probKey, salHistBasic, salHistOT, salHistAllowances, salHistDeductions,
                            salHistKickbacks, salHistOther, salMode, salModeMore, salLossTotal, salLoss1Yr, salHistRem);
                    addProblemSalaryRelatedHistory(problemSalaryRelatedHistory);
                }
            }
            csvReader.close();
        } catch (FileNotFoundException ex) {
            //fileNotFoundExcepton
        }
        return errList;
    }
    
    /*Problem Injury*/
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

    public static ArrayList<String> validateAndAddProblemInjury(String problemInjuryFile) 
            throws IOException{
        
        // Attributes
        ArrayList<String> errList = new ArrayList<String>();
        CSVReader csvReader = null;
        try {
            csvReader = new CSVReader(new FileReader(problemInjuryFile));
            String[] header = csvReader.readNext();
            String[] fields;
            int lineNum = 1;
            String errorMsg = "";

            // Loops through each line of the csv with an array of String
            while ((fields = csvReader.readNext()) != null) {
                lineNum++;
                // Assigning each field with its appropriate name
                String finNum = fields[0].trim();
                String jobKeyStr = fields[1].trim();
                String probKeyStr = fields[2].trim();
                String injDateStr = fields[3].trim();
                String injTime = fields[4].trim();
                String injLocation = fields[5].trim();
                String injDeath = fields[6].trim();
                String injBodypart = fields[7].trim();
                String injHow = fields[8].trim();
                String injAmbulance = fields[9].trim();
                String injInitialTreatment = fields[10].trim();
                String injWorkRelated = fields[11].trim();
                String injRem = fields[12].trim();
                
                int jobKey = 0;
                int probKey = 0;
                java.sql.Date injDate = null;
                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                /**
                 * Validations for empty fields
                 */
                boolean pass = true; //assume validation pass first;
                if (finNum.equals("")) {
                    errorMsg += header[1] + " is blank,";
                    pass = false;
                }

                if (jobKeyStr.equals("")) {
                    errorMsg += header[1] + " is blank,";
                    pass = false;
                }
                
                if (injDateStr.equals("")) {
                    errorMsg += header[2] + " is blank,";
                    pass = false;
                }

                //proceed only after empty fields validation is passed
                if (pass) { 

                    // check for any existing worker  with the same finNum. 
                    Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                    if (worker == null) {
                        errorMsg += "invalid FinNumber, ";
                    }

                    try {
                        jobKey = Integer.parseInt(jobKeyStr);
                        Job job = JobDAO.retrieveJobByJobId(jobKey);
                        if (job == null) {
                            errorMsg += "invalid jobkey, ";
                        } else {
                            if (worker != null && 
                                    !(worker.getFinNumber().equals(job.getWorkerFinNum()))) {
                                errorMsg += "invalid finNumber for this jobkey, ";
                            }
                        }
                    } catch (Exception ex) {
                        errorMsg += "invalid job key, ";
                    }
                    
                    try {
                        probKey = Integer.parseInt(probKeyStr);
                        Problem problem = ProblemDAO.retrieveProblemByProblemId(probKey);
                        if (problem == null) {
                            errorMsg += "invalid problem key, ";
                        } else {
                            if (worker != null && 
                                    !(worker.getFinNumber().equals(problem.getWorkerFinNum()))) {
                                errorMsg += "invalid finNumber for this problem key, ";
                            }
                        }
                    } catch (Exception ex) {
                        errorMsg += "invalid problem key, ";
                    }
                    
                    if (!injDateStr.equals("")) {
                        try {
                            java.util.Date tmp = sdf.parse(injDateStr);
                            injDate = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                            errorMsg += "Invalid injury Date Format,";
                        } 
                    }
                    
                    if (!injTime.equals("") && injTime.length() > 20){
                        errorMsg += header[5] + " cannot be more than 20 characters,";
                    }
                    
                    if (!injLocation.equals("") && injLocation.length() > 200){
                        errorMsg += header[6] + " cannot be more than 200 characters,";
                    }
                    
                    if (!injDeath.equals("")) {
                        if (injDeath.equals("Yes") || injDeath.equals("No")) {
                            
                        } else {
                            errorMsg += header[7] + " must be either 'Yes' or 'No'";
                        }
                    }
                    
                    if (!injBodypart.equals("") && injBodypart.length() > 500){
                        errorMsg += header[8] + " cannot be more than 500 characters,";
                    }
                    
                    if (!injHow.equals("") && injHow.length() > 1000){
                        errorMsg += header[9] + " cannot be more than 1000 characters,";
                    }
                    
                    if (!injAmbulance.equals("")) {
                        if (injAmbulance.equals("Yes") || injAmbulance.equals("No") || 
                                injAmbulance.equals("Don't know")) {
                            
                        } else {
                            errorMsg += header[10] + " must be either 'Yes' or 'No' or 'Don't know";
                        }
                    }
                    
                    if (!injInitialTreatment.equals("") && injInitialTreatment.length() > 200){
                        errorMsg += header[11] + " cannot be more than 200 characters,";
                    }
                    
                    if (!injWorkRelated.equals("")) {
                        if (injWorkRelated.equals("Yes") || injWorkRelated.equals("No") ||
                                injWorkRelated.equals("Don't know")) {
                            
                        } else {
                            errorMsg += header[12] + " must be either 'Yes' or 'No' or 'Don't know";
                        }
                    }
                    
                    if (!injRem.equals("") && injRem.length() > 200){
                        errorMsg += header[13] + " cannot be more than 200 characters,";
                    }
                } //pass
                
                // if there is an error, the line number of the error and its relevant message is 
                // added into the errorList
                if (!errorMsg.equals("")) {
                    errList.add(lineNum + ":" + errorMsg);
                    errorMsg = ""; // reset errorMsg variable
                } // if there is no error, a new Worker object is created and added to the workerList
                else {
                    errorMsg = ""; // reset errorMsg variable
                    ProblemInjury problemInjury = new ProblemInjury
                            (finNum, jobKey, probKey, injDate, injTime, injLocation, injDeath, injBodypart,
                            injHow, injAmbulance, injInitialTreatment, null, injWorkRelated, injRem);
                    addProblemInjury(problemInjury);
                }    
            }
            
            csvReader.close();
        } catch (FileNotFoundException ex) {
            //fileNotFoundExcepton
        }
        return errList;
    }

    /*Problem Illness*/
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
    
    public static ArrayList<String> validateAndAddProblemIllness(String problemIllnessFile) 
            throws IOException{
        
        // Attributes
        ArrayList<String> errList = new ArrayList<String>();
        CSVReader csvReader = null;
        try {
            csvReader = new CSVReader(new FileReader(problemIllnessFile));
            String[] header = csvReader.readNext();
            String[] fields;
            int lineNum = 1;
            String errorMsg = "";

            // Loops through each line of the csv with an array of String
            while ((fields = csvReader.readNext()) != null) {
                lineNum++;
                // Assigning each field with its appropriate name
                String finNum = fields[0].trim();
                String jobKeyStr = fields[1].trim();
                String probKeyStr = fields[2].trim();
                String illnessStartWhen = fields[3].trim();
                String illnessDiagWhen = fields[4].trim();
                String illnessDiagWho = fields[5].trim();
                String illnessNature = fields[6].trim();
                String illnessWorkRelated = fields[7].trim();
                String illnessWhy = fields[8].trim();
                String illnessRem = fields[9].trim();
                
                int jobKey = 0;
                int probKey = 0;
                
                /**
                 * Validations for empty fields
                 */
                boolean pass = true; //assume validation pass first;
                if (finNum.equals("")) {
                    errorMsg += header[0] + " is blank,";
                    pass = false;
                }
                
                if (jobKeyStr.equals("")) {
                    errorMsg += header[1] + " is blank,";
                    pass = false;
                }
                
                if (probKeyStr.equals("")) {
                    errorMsg += header[2] + " is blank,";
                    pass = false;
                }
                
                if (illnessStartWhen.equals("")) {
                    errorMsg += header[3] + " is blank,";
                    pass = false;
                }
                
                //proceed only after empty fields validation is passed
                if (pass) { 

                    // check for any existing worker  with the same finNum. 
                    Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                    if (worker == null) {
                        errorMsg += "invalid FinNumber, ";
                    }
                    
                    try {
                        jobKey = Integer.parseInt(jobKeyStr);
                        Job job = JobDAO.retrieveJobByJobId(jobKey);
                        if (job == null) {
                            errorMsg += "invalid job key, ";
                        } else {
                            if (worker != null && 
                                    !(worker.getFinNumber().equals(job.getWorkerFinNum()))) {
                                errorMsg += "invalid finNumber for this job key, ";
                            }
                        }
                    } catch (Exception ex) {
                        errorMsg += "invalid job key, ";
                    }
                    
                    try {
                        probKey = Integer.parseInt(probKeyStr);
                        Problem problem = ProblemDAO.retrieveProblemByProblemId(probKey);
                        if (problem == null) {
                            errorMsg += "invalid problem key, ";
                        } else {
                            if (worker != null && 
                                    !(worker.getFinNumber().equals(problem.getWorkerFinNum()))) {
                                errorMsg += "invalid finNumber for this problem key, ";
                            }
                        }
                    } catch (Exception ex) {
                        errorMsg += "invalid problem key, ";
                    }
                    
                    if (!illnessStartWhen.equals("") && illnessStartWhen.length() > 50){
                        errorMsg += header[3] + " cannot be more than 50 characters,";
                    }
                    
                    if (!illnessDiagWhen.equals("") && illnessDiagWhen.length() > 50){
                        errorMsg += header[4] + " cannot be more than 50 characters,";
                    }
                    
                    if (!illnessDiagWho.equals("") && illnessDiagWho.length() > 200){
                        errorMsg += header[5] + " cannot be more than 200 characters,";
                    }
                    
                    if (!illnessNature.equals("") && illnessNature.length() > 200){
                        errorMsg += header[6] + " cannot be more than 200 characters,";
                    }
                    
                    if (!illnessWorkRelated.equals("")) {
                        if (illnessWorkRelated.equals("Yes") || illnessWorkRelated.equals("No")
                                || illnessWorkRelated.equals("Don't know")) {
                            
                        } else {
                            errorMsg += header[7] + " must be either 'Yes' or 'No' or 'Don't know";
                        }
                    }
                    
                    if (!illnessWhy.equals("") && illnessWhy.length() > 500){
                        errorMsg += header[8] + " cannot be more than 500 characters,";
                    }
                    
                    if (!illnessRem.equals("") && illnessRem.length() > 200){
                        errorMsg += header[8] + " cannot be more than 200 characters,";
                    }
                } //pass
                
                // if there is an error, the line number of the error and its relevant message is 
                // added into the errorList
                if (!errorMsg.equals("")) {
                    errList.add(lineNum + ":" + errorMsg);
                    errorMsg = ""; // reset errorMsg variable
                } // if there is no error, a new Worker object is created and added to the workerList
                else {
                    errorMsg = ""; // reset errorMsg variable
                    ProblemIllness problemIllness = new ProblemIllness
                            (finNum, jobKey, probKey, illnessStartWhen, illnessDiagWhen, illnessDiagWho,
                            illnessNature, illnessWorkRelated, illnessWhy, illnessRem);
                    addProblemIllness(problemIllness);
                }    
            }
            csvReader.close();
        } catch (FileNotFoundException ex) {
            //fileNotFoundExcepton
        }
        return errList;
    }

    /*Problem Other Problem*/
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
    
    public static ArrayList<String> validateAndAddProblemOtherProblems(String problemOtherProblemsFile) 
            throws IOException{
        
        // Attributes
        ArrayList<String> errList = new ArrayList<String>();
        CSVReader csvReader = null;
        try {
            csvReader = new CSVReader(new FileReader(problemOtherProblemsFile));
            String[] header = csvReader.readNext();
            String[] fields;
            int lineNum = 1;
            String errorMsg = "";

            // Loops through each line of the csv with an array of String
            while ((fields = csvReader.readNext()) != null) {
                lineNum++;
                // Assigning each field with its appropriate name
                String finNum = fields[0].trim();
                String jobKeyStr = fields[1].trim();
                String probKeyStr = fields[2].trim();
                String othProblemDesc = fields[3].trim();
                String othProblemLossStr = fields[4].trim();
                String othProblemRem = fields[5].trim();
                
                int jobKey = 0;
                int probKey = 0;
                int othProblemLoss = 0;
                /**
                 * Validations for empty fields
                 */
                boolean pass = true; //assume validation pass first;
                if (finNum.equals("")) {
                    errorMsg += header[0] + " is blank,";
                    pass = false;
                }
                
                if (jobKeyStr.equals("")) {
                    errorMsg += header[1] + " is blank,";
                    pass = false;
                }

                if (probKeyStr.equals("")) {
                    errorMsg += header[2] + " is blank,";
                    pass = false;
                }

                if (othProblemDesc.equals("")) {
                    errorMsg += header[3] + " is blank,";
                    pass = false;
                }
                
                //proceed only after empty fields validation is passed
                if (pass) { 

                    // check for any existing worker  with the same finNum. 
                    Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                    if (worker == null) {
                        errorMsg += "invalid FinNumber, ";
                    }
                    
                    try {
                        jobKey = Integer.parseInt(jobKeyStr);
                        Job job = JobDAO.retrieveJobByJobId(jobKey);
                        if (job == null) {
                            errorMsg += "invalid job key, ";
                        } else {
                            if (worker != null && 
                                    !(worker.getFinNumber().equals(job.getWorkerFinNum()))) {
                                errorMsg += "invalid finNumber for this job key, ";
                            }
                        }
                    } catch (Exception ex) {
                        errorMsg += "invalid job key, ";
                    }
                    
                    try {
                        probKey = Integer.parseInt(probKeyStr);
                        Problem problem = ProblemDAO.retrieveProblemByProblemId(probKey);
                        if (problem == null) {
                            errorMsg += "invalid problem key, ";
                        } else {
                            if (worker != null && 
                                    !(worker.getFinNumber().equals(problem.getWorkerFinNum()))) {
                                errorMsg += "invalid finNumber for this problem key, ";
                            }
                        }
                    } catch (Exception ex) {
                        errorMsg += "invalid problem key, ";
                    }
                    
                    if (!othProblemDesc.equals("") && othProblemDesc.length() > 1000){
                        errorMsg += header[3] + " cannot be more than 1000 characters,";
                    }
                    
                    if (!othProblemLossStr.equals("")) {
                        try {
                            othProblemLoss = Integer.parseInt(othProblemLossStr);
                        } catch (Exception ex) {
                            errorMsg += header[4] + " - invalid format,";
                        }
                    }
                    
                    if (!othProblemRem.equals("") && othProblemRem.length() > 200) {
                        errorMsg += header[5] + " cannot be longer than 200 characters,";
                    }

                }   //pass 
                
                // if there is an error, the line number of the error and its relevant message is 
                // added into the errorList
                if (!errorMsg.equals("")) {
                    errList.add(lineNum + ":" + errorMsg);
                    errorMsg = ""; // reset errorMsg variable
                } // if there is no error, a new Worker object is created and added to the workerList
                else {
                    errorMsg = ""; // reset errorMsg variable
                    ProblemOtherProblems problemOtherProblems = new ProblemOtherProblems
                            (finNum, jobKey, probKey, othProblemDesc, othProblemLoss, othProblemRem);
                    addProblemOtherProblems(problemOtherProblems);
                }    
            }
            csvReader.close();
        } catch (FileNotFoundException ex) {
            //fileNotFoundExcepton
        }
        return errList;
    }
    
    /*Problem salary claim Issue*/
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
    
    public static ArrayList<String> validateAndAddProblemSalaryClaim(String problemSalaryClaimFile) 
            throws IOException{
        
        // Attributes
        ArrayList<String> errList = new ArrayList<String>();
        CSVReader csvReader = null;
        try {
            csvReader = new CSVReader(new FileReader(problemSalaryClaimFile));
            String[] header = csvReader.readNext();
            String[] fields;
            int lineNum = 1;
            String errorMsg = "";

            // Loops through each line of the csv with an array of String
            while ((fields = csvReader.readNext()) != null) {
                lineNum++;
                // Assigning each field with its appropriate name
                String finNum = fields[0].trim();
                String jobKeyStr = fields[1].trim();
                String probKeyStr = fields[2].trim();
                String salClaimDateStr = fields[3].trim();
                String salClaimLossStr = fields[4].trim();
                String salClaimBasis = fields[5].trim();
                
                int jobKey = 0;
                int probKey = 0;
                java.sql.Date salClaimDate = null;
                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                double salClaimLoss = 0;
                /**
                 * Validations for empty fields
                 */
                boolean pass = true; //assume validation pass first;
                if (finNum.equals("")) {
                    errorMsg += header[0] + " is blank,";
                    pass = false;
                }
                
                if (jobKeyStr.equals("")) {
                    errorMsg += header[1] + " is blank,";
                    pass = false;
                }

                if (probKeyStr.equals("")) {
                    errorMsg += header[2] + " is blank,";
                    pass = false;
                }

                if (salClaimDateStr.equals("")) {
                    errorMsg += header[3] + " is blank,";
                    pass = false;
                }
                
                //proceed only after empty fields validation is passed
                if (pass) { 

                    // check for any existing worker  with the same finNum. 
                    Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                    if (worker == null) {
                        errorMsg += "invalid FinNumber, ";
                    }
                    
                    try {
                        jobKey = Integer.parseInt(jobKeyStr);
                        Job job = JobDAO.retrieveJobByJobId(jobKey);
                        if (job == null) {
                            errorMsg += "invalid jobkey, ";
                        } else {
                            if (worker != null && 
                                    !(worker.getFinNumber().equals(job.getWorkerFinNum()))) {
                                errorMsg += "invalid finNumber for this jobkey, ";
                            }
                        }
                    } catch (Exception ex) {
                        errorMsg += "invalid job key, ";
                    }
                    
                    try {
                        probKey = Integer.parseInt(probKeyStr);
                        Problem problem = ProblemDAO.retrieveProblemByProblemId(probKey);
                        if (problem == null) {
                            errorMsg += "invalid problem key, ";
                        } else {
                            if (worker != null && 
                                    !(worker.getFinNumber().equals(problem.getWorkerFinNum()))) {
                                errorMsg += "invalid finNumber for this problem key, ";
                            }
                        }
                    } catch (Exception ex) {
                        errorMsg += "invalid problem key, ";
                    }
                    
                    if(!salClaimDateStr.equals("")) {
                        try {
                            java.util.Date tmp = sdf.parse(salClaimDateStr);
                            salClaimDate = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                            errorMsg += "Invalid Salary claim Date Format,";
                        } 
                    }
                    
                    if(!salClaimLossStr.equals("") && salClaimLossStr.matches("^[0-9]+(//.[0-9]{1,2})?$")) {
                        errorMsg += header[4] + " must have maximum 2 decimal places,"; 
                    }
                    
                    if (!salClaimBasis.equals("") && salClaimBasis.length() > 1000) {
                        errorMsg += header[5] + " cannot be longer than 1000 characters,";
                    }
                }   //pass 

                // if there is an error, the line number of the error and its relevant message is 
                // added into the errorList
                if (!errorMsg.equals("")) {
                    errList.add(lineNum + ":" + errorMsg);
                    errorMsg = ""; // reset errorMsg variable
                } // if there is no error, a new Worker object is created and added to the workerList
                else {
                    errorMsg = ""; // reset errorMsg variable
                    ProblemSalaryClaim problemSalaryClaim = new ProblemSalaryClaim
                            (finNum, jobKey, probKey, salClaimDate, salClaimLoss, salClaimBasis);
                    addProblemSalaryClaim(problemSalaryClaim);
                }    
            }
            csvReader.close();
        } catch (FileNotFoundException ex) {
            //fileNotFoundExcepton
        }
        return errList;
    }

        /*Problem wica */
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
    
     public static ArrayList<String> validateAndAddProblemWica (String probWicaFile) throws IOException {
        //Attributes
        ArrayList<String> errList = new ArrayList<String>();
        CSVReader csvReader = null;
        try{
            csvReader = new CSVReader(new FileReader(probWicaFile));
            String[] header = csvReader.readNext();
            String[] fields;
            int lineNum = 1;
            String errorMsg = "";

            //Loops through each line of the csv with an array of String
            while ((fields = csvReader.readNext()) != null){
                lineNum++;
                //Assigning each field with its appropriate name
                String finNum = fields[0].trim();
                String jobKeyStr = fields[1].trim();
                String probKeyStr = fields[2].trim();
                String dateStr = fields[3].trim();
                String status = fields[4].trim();
                String statusMore = fields[5].trim();
                String pointsStr = fields[6].trim();
                String dollarsStr = fields[7].trim();
                String rem = fields[8].trim();
               
                
                int jobKey = 0;
                int probKey = 0;
                double points = 0.0;
                double dollars = 0.0;
                java.sql.Date updatedDate = null;
                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                
                /**
                 * Validations for empty fields
                 */
                boolean pass = true; //assume validation pass first;
                if (finNum.equals("")) {
                    errorMsg += header[0] + " is blank,";
                    pass = false;
                }
                
                if (jobKeyStr.equals("")) {
                    errorMsg += header[1] + " is blank,";
                    pass = false;
                }
                if (probKeyStr.equals("")) {
                    errorMsg += header[2] + " is blank,";
                    pass = false;
                }
                if (dateStr.equals("")) {
                    errorMsg += header[3] + " is blank,";
                    pass = false;
                }
                if (status.equals("")) {
                    errorMsg += header[4] + " is blank,";
                    pass = false;
                }
                
                //proceed only after empty fields validation is passed
                if (pass) { 

                    // check for any existing worker  with the same finNum. 
                    Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                    if (worker == null) {
                        errorMsg += "invalid FinNumber, ";
                    }
                    
                    try {
                        jobKey = Integer.parseInt(jobKeyStr);
                        Job job = JobDAO.retrieveJobByJobId(jobKey);
                        if (job == null) {
                            errorMsg += "invalid job key, ";
                        } else {
                            if (worker != null && 
                                    !(worker.getFinNumber().equals(job.getWorkerFinNum()))) {
                                errorMsg += "invalid finNumber for this job key, ";
                            }
                        }
                    } catch (Exception ex) {
                        errorMsg += "invalid job key, ";
                    }
                    
                    try {
                        probKey = Integer.parseInt(probKeyStr);
                        Problem problem = ProblemDAO.retrieveProblemByProblemId(probKey);
                        if (problem == null) {
                            errorMsg += "invalid problem key, ";
                        } else {
                            if (worker != null && 
                                    !(worker.getFinNumber().equals(problem.getWorkerFinNum()))) {
                                errorMsg += "invalid finNumber for this problem key, ";
                            }
                        }
                    } catch (Exception ex) {
                        errorMsg += "invalid problem key, ";
                    }

                    if (!dateStr.equals("")) {
                        try {
                            java.util.Date tmp = sdf.parse(dateStr);
                            updatedDate = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                            errorMsg += "Invalid Updated Wica Date Format,";
                        } 
                    }
                    ArrayList<String> list = DropdownDAO.retrieveAllDropdownListOfProblems();
                    boolean exit = false;
                    for (String tmp: list) {
                        if (tmp.equalsIgnoreCase(status)) {
                            exit = true;
                            break;
                        }
                    }
                    
                    if (!exit) {
                        errorMsg += "invalid Wica Status, ";
                    }


                    if (!status.equals("") && status.length() > 30) {
                        errorMsg += header[5] + " cannot be longer than 30 characters,";
                    }
                    
                    if (!statusMore.equals("") && statusMore.length() > 50) {
                        errorMsg += header[6] + " cannot be longer than 50 characters,";
                    }
                    
                    if (!pointsStr.equals("") && !pointsStr.matches("^[0-9]+(//.[0-9]{1,2})?$")) {
                        errorMsg += header[7] + " must have maximum 2 decimal places,";
                    } else {
                        try {
                            points = Double.parseDouble(pointsStr);
                        } catch (Exception ex) {
                            errorMsg += header[14] + " - invalid format,";
                        }
                    }
                    
                    if (!dollarsStr.equals("") && !dollarsStr.matches("^[0-9]+(//.[0-9]{1,2})?$")) {
                        errorMsg += header[8] + " must have maximum 2 decimal places,";
                    } else {
                        try {
                            dollars = Double.parseDouble(dollarsStr);
                        } catch (Exception ex) {
                            errorMsg += header[8] + " - invalid format,";
                        }
                    }


                    if (!rem.equals("") && rem.length() > 200) {
                        errorMsg += header[9] + " cannot be longer than 200 characters,";
                    }
                    
                    
                } //pass
                
                // if there is an error, the line number of the error and its relevant message is 
                // added into the errorList
                if (!errorMsg.equals("")) {
                    errList.add(lineNum + ":" + errorMsg);
                    errorMsg = ""; // reset errorMsg variable
                } // if there is no error, a new Worker object is created and added to the workerList
                else {
                    errorMsg = ""; // reset errorMsg variable
                    ProblemWica problemWica = new ProblemWica
                            (finNum, jobKey, probKey, updatedDate, status, statusMore, points, dollars, rem);
                    addProblemWica (problemWica);
                }  
                
            }
            csvReader.close();
                
        } catch (FileNotFoundException ex) {
            //fileNotFoundException
        }
        return errList;
    }

    /*Problem wica claim Issue*/
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
    
    public static ArrayList<String> validateAndAddProblemWicaClaim(String problemWicaClaimFile) 
            throws IOException{
        
        // Attributes
        ArrayList<String> errList = new ArrayList<String>();
        CSVReader csvReader = null;
        try {
            csvReader = new CSVReader(new FileReader(problemWicaClaimFile));
            String[] header = csvReader.readNext();
            String[] fields;
            int lineNum = 1;
            String errorMsg = "";

            // Loops through each line of the csv with an array of String
            while ((fields = csvReader.readNext()) != null) {
                lineNum++;
                // Assigning each field with its appropriate name
                String finNum = fields[0].trim();
                String jobKeyStr = fields[1].trim();
                String probKeyStr = fields[2].trim();
                String wicaClaimDateStr = fields[3].trim();
                String wicaRefNbr = fields[4].trim();
                String wicaInsurer = fields[5].trim();
                String wicaPolicyNbr = fields[6].trim();
                String wicaWhoLodged = fields[7].trim();
                String wicaClaimRem = fields[8].trim();
                
                int jobKey = 0;
                int probKey = 0;
                java.sql.Date wicaClaimDate = null;
                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                /**
                 * Validations for empty fields
                 */
                boolean pass = true; //assume validation pass first;
                if (finNum.equals("")) {
                    errorMsg += header[0] + " is blank,";
                    pass = false;
                }
                
                if (jobKeyStr.equals("")) {
                    errorMsg += header[1] + " is blank,";
                    pass = false;
                }

                if (probKeyStr.equals("")) {
                    errorMsg += header[2] + " is blank,";
                    pass = false;
                }

                if (wicaClaimDateStr.equals("")) {
                    errorMsg += header[3] + " is blank,";
                    pass = false;
                }
                
                //proceed only after empty fields validation is passed
                if (pass) { 

                    // check for any existing worker  with the same finNum. 
                    Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                    if (worker == null) {
                        errorMsg += "invalid FinNumber, ";
                    }
                    
                    try {
                        jobKey = Integer.parseInt(jobKeyStr);
                        Job job = JobDAO.retrieveJobByJobId(jobKey);
                        if (job == null) {
                            errorMsg += "invalid jobkey, ";
                        } else {
                            if (worker != null && 
                                    !(worker.getFinNumber().equals(job.getWorkerFinNum()))) {
                                errorMsg += "invalid finNumber for this jobkey, ";
                            }
                        }
                    } catch (Exception ex) {
                        errorMsg += "invalid job key, ";
                    }
                    
                    try {
                        probKey = Integer.parseInt(probKeyStr);
                        Problem problem = ProblemDAO.retrieveProblemByProblemId(probKey);
                        if (problem == null) {
                            errorMsg += "invalid problem key, ";
                        } else {
                            if (worker != null && 
                                    !(worker.getFinNumber().equals(problem.getWorkerFinNum()))) {
                                errorMsg += "invalid finNumber for this problem key, ";
                            }
                        }
                    } catch (Exception ex) {
                        errorMsg += "invalid problem key, ";
                    }
                    
                    if (!wicaClaimDateStr.equals("")) {
                        try {
                            java.util.Date tmp = sdf.parse(wicaClaimDateStr);
                            wicaClaimDate = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                            errorMsg += "Invalid wica claim Date Format,";
                        } 
                    }
                    
                    if (!wicaRefNbr.equals("") && wicaRefNbr.length() > 30) {
                        errorMsg += header[4] + " cannot be longer than 30 characters,";
                    }
                    
                    if (!wicaInsurer.equals("") && wicaInsurer.length() > 50) {
                        errorMsg += header[5] + " cannot be longer than 50 characters,";
                    }
                    
                    if (!wicaPolicyNbr.equals("") && wicaPolicyNbr.length() > 50) {
                        errorMsg += header[6] + " cannot be longer than 50 characters,";
                    }
                    
                    if (!wicaWhoLodged.equals("") && wicaWhoLodged.length() > 200) {
                        errorMsg += header[7] + " cannot be longer than 200 characters,";
                    }
                    
                    if (!wicaClaimRem.equals("") && wicaClaimRem.length() > 200) {
                        errorMsg += header[8] + " cannot be longer than 200 characters,";
                    }
                }   //pass 

                // if there is an error, the line number of the error and its relevant message is 
                // added into the errorList
                if (!errorMsg.equals("")) {
                    errList.add(lineNum + ":" + errorMsg);
                    errorMsg = ""; // reset errorMsg variable
                } // if there is no error, a new Worker object is created and added to the workerList
                else {
                    errorMsg = ""; // reset errorMsg variable
                    ProblemWicaClaim problemWicaClaim = new ProblemWicaClaim
                            (finNum, jobKey, probKey, wicaClaimDate, wicaRefNbr, wicaInsurer, wicaPolicyNbr, 
                            wicaWhoLodged, wicaClaimRem);
                    addProblemWicaClaim(problemWicaClaim);
                }    
            }
            csvReader.close();
        } catch (FileNotFoundException ex) {
            //fileNotFoundExcepton
        }
        return errList;
    }

    /*Problem non-wica claim Issue*/
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
    
    public static ArrayList<String> validateAndAddProblemNonWicaClaim(String problemNonWicaClaimFile) 
            throws IOException{
        
        // Attributes
        ArrayList<String> errList = new ArrayList<String>();
        CSVReader csvReader = null;
        try {
            csvReader = new CSVReader(new FileReader(problemNonWicaClaimFile));
            String[] header = csvReader.readNext();
            String[] fields;
            int lineNum = 1;
            String errorMsg = "";

            // Loops through each line of the csv with an array of String
            while ((fields = csvReader.readNext()) != null) {
                lineNum++;
                // Assigning each field with its appropriate name
                String finNum = fields[0].trim();
                String jobKeyStr = fields[1].trim();
                String probKeyStr = fields[2].trim();
                String medClaimDateStr = fields[3].trim();
                String medClaimLossStr = fields[4].trim();
                String medClaimInsurer = fields[5].trim();
                String medClaimPolicyNbr = fields[6].trim();
                String medClaimBasis = fields[7].trim();
                String medClaimRem = fields[8].trim();
                
                int jobKey = 0;
                int probKey = 0;
                java.sql.Date medClaimDate = null;
                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                double medClaimLoss = 0.0;
                /**
                 * Validations for empty fields
                 */
                boolean pass = true; //assume validation pass first;
                if (finNum.equals("")) {
                    errorMsg += header[0] + " is blank,";
                    pass = false;
                }
                
                if (jobKeyStr.equals("")) {
                    errorMsg += header[1] + " is blank,";
                    pass = false;
                }

                if (probKeyStr.equals("")) {
                    errorMsg += header[2] + " is blank,";
                    pass = false;
                }

                if (medClaimDateStr.equals("")) {
                    errorMsg += header[3] + " is blank,";
                    pass = false;
                }
                
                //proceed only after empty fields validation is passed
                if (pass) { 

                    // check for any existing worker  with the same finNum. 
                    Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                    if (worker == null) {
                        errorMsg += "invalid FinNumber, ";
                    }
                    
                    try {
                        jobKey = Integer.parseInt(jobKeyStr);
                        Job job = JobDAO.retrieveJobByJobId(jobKey);
                        if (job == null) {
                            errorMsg += "invalid jobkey, ";
                        } else {
                            if (worker != null && 
                                    !(worker.getFinNumber().equals(job.getWorkerFinNum()))) {
                                errorMsg += "invalid finNumber for this jobkey, ";
                            }
                        }
                    } catch (Exception ex) {
                        errorMsg += "invalid job key, ";
                    }
                    
                    try {
                        probKey = Integer.parseInt(probKeyStr);
                        Problem problem = ProblemDAO.retrieveProblemByProblemId(probKey);
                        if (problem == null) {
                            errorMsg += "invalid problem key, ";
                        } else {
                            if (worker != null && 
                                    !(worker.getFinNumber().equals(problem.getWorkerFinNum()))) {
                                errorMsg += "invalid finNumber for this problem key, ";
                            }
                        }
                    } catch (Exception ex) {
                        errorMsg += "invalid problem key, ";
                    }
                    
                    if (!medClaimDateStr.equals("")) {
                        try {
                            java.util.Date tmp = sdf.parse(medClaimDateStr);
                            medClaimDate = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                            errorMsg += "Invalid non-wica medical claim Date Format,";
                        } 
                    }
                    
                    if (!medClaimLossStr.equals("") && !medClaimLossStr.matches("^[0-9]+(//.[0-9]{1,2})?$")) {
                        errorMsg += header[10] + " must have maximum 2 decimal places,";
                    } else {
                        try {
                            medClaimLoss = Double.parseDouble(medClaimLossStr);
                        } catch (Exception ex) {
                            errorMsg += header[10] + " - invalid format,";
                        }
                    }

                    
                    if (!medClaimInsurer.equals("") && medClaimInsurer.length() > 50) {
                        errorMsg += header[5] + " cannot be longer than 50 characters,";
                    }
                    
                    if (!medClaimPolicyNbr.equals("") && medClaimPolicyNbr.length() > 30) {
                        errorMsg += header[6] + " cannot be longer than 30 characters,";
                    }
                    
                    if (!medClaimBasis.equals("") && medClaimBasis.length() > 1000) {
                        errorMsg += header[7] + " cannot be longer than 1000 characters,";
                    }
                    
                    if (!medClaimRem.equals("") && medClaimRem.length() > 1000) {
                        errorMsg += header[8] + " cannot be longer than 1000 characters,";
                    }
                }   //pass 

                // if there is an error, the line number of the error and its relevant message is 
                // added into the errorList
                if (!errorMsg.equals("")) {
                    errList.add(lineNum + ":" + errorMsg);
                    errorMsg = ""; // reset errorMsg variable
                } // if there is no error, a new Worker object is created and added to the workerList
                else {
                    errorMsg = ""; // reset errorMsg variable
                    ProblemNonWicaClaim problemNonWicaClaim = new ProblemNonWicaClaim
                            (finNum, jobKey, probKey, medClaimDate, medClaimLoss, medClaimInsurer, medClaimPolicyNbr, 
                            medClaimBasis, medClaimRem);
                    addProblemNonWicaClaim(problemNonWicaClaim);
                }    
            }
            csvReader.close();
        } catch (FileNotFoundException ex) {
            //fileNotFoundExcepton
        }
        return errList;
    }
    
    
    /*Problem police report*/
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
    
    public static ArrayList<String> validateAndAddProblemPoliceReport(String problemPoliceReportFile) 
            throws IOException{
        
        // Attributes
        ArrayList<String> errList = new ArrayList<String>();
        CSVReader csvReader = null;
        try {
            csvReader = new CSVReader(new FileReader(problemPoliceReportFile));
            String[] header = csvReader.readNext();
            String[] fields;
            int lineNum = 1;
            String errorMsg = "";

            // Loops through each line of the csv with an array of String
            while ((fields = csvReader.readNext()) != null) {
                lineNum++;
                // Assigning each field with its appropriate name
                String finNum = fields[0].trim();
                String jobKeyStr = fields[1].trim();
                String probKeyStr = fields[2].trim();
                String policeRptDateStr = fields[3].trim();
                String policeReptStation = fields[4].trim();
                String policeRptPers = fields[5].trim();
                String policeRptNbr = fields[6].trim();
                String policeRptDetails = fields[7].trim();
                String policeRptRem = fields[8].trim();
                
                int jobKey = 0;
                int probKey = 0;
                java.sql.Date policeRptDate = null;
                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                /**
                 * Validations for empty fields
                 */
                boolean pass = true; //assume validation pass first;
                if (finNum.equals("")) {
                    errorMsg += header[0] + " is blank,";
                    pass = false;
                }
                
                if (jobKeyStr.equals("")) {
                    errorMsg += header[1] + " is blank,";
                    pass = false;
                }

                if (probKeyStr.equals("")) {
                    errorMsg += header[2] + " is blank,";
                    pass = false;
                }

                if (policeRptDateStr.equals("")) {
                    errorMsg += header[3] + " is blank,";
                    pass = false;
                }
                
                //proceed only after empty fields validation is passed
                if (pass) { 

                    // check for any existing worker  with the same finNum. 
                    Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                    if (worker == null) {
                        errorMsg += "invalid FinNumber, ";
                    }
                    
                    try {
                        jobKey = Integer.parseInt(jobKeyStr);
                        Job job = JobDAO.retrieveJobByJobId(jobKey);
                        if (job == null) {
                            errorMsg += "invalid jobkey, ";
                        } else {
                            if (worker != null && 
                                    !(worker.getFinNumber().equals(job.getWorkerFinNum()))) {
                                errorMsg += "invalid finNumber for this jobkey, ";
                            }
                        }
                    } catch (Exception ex) {
                        errorMsg += "invalid job key, ";
                    }
                    
                    try {
                        probKey = Integer.parseInt(probKeyStr);
                        Problem problem = ProblemDAO.retrieveProblemByProblemId(probKey);
                        if (problem == null) {
                            errorMsg += "invalid problem key, ";
                        } else {
                            if (worker != null && 
                                    !(worker.getFinNumber().equals(problem.getWorkerFinNum()))) {
                                errorMsg += "invalid finNumber for this problem key, ";
                            }
                        }
                    } catch (Exception ex) {
                        errorMsg += "invalid problem key, ";
                    }
                    
                    if (!policeRptDateStr.equals("")) {
                        try {
                            java.util.Date tmp = sdf.parse(policeRptDateStr);
                            policeRptDate = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                            errorMsg += "Invalid police report Date Format,";
                        } 
                    }
                    
                    if (!policeReptStation.equals("") && policeReptStation.length() > 50) {
                        errorMsg += header[4] + " cannot be longer than 50 characters,";
                    }
                    
                    if (!policeRptPers.equals("") && policeRptPers.length() > 200) {
                        errorMsg += header[5] + " cannot be longer than 200 characters,";
                    }
                    
                    if (!policeRptNbr.equals("") && policeRptNbr.length() > 30) {
                        errorMsg += header[6] + " cannot be longer than 30 characters,";
                    }
                    
                    if (!policeRptDetails.equals("") && policeRptDetails.length() > 1000) {
                        errorMsg += header[7] + " cannot be longer than 1000 characters,";
                    }
                    
                    if (!policeRptRem.equals("") && policeRptRem.length() > 200) {
                        errorMsg += header[8] + " cannot be longer than 200 characters,";
                    }
                }   //pass 

                // if there is an error, the line number of the error and its relevant message is 
                // added into the errorList
                if (!errorMsg.equals("")) {
                    errList.add(lineNum + ":" + errorMsg);
                    errorMsg = ""; // reset errorMsg variable
                } // if there is no error, a new Worker object is created and added to the workerList
                else {
                    errorMsg = ""; // reset errorMsg variable
                    ProblemPoliceReport problemPoliceReport = new ProblemPoliceReport
                            (finNum, jobKey, probKey, policeRptDate, policeReptStation, policeRptPers, policeRptNbr, 
                            policeRptDetails, policeRptRem);
                    addProblemPoliceReport(problemPoliceReport);
                }    
            }
            csvReader.close();
        } catch (FileNotFoundException ex) {
            //fileNotFoundExcepton
        }
        return errList;
    }
    
    /*Problem other complaint*/
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

    public static ArrayList<String> validateAndAddProblemOtherComplaints(String probOtherCompFile) throws IOException {
        //Attributes
        ArrayList<String> errList = new ArrayList<String>();
        CSVReader csvReader = null;
        try{
            csvReader = new CSVReader(new FileReader(probOtherCompFile));
            String[] header = csvReader.readNext();
            String[] fields;
            int lineNum = 1;
            String errorMsg = "";

            //Loops through each line of the csv with an array of String
            while ((fields = csvReader.readNext()) != null){
                lineNum++;
                //Assigning each field with its appropriate name
                String finNum = fields[0].trim();
                String jobKeyStr = fields[1].trim();
                String probKeyStr = fields[2].trim();
                String dateStr = fields[3].trim();
                String agency = fields[4].trim();
                String who = fields[5].trim();
                String whoMore = fields[6].trim();
                String mode = fields[7].trim();
                String modeMore = fields[8].trim();
                String details = fields[9].trim();
                String rem = fields[10].trim();

                int jobKey = 0;
                int probKey = 0;
                java.sql.Date complaintDate = null;
                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                
                /**
                 * Validations for empty fields
                 */
                boolean pass = true; //assume validation pass first;
                if (finNum.equals("")) {
                    errorMsg += header[0] + " is blank,";
                    pass = false;
                }
                
                if (jobKeyStr.equals("")) {
                    errorMsg += header[1] + " is blank,";
                    pass = false;
                }
                if (probKeyStr.equals("")) {
                    errorMsg += header[2] + " is blank,";
                    pass = false;
                }
                if (dateStr.equals("")) {
                    errorMsg += header[3] + " is blank,";
                    pass = false;
                }
                if (agency.equals("")) {
                    errorMsg += header[4] + " is blank,";
                    pass = false;
                }
                if (who.equals("")) {
                    errorMsg += header[5] + " is blank,";
                    pass = false;
                }

                


                //proceed only after empty fields validation is passed
                if (pass) { 

                    // check for any existing worker  with the same finNum. 
                    Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                    if (worker == null) {
                        errorMsg += "invalid FinNumber, ";
                    }
                    
                    try {
                        jobKey = Integer.parseInt(jobKeyStr);
                        Job job = JobDAO.retrieveJobByJobId(jobKey);
                        if (job == null) {
                            errorMsg += "invalid job key, ";
                        } else {
                            if (worker != null && 
                                    !(worker.getFinNumber().equals(job.getWorkerFinNum()))) {
                                errorMsg += "invalid finNumber for this job key, ";
                            }
                        }
                    } catch (Exception ex) {
                        errorMsg += "invalid job key, ";
                    }
                    
                    try {
                        probKey = Integer.parseInt(probKeyStr);
                        Problem problem = ProblemDAO.retrieveProblemByProblemId(probKey);
                        if (problem == null) {
                            errorMsg += "invalid problem key, ";
                        } else {
                            if (worker != null && 
                                    !(worker.getFinNumber().equals(problem.getWorkerFinNum()))) {
                                errorMsg += "invalid finNumber for this problem key, ";
                            }
                        }
                    } catch (Exception ex) {
                        errorMsg += "invalid problem key, ";
                    }

                    if (!dateStr.equals("")) {
                        try {
                            java.util.Date tmp = sdf.parse(dateStr);
                            complaintDate = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                            errorMsg += "Invalid complaint lodged Date Format,";
                        } 
                    }

                    if (!agency.equals("") && agency.length() > 50) {
                        errorMsg += header[5] + " cannot be longer than 50 characters,";
                    }
                    
                    if (!who.equals("") && who.length() > 12) {
                        errorMsg += header[6] + " cannot be longer than 12 characters,";
                    }
                    
                    if (!whoMore.equals("") && whoMore.length() > 50) {
                        errorMsg += header[7] + " cannot be longer than 50 characters,";
                    }
                    
                    if (!mode.equals("") && mode.length() > 30) {
                        errorMsg += header[8] + " cannot be longer than 30 characters,";
                    }
                    
                    if (!modeMore.equals("") && modeMore.length() > 200) {
                        errorMsg += header[9] + " cannot be longer than 200 characters,";
                    }
                    
                     if (!details.equals("") && details.length() > 1000) {
                        errorMsg += header[10] + " cannot be longer than 1000 characters,";
                    }

                     if (!rem.equals("") && rem.length() > 200) {
                        errorMsg += header[11] + " cannot be longer than 200 characters,";
                    }

                } //pass
                
                // if there is an error, the line number of the error and its relevant message is 
                // added into the errorList
                if (!errorMsg.equals("")) {
                    errList.add(lineNum + ":" + errorMsg);
                    errorMsg = ""; // reset errorMsg variable
                } // if there is no error, a new Worker object is created and added to the workerList
                else {
                    errorMsg = ""; // reset errorMsg variable
                    ProblemOtherComplaint problemOtherComplaint = new ProblemOtherComplaint
                            (finNum, jobKey, probKey, complaintDate, agency, who, whoMore, mode, modeMore, details, rem);
                    addProblemOtherComplaint (problemOtherComplaint);
                }  
                
            }
            csvReader.close();
                

        }catch (FileNotFoundException ex) {
            //fileNotFoundException
        }
        return errList;
    }
        
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

    public static ArrayList<String> validateAndAddProblemCaseDiscussions (String probCaseDiscussionsFile) throws IOException {
        //Attributes
        ArrayList<String> errList = new ArrayList<String>();
        CSVReader csvReader = null;
        try{
            csvReader = new CSVReader(new FileReader(probCaseDiscussionsFile));
            String[] header = csvReader.readNext();
            String[] fields;
            int lineNum = 1;
            String errorMsg = "";

            //Loops through each line of the csv with an array of String
            while ((fields = csvReader.readNext()) != null){
                lineNum++;
                //Assigning each field with its appropriate name
                String finNum = fields[0].trim();
                String jobKeyStr = fields[1].trim();
                String probKeyStr = fields[2].trim();
                String caseDissDateStr = fields[3].trim();
                String caseDissTime = fields[4].trim();
                String caseDissWhere = fields[5].trim();
                String caseDissWhereMore = fields[6].trim();
                String caseDissWorkerPresent = fields[7].trim();
                String caseDissTWC1 = fields[8].trim();
                String caseDissTWC2 = fields[9].trim();
                String caseDissOtherPerson = fields[10].trim();
                String caseDissTrasnslator = fields[11].trim();
                String caseDissTopic = fields[12].trim();
                String caseDissGist = fields[13].trim();
                String caseDissAssist = fields[14].trim();
                String caseDissCalculate = fields[15].trim();
                String caseDissAction = fields[16].trim();
                String caseDissRem = fields[17].trim();

                int jobKey = 0;
                int probKey = 0;
                java.sql.Date caseDissDate = null;
                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                
                /**
                 * Validations for empty fields
                 */
                boolean pass = true; //assume validation pass first;
                if (finNum.equals("")) {
                    errorMsg += header[0] + " is blank,";
                    pass = false;
                }
                
                if (jobKeyStr.equals("")) {
                    errorMsg += header[1] + " is blank,";
                    pass = false;
                }
                if (probKeyStr.equals("")) {
                    errorMsg += header[2] + " is blank,";
                    pass = false;
                }
                if (caseDissDateStr.equals("")) {
                    errorMsg += header[3] + " is blank,";
                    pass = false;
                }
                if (caseDissWhere.equals("")) {
                    errorMsg += header[5] + " is blank,";
                    pass = false;
                }
                if (caseDissTWC1.equals("")) {
                    errorMsg += header[8] + " is blank,";
                    pass = false;
                }
                if (caseDissTopic.equals("")) {
                    errorMsg += header[12] + " is blank,";
                    pass = false;
                }
                

                


                //proceed only after empty fields validation is passed
                if (pass) { 

                    // check for any existing worker  with the same finNum. 
                    Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                    if (worker == null) {
                        errorMsg += "invalid FinNumber, ";
                    }
                    
                    try {
                        jobKey = Integer.parseInt(jobKeyStr);
                        Job job = JobDAO.retrieveJobByJobId(jobKey);
                        if (job == null) {
                            errorMsg += "invalid job key, ";
                        } else {
                            if (worker != null && 
                                    !(worker.getFinNumber().equals(job.getWorkerFinNum()))) {
                                errorMsg += "invalid finNumber for this job key, ";
                            }
                        }
                    } catch (Exception ex) {
                        errorMsg += "invalid job key, ";
                    }
                    
                    try {
                        probKey = Integer.parseInt(probKeyStr);
                        Problem problem = ProblemDAO.retrieveProblemByProblemId(probKey);
                        if (problem == null) {
                            errorMsg += "invalid problem key, ";
                        } else {
                            if (worker != null && 
                                    !(worker.getFinNumber().equals(problem.getWorkerFinNum()))) {
                                errorMsg += "invalid finNumber for this problem key, ";
                            }
                        }
                    } catch (Exception ex) {
                        errorMsg += "invalid problem key, ";
                    }

                    if (!caseDissDateStr.equals("")) {
                        try {
                            java.util.Date tmp = sdf.parse(caseDissDateStr);
                            caseDissDate = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                            errorMsg += "Invalid Case Discussion Date Format,";
                        } 
                    }

                    ArrayList<String> list = DropdownDAO.retrieveAllDropdownListOfProblems();
                    boolean exit = false;
                    for (String tmp: list) {
                        if (tmp.equalsIgnoreCase(caseDissWhere)) {
                            exit = true;
                            break;
                        }
                    }
                    
                    if (!exit) {
                        errorMsg += "invalid Case Discussion Location, ";
                    }

                    if (!caseDissTime.equals("") && caseDissTime.length() > 20) {
                        errorMsg += header[5] + " cannot be longer than 20 characters,";
                    }
                    
                    if (!caseDissWhere.equals("") && caseDissWhere.length() > 30) {
                        errorMsg += header[6] + " cannot be longer than 30 characters,";
                    }
                    
                    if (!caseDissWhereMore.equals("") && caseDissWhereMore.length() > 50) {
                        errorMsg += header[7] + " cannot be longer than 50 characters,";
                    }
                    
                    if (!caseDissWorkerPresent.equals("") && caseDissWorkerPresent.length() > 1) {
                        errorMsg += header[8] + " cannot be longer than 1 characters,";
                    }
                    
                    if (!caseDissTWC1.equals("") && caseDissTWC1.length() > 200) {
                        errorMsg += header[9] + " cannot be longer than 200 characters,";
                    }
                    
                     if (!caseDissTWC2.equals("") && caseDissTWC2.length() > 200) {
                        errorMsg += header[10] + " cannot be longer than 200 characters,";
                    }

                     if (!caseDissOtherPerson.equals("") && caseDissOtherPerson.length() > 200) {
                        errorMsg += header[11] + " cannot be longer than 200 characters,";
                    }

                    if (!caseDissTrasnslator.equals("") && caseDissTrasnslator.length() > 50) {
                        errorMsg += header[12] + " cannot be longer than 50 characters,";
                    }

                    if (!caseDissTopic.equals("") && caseDissTopic.length() > 200) {
                        errorMsg += header[13] + " cannot be longer than 200 characters,";
                    }

                    if (!caseDissGist.equals("") && caseDissGist.length() > 1000) {
                        errorMsg += header[14] + " cannot be longer than 1000 characters,";
                    }

                    if (!caseDissAssist.equals("") && caseDissAssist.length() > 1000) {
                        errorMsg += header[15] + " cannot be longer than 1000 characters,";
                    }

                    if (!caseDissCalculate.equals("") && caseDissCalculate.length() > 1000) {
                        errorMsg += header[16] + " cannot be longer than 1000 characters,";
                    }

                    if (!caseDissAction.equals("") && caseDissAction.length() > 500) {
                        errorMsg += header[17] + " cannot be longer than 500 characters,";
                    }

                    if (!caseDissRem.equals("") && caseDissRem.length() > 500) {
                        errorMsg += header[18] + " cannot be longer than 500 characters,";
                    }

                } //pass
                
                // if there is an error, the line number of the error and its relevant message is 
                // added into the errorList
                if (!errorMsg.equals("")) {
                    errList.add(lineNum + ":" + errorMsg);
                    errorMsg = ""; // reset errorMsg variable
                } // if there is no error, a new Worker object is created and added to the workerList
                else {
                    errorMsg = ""; // reset errorMsg variable
                    ProblemCaseDiscussion problemCaseDiscussion = new ProblemCaseDiscussion
                            (finNum, jobKey, probKey, caseDissDate, caseDissTime, caseDissWhere, 
                            caseDissWhereMore, caseDissWorkerPresent, caseDissTWC1, caseDissTWC2, 
                            caseDissOtherPerson, caseDissTrasnslator, caseDissTopic, caseDissGist, 
                            caseDissAssist, caseDissCalculate, caseDissAction, caseDissRem);
                    addProblemCaseDiscussion (problemCaseDiscussion);
                }  
                
            }
            csvReader.close();
                

        }catch (FileNotFoundException ex) {
            //fileNotFoundException
        }
        return errList;
    }
    
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
    
    public static ArrayList<String> validateAndAddProblemHospital(String probHospitalFile) throws IOException {
        //Attributes
        ArrayList<String> errList = new ArrayList<String>();
        CSVReader csvReader = null;
        try{
            csvReader = new CSVReader(new FileReader(probHospitalFile));
            String[] header = csvReader.readNext();
            String[] fields;
            int lineNum = 1;
            String errorMsg = "";

            //Loops through each line of the csv with an array of String
            while ((fields = csvReader.readNext()) != null){
                lineNum++;
                //Assigning each field with its appropriate name
                String finNum = fields[0].trim();
                String jobKeyStr = fields[1].trim();
                String probKeyStr = fields[2].trim();
                String dateStr = fields[3].trim();
                String hospName = fields[4].trim();
                String hospNameMore = fields[5].trim();
                String doctor = fields[6].trim();
                String rem = fields[7].trim();

                int jobKey = 0;
                int probKey = 0;
                java.sql.Date hospDate = null;
                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                
                /**
                 * Validations for empty fields
                 */
                boolean pass = true; //assume validation pass first;
                if (finNum.equals("")) {
                    errorMsg += header[0] + " is blank,";
                    pass = false;
                }
                
                if (jobKeyStr.equals("")) {
                    errorMsg += header[1] + " is blank,";
                    pass = false;
                }
                if (probKeyStr.equals("")) {
                    errorMsg += header[2] + " is blank,";
                    pass = false;
                }
                if (dateStr.equals("")) {
                    errorMsg += header[3] + " is blank,";
                    pass = false;
                }
                if (hospName.equals("")) {
                    errorMsg += header[4] + " is blank,";
                    pass = false;
                }
                
                

                //proceed only after empty fields validation is passed
                if (pass) { 

                    // check for any existing worker  with the same finNum. 
                    Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                    if (worker == null) {
                        errorMsg += "invalid FinNumber, ";
                    }
                    
                    try {
                        jobKey = Integer.parseInt(jobKeyStr);
                        Job job = JobDAO.retrieveJobByJobId(jobKey);
                        if (job == null) {
                            errorMsg += "invalid job key, ";
                        } else {
                            if (worker != null && 
                                    !(worker.getFinNumber().equals(job.getWorkerFinNum()))) {
                                errorMsg += "invalid finNumber for this job key, ";
                            }
                        }
                    } catch (Exception ex) {
                        errorMsg += "invalid job key, ";
                    }
                    
                    try {
                        probKey = Integer.parseInt(probKeyStr);
                        Problem problem = ProblemDAO.retrieveProblemByProblemId(probKey);
                        if (problem == null) {
                            errorMsg += "invalid problem key, ";
                        } else {
                            if (worker != null && 
                                    !(worker.getFinNumber().equals(problem.getWorkerFinNum()))) {
                                errorMsg += "invalid finNumber for this problem key, ";
                            }
                        }
                    } catch (Exception ex) {
                        errorMsg += "invalid problem key, ";
                    }

                    if (!dateStr.equals("")) {
                        try {
                            java.util.Date tmp = sdf.parse(dateStr);
                            hospDate = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                            errorMsg += "Invalid Updated Date Format,";
                        } 
                    }

                    if (!hospName.equals("") && hospName.length() > 30) {
                        errorMsg += header[5] + " cannot be longer than 30 characters,";
                    }
                    
                    if (!hospNameMore.equals("") && hospNameMore.length() > 50) {
                        errorMsg += header[6] + " cannot be longer than 50 characters,";
                    }
                    
                    if (!doctor.equals("") && doctor.length() > 200) {
                        errorMsg += header[7] + " cannot be longer than 200 characters,";
                    }
                    
                    if (!rem.equals("") && rem.length() > 200) {
                        errorMsg += header[8] + " cannot be longer than 200 characters,";
                    }
                   

                } //pass
                
                // if there is an error, the line number of the error and its relevant message is 
                // added into the errorList
                if (!errorMsg.equals("")) {
                    errList.add(lineNum + ":" + errorMsg);
                    errorMsg = ""; // reset errorMsg variable
                } // if there is no error, a new Worker object is created and added to the workerList
                else {
                    errorMsg = ""; // reset errorMsg variable
                    ProblemHospital problemHospital = new ProblemHospital
                            (finNum, jobKey, probKey, hospDate, hospName, hospNameMore, doctor, rem);
                    addProblemHospital (problemHospital);
                }  
                
            }
            csvReader.close();    

        }catch (FileNotFoundException ex) {
            //fileNotFoundException
        }
        return errList;
    }
    
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

    public static void addProblemMCStatus(ProblemMCStatus problemMCStatus) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "INSERT INTO tbl_mc_status (MC_update, MC_status, "
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

    public static ArrayList<String> validateAndAddProblemMCStatus(String probMCStatusFile) throws IOException {
        //Attributes
        ArrayList<String> errList = new ArrayList<String>();
        CSVReader csvReader = null;
        try{
            csvReader = new CSVReader(new FileReader(probMCStatusFile));
            String[] header = csvReader.readNext();
            String[] fields;
            int lineNum = 1;
            String errorMsg = "";

            //Loops through each line of the csv with an array of String
            while ((fields = csvReader.readNext()) != null){
                lineNum++;
                //Assigning each field with its appropriate name
                String finNum = fields[0].trim();
                String jobKeyStr = fields[1].trim();
                String probKeyStr = fields[2].trim();
                String dateStr = fields[3].trim();
                String mcStatus = fields[4].trim();
                String mcStatusMore = fields[5].trim();
                String expDateStr = fields[6].trim();
                String mcDaysCumStr = fields[7].trim();
                String mcRem = fields[8].trim();

                int jobKey = 0;
                int probKey = 0;
                java.sql.Date mcDate = null;
                java.sql.Date expDate = null;
                int mcDaysCum = 0;
                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                
                /**
                 * Validations for empty fields
                 */
                boolean pass = true; //assume validation pass first;
                if (finNum.equals("")) {
                    errorMsg += header[0] + " is blank,";
                    pass = false;
                }
                
                if (jobKeyStr.equals("")) {
                    errorMsg += header[1] + " is blank,";
                    pass = false;
                }
                if (probKeyStr.equals("")) {
                    errorMsg += header[2] + " is blank,";
                    pass = false;
                }
                if (dateStr.equals("")) {
                    errorMsg += header[3] + " is blank,";
                    pass = false;
                }
                if (mcStatus.equals("")) {
                    errorMsg += header[4] + " is blank,";
                    pass = false;
                }
                
                //proceed only after empty fields validation is passed
                if (pass) { 

                    // check for any existing worker  with the same finNum. 
                    Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                    if (worker == null) {
                        errorMsg += "invalid FinNumber, ";
                    }
                    
                    try {
                        jobKey = Integer.parseInt(jobKeyStr);
                        Job job = JobDAO.retrieveJobByJobId(jobKey);
                        if (job == null) {
                            errorMsg += "invalid job key, ";
                        } else {
                            if (worker != null && 
                                    !(worker.getFinNumber().equals(job.getWorkerFinNum()))) {
                                errorMsg += "invalid finNumber for this job key, ";
                            }
                        }
                    } catch (Exception ex) {
                        errorMsg += "invalid job key, ";
                    }
                    
                    try {
                        probKey = Integer.parseInt(probKeyStr);
                        Problem problem = ProblemDAO.retrieveProblemByProblemId(probKey);
                        if (problem == null) {
                            errorMsg += "invalid problem key, ";
                        } else {
                            if (worker != null && 
                                    !(worker.getFinNumber().equals(problem.getWorkerFinNum()))) {
                                errorMsg += "invalid finNumber for this problem key, ";
                            }
                        }
                    } catch (Exception ex) {
                        errorMsg += "invalid problem key, ";
                    }

                    if (!dateStr.equals("")) {
                        try {
                            java.util.Date tmp = sdf.parse(dateStr);
                            mcDate = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                            errorMsg += "Invalid Updated Date Format,";
                        } 
                    }

                    if (!expDateStr.equals("")) {
                        try {
                            java.util.Date tmp = sdf.parse(expDateStr);
                            expDate = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                            errorMsg += "Invalid Expiry Date Format,";
                        } 
                    }

                    if (!mcStatus.equals("") && mcStatus.length() > 20) {
                        errorMsg += header[5] + " cannot be longer than 20 characters,";
                    }
                    
                    if (!mcStatusMore.equals("") && mcStatusMore.length() > 50) {
                        errorMsg += header[6] + " cannot be longer than 50 characters,";
                    }
                   
                    if (!mcRem.equals("") && mcRem.length() > 200) {
                        errorMsg += header[8] + " cannot be longer than 200 characters,";
                    }
                   
                    if (!mcDaysCumStr.equals("")) {
                        try {
                            mcDaysCum = Integer.parseInt(mcDaysCumStr);
                        } catch (Exception ex) {
                            errorMsg += header[7] + " must be an integer,";
                        }    
                    }

                } //pass
                
                // if there is an error, the line number of the error and its relevant message is 
                // added into the errorList
                if (!errorMsg.equals("")) {
                    errList.add(lineNum + ":" + errorMsg);
                    errorMsg = ""; // reset errorMsg variable
                } // if there is no error, a new Worker object is created and added to the workerList
                else {
                    errorMsg = ""; // reset errorMsg variable
                    ProblemMCStatus problemMCStatus = new ProblemMCStatus
                            (finNum, jobKey, probKey, mcDate, mcStatus, mcStatusMore, expDate, mcDaysCum, mcRem);
                    addProblemMCStatus (problemMCStatus);
                }
            }
            csvReader.close();
                
        }catch (FileNotFoundException ex) {
            //fileNotFoundException
        }
        return errList;
    }
    
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
                    + "R2R_feedback, R2R_med_cost, R2R_outlay"
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
                String workerFinNumber = rs.getString(7);
                int jobKey = rs.getInt(8);
                int probKey = rs.getInt(9);
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
    
    public static ArrayList<String> validateAndAddProblemR2R (String probR2RFile) throws IOException {
        //Attributes
        ArrayList<String> errList = new ArrayList<String>();
        CSVReader csvReader = null;
        try{
            csvReader = new CSVReader(new FileReader(probR2RFile));
            String[] header = csvReader.readNext();
            String[] fields;
            int lineNum = 1;
            String errorMsg = "";

            //Loops through each line of the csv with an array of String
            while ((fields = csvReader.readNext()) != null){
                lineNum++;
                //Assigning each field with its appropriate name
                String finNum = fields[0].trim();
                String jobKeyStr = fields[1].trim();
                String probKeyStr = fields[2].trim();
                String r2rDateStr = fields[3].trim();
                String r2rTime = fields[4].trim();
                String r2rHosp = fields[5].trim();
                String r2rDept = fields[6].trim();
                String r2r1 = fields[7].trim();
                String r2r2 = fields[8].trim();
                String purpose = fields[9].trim();
                String preApptNotes = fields[10].trim();
                String postApptNotes = fields[11].trim();
                String feedback = fields[12].trim();
                String medCostStr = fields[13].trim();
                String outlayStr = fields[14].trim();
                
                int jobKey = 0;
                int probKey = 0;
                java.sql.Date r2rDate = null;
                double medCost = 0.0;
                double outlay = 0.0;
                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                
                /**
                 * Validations for empty fields
                 */
                boolean pass = true; //assume validation pass first;
                if (finNum.equals("")) {
                    errorMsg += header[0] + " is blank,";
                    pass = false;
                }
                
                if (jobKeyStr.equals("")) {
                    errorMsg += header[1] + " is blank,";
                    pass = false;
                }
                if (probKeyStr.equals("")) {
                    errorMsg += header[2] + " is blank,";
                    pass = false;
                }
                if (r2rDateStr.equals("")) {
                    errorMsg += header[3] + " is blank,";
                    pass = false;
                }
                if (r2rHosp.equals("")) {
                    errorMsg += header[5] + " is blank,";
                    pass = false;
                }
                
                //proceed only after empty fields validation is passed
                if (pass) { 

                    // check for any existing worker  with the same finNum. 
                    Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                    if (worker == null) {
                        errorMsg += "invalid FinNumber, ";
                    }
                    
                    try {
                        jobKey = Integer.parseInt(jobKeyStr);
                        Job job = JobDAO.retrieveJobByJobId(jobKey);
                        if (job == null) {
                            errorMsg += "invalid job key, ";
                        } else {
                            if (worker != null && 
                                    !(worker.getFinNumber().equals(job.getWorkerFinNum()))) {
                                errorMsg += "invalid finNumber for this job key, ";
                            }
                        }
                    } catch (Exception ex) {
                        errorMsg += "invalid job key, ";
                    }
                    
                    try {
                        probKey = Integer.parseInt(probKeyStr);
                        Problem problem = ProblemDAO.retrieveProblemByProblemId(probKey);
                        if (problem == null) {
                            errorMsg += "invalid problem key, ";
                        } else {
                            if (worker != null && 
                                    !(worker.getFinNumber().equals(problem.getWorkerFinNum()))) {
                                errorMsg += "invalid finNumber for this problem key, ";
                            }
                        }
                    } catch (Exception ex) {
                        errorMsg += "invalid problem key, ";
                    }

                    if (!r2rDateStr.equals("")) {
                        try {
                            java.util.Date tmp = sdf.parse(r2rDateStr);
                            r2rDate = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                            errorMsg += "Invalid R2R Date Format,";
                        } 
                    }
                    
                    if (!medCostStr.equals("") && !medCostStr.matches("^[0-9]+(//.[0-9]{1,2})?$")) {
                        errorMsg += header[14] + " must have maximum 2 decimal places,";
                    } else {
                        try {
                            medCost = Double.parseDouble(medCostStr);
                        } catch (Exception ex) {
                            errorMsg += header[14] + " - invalid format,";
                        }
                    }
                    
                    if (!outlayStr.equals("") && !outlayStr.matches("^[0-9]+(//.[0-9]{1,2})?$")) {
                        errorMsg += header[15] + " must have maximum 2 decimal places,";
                    } else {
                        try {
                            medCost = Double.parseDouble(medCostStr);
                        } catch (Exception ex) {
                            errorMsg += header[14] + " - invalid format,";
                        }
                    }

                    if (!r2rTime.equals("") && r2rTime.length() > 20) {
                        errorMsg += header[5] + " cannot be longer than 20 characters,";
                    }
                    
                    if (!r2rHosp.equals("") && r2rHosp.length() > 20) {
                        errorMsg += header[6] + " cannot be longer than 20 characters,";
                    }
                    
                    if (!r2rDept.equals("") && r2rDept.length() > 50) {
                        errorMsg += header[7] + " cannot be longer than 50 characters,";
                    }
                    
                    if (!r2r1.equals("") && r2r1.length() > 20) {
                        errorMsg += header[8] + " cannot be longer than 20 characters,";
                    }
                    
                    if (!r2r2.equals("") && r2r2.length() > 20) {
                        errorMsg += header[9] + " cannot be longer than 20 characters,";
                    }
                    
                     if (!purpose.equals("") && purpose.length() > 50) {
                        errorMsg += header[10] + " cannot be longer than 50 characters,";
                    }

                     if (!preApptNotes.equals("") && preApptNotes.length() > 200) {
                        errorMsg += header[11] + " cannot be longer than 200 characters,";
                    }

                    if (!postApptNotes.equals("") && postApptNotes.length() > 200) {
                        errorMsg += header[12] + " cannot be longer than 200 characters,";
                    }

                    if (!feedback.equals("") && feedback.length() > 200) {
                        errorMsg += header[13] + " cannot be longer than 200 characters,";
                    }

                    
                } //pass
                
                // if there is an error, the line number of the error and its relevant message is 
                // added into the errorList
                if (!errorMsg.equals("")) {
                    errList.add(lineNum + ":" + errorMsg);
                    errorMsg = ""; // reset errorMsg variable
                } // if there is no error, a new Worker object is created and added to the workerList
                else {
                    errorMsg = ""; // reset errorMsg variable
                    ProblemR2R problemR2R = new ProblemR2R
                            (finNum, jobKey, probKey, r2rDate, r2rTime, r2rHosp, r2rDept, r2r1, r2r2, purpose, preApptNotes, postApptNotes, feedback, medCost, outlay);
                    addProblemR2R (problemR2R);
                }  
            }    
            csvReader.close();    

        } catch (FileNotFoundException ex) {
            //fileNotFoundException
        }
        return errList;
    }
     
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
                Date LawyerUpdate = rs.getDate(1);
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

    public static void addProblemLawyer(ProblemLawyer problemLawyer) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "INSERT INTO tbl_Lawyer (Lawyer_update,"
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
    
    public static ArrayList<String> validateAndAddProblemLawyer (String probLawyerFile) throws IOException {
        //Attributes
        ArrayList<String> errList = new ArrayList<String>();
        CSVReader csvReader = null;
        try{
            csvReader = new CSVReader(new FileReader(probLawyerFile));
            String[] header = csvReader.readNext();
            String[] fields;
            int lineNum = 1;
            String errorMsg = "";

            //Loops through each line of the csv with an array of String
            while ((fields = csvReader.readNext()) != null){
                lineNum++;
                //Assigning each field with its appropriate name
                String finNum = fields[0].trim();
                String jobKeyStr = fields[1].trim();
                String probKeyStr = fields[2].trim();
                String dateStr = fields[3].trim();
                String firmName = fields[4].trim();
                String firmNameMore = fields[5].trim();
                String lawyerName = fields[6].trim();
                String rem = fields[7].trim();
               
                
                int jobKey = 0;
                int probKey = 0;
                java.sql.Date lawyerDate = null;
                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                
                /**
                 * Validations for empty fields
                 */
                boolean pass = true; //assume validation pass first;
                if (finNum.equals("")) {
                    errorMsg += header[0] + " is blank,";
                    pass = false;
                }
                
                if (jobKeyStr.equals("")) {
                    errorMsg += header[1] + " is blank,";
                    pass = false;
                }
                if (probKeyStr.equals("")) {
                    errorMsg += header[2] + " is blank,";
                    pass = false;
                }
                if (dateStr.equals("")) {
                    errorMsg += header[3] + " is blank,";
                    pass = false;
                }
                if (firmName.equals("")) {
                    errorMsg += header[4] + " is blank,";
                    pass = false;
                }
                
                //proceed only after empty fields validation is passed
                if (pass) { 

                    // check for any existing worker  with the same finNum. 
                    Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                    if (worker == null) {
                        errorMsg += "invalid FinNumber, ";
                    }
                    
                    try {
                        jobKey = Integer.parseInt(jobKeyStr);
                        Job job = JobDAO.retrieveJobByJobId(jobKey);
                        if (job == null) {
                            errorMsg += "invalid job key, ";
                        } else {
                            if (worker != null && 
                                    !(worker.getFinNumber().equals(job.getWorkerFinNum()))) {
                                errorMsg += "invalid finNumber for this job key, ";
                            }
                        }
                    } catch (Exception ex) {
                        errorMsg += "invalid job key, ";
                    }
                    
                    try {
                        probKey = Integer.parseInt(probKeyStr);
                        Problem problem = ProblemDAO.retrieveProblemByProblemId(probKey);
                        if (problem == null) {
                            errorMsg += "invalid problem key, ";
                        } else {
                            if (worker != null && 
                                    !(worker.getFinNumber().equals(problem.getWorkerFinNum()))) {
                                errorMsg += "invalid finNumber for this problem key, ";
                            }
                        }
                    } catch (Exception ex) {
                        errorMsg += "invalid problem key, ";
                    }

                    if (!dateStr.equals("")) {
                        try {
                            java.util.Date tmp = sdf.parse(dateStr);
                            lawyerDate = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                            errorMsg += "Invalid Updated Lawyer Date Format,";
                        } 
                    }
                    ArrayList<String> list = DropdownDAO.retrieveAllDropdownListOfProblems();
                    boolean exit = false;
                    for (String tmp: list) {
                        if (tmp.equalsIgnoreCase(firmName)) {
                            exit = true;
                            break;
                        }
                    }
                    
                    if (!exit) {
                        errorMsg += "invalid Law Firm Name, ";
                    }
                    
                    

                    if (!firmName.equals("") && firmName.length() > 30) {
                        errorMsg += header[5] + " cannot be longer than 30 characters,";
                    }
                    
                    if (!firmNameMore.equals("") && firmNameMore.length() > 50) {
                        errorMsg += header[6] + " cannot be longer than 50 characters,";
                    }
                    
                    if (!lawyerName.equals("") && lawyerName.length() > 200) {
                        errorMsg += header[7] + " cannot be longer than 200 characters,";
                    }
                    
                    if (!rem.equals("") && rem.length() > 200) {
                        errorMsg += header[8] + " cannot be longer than 200 characters,";
                    }
                    
                    
                } //pass
                
                // if there is an error, the line number of the error and its relevant message is 
                // added into the errorList
                if (!errorMsg.equals("")) {
                    errList.add(lineNum + ":" + errorMsg);
                    errorMsg = ""; // reset errorMsg variable
                } // if there is no error, a new Worker object is created and added to the workerList
                else {
                    errorMsg = ""; // reset errorMsg variable
                    ProblemLawyer problemLawyer = new ProblemLawyer
                            (finNum, jobKey, probKey, lawyerDate, firmName, firmNameMore, lawyerName, rem);
                    addProblemLawyer (problemLawyer);
                }
                
            }
            csvReader.close();
                

        }catch (FileNotFoundException ex) {
            //fileNotFoundException
        }
        return errList;
    }
    
    /*Problem Case Milestone Non criminal*/
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
    
    public static ArrayList<String> validateAndAddProblemCaseMilestoneNC (String probNCFile) throws IOException {
        //Attributes
        ArrayList<String> errList = new ArrayList<String>();
        CSVReader csvReader = null;
        try{
            csvReader = new CSVReader(new FileReader(probNCFile));
            String[] header = csvReader.readNext();
            String[] fields;
            int lineNum = 1;
            String errorMsg = "";

            //Loops through each line of the csv with an array of String
            while ((fields = csvReader.readNext()) != null){
                lineNum++;
                //Assigning each field with its appropriate name
                String finNum = fields[0].trim();
                String jobKeyStr = fields[1].trim();
                String probKeyStr = fields[2].trim();
                String dateStr = fields[3].trim();
                String reached = fields[4].trim();
                String reachedMore = fields[5].trim();
                String rem = fields[6].trim();
               
                
                int jobKey = 0;
                int probKey = 0;
                java.sql.Date ncDate = null;
                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                
                /**
                 * Validations for empty fields
                 */
                boolean pass = true; //assume validation pass first;
                if (finNum.equals("")) {
                    errorMsg += header[0] + " is blank,";
                    pass = false;
                }
                
                if (jobKeyStr.equals("")) {
                    errorMsg += header[1] + " is blank,";
                    pass = false;
                }
                if (probKeyStr.equals("")) {
                    errorMsg += header[2] + " is blank,";
                    pass = false;
                }
                if (dateStr.equals("")) {
                    errorMsg += header[3] + " is blank,";
                    pass = false;
                }
                if (reached.equals("")) {
                    errorMsg += header[4] + " is blank,";
                    pass = false;
                }
                
                //proceed only after empty fields validation is passed
                if (pass) { 

                    // check for any existing worker  with the same finNum. 
                    Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                    if (worker == null) {
                        errorMsg += "invalid FinNumber, ";
                    }
                    
                    try {
                        jobKey = Integer.parseInt(jobKeyStr);
                        Job job = JobDAO.retrieveJobByJobId(jobKey);
                        if (job == null) {
                            errorMsg += "invalid job key, ";
                        } else {
                            if (worker != null && 
                                    !(worker.getFinNumber().equals(job.getWorkerFinNum()))) {
                                errorMsg += "invalid finNumber for this job key, ";
                            }
                        }
                    } catch (Exception ex) {
                        errorMsg += "invalid job key, ";
                    }
                    
                    try {
                        probKey = Integer.parseInt(probKeyStr);
                        Problem problem = ProblemDAO.retrieveProblemByProblemId(probKey);
                        if (problem == null) {
                            errorMsg += "invalid problem key, ";
                        } else {
                            if (worker != null && 
                                    !(worker.getFinNumber().equals(problem.getWorkerFinNum()))) {
                                errorMsg += "invalid finNumber for this problem key, ";
                            }
                        }
                    } catch (Exception ex) {
                        errorMsg += "invalid problem key, ";
                    }

                    if (!dateStr.equals("")) {
                        try {
                            java.util.Date tmp = sdf.parse(dateStr);
                            ncDate = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                            errorMsg += "Invalid Milestone NC Reached Date Format,";
                        } 
                    }
                    ArrayList<String> list = DropdownDAO.retrieveAllDropdownListOfProblems();
                    boolean exit = false;
                    for (String tmp: list) {
                        if (tmp.equalsIgnoreCase(reached)) {
                            exit = true;
                            break;
                        }
                    }
                    
                    if (!exit) {
                        errorMsg += "invalid Milestone Name, ";
                    }
                    
                    

                    if (!reached.equals("") && reached.length() > 50) {
                        errorMsg += header[5] + " cannot be longer than 50 characters,";
                    }
                    
                    if (!reachedMore.equals("") && reachedMore.length() > 200) {
                        errorMsg += header[6] + " cannot be longer than 200 characters,";
                    }
                    
                    if (!rem.equals("") && rem.length() > 200) {
                        errorMsg += header[7] + " cannot be longer than 200 characters,";
                    }
                    
                    
                } //pass
                
                // if there is an error, the line number of the error and its relevant message is 
                // added into the errorList
                if (!errorMsg.equals("")) {
                    errList.add(lineNum + ":" + errorMsg);
                    errorMsg = ""; // reset errorMsg variable
                } // if there is no error, a new Worker object is created and added to the workerList
                else {
                    errorMsg = ""; // reset errorMsg variable
                    ProblemCaseMilestoneNC problemCaseMilestoneNC = new ProblemCaseMilestoneNC
                            (finNum, jobKey, probKey,ncDate, reached, reachedMore, rem);
                    addProblemCaseMilestoneNC (problemCaseMilestoneNC);
                }  
            }    
            csvReader.close();
                

        } catch (FileNotFoundException ex) {
            //fileNotFoundException
        }
        return errList;
    }
   
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
    
    public static ArrayList<String> validateAndAddProblemCaseMilestoneCR (String probCRFile) throws IOException {
        //Attributes
        ArrayList<String> errList = new ArrayList<String>();
        CSVReader csvReader = null;
        try{
            csvReader = new CSVReader(new FileReader(probCRFile));
            String[] header = csvReader.readNext();
            String[] fields;
            int lineNum = 1;
            String errorMsg = "";

            //Loops through each line of the csv with an array of String
            while ((fields = csvReader.readNext()) != null){
                lineNum++;
                //Assigning each field with its appropriate name
                String finNum = fields[0].trim();
                String jobKeyStr = fields[1].trim();
                String probKeyStr = fields[2].trim();
                String dateStr = fields[3].trim();
                String reached = fields[4].trim();
                String reachedMore = fields[5].trim();
                String charges = fields[6].trim();
                String sentence = fields[7].trim();
                String rem = fields[8].trim();
               
                
                int jobKey = 0;
                int probKey = 0;
                java.sql.Date crDate = null;
                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                
                /**
                 * Validations for empty fields
                 */
                boolean pass = true; //assume validation pass first;
                if (finNum.equals("")) {
                    errorMsg += header[0] + " is blank,";
                    pass = false;
                }
                
                if (jobKeyStr.equals("")) {
                    errorMsg += header[1] + " is blank,";
                    pass = false;
                }
                if (probKeyStr.equals("")) {
                    errorMsg += header[2] + " is blank,";
                    pass = false;
                }
                if (dateStr.equals("")) {
                    errorMsg += header[3] + " is blank,";
                    pass = false;
                }
                if (reached.equals("")) {
                    errorMsg += header[4] + " is blank,";
                    pass = false;
                }

                
                
                //proceed only after empty fields validation is passed
                if (pass) { 

                    // check for any existing worker  with the same finNum. 
                    Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                    if (worker == null) {
                        errorMsg += "invalid FinNumber, ";
                    }
                    
                    try {
                        jobKey = Integer.parseInt(jobKeyStr);
                        Job job = JobDAO.retrieveJobByJobId(jobKey);
                        if (job == null) {
                            errorMsg += "invalid job key, ";
                        } else {
                            if (worker != null && 
                                    !(worker.getFinNumber().equals(job.getWorkerFinNum()))) {
                                errorMsg += "invalid finNumber for this job key, ";
                            }
                        }
                    } catch (Exception ex) {
                        errorMsg += "invalid job key, ";
                    }
                    
                    try {
                        probKey = Integer.parseInt(probKeyStr);
                        Problem problem = ProblemDAO.retrieveProblemByProblemId(probKey);
                        if (problem == null) {
                            errorMsg += "invalid problem key, ";
                        } else {
                            if (worker != null && 
                                    !(worker.getFinNumber().equals(problem.getWorkerFinNum()))) {
                                errorMsg += "invalid finNumber for this problem key, ";
                            }
                        }
                    } catch (Exception ex) {
                        errorMsg += "invalid problem key, ";
                    }

                    if (!dateStr.equals("")) {
                        try {
                            java.util.Date tmp = sdf.parse(dateStr);
                            crDate = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                            errorMsg += "Invalid Milestone CR Reached Date Format,";
                        } 
                    }
                    ArrayList<String> list = DropdownDAO.retrieveAllDropdownListOfProblems();
                    boolean exit = false;
                    for (String tmp: list) {
                        if (tmp.equalsIgnoreCase(reached)) {
                            exit = true;
                            break;
                        }
                    }
                    
                    if (!exit) {
                        errorMsg += "invalid Milestone Name, ";
                    }
                    
                    

                    if (!reached.equals("") && reached.length() > 50) {
                        errorMsg += header[5] + " cannot be longer than 50 characters,";
                    }
                    
                    if (!reachedMore.equals("") && reachedMore.length() > 200) {
                        errorMsg += header[6] + " cannot be longer than 200 characters,";
                    }
                    
                    if (!charges.equals("") && charges.length() > 200) {
                        errorMsg += header[7] + " cannot be longer than 200 characters,";
                    }

                    if (!sentence.equals("") && sentence.length() > 200) {
                        errorMsg += header[8] + " cannot be longer than 200 characters,";
                    }
                    
                    if (!rem.equals("") && rem.length() > 200) {
                        errorMsg += header[9] + " cannot be longer than 200 characters,";
                    }
                    
                    
                } //pass
                
                // if there is an error, the line number of the error and its relevant message is 
                // added into the errorList
                if (!errorMsg.equals("")) {
                    errList.add(lineNum + ":" + errorMsg);
                    errorMsg = ""; // reset errorMsg variable
                } // if there is no error, a new Worker object is created and added to the workerList
                else {
                    errorMsg = ""; // reset errorMsg variable
                    ProblemCaseMilestoneCR problemCaseMilestoneCR = new ProblemCaseMilestoneCR
                            (finNum, jobKey, probKey,crDate, reached, reachedMore, charges, sentence, rem);
                    addProblemCaseMilestoneCR (problemCaseMilestoneCR);
                }  
            }    
                csvReader.close();
                

        }catch (FileNotFoundException ex) {
            //fileNotFoundException
        }
        return errList;
    }

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
                Date departureDate = rs.getDate(4);
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
            pstmt.setDate(4, problemTTR.getDepartureDate());
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
            pstmt.setDate(4, problemTTR.getDepartureDate());
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
    
    public static ArrayList<String> validateAndAddProblemTTR (String probTTRFile) throws IOException {
        //Attributes
        ArrayList<String> errList = new ArrayList<String>();
        CSVReader csvReader = null;
        try{
            csvReader = new CSVReader(new FileReader(probTTRFile));
            String[] header = csvReader.readNext();
            String[] fields;
            int lineNum = 1;
            String errorMsg = "";

            //Loops through each line of the csv with an array of String
            while ((fields = csvReader.readNext()) != null){
                lineNum++;
                //Assigning each field with its appropriate name
                String finNum = fields[0].trim();
                String jobKeyStr = fields[1].trim();
                String probKeyStr = fields[2].trim();
                String dateStr = fields[3].trim();
                String status = fields[4].trim();
                String statusMore = fields[5].trim();
                String departureDateStr = fields[6].trim();
                String nameNew = fields[7].trim();
                String newJob = fields[8].trim();
                String rem = fields[9].trim();
               
                
                int jobKey = 0;
                int probKey = 0;
                java.sql.Date updatedDate = null;
                java.sql.Date depatureDate = null;
                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                
                /**
                 * Validations for empty fields
                 */
                boolean pass = true; //assume validation pass first;
                if (finNum.equals("")) {
                    errorMsg += header[0] + " is blank,";
                    pass = false;
                }
                
                if (jobKeyStr.equals("")) {
                    errorMsg += header[1] + " is blank,";
                    pass = false;
                }
                if (probKeyStr.equals("")) {
                    errorMsg += header[2] + " is blank,";
                    pass = false;
                }
                if (dateStr.equals("")) {
                    errorMsg += header[3] + " is blank,";
                    pass = false;
                }
                if (status.equals("")) {
                    errorMsg += header[4] + " is blank,";
                    pass = false;
                }
                
                //proceed only after empty fields validation is passed
                if (pass) { 

                    // check for any existing worker  with the same finNum. 
                    Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                    if (worker == null) {
                        errorMsg += "invalid FinNumber, ";
                    }
                    
                    try {
                        jobKey = Integer.parseInt(jobKeyStr);
                        Job job = JobDAO.retrieveJobByJobId(jobKey);
                        if (job == null) {
                            errorMsg += "invalid job key, ";
                        } else {
                            if (worker != null && 
                                    !(worker.getFinNumber().equals(job.getWorkerFinNum()))) {
                                errorMsg += "invalid finNumber for this job key, ";
                            }
                        }
                    } catch (Exception ex) {
                        errorMsg += "invalid job key, ";
                    }
                    
                    try {
                        probKey = Integer.parseInt(probKeyStr);
                        Problem problem = ProblemDAO.retrieveProblemByProblemId(probKey);
                        if (problem == null) {
                            errorMsg += "invalid problem key, ";
                        } else {
                            if (worker != null && 
                                    !(worker.getFinNumber().equals(problem.getWorkerFinNum()))) {
                                errorMsg += "invalid finNumber for this problem key, ";
                            }
                        }
                    } catch (Exception ex) {
                        errorMsg += "invalid problem key, ";
                    }

                    if (!dateStr.equals("")) {
                        try {
                            java.util.Date tmp = sdf.parse(dateStr);
                            updatedDate = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                            errorMsg += "Invalid Updated TTR Date Format,";
                        } 
                    }
                    ArrayList<String> list = DropdownDAO.retrieveAllDropdownListOfProblems();
                    boolean exit = false;
                    for (String tmp: list) {
                        if (tmp.equalsIgnoreCase(status)) {
                            exit = true;
                            break;
                        }
                    }
                    
                    if (!exit) {
                        errorMsg += "invalid TTR Status, ";
                    }
                    
                    

                    if (!status.equals("") && status.length() > 50) {
                        errorMsg += header[5] + " cannot be longer than 50 characters,";
                    }
                    
                    if (!statusMore.equals("") && statusMore.length() > 200) {
                        errorMsg += header[6] + " cannot be longer than 200 characters,";
                    }
                    
                    if (!departureDateStr.equals("")) {
                        try {
                            java.util.Date tmp = sdf.parse(dateStr);
                            depatureDate = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                            errorMsg += "Invalid depatureDate Date Format,";
                        } 
                    }


                    if (!nameNew.equals("") && nameNew.length() > 50) {
                        errorMsg += header[8] + " cannot be longer than 50 characters,";
                    }

                    if (!newJob.equals("") && newJob.length() > 200) {
                        errorMsg += header[9] + " cannot be longer than 50 characters,";
                    }
                    
                    if (!rem.equals("") && rem.length() > 200) {
                        errorMsg += header[10] + " cannot be longer than 200 characters,";
                    }
                    
                    
                } //pass
                
                // if there is an error, the line number of the error and its relevant message is 
                // added into the errorList
                if (!errorMsg.equals("")) {
                    errList.add(lineNum + ":" + errorMsg);
                    errorMsg = ""; // reset errorMsg variable
                } // if there is no error, a new Worker object is created and added to the workerList
                else {
                    errorMsg = ""; // reset errorMsg variable
                    ProblemTTR problemTTR = new ProblemTTR
                            (finNum, jobKey, probKey, updatedDate, status, statusMore, depatureDate, nameNew, newJob, rem);
                    addProblemTTR (problemTTR);
                } 
                
            }
            csvReader.close();          

        } catch (FileNotFoundException ex) {
            //fileNotFoundException
        }
        return errList;
    }

    /*general*/
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
