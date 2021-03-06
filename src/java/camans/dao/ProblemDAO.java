/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.dao;

import au.com.bytecode.opencsv.CSVReader;
import au.com.bytecode.opencsv.CSVWriter;
import camans.entity.Job;
import camans.entity.Problem;
import camans.entity.Worker;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author soemyatmyat
 */
public class ProblemDAO {

    /**
     * WorkerDAO has a public static variable problemList which is an
     * HashMap of Problem with the key that stores the validated list of jobs
     * for input to SQL
     */
    public static HashMap<String, ArrayList<Problem>> problemList = new HashMap<String, ArrayList<Problem>>();
    
    /**
     * retrieve a list of problem ids of this worker and this job
     * @param worker worker 
     * @param job job
     * @return a list of problem ids of this worker and this job
     */
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
    
    /**
     * retrieve Problem
     * @param problemid - problem id
     * @return problem with this problem id
     */
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
    
    /**
     * Update Problem details of this problem
     * @param problem problem
     */
    public static void updateProblem(Problem problem) {
        Connection conn = null;
        PreparedStatement stmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_problem SET Chief_problem_date = ?, Chief_problem = ? ,"
                    + " Chief_problem_more = ?, Chief_problem_remarks = ?, Referred_by = ?, "
                    + "Referred_to = ?, Referred_date = ?, Description = ? "
                    + "WHERE Worker_FIN_number = ? AND Job_key = ? AND Prob_key = ?";
            
            stmt = conn.prepareStatement(sql);
            
            stmt.setDate(1, problem.getProblemRegisteredDate());
            stmt.setString(2, problem.getProblem());
            stmt.setString(3, problem.getProblemMore());
            stmt.setString(4, problem.getProblemRemark());
            stmt.setString(5, problem.getReferredBy());
            stmt.setString(6, problem.getcurrentLeadCaseWorker());
            stmt.setDate(7, problem.getReferredDate());
            stmt.setString(8, problem.getReferralDescription());
            stmt.setString(9, problem.getWorkerFinNum());
            stmt.setInt(10, problem.getJobKey());
            stmt.setInt(11, problem.getProbKey());
            
            stmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "problem={" + problem + "}");
        } finally {
            ConnectionManager.close(conn, stmt, null);
        }        
    }
        
    /**
     * add this Problem to this worker with this job
     * @param worker worker
     * @param job job
     * @param problem problem
     */
    public static void addProblem(Worker worker, Job job, Problem problem) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "INSERT INTO tbl_problem (Worker_FIN_number, Job_key, Chief_problem_date, "
                    + "Chief_problem, Chief_problem_more, Chief_problem_remarks) "
                    + "VALUES (?,?,?,?,?, ?)";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, worker.getFinNumber());
            pstmt.setInt(2, job.getJobKey());
            pstmt.setDate(3, problem.getProblemRegisteredDate());
            pstmt.setString(4, problem.getProblem());
            pstmt.setString(5, problem.getProblemMore());
            pstmt.setString(6, problem.getProblemRemark());           
            pstmt.executeUpdate();
            
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "Worker={" + worker + "} Job={" + job + "} Problem={" + problem);
        } finally {
            ConnectionManager.close(conn, pstmt);
        }    
    }
      
    public static void addProblemData(Worker worker, Job job, Problem problem) {
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
    
    /**
     * delete all data in problems
     */
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
    
    /**
     * delete problem with this problem id
     * @param problem problem id
     */
    public static void deleteProblem(int probKey) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            
            sql = "DELETE FROM tbl_problem WHERE Prob_key = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, probKey);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "not able to delete data from Problem Table. ");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }  
    }
    
    /**
     * validating problem fields
     * @param probFileName - csv file name for problem data
     * @param problemErrFile - csv file name to store error from problem data
     * @return how many data got error
     */
    public static String validateAndAddProblem(String probFileName, String problemErrFile) throws IOException{
        problemList.clear();
        // Attributes
        CSVReader csvReader = null;
        CSVWriter csvWriter = null;
        int errCount = 0;
        try {
            csvReader = new CSVReader(new FileReader(probFileName));
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
                //SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
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


                    try {
                        jobKey = Integer.parseInt(jobKeyStr);
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
                    csvWriter = new CSVWriter(new FileWriter(problemErrFile, true));
                    if (errCount == 0) {
                        String[] newHeader = new String[8];
                        newHeader[header.length] = "Error_Description";
                        System.arraycopy(header, 0, newHeader, 0, header.length);
                        csvWriter.writeNext(newHeader);
                    }
                    String[] newFields = new String[header.length+1];
                    newFields[header.length] = errorMsg.substring(0, errorMsg.lastIndexOf(","));
                    System.arraycopy(fields, 0, newFields, 0, header.length);
                    csvWriter.writeNext(newFields);
                    csvWriter.close();
                    errorMsg = ""; // reset errorMsg variable
                    errCount++;
                } // if there is no error, a new Worker object is created and added to the workerList
                else {
                    errorMsg = ""; // reset errorMsg variable
                    Problem problem = new Problem(finNum, jobKey, probKey, registeredDate, problemType,
                            problemTypeOther, problemRemark, null, null, null, null);
                    //ProblemDAO.addProblem(worker, job, problem);
                    ArrayList<Problem> tmp = new ArrayList<Problem>();
                    tmp = problemList.get(finNum);
                    if (tmp == null) {
                        tmp = new ArrayList<Problem>();
                    }
                    tmp.add(problem);
                    problemList.put(finNum, tmp);
                }    
            }
            csvReader.close();
        } catch (FileNotFoundException ex) {
            //filenotfoundexception
        }
        if (errCount != 0) {
            return "problem.csv:" + errCount;
        }
        return null;
    }
    
    /**
     * add problem in problem list
     * @param problemList a list of problems
     */
    public static void addAll(ArrayList<Problem> problemList) {
        if (problemList != null && !problemList.isEmpty()) {
            for (Problem problem: problemList) {
                Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(problem.getWorkerFinNum());
                Job job = JobDAO.retrieveJobByJobId(problem.getJobKey());
                addProblem(worker, job, problem);
            }
            
        }  
    }
    
    /**
     * retrieve the latest year from problem
     * @return the latest year stored in problem
     */
    public static int getMaxYear() {
        int year = 0;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Year(max(Chief_problem_date)) FROM tbl_problem;";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                year = rs.getInt(1);
            }

           
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "getMaxYear={" + year + "}");           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return year;
    }
    
    /**
     * retrieve the earliest year from problem
     * @return the earliest year stored in problem
     */
    public static int getMinYear() {
        int year = 0;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Year(min(Chief_problem_date)) FROM tbl_problem;";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                year = rs.getInt(1);
            }

           
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "getMinYear={" + year + "}");           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return year;
    }
    
    /**
     * retrieve the problem count given nationality and year
     * @param nationality --
     * @param year -- year 
     * @return the total number of problems for given nationality and year
     */
    public static int retrieveProblemCountByNationalityAndYear(String nationality, int year) {
        int count = 0;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT COUNT(*) from "
                    + "(select Worker_FIN_number from tbl_problem where Year(Chief_problem_date) = ?) as table1 "
                    + "INNER JOIN (select FIN_number from tbl_worker where Nationality = ?) as table2 "
                    + "on table1.Worker_FIN_number = table2.FIN_number;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, year);
            pstmt.setString(2, nationality);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                count = rs.getInt(1);
            }                

           
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemCountByNationalityAndYear={" + count + "}");           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return count;
    }
    
    /**
     * retrieve the problem count given nationality and year and job sector
     * @param nationality --
     * @param year -- year 
     * @param jobSector -- job sector
     * @return the total number of problems for given nationality and year and job sector
     */
    public static int retrieveProblemCountByNationalityAndYearAndJobSector (String nationality, 
            int year, String jobSector) {
        int count = 0;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT count(distinct Prob_key) "
                    + "FROM (SELECT * from (select Worker_FIN_number, Prob_key from tbl_problem "
                    + "where Year(Chief_problem_date) = ?) as table1 INNER JOIN "
                    + "(select * from tbl_worker where Nationality = ?) as table2 "
                    + "on table1.Worker_FIN_number = table2.FIN_number) as table3 "
                    + "INNER JOIN (select * from tbl_job where Job_sector = ?) as table4 "
                    + "on table3.Worker_FIN_number = table4.Worker_FIN_number;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, year);
            pstmt.setString(2, nationality);
            pstmt.setString(3, jobSector);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                count = rs.getInt(1);
            }                

           
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "ProblemCountByNationalityAndYearAndJobSector={" + count + "}");           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return count;
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
