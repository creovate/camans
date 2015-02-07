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
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author soemyatmyat
 */
public class WorkerComplementsDAO {
    
    /**
     * Provide a consistent manner to handle SQL Exception
     *
     * @param ex The SQLException encountered
     * @param sql The SQL command issued
     * @param parameters Textual representation of the parameters passed in to
     * PreparedStatement
     */
    /*Nickname*/
    public static ArrayList<Integer> retrieveNickNameIdsOfWorker (Worker worker) {
        ArrayList<Integer> ids = new ArrayList<Integer>();
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID FROM tbl_worker_nickname where Worker_FIN_number = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, worker.getFinNumber());
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
    
    public static WorkerNickname retrieveWorkerNicknameById(int nicknameId) {
        WorkerNickname workerNickname = null;
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Worker_FIN_number, Nickname "
                    + " FROM tbl_worker_nickname where ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, nicknameId);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String workerFinNumber = rs.getString(1);
                String nickname = rs.getString(2);

                workerNickname = new WorkerNickname(workerFinNumber,nicknameId, nickname);
            }
            
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "Nickname={" + workerNickname + "}");           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return workerNickname;
    }
    
    public static void addNickname(WorkerNickname workerNickname) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "INSERT INTO tbl_worker_nickname (Worker_FIN_number, Nickname) "
                    + "VALUES (?,?)";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, workerNickname.getWorkerFinNum());
            pstmt.setString(2, workerNickname.getNickname());
            
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "WorkerNickname: " + workerNickname + "}");
        } finally {
            ConnectionManager.close(conn, pstmt);
        }    
    }
    
    public static void updateNickname(WorkerNickname workerNickname) {
        Connection conn = null;
        PreparedStatement stmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_worker_nickname SET Nickname = ? WHERE ID = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, workerNickname.getNickname());
            stmt.setInt(2, workerNickname.getId());
       
            stmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "Worker Nickname={" + workerNickname + "}");
        } finally {
            ConnectionManager.close(conn, stmt, null);
        }        
    }
    
    public static void deleteNickname(int nicknameId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "DELETE from tbl_worker_nickname WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, nicknameId);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "Worker nicknameId=" + nicknameId);
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }
    
    public static void deleteAllNicknames() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            
            sql = "DELETE FROM tbl_worker_nickname";
            pstmt = conn.prepareStatement(sql);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "not able to delete data from Worker-Nickname Table. ");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }     
    }
    
    public static ArrayList<String> validateAndAddNickname(String nickNameFileName) 
            throws IOException{
        
        // Attributes
        ArrayList<String> errList = new ArrayList<String>();
        CSVReader csvReader = null;
        try {
            csvReader = new CSVReader(new FileReader(nickNameFileName));
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
                String nickname = fields[1].trim();
                
                /**
                 * Validations for empty fields
                 */
                boolean pass = true; //assume validation pass first;
                if (finNum.equals("")) {
                    errorMsg += header[0] + " is blank,";
                    pass = false;
                }
                if (nickname.equals("")) {
                    errorMsg += header[1] + " is blank,";
                    pass = false;
                }

                //proceed only after empty fields validation is passed
                if (pass) { 

                    // check for any existing worker  with the same finNum. 
                    Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                    if (worker == null) {
                        errorMsg += "invalid FinNumber, ";
                    }
                    
                    if (nickname.length() > 50) {
                        errorMsg += "worker nickname cannot be longer than 50 characters,";
                    }

                }    

                // if there is an error, the line number of the error and its relevant message is added into the errorList
                if (!errorMsg.equals("")) {
                    errList.add(lineNum + ":" + errorMsg);
                    errorMsg = ""; // reset errorMsg variable
                } // if there is no error, a new Worker object is created and added to the workerList
                else {
                    errorMsg = ""; // reset errorMsg variable
                    WorkerNickname workerNickname = new WorkerNickname(finNum, nickname);
                    addNickname(workerNickname);
                    count++;
                }    
            }
            errList.add("nickname.csv:" + count);
            csvReader.close();
        } catch (FileNotFoundException ex) {
            //fileNotFoundExcepton
        }
        return errList;
    }
    
    /*PassportDetails*/
    public static ArrayList<Integer> retrievePassportIdsOfWorker (Worker worker) {
        ArrayList<Integer> ids = new ArrayList<Integer>();
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID FROM tbl_worker_passport_details where Worker_FIN_number = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, worker.getFinNumber());
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
    
    public static WorkerPassportDetails retrieveWorkerPassportDetailsById(int id) {
        WorkerPassportDetails workerPassportDetails = null;
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Passport_number, Passport_country, Passport_issue_date, "
                    + "Passport_expiry_date, Worker_FIN_number "
                    + " FROM tbl_worker_passport_details where ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String passportNumber = rs.getString(1);
                String passportCountry = rs.getString(2);
                Date passportIssueDate = rs.getDate(3);
                Date passportExpiryDate = rs.getDate(4);
                String workerFinNumber = rs.getString(5);
                
                workerPassportDetails = new WorkerPassportDetails(workerFinNumber, id, passportNumber
                        ,passportCountry, passportIssueDate, passportExpiryDate);
            }
            
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "workerPassportDetails={" + workerPassportDetails + "}");           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return workerPassportDetails;
    }
    
    public static void addWorkerPassportDetails(WorkerPassportDetails workerPassportDetails) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "INSERT INTO tbl_worker_passport_details (Passport_number, Passport_country, "
                    + "Passport_issue_date, Passport_expiry_date, Worker_FIN_number) "
                    + "VALUES (?,?,?,?,?)";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, workerPassportDetails.getPassportNumber());
            pstmt.setString(2, workerPassportDetails.getPassportCountry());
            pstmt.setDate(3, workerPassportDetails.getPassportIssueDate());
            pstmt.setDate(4, workerPassportDetails.getPassportExpirtyDate());
            pstmt.setString(5, workerPassportDetails.getWorkerFinNum());
            
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "workerPassportDetails: " + workerPassportDetails + "}");
        } finally {
            ConnectionManager.close(conn, pstmt);
        }    
    }
    
    public static void updatePassportDetails(WorkerPassportDetails workerPassportDetails) {
        Connection conn = null;
        PreparedStatement stmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_worker_passport_details SET Passport_number = ? , Passport_country = ?,"
                    + "Passport_issue_date = ?, Passport_expiry_date=? WHERE ID = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, workerPassportDetails.getPassportNumber());
            stmt.setString(2, workerPassportDetails.getPassportCountry());
            stmt.setDate(3, workerPassportDetails.getPassportIssueDate());
            stmt.setDate(4, workerPassportDetails.getPassportExpirtyDate());
            stmt.setInt(5, workerPassportDetails.getId());
            stmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "workerPassportDetails={" + workerPassportDetails + "}");
        } finally {
            ConnectionManager.close(conn, stmt, null);
        }        
    }
    
    public static void deletePassportDetails(int id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "DELETE from tbl_worker_passport_details WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "Worker Passport Id=" + id);
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }
    
    public static void deleteAllPassportDetails() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            
            sql = "DELETE FROM tbl_worker_passport_details";
            pstmt = conn.prepareStatement(sql);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "not able to delete data from Worker-Passport Table.");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }     
    }
    
    public static ArrayList<String> validateAndAddPassportDetails(String passportFile) 
            throws IOException{
        
        // Attributes
        ArrayList<String> errList = new ArrayList<String>();
        CSVReader csvReader = null;
        try {
            csvReader = new CSVReader(new FileReader(passportFile));
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
                String passportNum = fields[1].trim();
                String passportcountry = fields[2].trim();
                String issueDateStr = fields[3].trim();
                String expiryDateStr = fields[4].trim();
                java.sql.Date issueDate = null;
                java.sql.Date expiryDate = null;
                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                /**
                 * Validations for empty fields
                 */
                boolean pass = true; //assume validation pass first;
                if (finNum.equals("")) {
                    errorMsg += header[0] + " is blank,";
                    pass = false;
                }
                if (passportNum.equals("")) {
                    errorMsg += header[1] + " is blank,";
                    pass = false;
                }
                if (passportcountry.equals("")) {
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
                    
                    if (passportNum.length() > 20) {
                        errorMsg += "passport num cannot be longer than 20 characters,";
                    }
                    
                    if (passportcountry.length() > 30) {
                        errorMsg += "passport country cannot be longer than 30 characters,";
                    }
                    
                    if (!issueDateStr.equals("")) {
                        try {
                            java.util.Date tmp = sdf.parse(issueDateStr);
                            issueDate = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                            errorMsg += "Invalid Issue Date Format,";
                        } 
                    }
                    
                    if (!expiryDateStr.equals("")) {
                        try {
                            java.util.Date tmp = sdf.parse(expiryDateStr);
                            expiryDate = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                            errorMsg += "Invalid Expiry Date Format,";
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
                    WorkerPassportDetails workerPassportDetails = new WorkerPassportDetails
                            (finNum, passportNum, passportcountry, issueDate, expiryDate);
                    addWorkerPassportDetails(workerPassportDetails);
                    count++;
                }    
            }
            errList.add("passport.csv:" + count);
            csvReader.close();
        } catch (FileNotFoundException ex) {
            //fileNotFoundExcepton
        }
        return errList;
    }
    
    /*HomeCountryPhNumber*/
    public static ArrayList<Integer> retrieveHomeCountryPhoneNumIdsOfWorker (Worker worker) {
        ArrayList<Integer> ids = new ArrayList<Integer>();
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID FROM tbl_home_country_phone_number where Worker_FIN_number = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, worker.getFinNumber());
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
    
    public static WorkerHomeCountryPhNum retrieveWorkerHomeCountryPhNumById(int id) {
        WorkerHomeCountryPhNum workerHomeCountryPhNum = null;
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Home_country_telephone_number, Owner_of_number, Home_phone_obsolete, "
                    + "Worker_FIN_number "
                    + " FROM tbl_home_country_phone_number where ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String phNumber = rs.getString(1);
                String phOwner = rs.getString(2);
                Date obseleteDate = rs.getDate(3);
                String workerFinNumber = rs.getString(4);
                
                workerHomeCountryPhNum = new WorkerHomeCountryPhNum(workerFinNumber, id, phNumber
                        ,phOwner, obseleteDate);
            }
            
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "workerHomeCountryPhNum={" + workerHomeCountryPhNum + "}");           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return workerHomeCountryPhNum;
    }
    
    public static void addWorkerHomeCountryPhNum(WorkerHomeCountryPhNum workerHomeCountryPhNum) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "INSERT INTO tbl_home_country_phone_number (Home_country_telephone_number, Owner_of_number, "
                    + "Home_phone_obsolete, Worker_FIN_number) "
                    + "VALUES (?,?,?,?)";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, workerHomeCountryPhNum.getPhNumber());
            pstmt.setString(2, workerHomeCountryPhNum.getPhOwner());
            pstmt.setDate(3, workerHomeCountryPhNum.getObseleteDate());
            pstmt.setString(4, workerHomeCountryPhNum.getWorkerFinNum());
            
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "workerHomeCountryPhNum: " + workerHomeCountryPhNum + "}");
        } finally {
            ConnectionManager.close(conn, pstmt);
        }    
    }
   
    public static void updateWorkerHomeCountryPhNum(WorkerHomeCountryPhNum workerHomeCountryPhNum) {
        Connection conn = null;
        PreparedStatement stmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_home_country_phone_number SET Home_country_telephone_number = ? , Owner_of_number = ?,"
                    + "Home_phone_obsolete = ? WHERE ID = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, workerHomeCountryPhNum.getPhNumber());
            stmt.setString(2, workerHomeCountryPhNum.getPhOwner());
            stmt.setDate(3, workerHomeCountryPhNum.getObseleteDate());
            stmt.setInt(4, workerHomeCountryPhNum.getId());
            stmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "workerHomeCountryPhNum={" + workerHomeCountryPhNum + "}");
        } finally {
            ConnectionManager.close(conn, stmt, null);
        }        
    }

    public static void deleteHomeCountryPhNumber(int id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "DELETE from tbl_home_country_phone_number WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "Worker Home Country Ph Number Id=" + id);
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }
    
    public static void deleteAllHomeCountryPhoneNums() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            
            sql = "DELETE FROM tbl_home_country_phone_number";
            pstmt = conn.prepareStatement(sql);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "not able to delete data from Worker-Homecountryphnum Table.");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }     
    }
    
    public static ArrayList<String> validateAndAddHomeCountryPhoneNum(String homeCountryPhFile) 
            throws IOException{
        
        // Attributes
        ArrayList<String> errList = new ArrayList<String>();
        CSVReader csvReader = null;
        try {
            csvReader = new CSVReader(new FileReader(homeCountryPhFile));
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
                String homecountryph = fields[1].trim();
                String owner = fields[2].trim();
                String obseleteDateStr = fields[3].trim();
                java.sql.Date obseleteDate = null;
                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                /**
                 * Validations for empty fields
                 */
                boolean pass = true; //assume validation pass first;
                if (finNum.equals("")) {
                    errorMsg += header[0] + " is blank,";
                    pass = false;
                }
                if (homecountryph.equals("")) {
                    errorMsg += header[1] + " is blank,";
                    pass = false;
                }

                //proceed only after empty fields validation is passed
                if (pass) { 

                    // check for any existing worker  with the same finNum. 
                    Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                    if (worker == null) {
                        errorMsg += "invalid FinNumber, ";
                    }
                    
                    if (!homecountryph.matches("^[\\d\\(\\-\\s\\)]+$")) {
                        errorMsg += "invalid phone number, ";
                    }
                    
                    if (!owner.equals("") && owner.length() > 20) {
                        errorMsg += "Owner name cannot be longer than 20 characters,";
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
                    WorkerHomeCountryPhNum workerHomeCountryPhNum = new WorkerHomeCountryPhNum
                            (finNum, homecountryph, owner, obseleteDate);
                    addWorkerHomeCountryPhNum(workerHomeCountryPhNum);
                    count++;
                }    
            }
            errList.add("homecountryph.csv:" + count);
            csvReader.close();
        } catch (FileNotFoundException ex) {
            //fileNotFoundExcepton
        }
        return errList;
    }
    
    /*SgPhNum*/
    public static ArrayList<Integer> retrieveSgCountryPhoneNumIdsOfWorker (Worker worker) {
        ArrayList<Integer> ids = new ArrayList<Integer>();
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID FROM tbl_sg_phone_number where Worker_FIN_number = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, worker.getFinNumber());
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
    
    public static WorkerSgPhNum retrieveWorkerSgPhNumById(int id) {
        WorkerSgPhNum workerSgPhNum = null;
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Sg_phone_num, Sg_phone_obsolete, "
                    + "Worker_FIN_number "
                    + " FROM tbl_sg_phone_number where ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String phNumber = rs.getString(1);
                Date obseleteDate = rs.getDate(2);
                String workerFinNumber = rs.getString(3);
                
                workerSgPhNum = new WorkerSgPhNum(workerFinNumber, id, phNumber
                        ,obseleteDate);
            }
            
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "workerSgPhNum={" + workerSgPhNum + "}");           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return workerSgPhNum;
    }
    
    public static void addWorkerSgPhNum(WorkerSgPhNum workerSgPhNum) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "INSERT INTO tbl_sg_phone_number (Sg_phone_num, "
                    + "Sg_phone_obsolete, Worker_FIN_number) "
                    + "VALUES (?,?,?)";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, workerSgPhNum.getPhNumber());
            pstmt.setDate(2, workerSgPhNum.getObseleteDate());
            pstmt.setString(3, workerSgPhNum.getWorkerFinNum());
            
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "workerSgPhNum: " + workerSgPhNum + "}");
        } finally {
            ConnectionManager.close(conn, pstmt);
        }    
    }
   
    public static void updateWorkerSgPhNum(WorkerSgPhNum workerSgPhNum) {
        Connection conn = null;
        PreparedStatement stmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_sg_phone_number SET Sg_phone_num = ? ,"
                    + "Sg_phone_obsolete = ? WHERE ID = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, workerSgPhNum.getPhNumber());
            stmt.setDate(2, workerSgPhNum.getObseleteDate());
            stmt.setInt(3, workerSgPhNum.getId());
            stmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "workerSgPhNum={" + workerSgPhNum + "}");
        } finally {
            ConnectionManager.close(conn, stmt, null);
        }        
    }
    
    public static void deleteWorkerSgPhNum(int id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "DELETE from tbl_sg_phone_number WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "Worker Sg Phone Number Id=" + id);
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }
    
    public static void deleteAllSgPhoneNums() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            
            sql = "DELETE FROM tbl_sg_phone_number";
            pstmt = conn.prepareStatement(sql);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "not able to delete data from Worker-Sg Phone Number Table.");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }     
    }
    
    public static ArrayList<String> validateAndAddSgPhoneNum(String sgPhFile) 
            throws IOException{
        
        // Attributes
        ArrayList<String> errList = new ArrayList<String>();
        CSVReader csvReader = null;
        try {
            csvReader = new CSVReader(new FileReader(sgPhFile));
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
                String sgPh = fields[1].trim();
                String obseleteDateStr = fields[2].trim();
                java.sql.Date obseleteDate = null;
                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                /**
                 * Validations for empty fields
                 */
                boolean pass = true; //assume validation pass first;
                if (finNum.equals("")) {
                    errorMsg += header[0] + " is blank,";
                    pass = false;
                }
                if (sgPh.equals("")) {
                    errorMsg += header[1] + " is blank,";
                    pass = false;
                }

                //proceed only after empty fields validation is passed
                if (pass) { 

                    // check for any existing worker  with the same finNum. 
                    Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                    if (worker == null) {
                        errorMsg += "invalid FinNumber, ";
                    }
                    
                    if (!sgPh.matches("^[\\d\\(\\-\\s\\)]+$")) {
                        errorMsg += "invalid phone number, ";
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
                    WorkerSgPhNum workerSgPhNum = new WorkerSgPhNum
                            (finNum, sgPh, obseleteDate);
                    addWorkerSgPhNum(workerSgPhNum);
                    count++;
                }    
            }
            errList.add("sgph.csv:" + count);
            csvReader.close();
        } catch (FileNotFoundException ex) {
            //fileNotFoundExcepton
        }
        return errList;
    }
    
    /*SgAddress*/
    public static ArrayList<Integer> retrieveWorkerSgAddressIdsOfWorker (Worker worker) {
        ArrayList<Integer> ids = new ArrayList<Integer>();
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID FROM tbl_sg_address where Worker_FIN_number = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, worker.getFinNumber());
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
    
    public static WorkerSgAddress retrieveWorkerSgAddressById(int id) {
        WorkerSgAddress workerSgAddress = null;
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Singapore_address, Addr_singapore_obsolete, "
                    + "Worker_FIN_number "
                    + " FROM tbl_sg_address where ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String sgAddress = rs.getString(1);
                Date obseleteDate = rs.getDate(2);
                String workerFinNumber = rs.getString(3);
                
                workerSgAddress = new WorkerSgAddress(workerFinNumber, id, sgAddress
                        ,obseleteDate);
            }
            
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "workerSgAddress={" + workerSgAddress + "}");           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return workerSgAddress;
    }
    
    public static void addWorkerSgAddress(WorkerSgAddress workerSgAddress) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "INSERT INTO tbl_sg_address (Singapore_address, Addr_singapore_obsolete, "
                    + "Worker_FIN_number) "
                    + "VALUES (?,?,?)";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, workerSgAddress.getAddress());
            pstmt.setDate(2, workerSgAddress.getObseleteDate());
            pstmt.setString(3, workerSgAddress.getWorkerFinNum());
            
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "workerSgAddress: " + workerSgAddress + "}");
        } finally {
            ConnectionManager.close(conn, pstmt);
        }    
    }
   
    public static void updateWorkerSgAddress(WorkerSgAddress workerSgAddress) {
        Connection conn = null;
        PreparedStatement stmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_sg_address SET Singapore_address = ? , Addr_singapore_obsolete = ?"
                    + " WHERE ID = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, workerSgAddress.getAddress());
            stmt.setDate(2, workerSgAddress.getObseleteDate());
            stmt.setInt(3, workerSgAddress.getId());
            stmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "workerSgAddress={" + workerSgAddress + "}");
        } finally {
            ConnectionManager.close(conn, stmt, null);
        }        
    }
    
    public static void deleteWorkerSgAddress(int id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "DELETE from tbl_sg_address WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "Worker Sg Address Id=" + id);
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }
    
    public static void deleteAllWorkerSgAddresses() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            
            sql = "DELETE FROM tbl_sg_address";
            pstmt = conn.prepareStatement(sql);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "not able to delete data from Worker-SG Address Table.");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }     
    }
    
    public static ArrayList<String> validateAndAddSgAddress(String sgAddressFile) 
            throws IOException{
        
        // Attributes
        ArrayList<String> errList = new ArrayList<String>();
        CSVReader csvReader = null;
        try {
            csvReader = new CSVReader(new FileReader(sgAddressFile));
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
                String sgAddress = fields[1].trim();
                String obseleteDateStr = fields[2].trim();
                java.sql.Date obseleteDate = null;
                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                /**
                 * Validations for empty fields
                 */
                boolean pass = true; //assume validation pass first;
                if (finNum.equals("")) {
                    errorMsg += header[0] + " is blank,";
                    pass = false;
                }
                if (sgAddress.equals("")) {
                    errorMsg += header[1] + " is blank,";
                    pass = false;
                }

                //proceed only after empty fields validation is passed
                if (pass) { 

                    // check for any existing worker  with the same finNum. 
                    Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                    if (worker == null) {
                        errorMsg += "invalid FinNumber, ";
                    }
                    
                    if (sgAddress.length()>200) {
                        errorMsg += "sg address cannot be more than 200 characters, ";
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
                    WorkerSgAddress workerSgAddress = new WorkerSgAddress
                            (finNum, sgAddress, obseleteDate);
                    addWorkerSgAddress(workerSgAddress);
                    count++;
                }    
            }
            errList.add("sgaddress.csv:" + count);
            csvReader.close();
        } catch (FileNotFoundException ex) {
            //fileNotFoundExcepton
        }
        return errList;
    }
    
    /*HomeCountryAddress*/
    public static ArrayList<Integer> retrieveWorkerHomeCountryAddressIdsOfWorker (Worker worker) {
        ArrayList<Integer> ids = new ArrayList<Integer>();

         Connection conn = null;
         PreparedStatement pstmt = null;
         ResultSet rs = null;
         String sql = "";

         try {
             conn = ConnectionManager.getConnection();
             sql = "SELECT ID FROM tbl_home_country_address where Worker_FIN_number = ?";
             pstmt = conn.prepareStatement(sql);
             pstmt.setString(1, worker.getFinNumber());
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

    public static WorkerHomeCountryAddress retrieveWorkerHomeCountryAddressById(int id) {
        WorkerHomeCountryAddress workerHomeCountryAddress = null;

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Home_country_address, Home_country_obsolete_address, "
                    + "Worker_FIN_number "
                    + " FROM tbl_home_country_address where ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String homeCountryAddress = rs.getString(1);
                Date obseleteDate = rs.getDate(2);
                String workerFinNumber = rs.getString(3);

                workerHomeCountryAddress = new WorkerHomeCountryAddress(workerFinNumber, id, homeCountryAddress
                        ,obseleteDate);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql, "workerHomeCountryAddress={" + workerHomeCountryAddress + "}");           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return workerHomeCountryAddress;
    }

    public static void addWorkerHomeCountryAddress(WorkerHomeCountryAddress workerHomeCountryAddress) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "INSERT INTO tbl_home_country_address (Home_country_address, Home_country_obsolete_address, "
                    + "Worker_FIN_number) "
                    + "VALUES (?,?,?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, workerHomeCountryAddress.getAddress());
            pstmt.setDate(2, workerHomeCountryAddress.getObseleteDate());
            pstmt.setString(3, workerHomeCountryAddress.getWorkerFinNum());

            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "workerHomeCountryAddress: " + workerHomeCountryAddress + "}");
        } finally {
            ConnectionManager.close(conn, pstmt);
        }    
    }

    public static void updateWorkerHomeCountryAddress(WorkerHomeCountryAddress workerHomeCountryAddress) {
        Connection conn = null;
        PreparedStatement stmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_home_country_address SET Home_country_address = ? , Home_country_obsolete_address = ?"
                    + " WHERE ID = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, workerHomeCountryAddress.getAddress());
            stmt.setDate(2, workerHomeCountryAddress.getObseleteDate());
            stmt.setInt(3, workerHomeCountryAddress.getId());
            stmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "WorkerHomeCountryAddress={" + workerHomeCountryAddress + "}");
        } finally {
            ConnectionManager.close(conn, stmt, null);
        }        
    }

    public static void deleteWorkerHomeCountryAddress(int id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "DELETE from tbl_home_country_address WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "Worker Home Country Address Id=" + id);
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }
    
    public static void deleteAllHomeCountryAddresses() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            
            sql = "DELETE FROM tbl_home_country_address";
            pstmt = conn.prepareStatement(sql);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "not able to delete data from Worker-Home Country Address Table.");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }     
    }
    
    public static ArrayList<String> validateAndAddHomeCountryAddress(String homeCountryAddressFile) 
            throws IOException{
        
        // Attributes
        ArrayList<String> errList = new ArrayList<String>();
        CSVReader csvReader = null;
        try {
            csvReader = new CSVReader(new FileReader(homeCountryAddressFile));
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
                String homeCountryAddress = fields[1].trim();
                String obseleteDateStr = fields[2].trim();
                java.sql.Date obseleteDate = null;
                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                /**
                 * Validations for empty fields
                 */
                boolean pass = true; //assume validation pass first;
                if (finNum.equals("")) {
                    errorMsg += header[0] + " is blank,";
                    pass = false;
                }
                if (homeCountryAddress.equals("")) {
                    errorMsg += header[1] + " is blank,";
                    pass = false;
                }

                //proceed only after empty fields validation is passed
                if (pass) { 

                    // check for any existing worker  with the same finNum. 
                    Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                    if (worker == null) {
                        errorMsg += "invalid FinNumber, ";
                    }
                    
                    if (homeCountryAddress.length()>200) {
                        errorMsg += "home country address cannot be more than 200 characters, ";
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
                    WorkerHomeCountryAddress workerHomeCountryAddress = new WorkerHomeCountryAddress
                            (finNum, homeCountryAddress, obseleteDate);
                    addWorkerHomeCountryAddress(workerHomeCountryAddress);
                    count++;
                }    
            }
            errList.add("homecountryaddress.csv:" + count);
            csvReader.close();
        } catch (FileNotFoundException ex) {
            //fileNotFoundExcepton
        }
        return errList;
    }
    
    /*DigitalContact*/
    public static ArrayList<Integer> retrieveDigitalContactIdsOfWorker (Worker worker) {
        ArrayList<Integer> ids = new ArrayList<Integer>();

         Connection conn = null;
         PreparedStatement pstmt = null;
         ResultSet rs = null;
         String sql = "";

         try {
             conn = ConnectionManager.getConnection();
             sql = "SELECT ID FROM tbl_digital_contact where Worker_FIN_number = ?";
             pstmt = conn.prepareStatement(sql);
             pstmt.setString(1, worker.getFinNumber());
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

    public static WorkerDigitalContact retrieveWorkerDigitalContactById(int id) {
        WorkerDigitalContact workerDigitalContact = null;

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Digital_contact_type, Digital_more, "
                    + "Email_or_QQ_address, Owner_of_electronic_contact, Digital_remarks,"
                    + "Obsolete_date, Worker_FIN_number "
                    + " FROM tbl_digital_contact where ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String contactType = rs.getString(1);
                String contactTypeMore = rs.getString(2);
                String contactInfo = rs.getString(3);
                String owner = rs.getString(4);
                String remark = rs.getString(5);
                Date obseleteDate = rs.getDate(6);
                String workerFinNumber = rs.getString(7);

                workerDigitalContact = new WorkerDigitalContact(workerFinNumber, id, contactType
                        ,contactTypeMore, contactInfo, owner, remark, obseleteDate);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql, "workerDigitalContact={" + workerDigitalContact + "}");           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return workerDigitalContact;
    }

    public static void addWorkerDigitalContact(WorkerDigitalContact workerDigitalContact) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "INSERT INTO tbl_digital_contact (Digital_contact_type, Digital_more, "
                    + "Email_or_QQ_address,Owner_of_electronic_contact,Digital_remarks,"
                    + " Obsolete_date, Worker_FIN_number) "
                    + "VALUES (?,?,?,?,?,?, ?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, workerDigitalContact.getContactType());
            pstmt.setString(2, workerDigitalContact.getContactTypeMore());
            pstmt.setString(3, workerDigitalContact.getContactInfo());
            pstmt.setString(4, workerDigitalContact.getOwner());
            pstmt.setString(5, workerDigitalContact.getRemark());
            pstmt.setDate(6, workerDigitalContact.getObseleteDate());
            pstmt.setString(7, workerDigitalContact.getWorkerFinNum());

            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "workerDigitalContact: " + workerDigitalContact + "}");
        } finally {
            ConnectionManager.close(conn, pstmt);
        }    
    }

    public static void deleteWorkerDigitalContact(int id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "DELETE from tbl_digital_contact WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "Worker Digital Contact Id=" + id);
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }
    
    public static void updateWorkerDigitalContact(WorkerDigitalContact workerDigitalContact) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_digital_contact SET Digital_contact_type = ? , Digital_more = ?,"
                    + "Email_or_QQ_address =?, Owner_of_electronic_contact=?, Digital_remarks=?,"
                    + "Obsolete_date=?"
                    + " WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, workerDigitalContact.getContactType());
            pstmt.setString(2, workerDigitalContact.getContactTypeMore());
            pstmt.setString(3, workerDigitalContact.getContactInfo());
            pstmt.setString(4, workerDigitalContact.getOwner());
            pstmt.setString(5, workerDigitalContact.getRemark());
            pstmt.setDate(6, workerDigitalContact.getObseleteDate());
            pstmt.setInt(7, workerDigitalContact.getId());
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "workerDigitalContact={" + workerDigitalContact + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }        
    }
    
    public static void deleteAllDigitalContacts() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            
            sql = "DELETE FROM tbl_digital_contact";
            pstmt = conn.prepareStatement(sql);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "not able to delete data from Worker-Digtial Contact Table.");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }     
    }
    
    public static ArrayList<String> validateAndAddWorkerDigitalContact(String digitalContactFile) 
            throws IOException{
        
        // Attributes
        ArrayList<String> errList = new ArrayList<String>();
        CSVReader csvReader = null;
        try {
            csvReader = new CSVReader(new FileReader(digitalContactFile));
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
                String digitalType = fields[1].trim();
                String digitalTypeOther = fields[2].trim();
                String digitalDetail = fields[3].trim();
                String digitalOwner = fields[4].trim();
                String digitalRemark = fields[5].trim();
                String obseleteDateStr = fields[6].trim();
                java.sql.Date obseleteDate = null;
                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                /**
                 * Validations for empty fields
                 */
                boolean pass = true; //assume validation pass first;
                if (finNum.equals("")) {
                    errorMsg += header[0] + " is blank,";
                    pass = false;
                }
                if (digitalType.equals("")) {
                    errorMsg += header[1] + " is blank,";
                    pass = false;
                }
                if (digitalDetail.equals("")) {
                    errorMsg += header[1] + " is blank,";
                    pass = false;
                }

                //proceed only after empty fields validation is passed
                if (pass) { 

                    // check for any existing worker  with the same finNum. 
                    Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                    if (worker == null) {
                        errorMsg += "invalid FinNumber, ";
                    }
                    
                    ArrayList<String> list = DropdownDAO.retrieveAllDropdownListOfDigitalContactType();
                    boolean exit = false;
                    for (String tmp: list) {
                        if (tmp.equalsIgnoreCase(digitalType)) {
                            exit = true;
                            break;
                        }
                    }
                    
                    if (!exit) {
                        errorMsg += "Invalid Digital Type, ";
                    }
                    
                    if (!digitalTypeOther.equals("") && digitalTypeOther.length()>50) {
                        errorMsg += header[2]  + " cannot be more than 50 characters, ";
                    }
                    
                    if (digitalDetail.length() > 50) {
                        errorMsg += header[3]  + " cannot be more than 50 characters, ";
                    }
                    
                    if (!digitalOwner.equals("") && digitalOwner.length() > 50) {
                        errorMsg += header[4]  + " cannot be more than 50 characters, ";
                    }
                    
                    if (!digitalRemark.equals("") && digitalRemark.length() > 200) {
                        errorMsg += header[5]  + " cannot be more than 200 characters, ";
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
                    WorkerDigitalContact workerDigitalContact = new WorkerDigitalContact
                            (finNum, digitalType, digitalTypeOther,digitalDetail, digitalOwner,
                            digitalRemark,obseleteDate );
                    addWorkerDigitalContact(workerDigitalContact);
                    count++;
                }    
            }
            errList.add("digitalcontact.csv:" + count);
            csvReader.close();
        } catch (FileNotFoundException ex) {
            //fileNotFoundExcepton
        }
        return errList;
    }
    
    /*NextofKin*/
    public static ArrayList<Integer> retrieveNextOfKinIdsOfWorker (Worker worker) {
        ArrayList<Integer> ids = new ArrayList<Integer>();

         Connection conn = null;
         PreparedStatement pstmt = null;
         ResultSet rs = null;
         String sql = "";

         try {
             conn = ConnectionManager.getConnection();
             sql = "SELECT ID FROM tbl_kin where Worker_FIN_number = ?";
             pstmt = conn.prepareStatement(sql);
             pstmt.setString(1, worker.getFinNumber());
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

    public static WorkerNextOfKin retrieveWorkerNextOfKinById(int id) {
        WorkerNextOfKin workerNextOfKin = null;

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Kin_name, Kin_relationship, "
                    + "Kin_Id_doc, Kin_phone, Kin_digital,"
                    + "Kin_address, Kin_proof, "
                    + "Kin_remarks, Kin_obsolete_date, Worker_FIN_number "
                    + " FROM tbl_kin where ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String name = rs.getString(1);
                String relation = rs.getString(2);
                String document = rs.getString(3);
                String phoneNumber = rs.getString(4);
                String digital = rs.getString(5);
                String address = rs.getString(6);
                String proof = rs.getString(7);
                String remark = rs.getString(8);
                Date obseleteDate = rs.getDate(9);
                String workerFinNumber = rs.getString(10);

                workerNextOfKin = new WorkerNextOfKin(workerFinNumber, id, name
                        ,relation, document, phoneNumber, digital, address,
                        proof,remark,obseleteDate);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql, "workerNextOfKin={" + workerNextOfKin + "}");           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return workerNextOfKin;
    }

    public static void addWorkerNextOfKin(WorkerNextOfKin workerNextOfKin) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "INSERT INTO tbl_kin (Kin_name, Kin_relationship, "
                    + "Kin_Id_doc, Kin_phone, Kin_digital,"
                    + "Kin_address, Kin_proof, "
                    + "Kin_remarks, Kin_obsolete_date, Worker_FIN_number) "
                    + "VALUES (?,?,?,?,?,?, ?, ?,?,?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, workerNextOfKin.getName());
            pstmt.setString(2, workerNextOfKin.getRelation());
            pstmt.setString(3, workerNextOfKin.getDocument());
            pstmt.setString(4, workerNextOfKin.getPhoneNumber());
            pstmt.setString(5, workerNextOfKin.getDigital());
            pstmt.setString(6, workerNextOfKin.getAddress());
            pstmt.setString(7, workerNextOfKin.getProof());
            pstmt.setString(8, workerNextOfKin.getRemark());
            pstmt.setDate(9, workerNextOfKin.getObseleteDate());
            pstmt.setString(10, workerNextOfKin.getWorkerFinNum());

            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "workerNextOfKin: " + workerNextOfKin + "}");
        } finally {
            ConnectionManager.close(conn, pstmt);
        }    
    }

    public static void deleteWorkerNextOfKin(int id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "DELETE from tbl_kin WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "Worker Next of Kin Id=" + id);
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }
    
    public static void updateWorkerNextOfKin(WorkerNextOfKin workerNextOfKin) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_kin SET Kin_name = ? , Kin_relationship = ?,"
                    + "Kin_Id_doc =?, Kin_phone=?, Kin_digital=?,"
                    + "Kin_address=?, Kin_proof=?,Kin_remarks=?, Kin_obsolete_date=?"
                    + " WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, workerNextOfKin.getName());
            pstmt.setString(2, workerNextOfKin.getRelation());
            pstmt.setString(3, workerNextOfKin.getDocument());
            pstmt.setString(4, workerNextOfKin.getPhoneNumber());
            pstmt.setString(5, workerNextOfKin.getDigital());
            pstmt.setString(6, workerNextOfKin.getAddress());
            pstmt.setString(7, workerNextOfKin.getProof());
            pstmt.setString(8, workerNextOfKin.getRemark());
            pstmt.setDate(9, workerNextOfKin.getObseleteDate());
            pstmt.setInt(10, workerNextOfKin.getId());
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "workerNextOfKin={" + workerNextOfKin + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }        
    }
    
    public static void deleteAllNextOfKins() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            
            sql = "DELETE FROM tbl_kin";
            pstmt = conn.prepareStatement(sql);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "not able to delete data from Worker-Next of Kin Table.");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }     
    }
    
    public static ArrayList<String> validateAndAddWorkerNextOfKin(String nextOfKinFile) 
            throws IOException{
        
        // Attributes
        ArrayList<String> errList = new ArrayList<String>();
        CSVReader csvReader = null;
        try {
            csvReader = new CSVReader(new FileReader(nextOfKinFile));
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
                String kinName = fields[1].trim();
                String kinRel = fields[2].trim();
                String kinDoc = fields[3].trim();
                String kinPhone = fields[4].trim();
                String kinDigital = fields[5].trim();
                String kinAddr = fields[6].trim();
                String kinProof = fields[7].trim();
                String kinRemark = fields[8].trim();
                String obseleteDateStr = fields[9].trim();
                java.sql.Date obseleteDate = null;
                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                /**
                 * Validations for empty fields
                 */
                boolean pass = true; //assume validation pass first;
                if (finNum.equals("")) {
                    errorMsg += header[0] + " is blank,";
                    pass = false;
                }
                if (kinName.equals("")) {
                    errorMsg += header[1] + " is blank,";
                    pass = false;
                }

                //proceed only after empty fields validation is passed
                if (pass) { 

                    // check for any existing worker  with the same finNum. 
                    Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                    if (worker == null) {
                        errorMsg += "invalid FinNumber, ";
                    }
                    
                    if (kinName.length() > 50) {
                        errorMsg += header[1] + " cannot be more than 50 characters, ";
                    }
                    
                    if (!kinDoc.equals("") && kinDoc.length()>50) {
                        errorMsg += header[3]  + " cannot be more than 50 characters, ";
                    }
                    
                    if (!kinRel.equals("") && kinRel.length() > 50) {
                        errorMsg += header[2]  + " cannot be more than 50 characters, ";
                    }
                    
                    if (!kinPhone.equals("") && kinPhone.matches("^[\\d\\(\\-\\s\\)]+$")) {
                        errorMsg += header[4]  + " - invalid format, ";
                    }
                    
                    if (!kinDigital.equals("") && kinDigital.length() > 200) {
                        errorMsg += header[5]  + " cannot be more than 200 characters, ";
                    }
                    
                    if (!kinAddr.equals("") && kinAddr.length() > 200) {
                        errorMsg += header[6]  + " cannot be more than 200 characters, ";
                    }
                    
                    if (!kinProof.equals("") && kinProof.length() > 200) {
                        errorMsg += header[7]  + " cannot be more than 200 characters, ";
                    }
                    
                    if (!kinRemark.equals("") && kinRemark.length() > 200) {
                        errorMsg += header[8]  + " cannot be more than 200 characters, ";
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
                    WorkerNextOfKin workerNextOfKin = new WorkerNextOfKin
                            (finNum, kinName, kinRel ,kinDoc , kinPhone ,
                            kinDigital ,kinAddr ,kinProof ,kinRemark, obseleteDate );
                    addWorkerNextOfKin(workerNextOfKin);
                    count++;
                }    
            }
            errList.add("nextofkin.csv:" + count);
            csvReader.close();
        } catch (FileNotFoundException ex) {
            //fileNotFoundExcepton
        }
        return errList;
    }
    
    /*Famiy Member*/
    public static ArrayList<Integer> retrieveFamilyMemberIdsOfWorker (Worker worker) {
        ArrayList<Integer> ids = new ArrayList<Integer>();

         Connection conn = null;
         PreparedStatement pstmt = null;
         ResultSet rs = null;
         String sql = "";

         try {
             conn = ConnectionManager.getConnection();
             sql = "SELECT ID FROM tbl_family_member where Worker_FIN_number = ?";
             pstmt = conn.prepareStatement(sql);
             pstmt.setString(1, worker.getFinNumber());
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

    public static WorkerFamilyMember retrieveWorkerFamilyMemberById(int id) {
        WorkerFamilyMember workerFamilyMember = null;

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Name_of_family_member, Family_member_relationship, "
                    + "Family_member_where, Family_member_phone_number, Family_member_digital,"
                    + "Family_member_remarks, Family_member_obsolete, Worker_FIN_number "
                    + " FROM tbl_family_member where ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String name = rs.getString(1);
                String relation = rs.getString(2);
                String address = rs.getString(3);                
                String phoneNumber = rs.getString(4);
                String digital = rs.getString(5);
                String remark = rs.getString(6);
                Date obseleteDate = rs.getDate(7);
                String workerFinNumber = rs.getString(8);

                workerFamilyMember = new WorkerFamilyMember(workerFinNumber, id, name
                        ,relation, address,phoneNumber , digital,
                        remark,obseleteDate);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql, "WorkerFamilyMember={" + workerFamilyMember + "}");           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return workerFamilyMember;
    }

    public static void addWorkerFamilyMember(WorkerFamilyMember workerFamilyMember) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "INSERT INTO tbl_family_member (Name_of_family_member, Family_member_relationship, "
                    + "Family_member_where, Family_member_phone_number, Family_member_digital,"
                    + "Family_member_remarks, Family_member_obsolete, Worker_FIN_number) "
                    + "VALUES (?,?,?,?,?,?, ?, ?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, workerFamilyMember.getName());
            pstmt.setString(2, workerFamilyMember.getRelation());
            pstmt.setString(3, workerFamilyMember.getAddress());
            pstmt.setString(4, workerFamilyMember.getPhoneNumber());
            pstmt.setString(5, workerFamilyMember.getDigital());
            pstmt.setString(6, workerFamilyMember.getRemark());
            pstmt.setDate(7, workerFamilyMember.getObseleteDate());
            pstmt.setString(8, workerFamilyMember.getWorkerFinNum());

            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "workerFamilyMember: " + workerFamilyMember + "}");
        } finally {
            ConnectionManager.close(conn, pstmt);
        }    
    }

    public static void deleteFamilyMember(int id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "DELETE from tbl_family_member WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "Worker Family Member Id=" + id);
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }
    
    public static void updateWorkerFamilyMember(WorkerFamilyMember workerFamilyMember) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_family_member SET Name_of_family_member = ? , Family_member_relationship = ?,"
                    + "Family_member_where =?, Family_member_phone_number=?, Family_member_digital=?,"
                    + "Family_member_remarks=?, Family_member_obsolete=?"
                    + " WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, workerFamilyMember.getName());
            pstmt.setString(2, workerFamilyMember.getRelation());
            pstmt.setString(3, workerFamilyMember.getAddress());
            pstmt.setString(4, workerFamilyMember.getPhoneNumber());
            pstmt.setString(5, workerFamilyMember.getDigital());
            pstmt.setString(6, workerFamilyMember.getRemark());
            pstmt.setDate(7, workerFamilyMember.getObseleteDate());
            pstmt.setInt(8, workerFamilyMember.getId());
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "workerFamilyMember={" + workerFamilyMember + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }        
    }
    
    public static void deleteAllFamilyMembers() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            
            sql = "DELETE FROM tbl_family_member";
            pstmt = conn.prepareStatement(sql);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "not able to delete data from Worker-Family Member Table.");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }     
    }
    
    public static ArrayList<String> validateAndAddWorkerFamilyMember(String familyMemberFile) 
            throws IOException{
        
        // Attributes
        ArrayList<String> errList = new ArrayList<String>();
        CSVReader csvReader = null;
        try {
            csvReader = new CSVReader(new FileReader(familyMemberFile));
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
                String famMemName = fields[1].trim();
                String famMemRel = fields[2].trim();
                String famMemWhere = fields[3].trim();
                String famMemPhone = fields[4].trim();
                String famMemDigital = fields[5].trim();
                String famMemRem = fields[6].trim();
                String obseleteDateStr = fields[7].trim();
                java.sql.Date obseleteDate = null;
                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                /**
                 * Validations for empty fields
                 */
                boolean pass = true; //assume validation pass first;
                if (finNum.equals("")) {
                    errorMsg += header[0] + " is blank,";
                    pass = false;
                }
                if (famMemName.equals("")) {
                    errorMsg += header[1] + " is blank,";
                    pass = false;
                }

                //proceed only after empty fields validation is passed
                if (pass) { 

                    // check for any existing worker  with the same finNum. 
                    Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                    if (worker == null) {
                        errorMsg += "invalid FinNumber, ";
                    }
                    
                    if (famMemName.length() > 50) {
                        errorMsg += header[1] + " cannot be more than 50 characters, ";
                    }
                    
                    if (!famMemRel.equals("") && famMemRel.length()>50) {
                        errorMsg += header[2]  + " cannot be more than 50 characters, ";
                    }
                    
                    if (!famMemWhere.equals("") && famMemWhere.length() > 200) {
                        errorMsg += header[3]  + " cannot be more than 200 characters, ";
                    }
                    
                    if (!famMemPhone.equals("") && famMemPhone.matches("^[\\d\\(\\-\\s\\)]+$")) {
                        errorMsg += header[4]  + " - invalid format, ";
                    }
                    
                    if (!famMemDigital.equals("") && famMemDigital.length() > 200) {
                        errorMsg += header[5]  + " cannot be more than 200 characters, ";
                    }
                    
                    if (!famMemRem.equals("") && famMemRem.length() > 200) {
                        errorMsg += header[6]  + " cannot be more than 200 characters, ";
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
                    WorkerFamilyMember workerFamilyMember = new WorkerFamilyMember
                            (finNum, famMemName, famMemRel, famMemWhere, famMemPhone,
                            famMemDigital, famMemRem, obseleteDate );
                    addWorkerFamilyMember(workerFamilyMember);
                    count++;
                }    
            }
            errList.add("familymember.csv:" + count);
            csvReader.close();
        } catch (FileNotFoundException ex) {
            //fileNotFoundExcepton
        }
        return errList;
    }
    
    /*Friend*/
    public static ArrayList<Integer> retrieveFriendIdsOfWorker (Worker worker) {
        ArrayList<Integer> ids = new ArrayList<Integer>();

         Connection conn = null;
         PreparedStatement pstmt = null;
         ResultSet rs = null;
         String sql = "";

         try {
             conn = ConnectionManager.getConnection();
             sql = "SELECT ID FROM tbl_sg_friend where Worker_FIN_number = ?";
             pstmt = conn.prepareStatement(sql);
             pstmt.setString(1, worker.getFinNumber());
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

    public static WorkerFriend retrieveWorkerFriendById(int id) {
        WorkerFriend workerFriend = null;

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT friend_sg_name, friend_sg_phone, "
                    + "friend_sg_rel, friend_sg_rem, "
                    + "friend_sg_obsolete, Worker_FIN_number "
                    + " FROM tbl_sg_friend where ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String name = rs.getString(1);
                String phone = rs.getString(2);
                String relation = rs.getString(3);                
                String remark = rs.getString(4);
                Date obseleteDate = rs.getDate(5);
                String workerFinNumber = rs.getString(6);

                workerFriend = new WorkerFriend(workerFinNumber, id, name
                        ,phone, relation,
                        remark,obseleteDate);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql, "WorkerFriend={" + workerFriend + "}");           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return workerFriend;
    }

    public static void addWorkerFriend(WorkerFriend workerFriend) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "INSERT INTO tbl_sg_friend (friend_sg_name, friend_sg_phone, "
                    + "friend_sg_rel, friend_sg_rem, "
                    + "friend_sg_obsolete, Worker_FIN_number) "
                    + "VALUES (?,?,?,?,?,?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, workerFriend.getName());
            pstmt.setString(2, workerFriend.getPhone());
            pstmt.setString(3, workerFriend.getRelation());
            pstmt.setString(4, workerFriend.getRemark());
            pstmt.setDate(5, workerFriend.getObseleteDate());
            pstmt.setString(6, workerFriend.getWorkerFinNum());

            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "workerFriend: " + workerFriend + "}");
        } finally {
            ConnectionManager.close(conn, pstmt);
        }    
    }

    public static void updateWorkerFriend(WorkerFriend workerFriend) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_sg_friend SET friend_sg_name = ? , friend_sg_phone = ?,"
                    + "friend_sg_rel =?, friend_sg_rem=?, friend_sg_obsolete=?"
                    + " WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, workerFriend.getName());
            pstmt.setString(2, workerFriend.getPhone());
            pstmt.setString(3, workerFriend.getRelation());
            pstmt.setString(4, workerFriend.getRemark());
            pstmt.setDate(5, workerFriend.getObseleteDate());
            pstmt.setInt(6, workerFriend.getId());

            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "workerFriend={" + workerFriend + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }        
    }
    
    public static void deleteWorkerFriend(int id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "DELETE from tbl_sg_friend WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "Worker Sg Friend Id=" + id);
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }
    
    public static void deleteAllFriends() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            
            sql = "DELETE FROM tbl_sg_friend";
            pstmt = conn.prepareStatement(sql);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "not able to delete data from Worker-Friend Table.");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }     
    }
    
    public static ArrayList<String> validateAndAddWorkerFriend(String friendFile) 
            throws IOException{
        
        // Attributes
        ArrayList<String> errList = new ArrayList<String>();
        CSVReader csvReader = null;
        try {
            csvReader = new CSVReader(new FileReader(friendFile));
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
                String frdName = fields[1].trim();
                String frdPh = fields[2].trim();
                String frdRel = fields[3].trim();
                String frdRemark = fields[4].trim();
                String obseleteDateStr = fields[5].trim();
                java.sql.Date obseleteDate = null;
                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                /**
                 * Validations for empty fields
                 */
                boolean pass = true; //assume validation pass first;
                if (finNum.equals("")) {
                    errorMsg += header[0] + " is blank,";
                    pass = false;
                }
                if (frdName.equals("")) {
                    errorMsg += header[1] + " is blank,";
                    pass = false;
                }

                //proceed only after empty fields validation is passed
                if (pass) { 

                    // check for any existing worker  with the same finNum. 
                    Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                    if (worker == null) {
                        errorMsg += "invalid FinNumber, ";
                    }
                    
                    if (frdName.length() > 50) {
                        errorMsg += header[1] + " cannot be more than 50 characters, ";
                    }
                    
                    if (!frdPh.equals("") && frdPh.matches("^[\\d\\(\\-\\s\\)]+$")) {
                        errorMsg += header[2]  + "- invalid format, ";
                    }
                    
                    if (!frdRel.equals("") && frdRel.length() > 50) {
                        errorMsg += header[3]  + " cannot be more than 50 characters, ";
                    }
                    
                    if (!frdRemark.equals("") && frdRemark.length() > 200) {
                        errorMsg += header[4]  + " cannot be more than 200 characters, ";
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
                    WorkerFriend workerFriend = new WorkerFriend
                            (finNum, frdName, frdPh, frdRel, frdRemark, obseleteDate);
                    addWorkerFriend(workerFriend);
                    count++;
                }    
            }
            errList.add("friend.csv:" + count);
            csvReader.close();
        } catch (FileNotFoundException ex) {
            //fileNotFoundExcepton
        }
        return errList;
    }
    
    /*Language*/
    public static ArrayList<Integer> retrieveLanguageIdsOfWorker (Worker worker) {
        ArrayList<Integer> ids = new ArrayList<Integer>();

         Connection conn = null;
         PreparedStatement pstmt = null;
         ResultSet rs = null;
         String sql = "";

         try {
             conn = ConnectionManager.getConnection();
             sql = "SELECT ID FROM tbl_language where Worker_FIN_number = ?";
             pstmt = conn.prepareStatement(sql);
             pstmt.setString(1, worker.getFinNumber());
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

    public static WorkerLanguage retrieveWorkerLanguageById(int id) {
        WorkerLanguage workerLanguage = null;

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Worker_main_language, Worker_main_language_more, "
                    + "Spoken_english_standard, Language_remarks, "
                    + " Worker_FIN_number "
                    + " FROM tbl_language where ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String mainLanguage = rs.getString(1);
                String mainLangaugeMore = rs.getString(2);
                String spokenLanguageStandard = rs.getString(3);                
                String remark = rs.getString(4);
                String workerFinNumber = rs.getString(5);

                workerLanguage = new WorkerLanguage(workerFinNumber, id, mainLanguage
                        ,mainLangaugeMore, spokenLanguageStandard,
                        remark);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql, "WorkerLanguage={" + workerLanguage + "}");           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return workerLanguage;
    }

    public static void addWorkerLanguage(WorkerLanguage workerLanguage) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "INSERT INTO tbl_language (Worker_main_language, Worker_main_language_more, "
                    + "Spoken_english_standard, Language_remarks, "
                    + "Worker_FIN_number) "
                    + "VALUES (?,?,?,?,?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, workerLanguage.getMainLanguage());
            pstmt.setString(2, workerLanguage.getMainLangaugeMore());
            pstmt.setString(3, workerLanguage.getSpokenLanguageStandard());
            pstmt.setString(4, workerLanguage.getRemark());
            pstmt.setString(5, workerLanguage.getWorkerFinNum());

            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "workerLanguage: " + workerLanguage + "}");
        } finally {
            ConnectionManager.close(conn, pstmt);
        }    
    }

    public static void updateWorkerLanguage(WorkerLanguage workerLanguage) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_language SET Worker_main_language = ? , Worker_main_language_more = ?,"
                    + "Spoken_english_standard =?, Language_remarks=? "
                    + " WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, workerLanguage.getMainLanguage());
            pstmt.setString(2, workerLanguage.getMainLangaugeMore());
            pstmt.setString(3, workerLanguage.getSpokenLanguageStandard());
            pstmt.setString(4, workerLanguage.getRemark());
            pstmt.setInt(5, workerLanguage.getId());

            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "workerLanguage={" + workerLanguage + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }        
    }
    
    public static void deleteWorkerLanguage(int id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "DELETE from tbl_language WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "Worker Language Id=" + id);
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }
    
    public static void deleteAllLanguages() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            
            sql = "DELETE FROM tbl_language";
            pstmt = conn.prepareStatement(sql);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "not able to delete data from Worker-Language Table.");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }     
    }
    
    public static ArrayList<String> validateAndAddWorkerLanguage(String workerLanguageFile) 
            throws IOException{
        
        // Attributes
        ArrayList<String> errList = new ArrayList<String>();
        CSVReader csvReader = null;
        try {
            csvReader = new CSVReader(new FileReader(workerLanguageFile));
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
                String langType = fields[1].trim();
                String langTypeOther = fields[2].trim();
                String spokenEnglish = fields[3].trim();
                String langRemark = fields[4].trim();
                
                /**
                 * Validations for empty fields
                 */
                boolean pass = true; //assume validation pass first;
                if (finNum.equals("")) {
                    errorMsg += header[0] + " is blank,";
                    pass = false;
                }
                if (langType.equals("")) {
                    errorMsg += header[1] + " is blank,";
                    pass = false;
                }

                //proceed only after empty fields validation is passed
                if (pass) { 

                    // check for any existing worker  with the same finNum. 
                    Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                    if (worker == null) {
                        errorMsg += "invalid FinNumber, ";
                    }
                    
                    ArrayList<String> langList = DropdownDAO.retrieveAllDropdownListOfLanguage();
                    boolean exit = false;
                    for (String tmp: langList) {
                        if (tmp.equalsIgnoreCase(langType)) {
                            exit = true;
                            break;
                        }
                    }
                    if (!exit) {
                        errorMsg += "Invalid Language Type, ";
                    }
                    
                    if (!langTypeOther.equals("") && langTypeOther.length() > 50) {
                        errorMsg += header[2]  + " cannot be more than 50 characters, ";
                    }
                    
                    if (!spokenEnglish.equals("")) {
                        ArrayList<String> spokenEngStand = DropdownDAO.retrieveAllDropdownListOfSpokenEnglish();
                        for (String tmp: spokenEngStand) {
                            if (tmp.equalsIgnoreCase(spokenEnglish)) {
                                exit = true;
                                break;
                            }
                        }
                        if (!exit) {
                            errorMsg += "Invalid Language Type, ";
                        }
                    }
                    
                    
                    if (!langRemark.equals("") && langRemark.length() > 200) {
                        errorMsg += header[4]  + " cannot be more than 200 characters, ";
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
                    WorkerLanguage workerLanguage = new WorkerLanguage
                            (finNum, langType, langTypeOther, spokenEnglish, langRemark);
                    addWorkerLanguage(workerLanguage);
                    count++;
                }    
            }
            errList.add("language.csv:" + count);
            csvReader.close();
        } catch (FileNotFoundException ex) {
            //fileNotFoundExcepton
        }
        return errList;
    }
    
    /*Bank Account Details*/
    public static ArrayList<Integer> retrieveBankAccountDetailsIdsOfWorker (Worker worker) {
        ArrayList<Integer> ids = new ArrayList<Integer>();

         Connection conn = null;
         PreparedStatement pstmt = null;
         ResultSet rs = null;
         String sql = "";

         try {
             conn = ConnectionManager.getConnection();
             sql = "SELECT ID FROM tbl_bank_acc_details where Worker_FIN_number = ?";
             pstmt = conn.prepareStatement(sql);
             pstmt.setString(1, worker.getFinNumber());
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

    public static WorkerBankAcct retrieveBankAccountDetailsById(int id) {
        WorkerBankAcct workerBankAcct = null;

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Bank_account_name, Bank_account_number, "
                    + "Bank_name, Bank_branch_name, "
                    + " Bank_branch_address, Bank_branch_code, Bank_swift_code,"
                    + "Bank_account_remarks, Bank_obsolete_date, Worker_FIN_number "
                    + " FROM tbl_bank_acc_details where ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String bankAcctName = rs.getString(1);
                String bankAcctNumber = rs.getString(2);
                String bankName = rs.getString(3);    
                String bankBranchName = rs.getString(4);
                String bankBranchAddress = rs.getString(5);
                String bankBranchCode = rs.getString(6);
                String bankSwiftCode = rs.getString(7);
                String remark = rs.getString(8);
                Date obseleteDate = rs.getDate(9);
                String workerFinNumber = rs.getString(10);

                workerBankAcct = new WorkerBankAcct(workerFinNumber, id, bankAcctName
                        ,bankAcctNumber, bankName,bankBranchName,bankBranchAddress,
                        bankBranchCode,bankSwiftCode,remark,obseleteDate);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql, "WorkerBankAcct={" + workerBankAcct + "}");           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return workerBankAcct;
    }

    public static void addWorkerBankAccountDetails(WorkerBankAcct workerBankAcct) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "INSERT INTO tbl_bank_acc_details (Bank_account_name, Bank_account_number, "
                    + "Bank_name, Bank_branch_name, "
                    + " Bank_branch_address, Bank_branch_code, Bank_swift_code,"
                    + "Bank_account_remarks, Bank_obsolete_date, Worker_FIN_number) "
                    + "VALUES (?,?,?,?,?,?,?,?,?,?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, workerBankAcct.getBankAcctName());
            pstmt.setString(2, workerBankAcct.getBankAcctNumber());
            pstmt.setString(3, workerBankAcct.getBankName());
            pstmt.setString(4, workerBankAcct.getBankBranchName());
            pstmt.setString(5, workerBankAcct.getBankBranchAddress());
            pstmt.setString(6, workerBankAcct.getBankBranchCode());
            pstmt.setString(7, workerBankAcct.getBankSwiftCode());
            pstmt.setString(8, workerBankAcct.getRemark());
            pstmt.setDate(9, workerBankAcct.getObseleteDate());
            pstmt.setString(10, workerBankAcct.getWorkerFinNum());
            

            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "workerBankAcct: " + workerBankAcct + "}");
        } finally {
            ConnectionManager.close(conn, pstmt);
        }    
    }

    public static void updateWorkerBankAccountDetails(WorkerBankAcct workerBankAcct) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_bank_acc_details SET Bank_account_name = ? , Bank_account_number = ?,"
                    + "Bank_name =?, Bank_branch_name=?, Bank_branch_address=?,"
                    + "Bank_branch_code=?, Bank_swift_code=?, Bank_account_remarks=?,"
                    + "Bank_obsolete_date=? "
                    + " WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, workerBankAcct.getBankAcctName());
            pstmt.setString(2, workerBankAcct.getBankAcctNumber());
            pstmt.setString(3, workerBankAcct.getBankName());
            pstmt.setString(4, workerBankAcct.getBankBranchName());
            pstmt.setString(5, workerBankAcct.getBankBranchAddress());
            pstmt.setString(6, workerBankAcct.getBankBranchCode());
            pstmt.setString(7, workerBankAcct.getBankSwiftCode());
            pstmt.setString(8, workerBankAcct.getRemark());
            pstmt.setDate(9, workerBankAcct.getObseleteDate());
            pstmt.setInt(10, workerBankAcct.getId());

            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "workerBankAcct={" + workerBankAcct + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }        
    }
    
    public static void deleteBankAccountDetails(int id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "DELETE from tbl_bank_acc_details WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "Worker Bank Account Id=" + id);
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }
    
    public static void deleteAllBankAccountDetails() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            
            sql = "DELETE FROM tbl_bank_acc_details";
            pstmt = conn.prepareStatement(sql);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "not able to delete data from Worker-Bank Account Table.");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }     
    }
    
    public static ArrayList<String> validateAndAddWorkerBankAccountDetails(String bankAcctFile) 
            throws IOException{
        
        // Attributes
        ArrayList<String> errList = new ArrayList<String>();
        CSVReader csvReader = null;
        try {
            csvReader = new CSVReader(new FileReader(bankAcctFile));
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
                String bankAcctName = fields[1].trim();
                String bankAcctNum = fields[2].trim();
                String bankName = fields[3].trim();
                String branchName = fields[4].trim();
                String branchAddress = fields[5].trim();
                String branchCode = fields[6].trim();
                String swiftCode = fields[7].trim();
                String remark = fields[8].trim();
                String obseleteDateStr = fields[9].trim();
                java.sql.Date obseleteDate = null;
                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                
                /**
                 * Validations for empty fields
                 */
                boolean pass = true; //assume validation pass first;
                if (finNum.equals("")) {
                    errorMsg += header[0] + " is blank,";
                    pass = false;
                }
                if (bankAcctName.equals("")) {
                    errorMsg += header[1] + " is blank,";
                    pass = false;
                }
                
                if (bankAcctNum.equals("")) {
                    errorMsg += header[2] + " is blank,";
                    pass = false;
                }
                
                if (bankName.equals("")) {
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
                 
                    if (bankAcctName.length() > 50) {
                        errorMsg += header[1]  + " cannot be more than 50 characters, ";
                    }
                    
                    if (bankAcctNum.length() > 50) {
                        errorMsg += header[2]  + " cannot be more than 50 characters, ";
                    }
                    
                    if (bankName.length() > 50) {
                        errorMsg += header[3]  + " cannot be more than 50 characters, ";
                    }
                    
                    if (!branchName.equals("") && branchName.length() > 50) {
                        errorMsg += header[4]  + " cannot be more than 50 characters, ";
                    }
                    
                    if (!branchAddress.equals("") && branchAddress.length() > 300) {
                        errorMsg += header[5]  + " cannot be more than 300 characters, ";
                    }
                    
                    if (!branchCode.equals("") && branchCode.length() > 50) {
                        errorMsg += header[6]  + " cannot be more than 50 characters, ";
                    }
                    
                    if (!swiftCode.equals("") && swiftCode.length() > 50) {
                        errorMsg += header[7]  + " cannot be more than 50 characters, ";
                    }
                    
                    if (!remark.equals("") && remark.length() > 200) {
                        errorMsg += header[8]  + " cannot be more than 200 characters, ";
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
                    WorkerBankAcct workerBankAcct = new WorkerBankAcct
                            (finNum, bankAcctName, bankAcctNum, bankName, branchName,
                            branchAddress, branchCode , swiftCode, remark,obseleteDate );
                    addWorkerBankAccountDetails(workerBankAcct);
                    count++;
                }    
            }
            errList.add("bankacct.csv:" + count);
            csvReader.close();
        } catch (FileNotFoundException ex) {
            //fileNotFoundExcepton
        }
        return errList;
    }
    
    /*Worker Attachments*/
    public static ArrayList<Integer> retrieveAttachmentIdsOfWorker (Worker worker) {
        ArrayList<Integer> ids = new ArrayList<Integer>();

         Connection conn = null;
         PreparedStatement pstmt = null;
         ResultSet rs = null;
         String sql = "";

         try {
             conn = ConnectionManager.getConnection();
             sql = "SELECT ID FROM tbl_worker_attachment where FIN_number = ?";
             pstmt = conn.prepareStatement(sql);
             pstmt.setString(1, worker.getFinNumber());
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

    public static WorkerAttachment retrieveAttachmentDetailsById(int id) {
        WorkerAttachment workerAttachment = null;

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Document_name, File_path, Submit_by, FIN_number "
                    + "FROM tbl_worker_attachment where ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String docName = rs.getString(1);
                String filePath = rs.getString(2);
                String submitBy = rs.getString(3);    
                String workerFinNumber = rs.getString(4);

                workerAttachment = new WorkerAttachment(workerFinNumber, id, docName
                        ,filePath, submitBy);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql, "WorkerAttachment={" + workerAttachment + "}");           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return workerAttachment;
    }

    public static void addAttachmentDetails(WorkerAttachment workerAttachment) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "INSERT INTO tbl_worker_attachment (Document_name, File_path, "
                    + "Submit_by, FIN_number) "
                    + "VALUES (?,?,?,?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, workerAttachment.getDocumentName());
            pstmt.setString(2, workerAttachment.getFilePath());
            pstmt.setString(3, workerAttachment.getSubmitBy());
            pstmt.setString(4, workerAttachment.getWorkerFinNum());
            

            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "WorkerAttachment: " + workerAttachment + "}");
        } finally {
            ConnectionManager.close(conn, pstmt);
        }    
    }

    public static void updateAttachmentDetails(WorkerAttachment workerAttachment) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_worker_attachment SET Document_name = ? , File_path = ?,"
                    + "Submit_by =? WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, workerAttachment.getDocumentName());
            pstmt.setString(2, workerAttachment.getFilePath());
            pstmt.setString(3, workerAttachment.getSubmitBy());
            pstmt.setInt(4, workerAttachment.getId());

            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "WorkerAttachment={" + workerAttachment + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }        
    }    
    
    public static Timestamp retrieveTimeStamp(WorkerAttachment workerAttachment) {
        Timestamp timeStamp = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Entry_date FROM tbl_worker_attachment where ID = ?;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, workerAttachment.getId());
            rs = pstmt.executeQuery();
            while (rs.next()) {
                timeStamp = rs.getTimestamp(1);
            }
            return timeStamp;
            
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "WorkerAttachment={" + workerAttachment + "}");           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return timeStamp;
    }
    
    public static void deleteWorkerAttachment(WorkerAttachment workerAttachment) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "DELETE FROM tbl_worker_attachment WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, workerAttachment.getId());
            
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "workerAttachment={" + workerAttachment + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }        
    }
    
    public static void deleteAllWorkerAttachments() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            
            sql = "DELETE FROM tbl_worker_attachment";
            pstmt = conn.prepareStatement(sql);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "not able to delete data from Worker-Attachment Table.");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }     
    }
        
    /*General*/
    public static void deleteAll() {
        deleteAllNicknames();
        deleteAllPassportDetails();
        deleteAllHomeCountryPhoneNums();
        deleteAllSgPhoneNums();
        deleteAllWorkerSgAddresses();
        deleteAllHomeCountryAddresses();
        deleteAllDigitalContacts();
        deleteAllNextOfKins();
        deleteAllFamilyMembers();
        deleteAllFriends();
        deleteAllLanguages();
        deleteAllBankAccountDetails();
        deleteAllWorkerAttachments();
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
