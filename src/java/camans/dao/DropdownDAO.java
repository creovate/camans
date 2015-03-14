/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.dao;

import camans.entity.Dropdown;
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
    
   
    public static ArrayList<String> retrieveAllDropdownListOfNationalities() {
        ArrayList<String> nationalityList = new ArrayList<String>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Name FROM tbl_dropdown where dropdownType = ? order by displayRank ASC;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "Nationality_type");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String nationality = rs.getString(1);
                nationalityList.add(nationality);
            }
            
        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        } 
        return nationalityList;
    }
        
    public static ArrayList<String> retrieveAllDropdownListOfProblems() {
        ArrayList<String> problemList = new ArrayList<String>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Name FROM tbl_dropdown where dropdownType = ? order by displayRank ASC;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "Problem_type");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String problem = rs.getString(1);
                problemList.add(problem);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        } 
        return problemList;
    }

    public static ArrayList<String> retrieveAllDropdownListOfPassType() {
        ArrayList<String> passTypeList = new ArrayList<String>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Name FROM tbl_dropdown where dropdownType = ? order by displayRank ASC;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "Pass_type");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String passType = rs.getString(1);
                passTypeList.add(passType);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        } 
        return passTypeList;       
    }

    public static ArrayList<String> retrieveAllDropdownListOfJobSector() {
        ArrayList<String> jobSectorList = new ArrayList<String>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Name FROM tbl_dropdown where dropdownType = ? order by displayRank ASC;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "Job_sector_type");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String jobSector = rs.getString(1);
                jobSectorList.add(jobSector);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        } 
        return jobSectorList;       
    }

    public static ArrayList<String> retrieveAllDropdownListOfHosptialType() {
        ArrayList<String> hosptialList = new ArrayList<String>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Name FROM tbl_dropdown where dropdownType = ? order by displayRank ASC;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "Hospital_name");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String hospital = rs.getString(1);
                hosptialList.add(hospital);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        } 
        return hosptialList;       
    }
    
    public static ArrayList<String> retrieveAllDropdownListOfDigitalContactType() {
        ArrayList<String> digitalContactList = new ArrayList<String>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Name FROM tbl_dropdown where dropdownType = ? order by displayRank ASC;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "DigitalType");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String contactType = rs.getString(1);
                digitalContactList.add(contactType);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        } 
        return digitalContactList;            
    }

    public static ArrayList<String> retrieveAllDropdownListOfLanguage() {
    ArrayList<String> languageList = new ArrayList<String>();
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String sql = "";

    try {
        conn = ConnectionManager.getConnection();
        sql = "SELECT Name FROM tbl_dropdown where dropdownType = ? order by displayRank ASC;";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, "MainLang");
        rs = pstmt.executeQuery();
        while (rs.next()) {
            String language = rs.getString(1);
            languageList.add(language);
        }

    } catch (SQLException ex) {
        handleSQLException(ex, sql);           
    } finally {
        ConnectionManager.close(conn, pstmt, rs);
    } 
    return languageList;            
}

    public static ArrayList<String> retrieveAllDropdownListOfSpokenEnglish() {
        ArrayList<String> spokenEnglishStandards = new ArrayList<String>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Name FROM tbl_dropdown where dropdownType = ? order by displayRank ASC;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "Spoken_english_standard");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String standard = rs.getString(1);
                spokenEnglishStandards.add(standard);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        } 
        return spokenEnglishStandards; 
    }
    
    public static ArrayList<String> retrieveAllDropdownListOfWorkpassType() {
        ArrayList<String> workpassTypes = new ArrayList<String>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Name FROM tbl_dropdown where dropdownType = ? order by displayRank ASC;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "Work_pass_type");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String type = rs.getString(1);
                workpassTypes.add(type);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        } 
        return workpassTypes; 
    }
    
    public static ArrayList<String> retrieveAllDropdownListOfIPAPassType() {
        ArrayList<String> ipapassTypes = new ArrayList<String>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Name FROM tbl_dropdown where dropdownType = ? order by displayRank ASC;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "IPA_pass_type");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String type = rs.getString(1);
                ipapassTypes.add(type);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        } 
        return ipapassTypes; 
    }
    
    public static ArrayList<String> retrieveAllDropdownListOfAgentLocationType() {
        ArrayList<String> agentLocationTypes = new ArrayList<String>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Name FROM tbl_dropdown where dropdownType = ? order by displayRank ASC;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "Agent_location_type");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String type = rs.getString(1);
                agentLocationTypes.add(type);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        } 
        return agentLocationTypes; 
    }
    
    public static ArrayList<String> retrieveAllDropdownListOfWorkplaceType() {
        ArrayList<String> types = new ArrayList<String>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Name FROM tbl_dropdown where dropdownType = ? order by displayRank ASC;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "Workplace_type");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String type = rs.getString(1);
                types.add(type);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        } 
        return types; 
    }
    
    public static ArrayList<String> retrieveAllDropdownListOfWorkplaceDirectType() {
        ArrayList<String> types = new ArrayList<String>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Name FROM tbl_dropdown where dropdownType = ? order by displayRank ASC;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "Workplace_direct_type");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String type = rs.getString(1);
                types.add(type);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        } 
        return types; 
    }
    
    public static ArrayList<String> retrieveAllDropdownListOfWorkHistoryHowType() {
        ArrayList<String> types = new ArrayList<String>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Name FROM tbl_dropdown where dropdownType = ? order by displayRank ASC;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "Work_history_how_type");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String type = rs.getString(1);
                types.add(type);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        } 
        return types; 
    }
    
    public static ArrayList<String> retrieveAllDropdownListOfAccomProvidedType() {
        ArrayList<String> types = new ArrayList<String>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Name FROM tbl_dropdown where dropdownType = ? order by displayRank ASC;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "Accom_provided_type");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String type = rs.getString(1);
                types.add(type);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        } 
        return types; 
    }
    
    public static ArrayList<String> retrieveAllDropdownListOfAccomType() {
        ArrayList<String> types = new ArrayList<String>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Name FROM tbl_dropdown where dropdownType = ? order by displayRank ASC;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "Accommodation_type");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String type = rs.getString(1);
                types.add(type);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        } 
        return types; 
    }
    
    public static ArrayList<String> retrieveAllDropdownListOfCaseworkers() {
        ArrayList<String> types = new ArrayList<String>();
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
                String type = rs.getString(5);
                types.add(type);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        } 
        return types; 
    }
    
    public static ArrayList<String> retrieveAllDropdownListOfSalaryMode() {
        ArrayList<String> types = new ArrayList<String>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Name FROM tbl_dropdown where dropdownType = ? order by displayRank ASC;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "Salary_payment_type");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String type = rs.getString(1);
                types.add(type);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        } 
        return types; 
    }
    
    public static ArrayList<String> retrieveAllDropdownListOfComplaint() {
        ArrayList<String> types = new ArrayList<String>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Name FROM tbl_dropdown where dropdownType = ? order by displayRank ASC;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "Complaint_type");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String type = rs.getString(1);
                types.add(type);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        } 
        return types; 
    }
    
    public static ArrayList<String> retrieveAllDropdownListOfComplaintMode() {
        ArrayList<String> types = new ArrayList<String>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Name FROM tbl_dropdown where dropdownType = ? order by displayRank ASC;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "Complaint_mode_type");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String type = rs.getString(1);
                types.add(type);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        } 
        return types; 
    }
    
    public static ArrayList<String> retrieveAllDropdownListOfDiscussWhere() {
        ArrayList<String> types = new ArrayList<String>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Name FROM tbl_dropdown where dropdownType = ? order by displayRank ASC;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "Discuss_where_type");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String type = rs.getString(1);
                types.add(type);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        } 
        return types; 
    }
    
    public static ArrayList<String> retrieveAllDropdownListOfHosipital() {
        ArrayList<String> types = new ArrayList<String>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Name FROM tbl_dropdown where dropdownType = ? order by displayRank ASC;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "Hospital_name");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String type = rs.getString(1);
                types.add(type);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        } 
        return types; 
    }
    
    public static ArrayList<String> retrieveAllDropdownListOfMCStatus() {
        ArrayList<String> types = new ArrayList<String>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Name FROM tbl_dropdown where dropdownType = ? order by displayRank ASC;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "MC_status_type");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String type = rs.getString(1);
                types.add(type);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        } 
        return types; 
    }
    
    public static ArrayList<String> retrieveAllDropdownListOfWica() {
        ArrayList<String> types = new ArrayList<String>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Name FROM tbl_dropdown where dropdownType = ? order by displayRank ASC;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "Wicamon_status");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String type = rs.getString(1);
                types.add(type);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        } 
        return types; 
    }
    
    public static ArrayList<String> retrieveAllDropdownListOfMilestoneNonCriminal() {
        ArrayList<String> types = new ArrayList<String>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Name FROM tbl_dropdown where dropdownType = ? order by displayRank ASC;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "Miles_nc_reached");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String type = rs.getString(1);
                types.add(type);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        } 
        return types; 
    }
    
    public static ArrayList<String> retrieveAllDropdownListOfMilestoneCriminal() {
        ArrayList<String> types = new ArrayList<String>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Name FROM tbl_dropdown where dropdownType = ? order by displayRank ASC;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "Casemilestone_criminal_type");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String type = rs.getString(1);
                types.add(type);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        } 
        return types; 
    }
    
    public static ArrayList<String> retrieveAllDropdownListOfTTRStatus() {
        ArrayList<String> types = new ArrayList<String>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Name FROM tbl_dropdown where dropdownType = ? order by displayRank ASC;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "Ttr_status_type");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String type = rs.getString(1);
                types.add(type);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        } 
        return types; 
    }
    
    public static ArrayList<String> retrieveAllDropdownListOfLawFirms() {
        ArrayList<String> types = new ArrayList<String>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Name FROM tbl_dropdown where dropdownType = ? order by displayRank ASC;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "Lawyer_firm");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String type = rs.getString(1);
                types.add(type);
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
                    + "Remark = ? order by displayRank ASC;";
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
   
    public static ArrayList<String> retrieveAllDropdownType() {
        ArrayList<String> types = new ArrayList<String>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT distinct dropdownType FROM tbl_dropdown;";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String type = rs.getString(1);
                types.add(type);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        } 
        return types;   
    }
    
    public static ArrayList<String> retrieveAllDropdownListByType(String dropdownType) {
        ArrayList<String> types = new ArrayList<String>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Name FROM tbl_dropdown where dropdownType = ? order by displayRank ASC;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1,dropdownType );
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String type = rs.getString(1);
                types.add(type);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        } 
        return types;         
    }
        
    public static Dropdown retrieveDropdownItem(String dropdownType, String name) {
        Dropdown dropdownItem = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID, Remark, displayRank FROM tbl_dropdown "
                    + "where dropdownType = ? and Name = ?;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, dropdownType);
            pstmt.setString(2, name);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                String remark = rs.getString(2);
                int displayRank = rs.getInt(3);
                dropdownItem = new Dropdown(id, dropdownType, name, remark, displayRank);
            }
 
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "DropdownItem={" + dropdownItem + "}");         
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return dropdownItem;
    }
    
    public static Dropdown retrieveDropdownItemById(int id) {
        Dropdown dropdownItem = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT dropdownType, Name, Remark, displayRank FROM tbl_dropdown "
                    + "where ID = ?;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String dropdownType = rs.getString(1);
                String name = rs.getString(2);
                String remark = rs.getString(3);
                int displayRank = rs.getInt(4);
                dropdownItem = new Dropdown(id, dropdownType, name, remark, displayRank);
            }
 
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "DropdownItem={" + dropdownItem + "}");         
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return dropdownItem;
    }
    
    public static void updateDropdownItem(Dropdown dropdown){
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_dropdown SET dropdownType =?, Name = ? , Remark = ?,"
                    + "displayRank =? "
                    + "WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, dropdown.getDropdownType());
            pstmt.setString(2, dropdown.getName());
            pstmt.setString(3, dropdown.getRemark());
            pstmt.setInt(4, dropdown.getDisplayRank());
            pstmt.setInt(5, dropdown.getId());


            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "Dropdown={" + dropdown + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }
    
    public static void addDropdownItem (Dropdown dropdown) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            sql = "INSERT INTO tbl_dropdown (dropdownType, Name, Remark, displayRank) "
                    + "VALUES (?,?,?,?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, dropdown.getDropdownType());
            pstmt.setString(2, dropdown.getName());
            pstmt.setString(3, dropdown.getRemark());
            pstmt.setInt(4, dropdown.getDisplayRank());

            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "Dropdown={" + dropdown + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }
    
    public static void deleteDropdownItem (Dropdown dropdown) {
    Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "DELETE FROM tbl_dropdown WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, dropdown.getId());
            
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "Dropdown=" + dropdown);
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }    
    }
    
    private static void handleSQLException(SQLException ex, String sql, String... parameters) {
      String msg = "Unable to access data; SQL=" + sql + "\n";
      for (String parameter : parameters) {
        msg += "," + parameter + ex.getMessage();
      }
      Logger.getLogger(DropdownDAO.class.getName()).log(Level.SEVERE, msg, ex);
      throw new RuntimeException(msg, ex);
    }    
}
