/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
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
public class JobComplementsDAO {
    
    /*Job Pass Details*/
    public static ArrayList<Integer> retrievePassDetailsIdsOfJob (Job job) {
         ArrayList<Integer> ids = new ArrayList<Integer>();

         Connection conn = null;
         PreparedStatement pstmt = null;
         ResultSet rs = null;
         String sql = "";

         try {
             conn = ConnectionManager.getConnection();
             sql = "SELECT ID FROM tbl_pass_details where Worker_FIN_number = ? AND Job_key =?";
             pstmt = conn.prepareStatement(sql);
             pstmt.setString(1, job.getWorkerFinNum());
             pstmt.setInt(2, job.getJobKey());
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

    public static JobPassDetails retrieveJobPassDetailsById(int id) {
        JobPassDetails jobPassDetails = null;

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Pass_type, Pass_type_more,"
                    + " Pass_number, Pass_application_date, Pass_issue_date,"
                    + "Pass_expiry_date, Pass_issuer, Pass_remarks, "
                    + "Pass_obsolete_date, Worker_FIN_number, Job_key "
                    + " FROM tbl_pass_details where ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String Pass_type = rs.getString(1);
                String Pass_type_more = rs.getString(2);
                String passNumber = rs.getString(3);    
                Date Pass_application_date = rs.getDate(4);
                Date Pass_issue_date = rs.getDate(5);
                Date Pass_expiry_date = rs.getDate(6);
                String Pass_issuer = rs.getString(7);
                String Pass_remarks = rs.getString(8);
                Date obseleteDate = rs.getDate(9);
                String workerFinNumber = rs.getString(10);
                int jobKey = rs.getInt(11);
                
                jobPassDetails = new JobPassDetails(id, workerFinNumber, jobKey,Pass_type, Pass_type_more
                        ,passNumber, Pass_application_date,Pass_issue_date,Pass_expiry_date,
                        Pass_issuer,Pass_remarks,obseleteDate);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql, "JobPassDetails={" + jobPassDetails + "}");           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return jobPassDetails;
    }

    public static void addJobPassDetails(JobPassDetails jobPassDetails) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "INSERT INTO tbl_pass_details (Pass_type, Pass_type_more, "
                    + "Pass_number, Pass_application_date, "
                    + " Pass_issue_date, Pass_expiry_date, Pass_issuer,"
                    + "Pass_remarks, Pass_obsolete_date, Worker_FIN_number, Job_key) "
                    + "VALUES (?,?,?,?,?,?,?,?,?,?,?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, jobPassDetails.getPassType());
            pstmt.setString(2, jobPassDetails.getPassTypeMore());
            pstmt.setString(3, jobPassDetails.getPassNum());
            pstmt.setDate(4, jobPassDetails.getPassApplicationDate());
            pstmt.setDate(5, jobPassDetails.getIssueDate());
            pstmt.setDate(6, jobPassDetails.getExpiryDate());
            pstmt.setString(7, jobPassDetails.getIssuer());
            pstmt.setString(8, jobPassDetails.getRemarks());
            pstmt.setDate(9, jobPassDetails.getObsoleteDate());
            pstmt.setString(10, jobPassDetails.getWorkerFinNum());
            pstmt.setInt(11, jobPassDetails.getJobKey());

            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "jobPassDetails: " + jobPassDetails + "}");
        } finally {
            ConnectionManager.close(conn, pstmt);
        }    
    }

    public static void updateJobPassDetails(JobPassDetails jobPassDetails) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_pass_details SET Pass_type = ? , Pass_type_more = ?,"
                    + "Pass_number =?, Pass_application_date=?, Pass_issue_date=?,"
                    + "Pass_expiry_date=?, Pass_issuer=?, Pass_remarks=?,"
                    + "Pass_obsolete_date=?  "
                    + "WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, jobPassDetails.getPassType());
            pstmt.setString(2, jobPassDetails.getPassTypeMore());
            pstmt.setString(3, jobPassDetails.getPassNum());
            pstmt.setDate(4, jobPassDetails.getPassApplicationDate());
            pstmt.setDate(5, jobPassDetails.getIssueDate());
            pstmt.setDate(6, jobPassDetails.getExpiryDate());
            pstmt.setString(7, jobPassDetails.getIssuer());
            pstmt.setString(8, jobPassDetails.getRemarks());
            pstmt.setDate(9, jobPassDetails.getObsoleteDate());
            pstmt.setInt(10, jobPassDetails.getId());

            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "jobPassDetails={" + jobPassDetails + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }        
    }
    
    public static void deleteAllJobPassDetails() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            
            sql = "DELETE FROM tbl_pass_details";
            pstmt = conn.prepareStatement(sql);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "not able to delete data from Job-Pass Details Table. ");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }     
    }
        
    public static ArrayList<String> validateAndAddJobPassDetails(String jobPassFile) 
            throws IOException{
        
        // Attributes
        ArrayList<String> errList = new ArrayList<String>();
        CSVReader csvReader = null;
        try {
            csvReader = new CSVReader(new FileReader(jobPassFile));
            String[] header = csvReader.readNext();
            String[] fields;
            int lineNum = 1;
            String errorMsg = "";
            int count = 0;

            // Loops through each line of the csv with an array of String
            while ((fields = csvReader.readNext()) != null) {
                lineNum++;
                // Assigning each field with its appropriate name
                String finNum = fields[0].trim();
                String jobKeyStr = fields[1].trim();
                String passType = fields[2].trim();
                String passTypeMore = fields[3].trim();
                String passNbr = fields[4].trim();
                String passApplicDateStr = fields[5].trim();
                String passIssueDateStr = fields[6].trim();
                String passExpDateStr = fields[7].trim();
                String passIssuer = fields[8].trim();
                String passRemark = fields[9].trim();
                String obseleteDateStr = fields[10].trim();
                
                int jobKey = 0;
                java.sql.Date passApplicDate = null;
                java.sql.Date passIssueDate = null;
                java.sql.Date passExpDate = null;
                java.sql.Date obseleteDate = null;
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
                if (passType.equals("")) {
                    errorMsg += header[2] + " is blank,";
                    pass = false;
                }
                if (passNbr.equals("")) {
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
                    
                    ArrayList<String> list = DropdownDAO.retrieveAllDropdownListOfPassType();
                    boolean exit = false;
                    for (String tmp: list) {
                        if (tmp.equalsIgnoreCase(passType)) {
                            exit = true;
                            break;
                        }
                    }
                    
                    if (!exit) {
                        errorMsg += "invalid Pass Type, ";
                    }
                    
                    if (!passTypeMore.equals("") && passTypeMore.length() > 255){
                        errorMsg += header[3] + " cannot be more than 255 characters,";
                    }
                    
                    if (passNbr.length() > 20) {
                        errorMsg += header[4] + " cannot be more than 20 characters,";
                    }
                    if (!passApplicDateStr.equals("")) {
                        try {
                            java.util.Date tmp = sdf.parse(passApplicDateStr);
                            passApplicDate = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                            errorMsg += "Invalid Pass Application Date Format,";
                        } 
                    }
                    
                    if (!passIssueDateStr.equals("")) {
                        try {
                            java.util.Date tmp = sdf.parse(passIssueDateStr);
                            passIssueDate = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                            errorMsg += "Invalid Pass Issue Date Format,";
                        } 
                    }
                    
                    if (!passExpDateStr.equals("")) {
                        try {
                            java.util.Date tmp = sdf.parse(passExpDateStr);
                            passExpDate = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                            errorMsg += "Invalid Pass Expiry Date Format,";
                        } 
                    }
                    
                    if (!passIssuer.equals("") && passIssuer.length() > 20) {
                        errorMsg += "pass issuer cannot be longer than 20 characters,";
                    }
                    
                    if (!passRemark.equals("") && passRemark.length() > 200) {
                        errorMsg += "pass remark cannot be longer than 200 characters,";
                    }
                    
                    if (!obseleteDateStr.equals("")) {
                        try {
                            java.util.Date tmp = sdf.parse(obseleteDateStr);
                            obseleteDate = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                            errorMsg += "Invalid Obselete Date Format,";
                        } 
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
                    JobPassDetails jobPassDetails = new JobPassDetails
                            (finNum, jobKey, passType, passTypeMore, passNbr, passApplicDate, 
                            passIssueDate, passExpDate, passIssuer, passRemark, obseleteDate);
                    addJobPassDetails(jobPassDetails);
                    count++;
                }    
            }
            errList.add("passdetails.csv:" + count);
            csvReader.close();
        } catch (FileNotFoundException ex) {
            //fileNotFoundExcepton
        }
        return errList;
    }
    
    /*IPA Details*/
    public static ArrayList<Integer> retrieveIPADetailsIdsOfJob (Job job) {
         ArrayList<Integer> ids = new ArrayList<Integer>();

         Connection conn = null;
         PreparedStatement pstmt = null;
         ResultSet rs = null;
         String sql = "";

         try {
             conn = ConnectionManager.getConnection();
             sql = "SELECT ID FROM tbl_ipa_details where Worker_FIN_number = ? AND Job_key =?";
             pstmt = conn.prepareStatement(sql);
             pstmt.setString(1, job.getWorkerFinNum());
             pstmt.setInt(2, job.getJobKey());
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
    
    public static JobIPADetails retrieveJobIPADetailsById(int id) {
        JobIPADetails jobIPADetails = null;

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT IPA_pass_type, IPA_pass_type_more,"
                    + " IPA_application_date, IPA_employer_name, IPA_agent_name,"
                    + "IPA_industry, IPA_occupation, IPA_period_years, "
                    + "IPA_basic_salary, IPA_allowances, IPA_allowances_details, "
                    + "IPA_deduction, IPA_deduction_details,Housing_provided, "
                    + "IPA_remarks, Worker_FIN_number, Job_key "
                    + " FROM tbl_ipa_details where ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String IPA_pass_type = rs.getString(1);
                String IPA_pass_type_more = rs.getString(2);
                Date IPA_application_date = rs.getDate(3);    
                String IPA_employer_name = rs.getString(4);
                String IPA_agent_name = rs.getString(5);
                String IPA_industry = rs.getString(6);
                String IPA_occupation = rs.getString(7);
                String IPA_period_years = rs.getString(8);
                Double IPA_basic_salary = rs.getDouble(9);
                Double IPA_allownaces = rs.getDouble(10);
                String IPA_allowances_details = rs.getString(11);
                Double IPA_deduction = rs.getDouble(12);
                String IPA_deduction_details = rs.getString(13);
                String Housing_provided = rs.getString(14);
                String IPA_remarks = rs.getString(15);
                String workerFinNum = rs.getString(16);
                int jobKey = rs.getInt(17);

                jobIPADetails= new JobIPADetails(id, workerFinNum, jobKey, IPA_pass_type, IPA_pass_type_more,
                        IPA_application_date, IPA_employer_name,IPA_agent_name,
                        IPA_industry,IPA_occupation, IPA_period_years,IPA_basic_salary,
                        IPA_allownaces,IPA_allowances_details,IPA_deduction,
                        IPA_deduction_details,Housing_provided, IPA_remarks );
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql, "JobIPADetails={" + jobIPADetails + "}");           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return jobIPADetails;
    }
  
    public static void addJobIPADetails(JobIPADetails jobIPADetails) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "INSERT INTO tbl_ipa_details (IPA_pass_type, IPA_pass_type_more, "
                    + "IPA_application_date, IPA_employer_name, IPA_agent_name,"
                    + " IPA_industry, IPA_occupation, IPA_period_years,"
                    + "IPA_basic_salary, IPA_allowances, IPA_allowances_details, "
                    + "IPA_deduction,IPA_deduction_details,Housing_provided,IPA_remarks,"
                    + "Worker_FIN_number, Job_key)"
                    + "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, jobIPADetails.getIpaPassType());
            pstmt.setString(2, jobIPADetails.getIpaPassTypeMore());
            pstmt.setDate(3, jobIPADetails.getIpaApplicationDate());
            pstmt.setString(4, jobIPADetails.getIpaEmployerName());
            pstmt.setString(5, jobIPADetails.getIpaAgentName());
            pstmt.setString(6, jobIPADetails.getIndustry());
            pstmt.setString(7, jobIPADetails.getOccuupation());
            pstmt.setString(8, jobIPADetails.getPeriodYears());
            pstmt.setDouble(9, jobIPADetails.getBasicSalary());
            pstmt.setDouble(10, jobIPADetails.getIpaAllowances());
            pstmt.setString(11, jobIPADetails.getIpaAllowancesDetails());
            pstmt.setDouble(12, jobIPADetails.getIpaDeduction());
            pstmt.setString(13, jobIPADetails.getIpaDeductionDetails());
            pstmt.setString(14, jobIPADetails.getHousingProvided());
            pstmt.setString(15, jobIPADetails.getIpaRemarks());
            pstmt.setString(16, jobIPADetails.getWorkerFinNum());
            pstmt.setInt(17, jobIPADetails.getJobKey());
            
            
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "jobIPADetails: " + jobIPADetails + "}");
        } finally {
            ConnectionManager.close(conn, pstmt);
        }    
    }

    public static void updateJobIPADetails(JobIPADetails jobIPADetails) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_ipa_details SET IPA_pass_type = ? , IPA_pass_type_more = ?,"
                    + "IPA_application_date =?, IPA_employer_name=?, IPA_agent_name=?,"
                    + "IPA_industry=?, IPA_occupation=?, IPA_period_years=?,"
                    + "IPA_basic_salary=?, IPA_allowances=?, IPA_allowances_details=?,"
                    + "IPA_deduction=?,IPA_deduction_details=?,"
                    + "Housing_provided=?, IPA_remarks=? "
                    + "WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, jobIPADetails.getIpaPassType());
            pstmt.setString(2, jobIPADetails.getIpaPassTypeMore());
            pstmt.setDate(3, jobIPADetails.getIpaApplicationDate());
            pstmt.setString(4, jobIPADetails.getIpaEmployerName());
            pstmt.setString(5, jobIPADetails.getIpaAgentName());
            pstmt.setString(6, jobIPADetails.getIndustry());
            pstmt.setString(7, jobIPADetails.getOccuupation());
            pstmt.setString(8, jobIPADetails.getPeriodYears());
            pstmt.setDouble(9, jobIPADetails.getBasicSalary());
            pstmt.setDouble(10, jobIPADetails.getIpaAllowances());
            pstmt.setString(11, jobIPADetails.getIpaAllowancesDetails());
            pstmt.setDouble(12, jobIPADetails.getIpaDeduction());
            pstmt.setString(13, jobIPADetails.getIpaDeductionDetails());
            pstmt.setString(14, jobIPADetails.getHousingProvided());
            pstmt.setString(15, jobIPADetails.getIpaRemarks());
            pstmt.setInt(16, jobIPADetails.getId());

            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "jobIPADetails={" + jobIPADetails + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }        
    }
  
    public static void deleteAllJobIPADetails() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            
            sql = "DELETE FROM tbl_ipa_details";
            pstmt = conn.prepareStatement(sql);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "not able to delete data from Job-IPA Details Table. ");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }     
    }
        
    public static ArrayList<String> validateAndAddJobIPADetails(String jobIPADetailsFile) 
            throws IOException{
        
        // Attributes
        ArrayList<String> errList = new ArrayList<String>();
        CSVReader csvReader = null;
        try {
            csvReader = new CSVReader(new FileReader(jobIPADetailsFile));
            String[] header = csvReader.readNext();
            String[] fields;
            int lineNum = 1;
            String errorMsg = "";
            int count = 0;

            // Loops through each line of the csv with an array of String
            while ((fields = csvReader.readNext()) != null) {
                lineNum++;
                // Assigning each field with its appropriate name
                String finNum = fields[0].trim();
                String jobKeyStr = fields[1].trim();
                String ipaPassType = fields[2].trim();
                String ipaPassTypeMore = fields[3].trim();
                String ipaApplicDateStr = fields[4].trim();
                String ipaEmployer = fields[5].trim();
                String ipaAgent = fields[6].trim();
                String ipaIndustry = fields[7].trim();
                String ipaOccupation = fields[8].trim();
                String ipaPeriod = fields[9].trim();
                String ipaBasicStr = fields[10].trim();
                String ipaAllowanceStr = fields[11].trim();
                String ipaAllowDetails = fields[12].trim();
                String ipaDeductionStr = fields[13].trim();
                String ipaDeductionDetails = fields[14].trim();
                String ipaHousing = fields[15].trim();
                String ipaRemark = fields[16].trim();
                
                int jobKey = 0;
                java.sql.Date ipaApplicDate = null;
                double ipaBasic = 0.0;
                double ipaAllowance = 0.0;
                double ipaDeduction = 0.0;
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
                if (ipaPassType.equals("")) {
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
                    
                    ArrayList<String> list = DropdownDAO.retrieveAllDropdownListOfIPAPassType();
                    boolean exit = false;
                    for (String tmp: list) {
                        if (tmp.equalsIgnoreCase(ipaPassType)) {
                            exit = true;
                            break;
                        }
                    }
                    
                    if (!exit) {
                        errorMsg += "invalid IPA Pass Type, ";
                    }
                    
                    if (!ipaPassTypeMore.equals("") && ipaPassTypeMore.length() > 50){
                        errorMsg += header[3] + " cannot be more than 50 characters,";
                    }
                    
                    if (!ipaApplicDateStr.equals("")) {
                        try {
                            java.util.Date tmp = sdf.parse(ipaApplicDateStr);
                            ipaApplicDate = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                            errorMsg += "Invalid IPA Application Date Format,";
                        } 
                    }
                    
                    if (!ipaEmployer.equals("") && ipaEmployer.length() > 50) {
                        errorMsg += header[5] + " cannot be longer than 50 characters,";
                    }
                    
                    if (!ipaAgent.equals("") && ipaAgent.length() > 50) {
                        errorMsg += header[6] + " cannot be longer than 50 characters,";
                    }
                    
                    if (!ipaIndustry .equals("") && ipaIndustry.length() > 50) {
                        errorMsg += header[7] + " cannot be longer than 50 characters,";
                    }
                    
                    if (!ipaOccupation .equals("") && ipaOccupation.length() > 30) {
                        errorMsg += header[8] + " cannot be longer than 30 characters,";
                    }
                    
                    if (!ipaPeriod.equals("") && ipaPeriod.matches("^\\d+(\\.\\d{1,2})?$")) {
                        errorMsg += header[9] + " must have maximum 2 decimal places,";
                    }
                    
                    if (!ipaBasicStr.equals("") && !ipaBasicStr.matches("^\\d+(\\.\\d{1,2})?$")) {
                        errorMsg += header[10] + " must have maximum 2 decimal places,";
                    } else {
                        try {
                            ipaBasic = Double.parseDouble(ipaBasicStr);
                        } catch (Exception ex) {
                            errorMsg += header[10] + " - invalid format,";
                        }
                    }
                    
                    if (!ipaAllowanceStr.equals("") && !ipaAllowanceStr.matches("^\\d+(\\.\\d{1,2})?$")) {
                        errorMsg += header[11] + " must have maximum 2 decimal places,";
                    } else {
                        try {
                            ipaAllowance = Double.parseDouble(ipaAllowanceStr);
                        } catch (Exception ex) {
                            errorMsg += header[11] + " - invalid format,";
                        }
                    }
                    
                    if (!ipaAllowDetails.equals("") && ipaAllowDetails.length() > 200) {
                        errorMsg += header[12] + " cannot be longer than 200 characters,";
                    }
                    
                    if (!ipaDeductionStr.equals("") && !ipaDeductionStr.matches("^\\d+(\\.\\d{1,2})?$")) {
                        errorMsg += header[13] + " must have maximum 2 decimal places,";
                    } else {
                        try {
                            ipaDeduction = Double.parseDouble(ipaDeductionStr);
                        } catch (Exception ex) {
                            errorMsg += header[13] + " - invalid format,";
                        }
                    }
                    
                    if (!ipaDeductionDetails.equals("") && ipaDeductionDetails.length() > 200) {
                        errorMsg += header[14] + " cannot be longer than 200 characters,";
                    } 
                    
                    if (!ipaHousing.equals("")) {
                        if (ipaHousing.equals("Yes") || ipaHousing.equals("No")) {
                            
                        } else {
                            errorMsg += header[15] + " must be either 'Yes' or 'No'";
                        }
                    } 
                    
                    if (!ipaRemark.equals("") && ipaRemark.length() > 200) {
                        errorMsg += header[16] + " cannot be longer than 200 characters,";
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
                    JobIPADetails jobIPADetails = new JobIPADetails
                            (finNum, jobKey, ipaPassType, ipaPassTypeMore, ipaApplicDate, ipaEmployer, 
                            ipaAgent, ipaIndustry, ipaOccupation, ipaPeriod, ipaBasic, ipaAllowance,
                            ipaAllowDetails, ipaDeduction, ipaDeductionDetails, ipaHousing,ipaRemark );
                    addJobIPADetails(jobIPADetails);
                    count++;
                }    
            }
            errList.add("ipa.csv:" + count);
            csvReader.close();
        } catch (FileNotFoundException ex) {
            //fileNotFoundExcepton
        }
        return errList;
    }
    
    /*Verbal Assurance*/
    public static ArrayList<Integer> retrieveVerbalAssuranceOfJob (Job job) {
         ArrayList<Integer> ids = new ArrayList<Integer>();

         Connection conn = null;
         PreparedStatement pstmt = null;
         ResultSet rs = null;
         String sql = "";

         try {
             conn = ConnectionManager.getConnection();
             sql = "SELECT ID FROM tbl_verbal_assurances where Worker_FIN_number = ? AND Job_key =?";
             pstmt = conn.prepareStatement(sql);
             pstmt.setString(1, job.getWorkerFinNum());
             pstmt.setInt(2, job.getJobKey());
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

    public static JobVerbalAssurance retrieveVerbalAssuranceDetailsById(int id) {
        JobVerbalAssurance jobVerbalAssurance = null;

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Verbal_name, Verbal_relationship,"
                    + " Verbal_when, Verbal_where, Verbal_content,Worker_FIN_number, Job_key "
                    + " FROM tbl_verbal_assurances where ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String Verbal_name = rs.getString(1);
                String Verbal_relationship = rs.getString(2);
                String Verbal_when = rs.getString(3);    
                String Verbal_where = rs.getString(4);
                String Verbal_content = rs.getString(5);
                String Worker_FIN_number = rs.getString(6);
                int jobKey = rs.getInt(7);
                
                jobVerbalAssurance = new JobVerbalAssurance(id,Worker_FIN_number , jobKey, Verbal_name,
                        Verbal_relationship,Verbal_when, Verbal_where,Verbal_content);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql, "JobVerbalAssurance={" + jobVerbalAssurance + "}");           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return jobVerbalAssurance;
    }

    public static void addJobVerbalAssurance(JobVerbalAssurance jobVerbalAssurance) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "INSERT INTO tbl_verbal_assurances (Verbal_name, Verbal_relationship, "
                    + "Verbal_when, Verbal_where,Verbal_content,Worker_FIN_number, Job_key) "
                    + "VALUES (?,?,?,?,?,?,?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, jobVerbalAssurance.getVerbalName());
            pstmt.setString(2, jobVerbalAssurance.getVerbalRelationship());
            pstmt.setString(3, jobVerbalAssurance.getWhen());
            pstmt.setString(4, jobVerbalAssurance.getWhere());
            pstmt.setString(5, jobVerbalAssurance.getContent());
            pstmt.setString(6, jobVerbalAssurance.getWorkerFinNum());
            pstmt.setInt(7, jobVerbalAssurance.getJobKey());

            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "jobVerbalAssurance: " + jobVerbalAssurance + "}");
        } finally {
            ConnectionManager.close(conn, pstmt);
        }    
    }

    public static void updateJobVerbalAssurance(JobVerbalAssurance jobVerbalAssurance) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_verbal_assurances SET Verbal_name = ?,Verbal_relationship = ?,"
                    + "Verbal_when =?, Verbal_where=?, Verbal_content=?,Worker_FIN_number=?"
                    + "WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, jobVerbalAssurance.getVerbalName());
            pstmt.setString(2, jobVerbalAssurance.getVerbalRelationship());
            pstmt.setString(3, jobVerbalAssurance.getWhen());
            pstmt.setString(4, jobVerbalAssurance.getWhere());
            pstmt.setString(5, jobVerbalAssurance.getContent());
            pstmt.setString(6, jobVerbalAssurance.getWorkerFinNum());
            pstmt.setInt(7, jobVerbalAssurance.getId());

            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "jobVerbalAssurance={" + jobVerbalAssurance + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }        
    }
  
    public static void deleteAllJobVerbalAssurances() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            
            sql = "DELETE FROM tbl_verbal_assurances";
            pstmt = conn.prepareStatement(sql);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "not able to delete data from Job-Verbal Assurance Table. ");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }     
    }
    
    public static ArrayList<String> validateAndAddJobVerbalAssurance(String jobVerbalAssuranceFile) 
            throws IOException{
        
        // Attributes
        ArrayList<String> errList = new ArrayList<String>();
        CSVReader csvReader = null;
        try {
            csvReader = new CSVReader(new FileReader(jobVerbalAssuranceFile));
            String[] header = csvReader.readNext();
            String[] fields;
            int lineNum = 1;
            String errorMsg = "";
            int count = 0;

            // Loops through each line of the csv with an array of String
            while ((fields = csvReader.readNext()) != null) {
                lineNum++;
                // Assigning each field with its appropriate name
                String finNum = fields[0].trim();
                String jobKeyStr = fields[1].trim();
                String verbalName = fields[2].trim();
                String verbalRel = fields[3].trim();
                String verbalWhen = fields[4].trim();
                String verbalWhere = fields[5].trim();
                String verbalContent = fields[6].trim();
                
                int jobKey = 0;
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
                if (verbalName.equals("")) {
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
                    
                    if (verbalName.length() > 50){
                        errorMsg += header[2] + " cannot be more than 50 characters,";
                    }
                    
                    if (!verbalRel.equals("") && verbalRel.length() > 200) {
                        errorMsg += header[3] + " cannot be longer than 200 characters,";
                    }
                    
                    if (!verbalWhen.equals("") && verbalWhen.length() > 50) {
                        errorMsg += header[4] + " cannot be longer than 50 characters,";
                    }
                    
                    if (!verbalWhere.equals("") && verbalWhere.length() > 50) {
                        errorMsg += header[5] + " cannot be longer than 50 characters,";
                    }
                    
                    if (!verbalContent.equals("") && verbalContent.length() > 1000) {
                        errorMsg += header[6] + " cannot be longer than 1000 characters,";
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
                    JobVerbalAssurance jobVerbalAssurance = new JobVerbalAssurance (finNum, jobKey, 
                            verbalName, verbalRel, verbalWhen, verbalWhere, verbalContent);
                    addJobVerbalAssurance(jobVerbalAssurance);
                    count++;
                }    
            }
            errList.add("verbalassurance.csv:" + count);
            csvReader.close();
        } catch (FileNotFoundException ex) {
            //fileNotFoundExcepton
        }
        return errList;
    }
    
    /*Employment Contract*/
    public static ArrayList<Integer> retrieveEmploymentContractIdsOfJob (Job job) {
         ArrayList<Integer> ids = new ArrayList<Integer>();

         Connection conn = null;
         PreparedStatement pstmt = null;
         ResultSet rs = null;
         String sql = "";

         try {
             conn = ConnectionManager.getConnection();
             sql = "SELECT ID FROM tbl_employment_contract where Worker_FIN_number = ? AND Job_key =?";
             pstmt = conn.prepareStatement(sql);
             pstmt.setString(1, job.getWorkerFinNum());
             pstmt.setInt(2, job.getJobKey());
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

    public static JobEmploymentContract retrieveEmploymentContractById(int id) {
        JobEmploymentContract jobEmploymentContract = null;

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Short_name, Contract_date, Contract_where,"
                    + " Contract_language, Contract_opposite_name, Contract_opposite_relationship,"
                    + "Contract_occupation, Contract_basic_salary, Contract_allowances, "
                    + "Contract_deduction_details, Contract_duration, Contract_duress,"
                    + " Contract_remarks, Worker_FIN_number, Job_key "
                    + " FROM tbl_employment_contract where ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String shortName = rs.getString(1);
                Date Contract_date = rs.getDate(2);
                String Contract_where = rs.getString(3);
                String Contract_language = rs.getString(4);    
                String Contract_opposite_name = rs.getString(5);
                String Contract_opposite_relationship = rs.getString(6);
                String Contract_occupation = rs.getString(7);
                String Contract_basic_salary = rs.getString(8);
                String Contract_allowances = rs.getString(9);
                String Contract_deduction_details = rs.getString(10);
                String Contract_duration = rs.getString(11);
                String Contract_duress = rs.getString(12);
                String Contract_remarks = rs.getString(13);
                String workerFinNumber = rs.getString(14);
                int jobKey = rs.getInt(15);
                
                jobEmploymentContract = new JobEmploymentContract (id,workerFinNumber,jobKey,
                        shortName, Contract_date, Contract_where,
                        Contract_language, Contract_opposite_name,
                        Contract_opposite_relationship,Contract_occupation,
                        Contract_basic_salary,Contract_allowances,Contract_deduction_details,
                        Contract_duration,Contract_duress, Contract_remarks);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql, "JobEmploymentContract={" + jobEmploymentContract + "}");           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return jobEmploymentContract;
    }

    public static void addJobEmploymentContract(JobEmploymentContract jobEmploymentContract) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "INSERT INTO tbl_employment_contract (Short_name, Contract_date, Contract_where, "
                    + "Contract_language, Contract_opposite_name, "
                    + " Contract_opposite_relationship, Contract_occupation, Contract_basic_salary,"
                    + "Contract_allowances, Contract_deduction_details,"
                    + "Contract_duration, Contract_duress, Contract_remarks,Worker_FIN_number, Job_key ) "
                    + "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, jobEmploymentContract.getShortName());
            pstmt.setDate(2, jobEmploymentContract.getContractDate());
            pstmt.setString(3, jobEmploymentContract.getContractWhere());
            pstmt.setString(4, jobEmploymentContract.getContractlanguage());
            pstmt.setString(5, jobEmploymentContract.getContractOppName());
            pstmt.setString(6, jobEmploymentContract.getContractOppRelationship());
            pstmt.setString(7, jobEmploymentContract.getContractOccupation());
            pstmt.setString(8, jobEmploymentContract.getContractBasicSalary());
            pstmt.setString(9, jobEmploymentContract.getContractAllowances());
            pstmt.setString(10, jobEmploymentContract.getContractDeductDetails());
            pstmt.setString(11, jobEmploymentContract.getContractDuration());
            pstmt.setString(12, jobEmploymentContract.getContractDuress());
            pstmt.setString(13, jobEmploymentContract.getContractRemarks());
            pstmt.setString(14, jobEmploymentContract.getWorkerFinNum());
            pstmt.setInt(15, jobEmploymentContract.getJobKey());

            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "jobEmploymentContract: " + jobEmploymentContract + "}");
        } finally {
            ConnectionManager.close(conn, pstmt);
        }    
    }

    public static void updateJobEmploymentContract(JobEmploymentContract jobEmploymentContract) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_employment_contract SET Short_name =?, Contract_date = ? , Contract_where = ?,"
                    + "Contract_language =?, Contract_opposite_name=?, "
                    + "Contract_opposite_relationship=?, Contract_occupation=?, "
                    + "Contract_basic_salary=?, Contract_allowances=?, Contract_deduction_details=?,"
                    + "Contract_duration=?, Contract_duress=?, Contract_remarks=? "
                    + "WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, jobEmploymentContract.getShortName());
            pstmt.setDate(2, jobEmploymentContract.getContractDate());
            pstmt.setString(3, jobEmploymentContract.getContractWhere());
            pstmt.setString(4, jobEmploymentContract.getContractlanguage());
            pstmt.setString(5, jobEmploymentContract.getContractOppName());
            pstmt.setString(6, jobEmploymentContract.getContractOppRelationship());
            pstmt.setString(7, jobEmploymentContract.getContractOccupation());
            pstmt.setString(8, jobEmploymentContract.getContractBasicSalary());
            pstmt.setString(9, jobEmploymentContract.getContractAllowances());
            pstmt.setString(10, jobEmploymentContract.getContractDeductDetails());
            pstmt.setString(11, jobEmploymentContract.getContractDuration());
            pstmt.setString(12, jobEmploymentContract.getContractDuress());
            pstmt.setString(13, jobEmploymentContract.getContractRemarks());
            pstmt.setInt(14, jobEmploymentContract.getId());

            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "jobEmploymentContract={" + jobEmploymentContract + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }        
    }
  
    public static void deleteAllEmploymentContracts() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            
            sql = "DELETE FROM tbl_employment_contract";
            pstmt = conn.prepareStatement(sql);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "not able to delete data from Job-Employment contract Table. ");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }     
    }
    
    public static ArrayList<String> validateAndAddJobEmploymentContract(String jobEmploymentContractFile) 
            throws IOException{
        
        // Attributes
        ArrayList<String> errList = new ArrayList<String>();
        CSVReader csvReader = null;
        try {
            csvReader = new CSVReader(new FileReader(jobEmploymentContractFile));
            String[] header = csvReader.readNext();
            String[] fields;
            int lineNum = 1;
            String errorMsg = "";
            int count = 0;

            // Loops through each line of the csv with an array of String
            while ((fields = csvReader.readNext()) != null) {
                lineNum++;
                // Assigning each field with its appropriate name
                String finNum = fields[0].trim();
                String jobKeyStr = fields[1].trim();
                String contractDateStr = fields[2].trim();
                String contractWhere = fields[3].trim();
                String contractLang = fields[4].trim();
                String contractOppName = fields[5].trim();
                String contractOppRel = fields[6].trim();
                String contractOccup = fields[7].trim();
                String contractBasic = fields[8].trim();
                String contractAllow = fields[9].trim();
                String contractDeduct = fields[10].trim();
                String contractDuration = fields[11].trim();
                String contractDuress = fields[12].trim();
                String contractRemark = fields[13].trim();
                
                int jobKey = 0;
                java.sql.Date contractDate = null;
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
                if (contractDateStr.equals("")) {
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
                        java.util.Date tmp = sdf.parse(contractDateStr);
                        contractDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        errorMsg += "Invalid Contract Date Date Format,";
                    } 
                    
                    
                    if (!contractWhere.equals("") && contractWhere.length() > 200) {
                        errorMsg += header[3] + " cannot be longer than 200 characters,";
                    }
                    
                    if (!contractLang.equals("") && contractLang.length() > 50) {
                        errorMsg += header[4] + " cannot be longer than 50 characters,";
                    }
                    
                    if (!contractOppName.equals("") && contractOppName.length() > 50) {
                        errorMsg += header[5] + " cannot be longer than 50 characters,";
                    }
                    
                    if (!contractOppRel.equals("") && contractOppRel.length() > 200) {
                        errorMsg += header[6] + " cannot be longer than 200 characters,";
                    }
                    
                    if (!contractOccup.equals("") && contractOccup.length() > 200) {
                        errorMsg += header[7] + " cannot be longer than 200 characters,";
                    }
                    
                    if (!contractBasic.equals("") && contractBasic.length() > 50) {
                        errorMsg += header[8] + " cannot be longer than 50 characters,";
                    }
                    
                    if (!contractAllow.equals("") && contractAllow.length() > 500) {
                        errorMsg += header[9] + " cannot be longer than 500 characters,";
                    }
                    
                    if (!contractDeduct.equals("") && contractDeduct.length() > 500) {
                        errorMsg += header[10] + " cannot be longer than 500 characters,";
                    }
                    
                    if (!contractDuration.equals("") && contractDuration.length() > 20) {
                        errorMsg += header[11] + " cannot be longer than 20 characters,";
                    }
                    
                    if (!contractDuress.equals("") && contractDuress.length() > 500) {
                        errorMsg += header[12] + " cannot be longer than 500 characters,";
                    }
                    
                    if (!contractRemark.equals("") && contractRemark.length() > 200) {
                        errorMsg += header[13] + " cannot be longer than 200 characters,";
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
                    JobEmploymentContract jobEmploymentContract = new JobEmploymentContract
                            (finNum, jobKey, null, contractDate, contractWhere, contractLang, contractOppName, 
                            contractOppRel,contractOccup,contractBasic,contractAllow,contractDeduct,
                            contractDuration,contractDuress,contractRemark);
                    addJobEmploymentContract(jobEmploymentContract);
                    count++;
                }    
            }
            errList.add("employmentcontract.csv:" + count);
            csvReader.close();
        } catch (FileNotFoundException ex) {
            //fileNotFoundExcepton
        }
        return errList;
    }
    
    /*Intermediary Agent*/
    public static ArrayList<Integer> retrieveJobIntermediaryAgentIdsOfJob (Job job) {
         ArrayList<Integer> ids = new ArrayList<Integer>();

         Connection conn = null;
         PreparedStatement pstmt = null;
         ResultSet rs = null;
         String sql = "";

         try {
             conn = ConnectionManager.getConnection();
             sql = "SELECT ID FROM tbl_agent where Worker_FIN_number = ? AND Job_key =?";
             pstmt = conn.prepareStatement(sql);
             pstmt.setString(1, job.getWorkerFinNum());
             pstmt.setInt(2, job.getJobKey());
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

    public static JobIntermediaryAgent retrieveJobIntermediaryAgentById(int id) {
        JobIntermediaryAgent jobIntermediaryAgent = null;

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Agent_company, Agent_person_name,"
                    + " Agent_location, Agent_location_more, Agent_address,"
                    + "Agent_contact, Agent_amt_paid, Agent_amt_owed, "
                    + "Agent_fee_shared, Agent_fee_training, Agent_fee_airfare,"
                    + "Agent_fee_where,Agent_fee_when, Agent_fee_repay,Agent_employer, "
                    + "Agent_remarks, Worker_FIN_number, Job_key "
                    + " FROM tbl_agent where ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String Agent_company = rs.getString(1);
                String Agent_person_name = rs.getString(2);
                String Agent_location = rs.getString(3);    
                String Agent_location_more = rs.getString(4);
                String Agent_address = rs.getString(5);
                String Agent_contact = rs.getString(6);
                Double Agent_amt_paid = rs.getDouble(7);
                Double Agent_amt_owed = rs.getDouble(8);
                String Agent_fee_shared = rs.getString(9);
                String Agent_fee_training = rs.getString(10);
                String Agent_fee_airfare = rs.getString(11);
                String Agent_fee_where = rs.getString(12);
                String Agent_fee_when = rs.getString(13);
                String Agent_fee_repay = rs.getString(14);
                String Agent_employer = rs.getString(15);
                String Agent_remarks = rs.getString(16);
                String workerFinNumber = rs.getString(17);
                int jobKey = rs.getInt(18);
                
                jobIntermediaryAgent = new JobIntermediaryAgent(jobKey, workerFinNumber, id,
                        Agent_company, Agent_person_name
                        ,Agent_location, Agent_location_more,Agent_address,Agent_contact,
                        Agent_amt_paid,Agent_amt_owed,Agent_fee_shared,
                        Agent_fee_training,Agent_fee_airfare,Agent_fee_where,Agent_fee_when,
                        Agent_fee_repay,Agent_employer, Agent_remarks);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql, "JobIntermediaryAgent={" + jobIntermediaryAgent + "}");           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return jobIntermediaryAgent;
    }

    public static void addJobIntermediaryAgent(JobIntermediaryAgent jobIntermediaryAgent) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "INSERT INTO tbl_agent (Agent_company, Agent_person_name, "
                    + "Agent_location, Agent_location_more, "
                    + " Agent_address, Agent_contact, Agent_amt_paid,"
                    + "Agent_amt_owed, Agent_fee_shared,Agent_fee_training,"
                    + " Agent_fee_airfare, Agent_fee_where, Agent_fee_when, "
                    + "Agent_fee_repay,Agent_employer, Agent_remarks, Worker_FIN_number, Job_key ) "
                    + "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, jobIntermediaryAgent.getAgentCompany());
            pstmt.setString(2, jobIntermediaryAgent.getAgentPersonName());
            pstmt.setString(3, jobIntermediaryAgent.getAgentLocation());
            pstmt.setString(4, jobIntermediaryAgent.getAgentlocationMore());
            pstmt.setString(5, jobIntermediaryAgent.getAgentAddress());
            pstmt.setString(6, jobIntermediaryAgent.getAgentContact());
            pstmt.setDouble(7, jobIntermediaryAgent.getAgentAmtPaid());
            pstmt.setDouble(8, jobIntermediaryAgent.getAgentAmtOwed());
            pstmt.setString(9, jobIntermediaryAgent.getAgentFeeShared());
            pstmt.setString(10, jobIntermediaryAgent.getAgentFeeTraining());
            pstmt.setString(11, jobIntermediaryAgent.getAgentFeeAirfare());
            pstmt.setString(12, jobIntermediaryAgent.getAgentFeeWhere());
            pstmt.setString(13, jobIntermediaryAgent.getAgentFeeWhen());
            pstmt.setString(14, jobIntermediaryAgent.getAgentFeeRepay());
            pstmt.setString(15, jobIntermediaryAgent.getAgentEmployer());
            pstmt.setString(16, jobIntermediaryAgent.getAgentRemarks());
            pstmt.setString(17, jobIntermediaryAgent.getWorkerFinNum());
            pstmt.setInt(18, jobIntermediaryAgent.getJobKey());

            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "jobIntermediaryAgent: " + jobIntermediaryAgent + "}");
        } finally {
            ConnectionManager.close(conn, pstmt);
        }    
    }

    public static void updateJobIntermediaryAgent(JobIntermediaryAgent jobIntermediaryAgent) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_agent SET Agent_company = ? , Agent_person_name = ?,"
                    + "Agent_location =?, Agent_location_more=?, Agent_address=?,"
                    + "Agent_contact=?, Agent_amt_paid=?, Agent_amt_owed=?,"
                    + "Agent_fee_shared=?, Agent_fee_training=?, Agent_fee_airfare=?,"
                    + "Agent_fee_where=?, Agent_fee_when =?, Agent_fee_repay=?,"
                    + "Agent_employer=?, Agent_remarks=?  "
                    + "WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, jobIntermediaryAgent.getAgentCompany());
            pstmt.setString(2, jobIntermediaryAgent.getAgentPersonName());
            pstmt.setString(3, jobIntermediaryAgent.getAgentLocation());
            pstmt.setString(4, jobIntermediaryAgent.getAgentlocationMore());
            pstmt.setString(5, jobIntermediaryAgent.getAgentAddress());
            pstmt.setString(6, jobIntermediaryAgent.getAgentContact());
            pstmt.setDouble(7, jobIntermediaryAgent.getAgentAmtPaid());
            pstmt.setDouble(8, jobIntermediaryAgent.getAgentAmtOwed());
            pstmt.setString(9, jobIntermediaryAgent.getAgentFeeShared());
            pstmt.setString(10, jobIntermediaryAgent.getAgentFeeTraining());
            pstmt.setString(11, jobIntermediaryAgent.getAgentFeeAirfare());
            pstmt.setString(12, jobIntermediaryAgent.getAgentFeeWhere());
            pstmt.setString(13, jobIntermediaryAgent.getAgentFeeWhen());
            pstmt.setString(14, jobIntermediaryAgent.getAgentFeeRepay());
            pstmt.setString(15, jobIntermediaryAgent.getAgentEmployer());
            pstmt.setString(16, jobIntermediaryAgent.getAgentRemarks());
            pstmt.setInt(17, jobIntermediaryAgent.getID());

            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "jobIntermediaryAgent={" + jobIntermediaryAgent + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }        
    }
    
    public static void deleteAllJobIntermediaryAgent() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            
            sql = "DELETE FROM tbl_agent";
            pstmt = conn.prepareStatement(sql);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "not able to delete data from Job-Intermediary Agent. ");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }     
    }
    
    public static ArrayList<String> validateAndAddJobIntermediaryAgent(String jobIntermediaryAgentFile) 
            throws IOException{
        
        // Attributes
        ArrayList<String> errList = new ArrayList<String>();
        CSVReader csvReader = null;
        try {
            csvReader = new CSVReader(new FileReader(jobIntermediaryAgentFile));
            String[] header = csvReader.readNext();
            String[] fields;
            int lineNum = 1;
            String errorMsg = "";
            int count = 0;

            // Loops through each line of the csv with an array of String
            while ((fields = csvReader.readNext()) != null) {
                lineNum++;
                // Assigning each field with its appropriate name
                String finNum = fields[0].trim();
                String jobKeyStr = fields[1].trim();
                String agentCompany = fields[2].trim();
                String agentPers = fields[3].trim();
                String agentLocation = fields[4].trim();
                String agentLocationMore = fields[5].trim();
                String agentAddr = fields[6].trim();
                String agentContact = fields[7].trim();
                String agentAmtPaidStr = fields[8].trim();
                String agentAmtOwnedStr = fields[9].trim();
                String agentFeeShared = fields[10].trim();
                String agentFeeTraining = fields[11].trim();
                String agentFeeAirFare = fields[12].trim();
                String agentFeeWhen = fields[13].trim();
                String agentFeeWhere = fields[14].trim();
                String agentFeeRepay = fields[15].trim();
                String agentEmployer = fields[16].trim();
                String agentRemark = fields[17].trim();
                
                int jobKey = 0;
                double agentAmtOwned = 0;
                double agentAmtPaid = 0;
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
                if (agentCompany.equals("")) {
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
                    
                    if (agentCompany.length() > 50) {
                        errorMsg += header[2] + " cannot be longer than 50 characters,";
                    }
                         
                    if (!agentPers.equals("") && agentPers.length() > 50) {
                        errorMsg += header[3] + " cannot be longer than 50 characters,";
                    }
                    
                    if (!agentLocation.equals("")) {
                        ArrayList<String> list = DropdownDAO.retrieveAllDropdownListOfAgentLocationType();
                        boolean exit = false;
                        for (String tmp: list) {
                            if (tmp.equalsIgnoreCase(agentLocation)) {
                                exit = true;
                                break;
                            }
                        }

                        if (!exit) {
                            errorMsg += "Invalid Agent Location Type, ";
                        }
                    }
                    
                    if (!agentLocationMore.equals("") && agentLocationMore.length() > 50) {
                        errorMsg += header[5] + " cannot be longer than 50 characters,";
                    }
                    
                    if (!agentAddr.equals("") && agentAddr.length() > 300) {
                        errorMsg += header[6] + " cannot be longer than 300 characters,";
                    }
                    
                    if (!agentContact.equals("") && agentContact.length() > 200) {
                        errorMsg += header[7] + " cannot be longer than 200 characters,";
                    }
                    
                    if (!agentAmtPaidStr.equals("") && !agentAmtPaidStr.matches("^\\d+(\\.\\d{1,2})?$")) {
                        errorMsg += header[8] + " must have maximum 2 decimal places,";
                    } else {
                        try {
                            agentAmtPaid = Double.parseDouble(agentAmtPaidStr);
                        } catch (Exception ex) {
                            errorMsg += header[8] + " - invalid format,";
                        }
                    }
                    
                    if (!agentAmtOwnedStr.equals("") && !agentAmtOwnedStr.matches("^\\d+(\\.\\d{1,2})?$")) {
                        errorMsg += header[9] + " must have maximum 2 decimal places,";
                    } else {
                        try {
                            agentAmtOwned = Double.parseDouble(agentAmtOwnedStr);
                        } catch (Exception ex) {
                            errorMsg += header[9] + " - invalid format,";
                        }
                    }
                    
                    if (!agentFeeShared.equals("") && agentFeeShared.length() > 200) {
                        errorMsg += header[10] + " cannot be longer than 200 characters,";
                    }
                    
                    if (!agentFeeTraining.equals("") && agentFeeTraining.length() > 50) {
                        errorMsg += header[11] + " cannot be longer than 50 characters,";
                    }
                    
                    if (!agentFeeAirFare.equals("") && agentFeeAirFare.length() > 50) {
                        errorMsg += header[12] + " cannot be longer than 50 characters,";
                    }
                    
                    if (!agentFeeWhen.equals("") && agentFeeWhen.length() > 50) {
                        errorMsg += header[13] + " cannot be longer than 50 characters,";
                    }
                    
                    if (!agentFeeWhere.equals("") && agentFeeWhere.length() > 50) {
                        errorMsg += header[14] + " cannot be longer than 50 characters,";
                    }
                    
                    if (!agentFeeRepay.equals("") && agentFeeRepay.length() > 200) {
                        errorMsg += header[15] + " cannot be longer than 200 characters,";
                    }
                    
                    if (!agentEmployer.equals("") && agentEmployer.length() > 200) {
                        errorMsg += header[16] + " cannot be longer than 200 characters,";
                    }
                    
                    if (!agentRemark.equals("") && agentRemark.length() > 1000) {
                        errorMsg += header[17] + " cannot be longer than 1000 characters,";
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
                    JobIntermediaryAgent jobIntermediaryAgent = new JobIntermediaryAgent
                            (finNum, jobKey, agentCompany, agentPers, agentLocation, agentLocationMore, 
                            agentAddr,agentContact,agentAmtPaid,agentAmtOwned,agentFeeShared,
                            agentFeeTraining,agentFeeAirFare,agentFeeWhen, agentFeeWhere,
                            agentFeeRepay, agentEmployer, agentRemark);
                    addJobIntermediaryAgent(jobIntermediaryAgent);
                    count++;
                }    
            }
            errList.add("intermediaryagent.csv:" + count);
            csvReader.close();
        } catch (FileNotFoundException ex) {
            //fileNotFoundExcepton
        }
        return errList;
    }
    
    /*Employer*/
    public static ArrayList<Integer> retrieveJobEmployerIdsOfJob (Job job) {
         ArrayList<Integer> ids = new ArrayList<Integer>();

         Connection conn = null;
         PreparedStatement pstmt = null;
         ResultSet rs = null;
         String sql = "";

         try {
             conn = ConnectionManager.getConnection();
             sql = "SELECT ID FROM tbl_employer where Worker_FIN_number = ? AND Job_key =?";
             pstmt = conn.prepareStatement(sql);
             pstmt.setString(1, job.getWorkerFinNum());
             pstmt.setInt(2, job.getJobKey());
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

    public static JobEmployer retrieveJobEmployerById(int id) {
        JobEmployer jobEmployer = null;

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Employer_official_name, Employer_ID,Employer_address,"
                    + " Employer_contacts, Employer_persons, Employer_remarks,"
                    + " Worker_FIN_number, Job_key "
                    + " FROM tbl_employer where ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String Employer_official_name = rs.getString(1);
                String Employer_ID = rs.getString(2);
                String Employer_address = rs.getString(3);    
                String Employer_contacts = rs.getString(4);
                String Employer_persons = rs.getString(5);
                String Employer_remarks = rs.getString(6);
                String workerFinNumber = rs.getString(7);
                int jobKey = rs.getInt(8);
                
                jobEmployer = new JobEmployer(id, workerFinNumber, jobKey,Employer_official_name,
                        Employer_ID,Employer_address,Employer_contacts,Employer_persons,Employer_remarks);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql, "JobEmployer={" + jobEmployer + "}");           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return jobEmployer;
    }

    public static void addJobEmployer(JobEmployer jobEmployer) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "INSERT INTO tbl_employer (Employer_official_name, Employer_ID, "
                    + "Employer_address, Employer_contacts, "
                    + " Employer_persons, Employer_remarks,Worker_FIN_number, Job_key ) "
                    + "VALUES (?,?,?,?,?,?,?,?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, jobEmployer.getEmployerOfficialName());
            pstmt.setString(2, jobEmployer.getEmployerID());
            pstmt.setString(3, jobEmployer.getEmployerAddress());
            pstmt.setString(4, jobEmployer.getEmployerContacts());
            pstmt.setString(5, jobEmployer.getEmployerPersons());
            pstmt.setString(6, jobEmployer.getEmployerRemarks());
            pstmt.setString(7, jobEmployer.getWorkerFinNum());
            pstmt.setInt(8, jobEmployer.getJobKey());
            

            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "jobEmployer: " + jobEmployer + "}");
        } finally {
            ConnectionManager.close(conn, pstmt);
        }    
    }

    public static void updateJobEmployer(JobEmployer jobEmployer) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_employer SET Employer_official_name = ? , Employer_ID = ?,"
                    + "Employer_address =?, Employer_contacts=?, Employer_persons=?,"
                    + "Employer_remarks=?"
                    + "WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, jobEmployer.getEmployerOfficialName());
            pstmt.setString(2, jobEmployer.getEmployerID());
            pstmt.setString(3, jobEmployer.getEmployerAddress());
            pstmt.setString(4, jobEmployer.getEmployerContacts());
            pstmt.setString(5, jobEmployer.getEmployerPersons());
            pstmt.setString(6, jobEmployer.getEmployerRemarks());
            pstmt.setInt(7, jobEmployer.getId());

            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "jobEmployer={" + jobEmployer + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }        
    }
    
    public static void deleteAllJobEmployers() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            
            sql = "DELETE FROM tbl_employer";
            pstmt = conn.prepareStatement(sql);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "not able to delete data from Job-Employers. ");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }     
    }
    
    public static ArrayList<String> validateAndAddJobEmployer(String jobEmployerFile) 
            throws IOException{
        
        // Attributes
        ArrayList<String> errList = new ArrayList<String>();
        CSVReader csvReader = null;
        try {
            csvReader = new CSVReader(new FileReader(jobEmployerFile));
            String[] header = csvReader.readNext();
            String[] fields;
            int lineNum = 1;
            String errorMsg = "";
            int count = 0;

            // Loops through each line of the csv with an array of String
            while ((fields = csvReader.readNext()) != null) {
                lineNum++;
                // Assigning each field with its appropriate name
                String finNum = fields[0].trim();
                String jobKeyStr = fields[1].trim();
                String employerName = fields[2].trim();
                String employerid = fields[3].trim();
                String employerAddr = fields[4].trim();
                String employerContact = fields[5].trim();
                String employerPers = fields[6].trim();
                String employerRemark = fields[7].trim();
                
                
                int jobKey = 0;
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
                if (employerName.equals("")) {
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
                    
                    if (employerName.length() > 50) {
                        errorMsg += header[2] + " cannot be longer than 50 characters,";
                    }
                         
                    if (!employerid.equals("") && employerid.length() > 50) {
                        errorMsg += header[3] + " cannot be longer than 50 characters,";
                    }
                    
                    if (!employerAddr.equals("") && employerAddr.length() > 200) {
                        errorMsg += header[4] + " cannot be longer than 200 characters,";
                    }
                    
                    if (!employerContact.equals("") && employerContact.length() > 200) {
                        errorMsg += header[5] + " cannot be longer than 200 characters,";
                    }
                    
                    if (!employerPers.equals("") && employerPers.length() > 200) {
                        errorMsg += header[6] + " cannot be longer than 200 characters,";
                    }
                    
                    if (!employerRemark.equals("") && employerRemark.length() > 200) {
                        errorMsg += header[7] + " cannot be longer than 200 characters,";
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
                    JobEmployer jobEmployer = new JobEmployer(finNum, jobKey,employerName,employerid,
                            employerAddr,employerContact,employerPers,employerRemark);
                    addJobEmployer(jobEmployer);
                    count++;
                }    
            }
            errList.add("employer.csv:" + count);
            csvReader.close();
        } catch (FileNotFoundException ex) {
            //fileNotFoundExcepton
        }
        return errList;
    }
    
    /*Workplace Details*/
    public static ArrayList<Integer> retrieveJobWorkplaceIdsOfJob (Job job) {
         ArrayList<Integer> ids = new ArrayList<Integer>();

         Connection conn = null;
         PreparedStatement pstmt = null;
         ResultSet rs = null;
         String sql = "";

         try {
             conn = ConnectionManager.getConnection();
             sql = "SELECT ID FROM tbl_workplace where Worker_FIN_number = ? AND Job_key =?";
             pstmt = conn.prepareStatement(sql);
             pstmt.setString(1, job.getWorkerFinNum());
             pstmt.setInt(2, job.getJobKey());
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

    public static JobWorkplace retrieveJobWorkplaceById(int id) {
        JobWorkplace jobWorkplace = null;

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Workplace_type, Workplace_type_more, Workplace_whose, "
                    + "Workplace_persons, Workplace_employer_relationship,"
                    + "Workplace_direct, Workplace_direct_more, Workplace_start, "
                    + "Workplace_end, Workplace_condition,Workplace_safety,"
                    + "Workplace_remarks, Worker_FIN_number, Job_key "
                    + "FROM tbl_workplace where ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String Workplace_type = rs.getString(1);
                String Workplace_type_more = rs.getString(2);
                String Workplace_whose = rs.getString(3);    
                String Workplace_persons = rs.getString(4);
                String Workplace_employer_relationship = rs.getString(5);
                String Workplace_direct = rs.getString(6);
                String Workplace_direct_more = rs.getString(7);
                String Workplace_start = rs.getString(8);
                String Workplace_end = rs.getString(9);
                String Workplace_condition = rs.getString(10);
                String Workplace_safety = rs.getString(11);
                String Workplace_remarks = rs.getString(12);
                String workerFinNumber = rs.getString(13);
                int jobKey = rs.getInt(14);
                
                jobWorkplace = new JobWorkplace(id,workerFinNumber,jobKey,Workplace_type,
                        Workplace_type_more,Workplace_whose, Workplace_persons,
                        Workplace_employer_relationship,Workplace_direct,
                        Workplace_direct_more,Workplace_start,Workplace_end,
                        Workplace_condition, Workplace_safety,Workplace_remarks);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql, "JobWorkplace={" + jobWorkplace + "}");           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return jobWorkplace;
    }

    public static void addJobWorkplace(JobWorkplace jobWorkplace) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "INSERT INTO tbl_workplace (Workplace_type, Workplace_type_more, "
                    + "Workplace_whose, Workplace_persons, Workplace_employer_relationship, "
                    + "Workplace_direct, Workplace_direct_more, Workplace_start,"
                    + "Workplace_end, Workplace_condition, Workplace_safety, "
                    + "Workplace_remarks,Worker_FIN_number, Job_key ) "
                    + "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, jobWorkplace.getWorkplaceType());
            pstmt.setString(2, jobWorkplace.getWorkplaceTypeMore());
            pstmt.setString(3, jobWorkplace.getWorkplaceWhose());
            pstmt.setString(4, jobWorkplace.getWorkpladePersons());
            pstmt.setString(5, jobWorkplace.getWorkplaceEmployerRelationship());
            pstmt.setString(6, jobWorkplace.getWorkplaceDirect());
            pstmt.setString(7, jobWorkplace.getWorkplaceDirectMore());
            pstmt.setString(8, jobWorkplace.getWorkplaceStart());
            pstmt.setString(9, jobWorkplace.getWorkplaceEnd());
            pstmt.setString(10, jobWorkplace.getWorkplaceCondition());
            pstmt.setString(11, jobWorkplace.getWorkplaceSafety());
            pstmt.setString(12, jobWorkplace.getWorkplaceRemarks());
            pstmt.setString(13, jobWorkplace.getWorkerFinNum());
            pstmt.setInt(14, jobWorkplace.getJobKey());

            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "jobWorkplace: " + jobWorkplace + "}");
        } finally {
            ConnectionManager.close(conn, pstmt);
        }    
    }

    public static void updateJobWorkplace(JobWorkplace jobWorkplace) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_workplace SET Workplace_type = ? , Workplace_type_more = ?,"
                    + "Workplace_whose =?, Workplace_persons=?, Workplace_employer_relationship=?,"
                    + "Workplace_direct=?, Workplace_direct_more=?, Workplace_start=?,"
                    + "Workplace_end=? ,Workplace_condition=? , Workplace_safety=?, Workplace_remarks=? "
                    + "WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, jobWorkplace.getWorkplaceType());
            pstmt.setString(2, jobWorkplace.getWorkplaceTypeMore());
            pstmt.setString(3, jobWorkplace.getWorkplaceWhose());
            pstmt.setString(4, jobWorkplace.getWorkpladePersons());
            pstmt.setString(5, jobWorkplace.getWorkplaceEmployerRelationship());
            pstmt.setString(6, jobWorkplace.getWorkplaceDirect());
            pstmt.setString(7, jobWorkplace.getWorkplaceDirectMore());
            pstmt.setString(8, jobWorkplace.getWorkplaceStart());
            pstmt.setString(9, jobWorkplace.getWorkplaceEnd());
            pstmt.setString(10, jobWorkplace.getWorkplaceCondition());
            pstmt.setString(11, jobWorkplace.getWorkplaceSafety());
            pstmt.setString(12, jobWorkplace.getWorkplaceRemarks());
            pstmt.setInt(13, jobWorkplace.getId());

            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "jobWorkplace={" + jobWorkplace + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }        
    }
    
    public static void deleteAllJobWorkPlaces() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            
            sql = "DELETE FROM tbl_workplace";
            pstmt = conn.prepareStatement(sql);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "not able to delete data from Job-Work Place Table. ");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }     
    }
    
    public static ArrayList<String> validateAndAddJobWorkplace(String jobIntermediaryAgentFile) 
            throws IOException{
        
        // Attributes
        ArrayList<String> errList = new ArrayList<String>();
        CSVReader csvReader = null;
        try {
            csvReader = new CSVReader(new FileReader(jobIntermediaryAgentFile));
            String[] header = csvReader.readNext();
            String[] fields;
            int lineNum = 1;
            String errorMsg = "";
            int count = 0;

            // Loops through each line of the csv with an array of String
            while ((fields = csvReader.readNext()) != null) {
                lineNum++;
                // Assigning each field with its appropriate name
                String finNum = fields[0].trim();
                String jobKeyStr = fields[1].trim();
                String workplaceType = fields[2].trim();
                String workplaceTypeMore = fields[3].trim();
                String workplaceWhose = fields[4].trim();
                String workplacePers = fields[5].trim();
                String workplaceEmpRel = fields[6].trim();
                String workplaceDirect = fields[7].trim();
                String workplaceDirectMore = fields[8].trim();
                String workplaceStart = fields[9].trim();
                String workplaceEnd = fields[10].trim();
                String workplaceCond = fields[11].trim();
                String workplaceSafety = fields[12].trim();
                String workplaceRemark = fields[13].trim();
                
                
                int jobKey = 0;
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
                
                if (workplaceType.equals("")) {
                    errorMsg += header[2] + " is blank,";
                    pass = false;
                }
                
                if (workplaceDirect.equals("")) {
                    errorMsg += header[7] + " is blank,";
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
                    
                    ArrayList<String> list = DropdownDAO.retrieveAllDropdownListOfWorkplaceType();
                    boolean exit = false;
                    for (String tmp: list) {
                        if (tmp.equalsIgnoreCase(workplaceType)) {
                            exit = true;
                            break;
                        }
                    }

                    if (!exit) {
                        errorMsg += "Invalid Work Place Type, ";
                    }
              
                    if (!workplaceTypeMore.equals("") && workplaceTypeMore.length() > 200) {
                        errorMsg += header[3] + " cannot be longer than 200 characters,";
                    }
                    
                    if (!workplaceWhose.equals("") && workplaceWhose.length() > 50) {
                        errorMsg += header[4] + " cannot be longer than 50 characters,";
                    }
                    
                    
                    if (!workplacePers.equals("") && workplacePers.length() > 200) {
                        errorMsg += header[5] + " cannot be longer than 200 characters,";
                    }
                    
                    if (!workplaceEmpRel.equals("") && workplaceEmpRel.length() > 50) {
                        errorMsg += header[6] + " cannot be longer than 50 characters,";
                    }
                    
                    list = DropdownDAO.retrieveAllDropdownListOfWorkplaceDirectType();
                    exit = false;
                    for (String tmp: list) {
                        if (tmp.equalsIgnoreCase(workplaceDirect)) {
                            exit = true;
                            break;
                        }
                    }

                    if (!exit) {
                        errorMsg += "Invalid Agent Location Type, ";
                    }
                    
                    if (!workplaceDirectMore.equals("") && workplaceDirectMore.length() > 200) {
                        errorMsg += header[8] + " cannot be longer than 200 characters,";
                    }
                    
                    if (!workplaceStart.equals("") && workplaceStart.length() > 50) {
                        errorMsg += header[9] + " cannot be longer than 50 characters,";
                    }
                    
                    if (!workplaceEnd.equals("") && workplaceEnd.length() > 50) {
                        errorMsg += header[10] + " cannot be longer than 50 characters,";
                    }
                    
                    if (!workplaceCond.equals("") && workplaceCond.length() > 500) {
                        errorMsg += header[11] + " cannot be longer than 500 characters,";
                    }
                    
                    if (!workplaceSafety.equals("") && workplaceSafety.length() > 200) {
                        errorMsg += header[12] + " cannot be longer than 50 characters,";
                    }
                    
                    if (!workplaceRemark.equals("") && workplaceRemark.length() > 200) {
                        errorMsg += header[13] + " cannot be longer than 50 characters,";
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
                    JobWorkplace jobWorkplace = new JobWorkplace
                            (finNum, jobKey, workplaceType, workplaceTypeMore, workplaceWhose, 
                            workplacePers,workplaceEmpRel,workplaceDirect,workplaceDirectMore,
                            workplaceStart,workplaceEnd,workplaceCond, workplaceSafety,
                            workplaceRemark);
                    addJobWorkplace(jobWorkplace);
                    count++;
                }    
            }
            errList.add("workplace.csv:" + count);
            csvReader.close();
        } catch (FileNotFoundException ex) {
            //fileNotFoundExcepton
        }
        return errList;
    }
    
    /*Work History*/
    
    public static ArrayList<Integer> retrieveJobWorkHistoryIdsOfJob (Job job) {
         ArrayList<Integer> ids = new ArrayList<Integer>();

         Connection conn = null;
         PreparedStatement pstmt = null;
         ResultSet rs = null;
         String sql = "";

         try {
             conn = ConnectionManager.getConnection();
             sql = "SELECT ID FROM tbl_work_history where Worker_FIN_number = ? AND Job_key =?";
             pstmt = conn.prepareStatement(sql);
             pstmt.setString(1, job.getWorkerFinNum());
             pstmt.setInt(2, job.getJobKey());
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

    public static JobWorkHistory retrieveJobWorkHistoryById(int id) {
        JobWorkHistory jobWorkHistory = null;

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Work_hist_how, Work_hist_how_more,"
                    + " Work_hist_date, Work_hist_first, Work_hist_year_arrive,"
                    + " Work_hist_previous,Work_hist_previous_problems,"
                    + "Work_hist_remarks,Worker_FIN_number, Job_key "
                    + " FROM tbl_work_history where ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String Work_hist_how = rs.getString(1);
                String Work_hist_how_more = rs.getString(2);
                Date Work_hist_date = rs.getDate(3);
                String Work_hist_first = rs.getString(4);
                String Work_hist_year_arrive = rs.getString(5);
                String Work_hist_previous = rs.getString(6);
                String Work_hist_previous_problems = rs.getString(7);
                String Work_hist_remarks = rs.getString(8);
                String workerFinNumber = rs.getString(9);
                int jobKey = rs.getInt(10);

                jobWorkHistory = new JobWorkHistory(id,workerFinNumber,jobKey,Work_hist_how,
                        Work_hist_how_more,Work_hist_date, 
                        Work_hist_first,Work_hist_year_arrive,
                        Work_hist_previous,Work_hist_previous_problems,Work_hist_remarks);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql, "JobWorkHistory={" + jobWorkHistory + "}");           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return jobWorkHistory;
    }

    public static void addJobWorkHistory(JobWorkHistory jobWorkHistory) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "INSERT INTO tbl_work_history (Work_hist_how, Work_hist_how_more, "
                    + "Work_hist_date, Work_hist_first,Work_hist_year_arrive, "
                    + "Work_hist_previous, Work_hist_previous_problems, "
                    + "Work_hist_remarks, Worker_FIN_number, Job_key) "
                    + "VALUES (?,?,?,?,?,?,?,?,?,?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, jobWorkHistory.getWorkHistHow());
            pstmt.setString(2, jobWorkHistory.getWorkHistHowMore());
            pstmt.setDate(3, jobWorkHistory.getWorkHistDate());
            pstmt.setString(4, jobWorkHistory.getWorkHistFirst());
            pstmt.setString(5, jobWorkHistory.getWorkHistYearArrive());
            pstmt.setString(6, jobWorkHistory.getWorkHistPrevious());
            pstmt.setString(7, jobWorkHistory.getWorkHistPrevProblems());
            pstmt.setString(8, jobWorkHistory.getWorkHistRemarks());
            pstmt.setString(9, jobWorkHistory.getWorkerFinNum());
            pstmt.setInt(10, jobWorkHistory.getJobKey());

            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "jobWorkHistory: " + jobWorkHistory + "}");
        } finally {
            ConnectionManager.close(conn, pstmt);
        }    
    }

    public static void updateJobWorkHistory(JobWorkHistory jobWorkHistory) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_work_history SET Work_hist_how=?, Work_hist_how_more=?, "
                    + "Work_hist_date=?, Work_hist_first=?,Work_hist_year_arrive=?, "
                    + "Work_hist_previous=?, Work_hist_previous_problems=?, "
                    + "Work_hist_remarks=? "
                    + "WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, jobWorkHistory.getWorkHistHow());
            pstmt.setString(2, jobWorkHistory.getWorkHistHowMore());
            pstmt.setDate(3, jobWorkHistory.getWorkHistDate());
            pstmt.setString(4, jobWorkHistory.getWorkHistFirst());
            pstmt.setString(5, jobWorkHistory.getWorkHistYearArrive());
            pstmt.setString(6, jobWorkHistory.getWorkHistPrevious());
            pstmt.setString(7, jobWorkHistory.getWorkHistPrevProblems());
            pstmt.setString(8, jobWorkHistory.getWorkHistRemarks());
            pstmt.setInt(9, jobWorkHistory.getId());

            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "jobWorkHistory={" + jobWorkHistory + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }        
    }
    
    public static void deleteAllJobWorkHistories() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            
            sql = "DELETE FROM tbl_work_history";
            pstmt = conn.prepareStatement(sql);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "not able to delete data from Job-Work History Table. ");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }     
    }
    
    public static ArrayList<String> validateAndAddJobWorkHistory(String jobWorkHistoryFile) 
            throws IOException{
        
        // Attributes
        ArrayList<String> errList = new ArrayList<String>();
        CSVReader csvReader = null;
        try {
            csvReader = new CSVReader(new FileReader(jobWorkHistoryFile));
            String[] header = csvReader.readNext();
            String[] fields;
            int lineNum = 1;
            String errorMsg = "";
            int count = 0;

            // Loops through each line of the csv with an array of String
            while ((fields = csvReader.readNext()) != null) {
                lineNum++;
                // Assigning each field with its appropriate name
                String finNum = fields[0].trim();
                String jobKeyStr = fields[1].trim();
                String workHistoryHow = fields[2].trim();
                String workHistHowMore = fields[3].trim();
                String workHistDateStr = fields[4].trim();
                String workHistFirst = fields[5].trim();
                String workHistYrArrive = fields[6].trim();
                String workHistPrevious = fields[7].trim();
                String workHistProblems = fields[8].trim();
                String workHistRemark = fields[9].trim();
                
                int jobKey = 0;
                java.sql.Date workHistDate = null;
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
                if (workHistoryHow.equals("")) {
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
                    
                    if (workHistoryHow.length() > 50) {
                        errorMsg += header[2] + " cannot be longer than 50 characters,";
                    }
                         
                    if (!workHistHowMore.equals("") && workHistHowMore.length() > 200) {
                        errorMsg += header[3] + " cannot be longer than 200 characters,";
                    }
                    
                    if (!workHistDateStr.equals("")) {
                        try {
                            java.util.Date tmp = sdf.parse(workHistDateStr);
                            workHistDate = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                            errorMsg += "Invalid Work History Date Format,";
                        } 
                    }
                    
                    if (!workHistFirst.equals("")) {
                        if (workHistFirst.equals("Yes") || workHistFirst.equals("No")) {
                         
                        } else {
                            errorMsg += header[5] + "- should be either 'Yes' or 'No',";
                        }
                    }
                    
                    if (!workHistYrArrive.equals("")) {
                        try {
                            int tmp = Integer.parseInt(workHistYrArrive);
                        } catch (Exception ex) {
                            errorMsg += header[6] + " must be a number,";
                        }
                    }
                    
                    if (!workHistPrevious.equals("") && workHistPrevious.length() > 1000) {
                        errorMsg += header[7] + " cannot be longer than 1000 characters,";
                    }
                    
                    if (!workHistProblems.equals("") && workHistProblems.length() > 1000) {
                        errorMsg += header[8] + " cannot be longer than 1000 characters,";
                    }
                    
                    if (!workHistRemark.equals("") && workHistRemark.length() > 200) {
                        errorMsg += header[9] + " cannot be longer than 200 characters,";
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
                    JobWorkHistory jobWorkHistory = new JobWorkHistory(finNum, jobKey, workHistoryHow, 
                            workHistHowMore, workHistDate, workHistFirst, workHistYrArrive,
                            workHistPrevious,workHistProblems,workHistRemark);
                    addJobWorkHistory(jobWorkHistory);
                    count++;
                }    
            }
            errList.add("workhistory.csv:" + count);
            csvReader.close();
        } catch (FileNotFoundException ex) {
            //fileNotFoundExcepton
        }
        return errList;
    }
    
    /*Table Accommodation*/
    
    public static ArrayList<Integer> retrieveJobAccomodationIdsOfJob (Job job) {
         ArrayList<Integer> ids = new ArrayList<Integer>();

         Connection conn = null;
         PreparedStatement pstmt = null;
         ResultSet rs = null;
         String sql = "";

         try {
             conn = ConnectionManager.getConnection();
             sql = "SELECT ID FROM tbl_accomodation where Worker_FIN_number = ? AND Job_key =?";
             pstmt = conn.prepareStatement(sql);
             pstmt.setString(1, job.getWorkerFinNum());
             pstmt.setInt(2, job.getJobKey());
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

    public static JobAccomodation retrieveJobAccomodationById(int id) {
        JobAccomodation jobAccomodation = null;

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Accomodation_provided, Accomodation_provided_more,"
                    + " Accomodation_type, Accomodation_type_more, Accomodation_location,"
                    + "Accomodation_condition, Accomodation_charged, Accomodation_self_paid, "
                    + "Accomodation_meals,Accomodation_start, Accomodation_end, "
                    + "Accomodation_remarks, Worker_FIN_number, Job_key "
                    + " FROM tbl_accomodation where ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String Accomodation_provided = rs.getString(1);
                String Accomodation_provided_more = rs.getString(2);
                String Accomodation_type = rs.getString(3);    
                String Accomodation_type_more = rs.getString(4);
                String Accomodation_location = rs.getString(5);
                String Accomodation_condition = rs.getString(6);
                Double Accomodation_charged = rs.getDouble(7);
                Double Accomodation_self_paid = rs.getDouble(8);
                String Accomodation_meals = rs.getString(9);
                String Accomodation_start = rs.getString(10);
                String Accomodation_end = rs.getString(11);
                String Accomodation_remarks = rs.getString(12);
                String workerFinNum = rs.getString(13);
                int jobKey = rs.getInt(14);
                
                jobAccomodation = new JobAccomodation(id, workerFinNum, jobKey, Accomodation_provided,
                        Accomodation_provided_more, Accomodation_type, Accomodation_type_more,
                        Accomodation_location,Accomodation_condition,
                        Accomodation_charged,Accomodation_self_paid,Accomodation_meals,
                        Accomodation_start, Accomodation_end, Accomodation_remarks);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql, "JobAccomodation={" + jobAccomodation + "}");           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return jobAccomodation;
    }

    public static void addJobAccomodation(JobAccomodation jobAccomodation) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "INSERT INTO tbl_accomodation (Accomodation_provided, "
                    + "Accomodation_provided_more, Accomodation_type, "
                    + "Accomodation_type_more, Accomodation_location, "
                    + "Accomodation_condition, Accomodation_charged,"
                    + "Accomodation_self_paid, Accomodation_meals, Accomodation_start, "
                    + "Accomodation_end, Accomodation_remarks, Worker_FIN_number, Job_key ) "
                    + "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, jobAccomodation.getAccProvided());
            pstmt.setString(2, jobAccomodation.getAccProvidedMore());
            pstmt.setString(3, jobAccomodation.getAccType());
            pstmt.setString(4, jobAccomodation.getAccTypeMore());
            pstmt.setString(5, jobAccomodation.getAccLocation());
            pstmt.setString(6, jobAccomodation.getAccCondition());
            pstmt.setDouble(7, jobAccomodation.getAccCharged());
            pstmt.setDouble(8, jobAccomodation.getAccSelfPaid());
            pstmt.setString(9, jobAccomodation.getAccMeals());
            pstmt.setString(10, jobAccomodation.getAccStart());
            pstmt.setString(11, jobAccomodation.getAccEnd());
            pstmt.setString(12, jobAccomodation.getAccRemarks());
            pstmt.setString(13, jobAccomodation.getWorkerFinNum());
            pstmt.setInt(14, jobAccomodation.getJobKey());

            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "jobAccomodation: " + jobAccomodation + "}");
        } finally {
            ConnectionManager.close(conn, pstmt);
        }    
    }

    public static void updateJobAccomodation(JobAccomodation jobAccomodation) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_accomodation SET Accomodation_provided = ? , "
                    + "Accomodation_provided_more = ?, Accomodation_type =?, "
                    + "Accomodation_type_more=?, Accomodation_location=?,"
                    + "Accomodation_condition=?, Accomodation_charged=?, "
                    + "Accomodation_self_paid=?, Accomodation_meals=?,"
                    + "Accomodation_start=?, Accomodation_end=?, Accomodation_remarks=?  "
                    + "WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, jobAccomodation.getAccProvided());
            pstmt.setString(2, jobAccomodation.getAccProvidedMore());
            pstmt.setString(3, jobAccomodation.getAccType());
            pstmt.setString(4, jobAccomodation.getAccTypeMore());
            pstmt.setString(5, jobAccomodation.getAccLocation());
            pstmt.setString(6, jobAccomodation.getAccCondition());
            pstmt.setDouble(7, jobAccomodation.getAccCharged());
            pstmt.setDouble(8, jobAccomodation.getAccSelfPaid());
            pstmt.setString(9, jobAccomodation.getAccMeals());
            pstmt.setString(10, jobAccomodation.getAccStart());
            pstmt.setString(11, jobAccomodation.getAccEnd());
            pstmt.setString(12, jobAccomodation.getAccRemarks());
            pstmt.setInt(13, jobAccomodation.getId());

            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "jobAccomodation={" + jobAccomodation + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }        
    }
 
    public static void deleteAllJobAccomodations() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            
            sql = "DELETE FROM tbl_accomodation";
            pstmt = conn.prepareStatement(sql);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "not able to delete data from Job-Accomodations Table. ");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }     
    }
    
    public static ArrayList<String> validateAndAddJobAccomodation(String jobAccomodationFile) 
            throws IOException{
        
        // Attributes
        ArrayList<String> errList = new ArrayList<String>();
        CSVReader csvReader = null;
        try {
            csvReader = new CSVReader(new FileReader(jobAccomodationFile));
            String[] header = csvReader.readNext();
            String[] fields;
            int lineNum = 1;
            String errorMsg = "";
            int count = 0;

            // Loops through each line of the csv with an array of String
            while ((fields = csvReader.readNext()) != null) {
                lineNum++;
                // Assigning each field with its appropriate name
                String finNum = fields[0].trim();
                String jobKeyStr = fields[1].trim();
                String accomProvided = fields[2].trim();
                String accomProvidedMore = fields[3].trim();
                String accomType = fields[4].trim();
                String accomTypeMore = fields[5].trim();
                String accomLocation = fields[6].trim();
                String accomConditions = fields[7].trim();
                String accomChargedStr = fields[8].trim();
                String accomSelfPaidStr = fields[9].trim();
                String accomMeals = fields[10].trim();
                String accomStart = fields[11].trim();
                String accomEnd = fields[12].trim();
                String accomRemark = fields[13].trim();
                
                int jobKey = 0;
                double accomCharged = 0;
                double accomSelfPaid = 0;
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
                if (accomProvided.equals("")) {
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

                    ArrayList<String> list = DropdownDAO.retrieveAllDropdownListOfAccomProvidedType();
                    boolean exit = false;
                    for (String tmp: list) {
                        if (tmp.equalsIgnoreCase(accomProvided)) {
                            exit = true;
                            break;
                        }
                    }

                    if (!exit) {
                        errorMsg += "Invalid Accommodation Provided Type, ";
                    }
                    
                    if (!accomProvidedMore.equals("") && accomProvidedMore.length() > 200) {
                        errorMsg += header[3] + " cannot be longer than 200 characters,";
                    }
                    
                    if (!accomType.equals("")) {
                        list = DropdownDAO.retrieveAllDropdownListOfAccomType();
                        exit = false;
                        for (String tmp: list) {
                            if (tmp.equalsIgnoreCase(accomProvided)) {
                                exit = true;
                                break;
                            }
                        }

                        if (!exit) {
                            errorMsg += "Invalid Accommodation Type, ";
                        }    
                    }
                    
                    if (!accomTypeMore.equals("") && accomTypeMore.length() > 300) {
                        errorMsg += header[5] + " cannot be longer than 300 characters,";
                    }

                    if (!accomLocation.equals("") && accomLocation.length() > 200) {
                        errorMsg += header[6] + " cannot be longer than 200 characters,";
                    }
                    
                    if (!accomConditions.equals("") && accomConditions.length() > 500) {
                        errorMsg += header[7] + " cannot be longer than 500 characters,";
                    }
                    
                    if (!accomChargedStr.equals("") && !accomChargedStr.matches("^\\d+(\\.\\d{1,2})?$")) {
                        errorMsg += header[8] + " must have maximum 2 decimal places,";
                    } else {
                        try {
                            accomCharged = Double.parseDouble(accomChargedStr);
                        } catch (Exception ex) {
                            errorMsg += header[8] + " - invalid format,";
                        }
                    }
                    
                    if (!accomSelfPaidStr.equals("") && !accomSelfPaidStr.matches("^\\d+(\\.\\d{1,2})?$")) {
                        errorMsg += header[9] + " must have maximum 2 decimal places,";
                    } else {
                        try {
                            accomSelfPaid = Double.parseDouble(accomSelfPaidStr);
                        } catch (Exception ex) {
                            errorMsg += header[9] + " - invalid format,";
                        }
                    }
                    
                    if (!accomMeals.equals("") && accomMeals.length() > 200) {
                        errorMsg += header[10] + " cannot be longer than 200 characters,";
                    }
                    
                    if (!accomStart.equals("") && accomStart.length() > 50) {
                        errorMsg += header[11] + " cannot be longer than 50 characters,";
                    }
                    
                    if (!accomEnd.equals("") && accomEnd.length() > 50) {
                        errorMsg += header[12] + " cannot be longer than 50 characters,";
                    }
                    
                    if (!accomRemark.equals("") && accomRemark.length() > 200) {
                        errorMsg += header[13] + " cannot be longer than 200 characters,";
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
                    JobAccomodation jobAccomodation = new JobAccomodation
                            (finNum, jobKey, accomProvided, accomProvidedMore, accomType, 
                            accomTypeMore, accomLocation,accomConditions,accomCharged,
                            accomSelfPaid,accomMeals,accomStart,accomEnd,accomRemark);
                    addJobAccomodation(jobAccomodation);
                    count++;
                }    
            }
            errList.add("accomodation.csv:" + count);
            csvReader.close();
        } catch (FileNotFoundException ex) {
            //fileNotFoundExcepton
        }
        return errList;
    }
    
    /*general*/
    public static void deleteAll() {
        deleteAllJobPassDetails();
        deleteAllJobIPADetails();
        deleteAllJobVerbalAssurances();
        deleteAllEmploymentContracts();
        deleteAllJobIntermediaryAgent();
        deleteAllJobEmployers();
        deleteAllJobWorkPlaces();
        deleteAllJobWorkHistories();
        deleteAllJobAccomodations();
        
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
   
  
