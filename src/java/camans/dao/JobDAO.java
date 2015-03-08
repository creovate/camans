/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.dao;

import au.com.bytecode.opencsv.CSVReader;
import au.com.bytecode.opencsv.CSVWriter;
import camans.entity.Job;
import camans.entity.User;
import camans.entity.Worker;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author soemyatmyat
 */
public class JobDAO {
    
    /**
     * WorkerDAO has a public static variable jobList which is an
     * HashMap of Job with the key that stores the validated list of jobs
     * for input to SQL
     */
    public static HashMap<String, ArrayList<Job>> jobList = new HashMap<String, ArrayList<Job>>();
    
    public static int retrieveMaxJobId() {
        
        int jobKey = 0;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT max(Job_key) from tbl_job";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                jobKey = rs.getInt(1);
            }
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "Cannot retrieve max job id");
        } finally {
            ConnectionManager.close(conn, pstmt);
        }  
        return jobKey;
    }
    
    public static ArrayList<Integer> retrieveJobIdsOfWorker (Worker worker) {
        ArrayList<Integer> jobIds = new ArrayList<Integer>();
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
        String finNum = worker.getFinNumber();
        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Job_key FROM tbl_job where Worker_FIN_number = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, worker.getFinNumber());
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int jobKey = rs.getInt(1);
                jobIds.add(jobKey);
            }
            
        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }        
        
        return jobIds;
    }
    
    public static Job retrieveJobByJobId(int jobId) {
        Job job = null;
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Worker_FIN_number, Job_key, Employer_name, Workpass_type, Workpass_more, Job_sector,"
                    + "Job_sector_more, Occupation, Job_start_date, Job_end_date, Job_whether_TJS, Job_remarks"
                    + " FROM tbl_job where Job_Key = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, jobId);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String workerFinNumber = rs.getString(1);
                int jobKey = rs.getInt(2);
                String employerName = rs.getString(3);
                String workPassType = rs.getString(4);
                String workPassMore = rs.getString(5);
                String jobSector = rs.getString(6);
                String jobSectorMore = rs.getString(7);
                String occupation = rs.getString(8);
                String jobStartDate = rs.getString(9);
                String jobEndDate = rs.getString(10);
                String jobTJS = rs.getString(11);
                String jobRemark = rs.getString(12);
                job = new Job(workerFinNumber, jobKey, employerName, workPassType, workPassMore, 
                        jobSector, jobSectorMore, occupation, jobStartDate, jobEndDate,
                        jobTJS, jobRemark);
            }
            
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "Job={" + job + "}");           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return job;
    }
    
    public static void addJob(Worker worker, Job job) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "INSERT INTO tbl_job (Worker_FIN_number, Job_key, Employer_name,  Workpass_type, Workpass_more, "
                    + "Job_sector, Job_sector_more, Occupation, Job_start_date, job_end_date,"
                    + "Job_whether_TJS, Job_remarks) "
                    + "VALUES (?,?,?,?,?,?,?,?,?,?,?,?)";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, worker.getFinNumber());
            pstmt.setInt(2, job.getJobKey());
            pstmt.setString(3, job.getEmployerName());
            pstmt.setString(4, job.getWorkPassType());
            pstmt.setString(5, job.getWorkPassMore());
            pstmt.setString(6, job.getJobSector());
            pstmt.setString(7, job.getJobSectorMore());
            pstmt.setString(8, job.getOccupation());
            pstmt.setString(9, job.getJobStartDate());
            pstmt.setString(10, job.getJobEndDate());
            pstmt.setString(11, job.getJobTJS());
            pstmt.setString(12, job.getJobRemark());
            
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "Worker={" + worker + "} Job={" + job + "}");
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
            
            sql = "DELETE FROM tbl_job";
            pstmt = conn.prepareStatement(sql);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "not able to delete data from Job Table. ");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        } 
    }
    
    public static void deleteJob(int jobKey) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            
            sql = "DELETE FROM tbl_job WHERE Job_key = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, jobKey);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "not able to delete data from Job Table. ");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        } 
    }
    
    public static String validateAndAddJob(String jobFileName, String jobErrFile) throws IOException {
        
        // empty existing data in jobList before continuing
        jobList.clear();
        // Attributes
        CSVReader csvReader = null;
        CSVWriter csvWriter = null;
        int errCount = 0;
        try {
            csvReader = new CSVReader(new FileReader(jobFileName));
            String[] header = csvReader.readNext();
            String[] fields;
            String errorMsg = "";
            Worker worker = null;

            // Loops through each line of the csv with an array of String
            while ((fields = csvReader.readNext()) != null) {
                // Assigning each field with its appropriate name
                String finNum = fields[0].trim();
                String jobKeyStr = fields[1].trim();
                String employerName = fields[2].trim();
                String workPassType = fields[3].trim();
                String workPassOther = fields[4].trim();
                String jobSector = fields[5].trim();
                String jobSectorOther = fields[6].trim();
                String occupation = fields[7].trim();
                String jobStartDate = fields[8].trim();
                String jobEndDate = fields[9].trim();
                String jobTJS = fields[10].trim();
                String jobRemark = fields[11].trim();
                int jobKey = 0;

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
                if (employerName.equals("")) {
                    errorMsg += header[2] + " is blank,";
                    pass = false;
                }
                if (workPassType.equals("")) {
                    errorMsg += header[3] + " is blank,";
                    pass = false;
                }

                //proceed only after empty fields validation is passed
                if (pass) { 

                    boolean exist = false; //assume fin does not exist in workerList first

                    try {
                        jobKey = Integer.parseInt(jobKeyStr);
                        Job tmpJob = JobDAO.retrieveJobByJobId(jobKey);
                        if (tmpJob != null) {
                            errorMsg += "duplicate jobKey, ";
                        }
                    } catch (Exception ex) {
                        errorMsg += "Invalid Job Key Format,";
                    }

                    if (employerName.length() > 50) {
                        errorMsg += "Employer Name is longer than 50 characters,";
                    }

                    ArrayList<String> workPassList = DropdownDAO.retrieveAllDropdownListOfWorkpassType();
                    exist = false;
                    for (String tmp: workPassList) {
                        if (tmp.equalsIgnoreCase(workPassType)) {
                            exist = true;
                            break;
                        }
                    }
                    if (!exist) {
                        errorMsg += "Invalid Worker Pass Type, ";
                    }

                    if (!workPassOther.equals("") && workPassOther.length() > 50) {
                        errorMsg += header[4] + " cannot be more than 50 characters,";
                    }

                    if (!jobSector.equals("")) {
                        ArrayList<String> jobSectorList = DropdownDAO.retrieveAllDropdownListOfJobSector();
                        exist = false;
                        for (String tmp: jobSectorList) {
                            if (tmp.equalsIgnoreCase(jobSector)) {
                                exist = true;
                                break;
                            }
                        }
                        if (!exist) {
                            errorMsg += "Invalid Job Sector, ";
                        }
                    }

                    if (!jobSectorOther.equals("") && jobSectorOther.length() > 50) {
                        errorMsg += header[6] + " cannot be more than 50 characters,";
                    }

                    if (!occupation.equals("") && occupation.length() > 50) {
                        errorMsg += header[7] + " cannot be more than 50 characters,";
                    }

                    if (!jobStartDate.equals("") && jobStartDate.length() > 50) {
                        errorMsg += header[8] + " cannot be more than 500 characters,";
                    }

                    if (!jobEndDate.equals("") && jobEndDate.length() > 50) {
                        errorMsg += header[9] + " cannot be more than 500 characters,";
                    }

                    if (!jobTJS.equals("")) {
                        if (jobTJS.equalsIgnoreCase("Yes") || jobTJS.equalsIgnoreCase("No")) {

                        } else {
                            errorMsg += "Invalid TJS Format. Should be either 'Yes' or 'No, ";
                        }
                    }


                    if (!jobRemark.equals("") && jobRemark.length() > 500) {
                        errorMsg += header[11] + " cannot be more than 500 characters,";
                    }

                }    

                // if there is an error, the line number of the error and its relevant message is added into the errorList
                if (!errorMsg.equals("")) {
                    
                    csvWriter = new CSVWriter(new FileWriter(jobErrFile, true));
                    if (errCount == 0) {
                        String[] newHeader = new String[13];
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
                    Job job = new Job(finNum, jobKey, employerName, workPassType, workPassOther, jobSector, 
                                jobSectorOther, occupation, jobStartDate, jobEndDate, jobTJS, jobRemark);
                    //addJob(worker, job);
                    ArrayList<Job> tmp = new ArrayList<Job>();
                    tmp = jobList.get(finNum);
                    if (tmp == null) {
                        tmp = new ArrayList<Job>();
                    }
                    tmp.add(job);
                    jobList.put(finNum, tmp);
                }    
            }
            csvReader.close();
        } catch (FileNotFoundException ex) {
            //fileNotFoundExceptin
        }
        if (errCount != 0) {
            return "job.csv:" + errCount;
        }
        return null;
    }
        
    public static void addAll(ArrayList<Job> jobList) {
        if (jobList != null && !jobList.isEmpty()) {
            for (Job job: jobList) {
                Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(job.getWorkerFinNum());
                addJob(worker, job);
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
    
    public static void updateJob(Job job) {
        Connection conn = null;
        PreparedStatement stmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_job SET Employer_name = ? , Workpass_type = ?, Workpass_more = ? ,"
                    + "Job_sector =?, Job_sector_more=?, Occupation=?, "
                    + "Job_start_date =?, Job_end_date=?, Job_whether_TJS=?, Job_remarks=? "
                    + "WHERE Job_key = ?";
            
            stmt = conn.prepareStatement(sql);
            
            stmt.setString(1, job.getEmployerName());
            stmt.setString(2, job.getWorkPassType());
            stmt.setString(3, job.getWorkPassMore());
            stmt.setString(4, job.getJobSector());
            stmt.setString(5, job.getJobSectorMore());
            stmt.setString(6, job.getOccupation());
            stmt.setString(7, job.getJobStartDate());
            stmt.setString(8, job.getJobEndDate());
            stmt.setString(9, job.getJobTJS());
            stmt.setString(10, job.getJobRemark());
            stmt.setInt(11, job.getJobKey());
            
            stmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "Job={" + job + "}");
        } finally {
            ConnectionManager.close(conn, stmt, null);
        }        
    }
}
