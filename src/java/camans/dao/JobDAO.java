/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.dao;

import camans.entity.Job;
import camans.entity.User;
import camans.entity.Worker;
import java.sql.Connection;
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
public class JobDAO {

    public static ArrayList<Integer> retrieveJobIdsOfWorker (Worker worker) {
        ArrayList<Integer> jobIds = new ArrayList<Integer>();
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

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
