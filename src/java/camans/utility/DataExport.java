/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.utility;

import au.com.bytecode.opencsv.CSVWriter;
import camans.dao.ConnectionManager;
import camans.dao.UserDAO;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author soemyatmyat
 */
public class DataExport {
    
    public static void exportData(String fileName) throws IOException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        ResultSet rs = null;
        CSVWriter csvWriter = null;
        
        try {
          csvWriter = new CSVWriter (new FileWriter(fileName));
          conn = ConnectionManager.getConnection();
          //String csvfileName = fileName.substring(fileName.lastIndexOf("\\")+1);
          String csvfileName = fileName.substring(fileName.lastIndexOf("/")+1);
          if (csvfileName.equalsIgnoreCase("worker.csv")) {
             sql = "SELECT FIN_number, Name_of_worker, Worker_registration_date, Created_by, Create_for, Gender, "
                    + "Nationality, Nationality_more, Date_of_birth FROM tbl_worker";
          } else if (csvfileName.equalsIgnoreCase("job.csv")) {
              sql = "SELECT Worker_FIN_number, Job_key, Employer_name, Workpass_type, Workpass_more, Job_sector, "
                      + "Job_sector_more, Occupation, Job_start_date, Job_end_date, Job_whether_TJS, Job_remarks "
                      + "FROM tbl_job ";
          } else if (csvfileName.equalsIgnoreCase("problem.csv")) {
              sql = "SELECT Worker_FIN_number, Job_key, Prob_key, Chief_problem_date, Chief_problem, Chief_problem_more, "
                      + "Chief_problem_remarks, Referred_by, Referred_to, Referred_date, Description FROM tbl_problem";
          } else if (csvfileName.equalsIgnoreCase("benefit.csv")) {
              sql = "SELECT Worker_FIN_number, Job_key, Prob_key, Bene_date, Bene_giver, Bene_type, Bene_type_more, "
                      + "Bene_serial, Bene_purpose, Bene_rem, Bene_value FROM tbl_benefit";
          } else if (csvfileName.equalsIgnoreCase("audit.csv")) {
              sql = "SELECT Entry_date, username, Key_log, FIN_log, Action_type, Action_description_log FROM tbl_audit";
          } else if (csvfileName.equalsIgnoreCase("aggravatingissue.csv")) {
              sql = "SELECT Worker_FIN_number, Job_key, Prob_key, Aggra_issue, Aggra_issue_more, Aggra_loss, "
                      + "Aggra_remarks FROM tbl_aggravating_issue";
          } else if (csvfileName.equalsIgnoreCase("leadcaseworker.csv")) {
              sql = "SELECT Worker_FIN_number, Job_key, Prob_key, Lead_case_worker, Lead_start, Lead_end FROM tbl_lead_case_worker";
          } else if (csvfileName.equalsIgnoreCase("auxiliarycaseworker.csv")) {
              sql = "SELECT Worker_FIN_number, Job_key, Prob_key, Aux_name, Aux_start, Aux_end FROM tbl_auxillarycaseworker";
          } else if (csvfileName.equalsIgnoreCase("salaryrelatedhistory.csv")) {
              sql = "SELECT Worker_FIN_number, Job_key, Prob_key, Sal_hist_basic, Sal_hist_ot, Sal_hist_allowances, "
                      + "Sal_hist_deductions, Sal_hist_kickbacks, Sal_hist_other, Sal_mode, Sal_mode_more, Sal_loss_total, "
                      + "Sal_loss_1_year, Sal_his_remarks FROM tbl_salary_history ";
          } else if (csvfileName.equalsIgnoreCase("injury.csv")) {
              sql = "SELECT Worker_FIN_number, Job_key, Prob_key, Injury_date, Injury_time, Injury_location, "
                      + "Injury_death, Injury_body_part, Injury_how, Injury_ambulance, Injury_initial_treatment, "
                      + "Injury_initial_treatment_more, Injury_work_related, Injury_remarks FROM tbl_injury;";
          } else if (csvfileName.equalsIgnoreCase("illness.csv")) {
              sql = "SELECT Worker_FIN_number, Job_key, Prob_key, Illness_start_when, Illness_diag_when, "
                      + "Illness_diag_who, Illness_nature, Illness_work_related, Illness_why, Illness_rem "
                      + "FROM tbl_illness";
          } else if (csvfileName.equalsIgnoreCase("otherproblems.csv")) {
              sql = "SELECT Worker_FIN_number, Job_key, Prob_key, Oth_problem_desc, Oth_problem_loss, "
                      + "Oth_problem_rem FROM tbl_other_problems;";
          } else if (csvfileName.equalsIgnoreCase("salaryclaim.csv")) {
              sql = "SELECT Worker_FIN_number, Job_key, Prob_key, Sal_claim_date, Sal_claim_loss, Sal_claim_basis "
                      + "FROM tbl_salary_claim_lodged;";
          } else if (csvfileName.equalsIgnoreCase("wica.csv")) {
              sql = "SELECT Worker_FIN_number, Job_key, Prob_key, Wicamon_update, Wicamon_status, Wicamon_status_more, "
                      + "Wicamon_points, Wicamon_dollars, Wicamon_remarks FROM tbl_wica ";
          } else if (csvfileName.equalsIgnoreCase("wicaclaim.csv")) {
              sql = "SELECT Worker_FIN_number, Job_key, Prob_key, Wica_claim_date, Wica_ref_nbr, Wica_insurer, "
                      + "Wica_policy_nbr, Wica_claim_reason, Wica_claim_rem FROM tbl_wica_claim ";
          } else if (csvfileName.equalsIgnoreCase("nonwicaclaim.csv")) {
              sql = "SELECT Worker_FIN_number, Job_key, Prob_key, Med_claim_date, Med_claim_loss, Med_claim_insurer,"
                      + "Med_claim_policy_nbr, Med_claim_basis, Med_claim_rem FROM tbl_non_wica_claim ";
          } else if (csvfileName.equalsIgnoreCase("policereport.csv")) {
              sql = "SELECT Worker_FIN_number, Job_key, Prob_key, Police_rpt_date, Police_rpt_station, Police_rpt_pers, "
                      + "Police_rpt_ref_nbr, Police_rpt_details, Police_rpt_rem FROM tbl_police_report ";
          } else if (csvfileName.equalsIgnoreCase("othercomplaints.csv")) {
              sql = "SELECT Worker_FIN_number, Job_key, Prob_key, Other_plaint_date, Other_plaint_agency, "
                      + "Other_plaint_who, Other_plaint_who_more, Other_plaint_mode, Other_plaint_mode_more, "
                      + "Other_plaint_details, Other_plaint_rem FROM tbl_other_complaint";
          } else if (csvfileName.equalsIgnoreCase("casediscussion.csv")) {
              sql = "SELECT Worker_FIN_number, Job_key, Prob_key, Discuss_date, Discuss_time, Discuss_where, Discuss_where_more, "
                      + "Discuss_worker_present, Discuss_TWC2_pers1, Discuss_TWC2_pers2, Discuss_oth_pers, Discuss_translator, "
                      + "Discuss_topic, Discuss_gist, Discuss_assist, Discuss_calculate, Discuss_action, Discuss_rem FROM tbl_case_discussion ";
          } else if (csvfileName.equalsIgnoreCase("hospital.csv")) {
              sql = "SELECT Worker_FIN_number, Job_key, Prob_key, Hosp_update, Hosp_name, Hosp_name_more, "
                      + "Hosp_doctor, Hosp_remark FROM tbl_hospital";
          } else if (csvfileName.equalsIgnoreCase("mcstatus.csv")) {
              sql = "SELECT Worker_FIN_number, Job_key, Prob_key, MC_update, MC_status, MC_status_more, "
                      + "MC_exp_date, MC_days_cumul, MC_rem FROM tbl_mc_status";
          } else if (csvfileName.equalsIgnoreCase("r2r.csv")) {
              sql = "SELECT Worker_FIN_number, Job_key, Prob_key, R2R_date, R2R_time, R2R_hosp, R2R_dept, "
                      + "R2R1, R2R2, R2R_purpose, R2R_pre_appt_notes, R2R_post_appt_notes, R2R_feedback, "
                      + "R2R_med_cost, R2R_outlay FROM tbl_r2r ";
          } else if (csvfileName.equalsIgnoreCase("lawyer.csv")) {
              sql = "SELECT Worker_FIN_number, Job_key, Prob_key,Lawyer_update, Lawyer_firm, Lawyer_firm_more, "
                      + "Lawyer_Name, Lawyer_remarks FROM tbl_lawyer";
          } else if (csvfileName.equalsIgnoreCase("casemilestonenc.csv")) {
              sql = "SELECT Worker_FIN_number, Job_key, Prob_key, Miles_nc_date, Miles_nc_reached, "
                      + "Miles_nc_reached_more, Miles_nc_rem FROM tbl_casemilestone_noncriminal";
          } else if (csvfileName.equalsIgnoreCase("casemilestonecr.csv")) {
              sql = "SELECT Worker_FIN_number, Job_key, Prob_key, Miles_cr_date, Miles_cr_reached, "
                      + "Miles_cr_reached_more, Miles_cr_charges, Miles_cr_sentence, Miles_cr_rem "
                      + "FROM tbl_casemilestone_criminal ";
          } else if (csvfileName.equalsIgnoreCase("ttr.csv")) {
              sql = "SELECT Worker_FIN_number, Job_key, Prob_key, Ttr_update, Ttr_status, Ttr_status_more, "
                      + "Departure_date, Name_new_employer, New_job, Ttr_rem FROM tbl_ttr";
          } else if (csvfileName.equalsIgnoreCase("nickname.csv")) {
              sql = "SELECT Worker_FIN_number, Nickname FROM tbl_worker_nickname";
          } else if (csvfileName.equalsIgnoreCase("passport.csv")) {
              sql = "SELECT Worker_FIN_number, Passport_number, Passport_country, Passport_issue_date, "
                      + "Passport_expiry_date FROM tbl_worker_passport_details";
          } else if (csvfileName.equalsIgnoreCase("homecountryph.csv")) {
              sql = "SELECT Worker_FIN_number, Home_country_telephone_number, Owner_of_number, Home_phone_obsolete "
                      + "FROM tbl_home_country_phone_number";
          } else if (csvfileName.equalsIgnoreCase("homecountryaddress.csv")) {
              sql = "SELECT Worker_FIN_number, Home_country_address, Home_country_obsolete_address "
                      + "FROM tbl_home_country_address";
          } else if (csvfileName.equalsIgnoreCase("sgph.csv")) {
              sql = "SELECT Worker_FIN_number, Sg_phone_num, Sg_phone_obsolete FROM tbl_sg_phone_number";
          } else if (csvfileName.equalsIgnoreCase("sgaddress.csv")) {
              sql = "SELECT Worker_FIN_number, Singapore_address, Addr_singapore_obsolete FROM tbl_sg_address";
          } else if (csvfileName.equalsIgnoreCase("digitalcontact.csv")) {
              sql = "SELECT Worker_FIN_number, Digital_contact_type, Digital_more, Email_or_QQ_address, "
                      + "Owner_of_electronic_contact, Digital_remarks, Obsolete_date FROM tbl_digital_contact";
          } else if (csvfileName.equalsIgnoreCase("nextofkin.csv")) {
              sql = "SELECT Worker_FIN_number, Kin_name, Kin_relationship, Kin_Id_doc, Kin_phone, "
                      + "Kin_digital, Kin_address, Kin_proof, Kin_remarks, Kin_obsolete_date FROM tbl_kin";
          } else if (csvfileName.equalsIgnoreCase("familymember.csv")) {
              sql = "SELECT Worker_FIN_number, Name_of_family_member, Family_member_relationship, "
                      + "Family_member_where, Family_member_phone_number, Family_member_digital, "
                      + "Family_member_remarks, Family_member_obsolete FROM tbl_family_member";
          } else if (csvfileName.equalsIgnoreCase("sgfriend.csv")) {
              sql = "SELECT Worker_FIN_number, friend_sg_name, friend_sg_phone, friend_sg_rel, friend_sg_rem,"
                      + "friend_sg_obsolete FROM tbl_sg_friend ";
          } else if (csvfileName.equalsIgnoreCase("language.csv")) {
              sql = "SELECT Worker_FIN_number, Worker_main_language, Worker_main_language_more, "
                      + "Spoken_english_standard, Language_remarks FROM tbl_language";
          } else if (csvfileName.equalsIgnoreCase("bankacct.csv")) {
              sql = "SELECT Worker_FIN_number, Bank_account_name, Bank_account_number, Bank_name, "
                      + "Bank_branch_name, Bank_branch_address, Bank_branch_code, Bank_swift_code, "
                      + "Bank_account_remarks, Bank_obsolete_date FROM tbl_bank_acc_details ";
          } else if (csvfileName.equalsIgnoreCase("currentpass.csv")) {
              sql = "SELECT Worker_FIN_number, Job_key, Pass_type, Pass_type_more, Pass_number, "
                      + "Pass_application_date, Pass_issue_date, Pass_expiry_date, Pass_issuer, Pass_remarks,"
                      + "Pass_obsolete_date FROM tbl_pass_details";
          } else if (csvfileName.equalsIgnoreCase("ipa.csv")) {
              sql = "SELECT Worker_FIN_number, Job_key, IPA_pass_type, IPA_pass_type_more, "
                      + "IPA_application_date, IPA_employer_name, IPA_agent_name, IPA_industry, "
                      + "IPA_occupation, IPA_period_years, IPA_basic_salary, IPA_allowances, "
                      + "IPA_allowances_details, IPA_deduction, IPA_deduction_details, Housing_provided, "
                      + "IPA_remarks FROM tbl_ipa_details ";
          } else if (csvfileName.equalsIgnoreCase("verbalassurance.csv")) {
              sql = "SELECT Worker_FIN_number, Job_key, Verbal_name, Verbal_relationship, Verbal_when, "
                      + "Verbal_where, Verbal_content FROM tbl_verbal_assurances";
          } else if (csvfileName.equalsIgnoreCase("employmentcontract.csv")) {
              sql = "SELECT Worker_FIN_number, Job_key, Short_name, Contract_date, Contract_where, "
                      + "Contract_language, Contract_opposite_name, Contract_opposite_relationship, "
                      + "Contract_occupation, Contract_basic_salary, Contract_allowances, "
                      + "Contract_deduction_details, Contract_duration, Contract_duress, Contract_remarks "
                      + "FROM tbl_employment_contract";
          } else if (csvfileName.equalsIgnoreCase("intermediaryagent.csv")) {
              sql = "SELECT Worker_FIN_number, Job_key, Agent_Company, Agent_person_name, Agent_location, "
                      + "Agent_location_more, Agent_address, Agent_contact, Agent_amt_paid, Agent_amt_owed, "
                      + "Agent_fee_shared, Agent_fee_training, Agent_fee_airfare, Agent_fee_where, "
                      + "Agent_fee_when, Agent_fee_repay, Agent_employer, Agent_remarks FROM tbl_agent";
          } else if (csvfileName.equalsIgnoreCase("employer.csv")) {
              sql = "SELECT Worker_FIN_number, Job_key, Employer_official_name, Employer_ID, Employer_address, "
                      + "Employer_contacts, Employer_persons, Employer_remarks FROM tbl_employer";
          } else if (csvfileName.equalsIgnoreCase("workplace.csv")) {
              sql = "SELECT Worker_FIN_number, Job_key, Workplace_type, Workplace_type_more, Workplace_whose, "
                      + "Workplace_persons, Workplace_employer_relationship, Workplace_direct, "
                      + "Workplace_direct_more, Workplace_start, Workplace_end, Workplace_condition, "
                      + "Workplace_safety, Workplace_remarks FROM tbl_workplace";
          } else if (csvfileName.equalsIgnoreCase("workhistory.csv")) {
              sql = "SELECT Worker_FIN_number, Job_key, Work_hist_how, Work_hist_how_more, Work_hist_date, "
                      + "Work_hist_first, Work_hist_year_arrive, Work_hist_previous, Work_hist_previous_problems, "
                      + "Work_hist_remarks FROM tbl_work_history";
          } else if (csvfileName.equalsIgnoreCase("accomodation.csv")) {
              sql = "SELECT Worker_FIN_number, Job_key, Accomodation_provided, Accomodation_provided_more, "
                      + "Accomodation_type, Accomodation_type_more, Accomodation_location, Accomodation_condition, "
                      + "Accomodation_charged, Accomodation_self_paid, Accomodation_meals, Accomodation_start, "
                      + "Accomodation_end, Accomodation_remarks FROM tbl_accomodation";
          }
          pstmt = conn.prepareStatement(sql);
          rs = pstmt.executeQuery();
          csvWriter.writeAll(rs, true); //write all data including header
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "not able to export data from Worker Table. ");
        } catch (IOException ex) {
            
        } finally {
            csvWriter.close();
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
