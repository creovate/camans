/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.dao;

import camans.entity.User;
import camans.entity.Worker;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author soemyatmyat
 */
public class DropdownDAO {
    
   
    public static HashMap<Integer, String> retrieveAllDropdownListOfNationalities() {
        HashMap<Integer,String> nationalityList = new HashMap<Integer,String>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID, Name FROM tbl_dropdown where dropdownType = ? order by Name ASC;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "Nationality_type");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                String nationality = rs.getString(2);
                nationalityList.put(id, nationality);
            }
            
        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        } 
        return nationalityList;
    }
        
    public static HashMap<Integer,String> retrieveAllDropdownListOfProblems() {
        HashMap<Integer,String> problemList = new HashMap<Integer,String>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID, Name FROM tbl_dropdown where dropdownType = ? order by Name ASC;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "Problem_type");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                String problem = rs.getString(2);
                problemList.put(id, problem);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        } 
        return problemList;
    }

    public static HashMap<Integer,String> retrieveAllDropdownListOfPassType() {
        HashMap<Integer,String> passTypeList = new HashMap<Integer,String>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID, Name FROM tbl_dropdown where dropdownType = ? order by Name ASC;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "Pass_type");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                String passType = rs.getString(2);
                passTypeList.put(id, passType);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        } 
        return passTypeList;       
    }

    public static HashMap<Integer,String> retrieveAllDropdownListOfJobSector() {
        HashMap<Integer,String> jobSectorList = new HashMap<Integer,String>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID, Name FROM tbl_dropdown where dropdownType = ? order by Name ASC;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "Job_sector_type");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                String jobSector = rs.getString(2);
                jobSectorList.put(id, jobSector);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        } 
        return jobSectorList;       
    }

    public static HashMap<Integer,String> retrieveAllDropdownListOfHosptialType() {
        HashMap<Integer,String> hosptialList = new HashMap<Integer,String>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID, Name FROM tbl_dropdown where dropdownType = ? order by Name ASC;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "Hospital_name");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                String hospital = rs.getString(2);
                hosptialList.put(id, hospital);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        } 
        return hosptialList;       
    }
    
    public static HashMap<Integer,String> retrieveAllDropdownListOfDigitalContactType() {
        HashMap<Integer,String> digitalContactList = new HashMap<Integer,String>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID, Name FROM tbl_dropdown where dropdownType = ? order by Name ASC;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "DigitalType");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                String contactType = rs.getString(2);
                digitalContactList.put(id, contactType);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        } 
        return digitalContactList;            
    }

    public static HashMap<Integer,String> retrieveAllDropdownListOfLanguage() {
    HashMap<Integer,String> languageList = new HashMap<Integer,String>();
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String sql = "";

    try {
        conn = ConnectionManager.getConnection();
        sql = "SELECT ID, Name FROM tbl_dropdown where dropdownType = ? order by Name ASC;";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, "MainLang");
        rs = pstmt.executeQuery();
        while (rs.next()) {
            int id = rs.getInt(1);
            String language = rs.getString(2);
            languageList.put(id, language);
        }

    } catch (SQLException ex) {
        handleSQLException(ex, sql);           
    } finally {
        ConnectionManager.close(conn, pstmt, rs);
    } 
    return languageList;            
}

    public static HashMap<Integer,String> retrieveAllDropdownListOfSpokenEnglish() {
        HashMap<Integer,String> spokenEnglishStandards = new HashMap<Integer,String>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID, Name FROM tbl_dropdown where dropdownType = ? order by Name ASC;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "Spoken_english_standard");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                String standard = rs.getString(2);
                spokenEnglishStandards.put(id, standard);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        } 
        return spokenEnglishStandards; 
    }
    
    public static HashMap<Integer,String> retrieveAllDropdownListOfWorkpassType() {
        HashMap<Integer,String> workpassTypes = new HashMap<Integer,String>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID, Name FROM tbl_dropdown where dropdownType = ? order by Name ASC;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "Work_pass_type");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                String type = rs.getString(2);
                workpassTypes.put(id, type);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        } 
        return workpassTypes; 
    }
    
    public static HashMap<Integer,String> retrieveAllDropdownListOfIPAPassType() {
        HashMap<Integer,String> ipapassTypes = new HashMap<Integer,String>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID, Name FROM tbl_dropdown where dropdownType = ? order by Name ASC;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "IPA_pass_type");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                String type = rs.getString(2);
                ipapassTypes.put(id, type);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        } 
        return ipapassTypes; 
    }
    
    public static HashMap<Integer,String> retrieveAllDropdownListOfAgentLocationType() {
        HashMap<Integer,String> agentLocationTypes = new HashMap<Integer,String>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID, Name FROM tbl_dropdown where dropdownType = ? order by Name ASC;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "Agent_location_type");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                String type = rs.getString(2);
                agentLocationTypes.put(id, type);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        } 
        return agentLocationTypes; 
    }
    
    public static HashMap<Integer,String> retrieveAllDropdownListOfWorkplaceType() {
        HashMap<Integer,String> types = new HashMap<Integer,String>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID, Name FROM tbl_dropdown where dropdownType = ? order by Name ASC;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "Workplace_type");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                String type = rs.getString(2);
                types.put(id, type);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        } 
        return types; 
    }
    
    public static HashMap<Integer,String> retrieveAllDropdownListOfWorkplaceDirectType() {
        HashMap<Integer,String> types = new HashMap<Integer,String>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID, Name FROM tbl_dropdown where dropdownType = ? order by Name ASC;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "Workplace_direct_type");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                String type = rs.getString(2);
                types.put(id, type);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        } 
        return types; 
    }
    
    public static HashMap<Integer,String> retrieveAllDropdownListOfWorkHistoryHowType() {
        HashMap<Integer,String> types = new HashMap<Integer,String>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID, Name FROM tbl_dropdown where dropdownType = ? order by Name ASC;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "Work_history_how_type");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                String type = rs.getString(2);
                types.put(id, type);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        } 
        return types; 
    }
    
    public static HashMap<Integer,String> retrieveAllDropdownListOfAccomProvidedType() {
        HashMap<Integer,String> types = new HashMap<Integer,String>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID, Name FROM tbl_dropdown where dropdownType = ? order by Name ASC;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "Accom_provided_type");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                String type = rs.getString(2);
                types.put(id, type);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        } 
        return types; 
    }
    
    public static HashMap<Integer,String> retrieveAllDropdownListOfAccomType() {
        HashMap<Integer,String> types = new HashMap<Integer,String>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID, Name FROM tbl_dropdown where dropdownType = ? order by Name ASC;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "Accommodation_type");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                String type = rs.getString(2);
                types.put(id, type);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        } 
        return types; 
    }
    
    public static HashMap<Integer,String> retrieveAllDropdownListOfCaseworkers() {
        HashMap<Integer,String> types = new HashMap<Integer,String>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT * FROM tbl_user";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                String type = rs.getString(2);
                types.put(id, type);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        } 
        return types; 
    }
    
    public static HashMap<Integer,String> retrieveAllDropdownListOfSalaryMode() {
        HashMap<Integer,String> types = new HashMap<Integer,String>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID, Name FROM tbl_dropdown where dropdownType = ? order by Name ASC;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "Salary_payment_type");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                String type = rs.getString(2);
                types.put(id, type);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        } 
        return types; 
    }
    
    public static HashMap<Integer,String> retrieveAllDropdownListOfComplaint() {
        HashMap<Integer,String> types = new HashMap<Integer,String>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID, Name FROM tbl_dropdown where dropdownType = ? order by Name ASC;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "Complaint_type");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                String type = rs.getString(2);
                types.put(id, type);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        } 
        return types; 
    }
    
    public static HashMap<Integer,String> retrieveAllDropdownListOfComplaintMode() {
        HashMap<Integer,String> types = new HashMap<Integer,String>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID, Name FROM tbl_dropdown where dropdownType = ? order by Name ASC;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "Complaint_mode_type");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                String type = rs.getString(2);
                types.put(id, type);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        } 
        return types; 
    }
    
    public static HashMap<Integer,String> retrieveAllDropdownListOfDiscussWhere() {
        HashMap<Integer,String> types = new HashMap<Integer,String>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID, Name FROM tbl_dropdown where dropdownType = ? order by Name ASC;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "Discuss_where_type");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                String type = rs.getString(2);
                types.put(id, type);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        } 
        return types; 
    }
    
    public static HashMap<Integer,String> retrieveAllDropdownListOfHosipital() {
        HashMap<Integer,String> types = new HashMap<Integer,String>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID, Name FROM tbl_dropdown where dropdownType = ? order by Name ASC;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "Hospital_name");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                String type = rs.getString(2);
                types.put(id, type);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        } 
        return types; 
    }
    
    public static HashMap<Integer,String> retrieveAllDropdownListOfMCStatus() {
        HashMap<Integer,String> types = new HashMap<Integer,String>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID, Name FROM tbl_dropdown where dropdownType = ? order by Name ASC;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "MC_status_type");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                String type = rs.getString(2);
                types.put(id, type);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        } 
        return types; 
    }
    
    public static HashMap<Integer,String> retrieveAllDropdownListOfWica() {
        HashMap<Integer,String> types = new HashMap<Integer,String>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID, Name FROM tbl_dropdown where dropdownType = ? order by Name ASC;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "Wicamon_status");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                String type = rs.getString(2);
                types.put(id, type);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        } 
        return types; 
    }
    
    public static HashMap<Integer,String> retrieveAllDropdownListOfMilestoneNonCriminal() {
        HashMap<Integer,String> types = new HashMap<Integer,String>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID, Name FROM tbl_dropdown where dropdownType = ? order by Name ASC;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "Miles_nc_reached");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                String type = rs.getString(2);
                types.put(id, type);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        } 
        return types; 
    }
    
    public static HashMap<Integer,String> retrieveAllDropdownListOfMilestoneCriminal() {
        HashMap<Integer,String> types = new HashMap<Integer,String>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID, Name FROM tbl_dropdown where dropdownType = ? order by Name ASC;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "Casemilestone_criminal_type");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                String type = rs.getString(2);
                types.put(id, type);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        } 
        return types; 
    }
    
    public static HashMap<Integer,String> retrieveAllDropdownListOfTTRStatus() {
        HashMap<Integer,String> types = new HashMap<Integer,String>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID, Name FROM tbl_dropdown where dropdownType = ? order by Name ASC;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "Ttr_status_type");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                String type = rs.getString(2);
                types.put(id, type);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        } 
        return types; 
    }
    
    public static HashMap<Integer,String> retrieveAllDropdownListOfLawFirms() {
        HashMap<Integer,String> types = new HashMap<Integer,String>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID, Name FROM tbl_dropdown where dropdownType = ? order by Name ASC;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "Lawyer_firm");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                String type = rs.getString(2);
                types.put(id, type);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        } 
        return types;         
    }
    
    public static ArrayList<String> retreiveAllDropdownListOfBenefits(String benefitType) {
        ArrayList<String> list = new ArrayList<String>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
 
        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Name FROM tbl_dropdown where dropdownType = ? and "
                    + "Other = ? order by Name ASC;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "Bene_Type");
            pstmt.setString(2, benefitType);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String name = rs.getString(1);
                list.add(name);
            }
 
        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return list;
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
