/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.dao;

import au.com.bytecode.opencsv.CSVReader;
import au.com.bytecode.opencsv.CSVWriter;
import camans.entity.User;
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
public class WorkerDAO {
        
    /**
     * WorkerDAO has a public static variable workerlist which is an
     * HashMap of Worker with the key fin number that stores the validated list of workers
     * for input to SQL
     */
    public static HashMap<String, Worker> workerList = new HashMap<String, Worker>();
    
    public static Worker retrieveWorkerbyFinNumber(String finNumber) {
        Worker worker = null;
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Name_of_worker, Worker_registration_date, Created_by, Create_for, Gender,"
                    + "Nationality, Nationality_more, Date_of_birth, Photo"
                    + " FROM tbl_worker where FIN_number = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, finNumber);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String name = rs.getString(1);
                Date registeredDate = rs.getDate(2);
                String createdBy = rs.getString(3);
                String createdFor = rs.getString(4);
                String gender = rs.getString(5);
                String nationality = rs.getString(6);
                String nationalityMore = rs.getString(7);
                Date dob = rs.getDate(8);
                String photoPath = rs.getString(9);
                worker = new Worker(finNumber, name, registeredDate, createdBy, createdFor, gender,
                        nationality, nationalityMore, dob, photoPath);
            }
            
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "Worker={" + worker + "}");           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return worker;
    }
    
    public static void addWorker(Worker worker) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "INSERT INTO tbl_worker (FIN_number, Name_of_Worker, Worker_registration_date, "
                    + "Created_by, Create_for, Gender, Nationality, Nationality_more, "
                    + "Date_of_birth, Photo) "
                    + "VALUES (?,?,?,?,?,?,?,?,?,?)";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, worker.getFinNumber());
            pstmt.setString(2, worker.getName());
            pstmt.setDate(3, worker.getRegistrationDate());
            pstmt.setString(4, worker.getCreatedBy());
            pstmt.setString(5, worker.getCreatedFor());
            pstmt.setString(6, worker.getGender());
            pstmt.setString(7, worker.getNationality());
            pstmt.setString(8, worker.getNationalityMore());
            pstmt.setDate(9, worker.getDateOfBirth());
            pstmt.setString(10, worker.getPhotoPath());
            
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "Worker={" + worker + "}");
        } finally {
            ConnectionManager.close(conn, pstmt);
        }    
    }
    
    public static ArrayList<Worker> retrieveLatestWorkers() {
        ArrayList<Worker> workerList = new ArrayList<Worker>();
                Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT FIN_number, Name_of_worker, Worker_registration_date, Created_by, "
                    + "Create_for, Gender,"
                    + "Nationality, Nationality_more, Date_of_birth, Photo"
                    + " FROM tbl_worker order by Entry_date DESC limit 12;";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String finNumber = rs.getString(1);
                String name = rs.getString(2);
                Date registeredDate = rs.getDate(3);
                String createdBy = rs.getString(4);
                String createdFor = rs.getString(5);
                String gender = rs.getString(6);
                String nationality = rs.getString(7);
                String nationalityMore = rs.getString(8);
                Date dob = rs.getDate(9);
                String photoPath = rs.getString(10);
                Worker worker = new Worker(finNumber, name, registeredDate, createdBy, createdFor, gender,
                        nationality, nationalityMore, dob, photoPath);
                workerList.add(worker);
            }
            
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "WorkerList={" + workerList + "}");           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }

        return workerList;
    }
 
    public static ArrayList<Worker> retrieveWorkersBySearchFilter(String sql) {
        ArrayList<Worker> workerList = new ArrayList<Worker>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = ConnectionManager.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String finNumber = rs.getString(1);
                
                Worker worker = retrieveWorkerbyFinNumber(finNumber);
                workerList.add(worker);
            }
            
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "WorkerList={" + workerList + "}");           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return workerList;
    }

    public static ArrayList<Worker> retrieveWorkersByUser(String username) {
        ArrayList<Worker> workerList = new ArrayList<Worker>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT distinct Worker_FIN_number from tbl_lead_case_worker where Lead_case_worker = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String finNumber = rs.getString(1);
                Worker worker = retrieveWorkerbyFinNumber(finNumber);
                workerList.add(worker);
            }
            sql = "SELECT distinct Worker_FIN_number from tbl_auxillarycaseworker where Aux_name = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String finNumber = rs.getString(1);
                Worker worker = retrieveWorkerbyFinNumber(finNumber);
                workerList.add(worker);
            } 
            
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "WorkerList={" + workerList + "}");           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        
        return workerList;
    }
     
    public static void updateWorkerPhotoPath(Worker worker ){
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_worker SET Photo = ? WHERE FIN_number = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, worker.getPhotoPath());
            pstmt.setString(2, worker.getFinNumber());
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "Worker={" + worker + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        } 
    }
    
    public static void updateWorkerFinNumber(String oldFin, String newFin){
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = " update tbl_worker set FIN_number= ? where FIN_number = ?;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1,newFin);
            pstmt.setString(2,oldFin);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "Worker={" +   "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        } 
    }
    
    public static void deleteAll() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            
            sql = "DELETE FROM tbl_worker";
            pstmt = conn.prepareStatement(sql);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "not able to delete data from Worker Table. ");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }     
    }
    
    public static void deleteWorker(String workerFin) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            
            sql = "DELETE FROM tbl_worker where FIN_number = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, workerFin);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "not able to delete data from Worker Table. ");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }     
    }
    
    public static String validateAndAddWorker(String workerFileName, String workerErrFile) throws IOException{
        
        // empty existing data in workerList before continuing
        workerList.clear();
        // Attributes
        CSVReader csvReader = null;
        CSVWriter csvWriter = null;
        int errCount = 0;
        try {
            csvReader = new CSVReader(new FileReader(workerFileName));
            String[] header = csvReader.readNext();
            String[] fields;
            String errorMsg = "";

            // Loops through each line of the csv with an array of String
            while ((fields = csvReader.readNext()) != null) {
                
                // Assigning each field with its appropriate name
                String finNum = fields[0].trim();
                String workerName = fields[1].trim();
                String registeredDateStr = fields[2].trim();
                String createdBy = fields[3].trim();
                String createdFor = fields[4].trim();
                String gender = fields[5].trim();
                String nationality = fields[6].trim();
                String nationalityOther = fields[7].trim();
                String dobStr = fields[8].trim();
                java.sql.Date registeredDate = null;
                java.sql.Date dob = null;
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
                if (workerName.equals("")) {
                    errorMsg += header[1] + " is blank,";
                    pass = false;
                }
                if (registeredDateStr.equals("")) {
                    errorMsg += header[2] + " is blank,";
                    pass = false;
                }
                if (createdBy.equals("")) {
                    errorMsg += header[3] + " is blank,";
                    pass = false;
                }
                if (gender.equals("")) {
                    errorMsg += header[5] + " is blank,";
                    pass = false;
                }
                if (nationality.equals("")) {
                    errorMsg += header[6] + " is blank, ";
                    pass = false;
                }

                //proceed only after empty fields validation is passed
                if (pass) { 

                    // check for any existing worker  with the same finNum. 
                    Worker tmpWorker = retrieveWorkerbyFinNumber(finNum);
                    if (tmpWorker != null) {
                        errorMsg += "duplicate FinNumber,";
                    }   

                    if (finNum.matches("^[A-Z][0-9]{7}[A-Z]") || finNum.matches("^GEN[0-9]{6}")) {
                    } else {
                        errorMsg += "invalid FinNumber,";
                    }
                    if (workerName.length() > 50) {
                        errorMsg += "worker Name is longer than 50 characters,";
                    }

                    try {
                        java.util.Date tmp = sdf.parse(registeredDateStr);
                        registeredDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        errorMsg += "Invalid Registered Date Format,";
                    } 

                    //this is not linked to user table
                    if (createdBy.length() > 20) {
                        errorMsg += "Created By is longer than 20 characters, ";
                    }

                    if (createdFor.length() > 20) {
                        errorMsg += "Created For is longer than 20 charcters, ";
                    }

                    if (gender.equalsIgnoreCase("Male") || gender.equalsIgnoreCase("Female")) {

                    } else {
                        errorMsg += "Invalid Gender Format. Should be either 'Male' or 'Female, ";
                    }

                    ArrayList<String> nationalitiesList = DropdownDAO.retrieveAllDropdownListOfNationalities();
                    boolean check = false;
                    for (String tmp: nationalitiesList) {
                        if (tmp.equalsIgnoreCase(nationality)) {
                            check = true;
                            break;
                        }
                    }
                    if (!check) {
                        errorMsg += "Invalid Nationality, ";
                    }

                    if (!nationalityOther.equals("") && nationalityOther.length() > 50) {
                        errorMsg += header[7] + " cannot be more than 50 characters,";
                    }

                    if (!dobStr.equals("")) {
                        try {
                            java.util.Date tmp = sdf.parse(dobStr);
                            dob = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                            errorMsg += "Invalid Date of Birth Format,";
                        }
                    }
                }    

                // if there is an error, the line number of the error and its relevant message is added into the errorList
                if (!errorMsg.equals("")) {
                    csvWriter = new CSVWriter(new FileWriter(workerErrFile, true));
                    if (errCount == 0) {
                        String[] newHeader = new String[10];
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
                    Worker worker = new Worker(finNum, workerName, registeredDate, createdBy, createdFor,
                            gender, nationality, nationalityOther, dob, null);
                    workerList.put(finNum, worker);
                    //addWorker(worker);
                }    
            }
            csvReader.close();
        } catch (FileNotFoundException ex) {
            //fileNotFoundExcepton
        }
        if (errCount != 0) {
            return "worker.csv:" + errCount;
        }
        return null;
    }

    private static void handleSQLException(SQLException ex, String sql, String... parameters) {
      String msg = "Unable to access data; SQL=" + sql + "\n";
      for (String parameter : parameters) {
        msg += "," + parameter + ex.getMessage();
      }
      Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, msg, ex);
      throw new RuntimeException(msg, ex);
    }

    public static void updateWorkerProfile(Worker worker) {
        Connection conn = null;
        PreparedStatement stmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_worker SET Name_of_Worker = ?, Worker_registration_date = ? , "
                    + "Created_by = ?, Create_for = ?, Gender = ?, Nationality = ?, "
                    + "Nationality_more = ?, Date_of_birth = ? WHERE FIN_number = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1,worker.getName());
            stmt.setDate(2,worker.getRegistrationDate());
            stmt.setString(3, worker.getCreatedBy());
            stmt.setString(4, worker.getCreatedFor());
            stmt.setString(5, worker.getGender());
            stmt.setString(6, worker.getNationality());
            stmt.setString(7, worker.getNationalityMore());
            stmt.setDate(8, worker.getDateOfBirth());
            stmt.setString(9, worker.getFinNumber());
            
            stmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "worker={" + worker + "}");
        } finally {
            ConnectionManager.close(conn, stmt, null);
        }        
    }
    
}
