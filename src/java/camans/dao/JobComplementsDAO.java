/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.dao;

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
 
    private static void handleSQLException(SQLException ex, String sql, String... parameters) {
      String msg = "Unable to access data; SQL=" + sql + "\n";
      for (String parameter : parameters) {
        msg += "," + parameter + ex.getMessage();
      }
      Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, msg, ex);
      throw new RuntimeException(msg, ex);
    }

}
   
  
