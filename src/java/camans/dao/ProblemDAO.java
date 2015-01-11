/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.dao;

import au.com.bytecode.opencsv.CSVReader;
import camans.entity.Job;
import camans.entity.Problem;
import camans.entity.Worker;
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
    
    public static void updateProblem(Problem problem) {
        Connection conn = null;
        PreparedStatement stmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_problem SET Chief_problem_date = ?, Chief_problem = ? ,"
                    + " Chief_problem_more = ?, Chief_problem_remarks = ? "
                    + "WHERE Worker_FIN_number = ? AND Job_key = ? AND Prob_key = ?";
            
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
      
    public static void deleteAll() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            
            sql = "DELETE FROM tbl_problem";
            pstmt = conn.prepareStatement(sql);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "not able to delete data from Problem Table. ");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }  
    }
    
    public static ArrayList<String> validateAndAddProblem(String probFileName) throws IOException{

        // Attributes
        ArrayList<String> errList = new ArrayList<String>();
        try {
            CSVReader csvReader = new CSVReader(new FileReader(probFileName));
            String[] header = csvReader.readNext();
            String[] fields;
            int lineNum = 1;
            String errorMsg = "";
            Worker worker = null;
            Job job = null;

            // Loops through each line of the csv with an array of String
            while ((fields = csvReader.readNext()) != null) {
                lineNum++;
                // Assigning each field with its appropriate name
                String finNum = fields[0].trim();
                String jobKeyStr = fields[1].trim();
                String probKeyStr = fields[2].trim();
                String registeredDateStr = fields[3].trim();
                String problemType = fields[4].trim();
                String problemTypeOther = fields[5].trim();
                String problemRemark = fields[6].trim();

                int jobKey = 0;
                int probKey = 0;
                java.sql.Date registeredDate = null;
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
                if (registeredDateStr.equals("")) {
                    errorMsg += header[3] + " is blank,";
                    pass = false;
                }
                if (problemType.equals("")) {
                    errorMsg += header[4] + " is blank,";
                    pass = false;
                }

                //proceed only after empty fields validation is passed
                if (pass) { 

                    // check for any existing worker  with the same finNum. 
                    worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                    if (worker == null) {
                        errorMsg += "invalid FinNumber, ";
                    }

                    try {
                        jobKey = Integer.parseInt(jobKeyStr);
                        job = JobDAO.retrieveJobByJobId(jobKey);
                        if (job == null) {
                            errorMsg += "invalid jobkey, ";
                        } else {
                            if (worker != null && 
                                    !(worker.getFinNumber().equals(job.getWorkerFinNum()))) {
                                errorMsg += "invalid finNumber for this jobkey, ";
                            }
                        }
                    } catch (Exception ex) {
                        errorMsg += "Invalid Job Key Format,";
                    }

                    try {
                        probKey = Integer.parseInt(probKeyStr);
                        Problem tmpProb = ProblemDAO.retrieveProblemByProblemId(probKey);
                        if (tmpProb != null) {
                            errorMsg += "duplicate problem key, ";
                        }
                    } catch (Exception ex) {
                        errorMsg += "Invalid Problem Key Format,";
                    }

                    try {
                        java.util.Date tmp = sdf.parse(registeredDateStr);
                        registeredDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        errorMsg += "Invalid Registered Date Format,";
                    } 

                    ArrayList<String> problemTypeList = DropdownDAO.retrieveAllDropdownListOfProblems();
                    boolean exist = false;
                    for (String tmp: problemTypeList) {
                        if (tmp.equalsIgnoreCase(problemType)) {
                            exist = true;
                            break;
                        }
                    }
                    if (!exist) {
                        errorMsg += "Invalid Problem type, ";
                    }

                    if (!problemTypeOther.equals("") && problemTypeOther.length() > 50) {
                        errorMsg += header[5] + " cannot be more than 50 characters,";
                    }

                    if (!problemRemark.equals("") && problemRemark.length() > 200) {
                        errorMsg += header[6] + " cannot be more than 200 characters,";
                    }


                }    

                // if there is an error, the line number of the error and its relevant message is added into the errorList
                if (!errorMsg.equals("")) {
                    errList.add(lineNum + ":" + errorMsg);
                    errorMsg = ""; // reset errorMsg variable
                } // if there is no error, a new Worker object is created and added to the workerList
                else {
                    errorMsg = ""; // reset errorMsg variable
                    Problem problem = new Problem(finNum, jobKey, probKey, registeredDate, problemType,
                            problemTypeOther, problemRemark, null, null, null, null);
                    ProblemDAO.addProblem(worker, job, problem);
                }    
            }
            csvReader.close();
        } catch (FileNotFoundException ex) {
            //filenotfoundexception
        }
        return errList;
    }
    
    public static void addAll(ArrayList<Problem> problemList) {
        if (problemList != null && !problemList.isEmpty()) {
            for (Problem problem: problemList) {
                Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(problem.getWorkerFinNum());
                Job job = JobDAO.retrieveJobByJobId(problem.getJobKey());
                addProblem(worker, job, problem);
            }
            
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
