/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.utility;

import au.com.bytecode.opencsv.CSVReader;
import au.com.bytecode.opencsv.CSVWriter;
import camans.dao.*;
import camans.entity.*;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

/**
 *
 * @author soemyatmyat
 */
public class DataValidator {
    
    public static String validateData(String fileName, String errFileName) {
        
        
        // Attributes
        CSVReader csvReader = null;
        CSVWriter csvWriter = null;

        String returnMsg = "";
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        //SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
        
        try {
            csvReader = new CSVReader(new FileReader(fileName));
            //String fileShortName = fileName.substring(fileName.lastIndexOf("\\")+1);
            String fileShortName = fileName.substring(fileName.lastIndexOf("/")+1);
            String[] header = csvReader.readNext();
            String[] fields;
            String errorMsg = "";
            int errCount = 0;
            int succCount = 0;
            
                if (fileShortName.equals("nickname.csv")) {
               
                // Loops through each line of the csv with an array of String
                while ((fields = csvReader.readNext()) != null) {
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
                            errorMsg += "Fin number does not exist, ";
                        }

                        if (nickname.length() > 50) {
                            errorMsg += "worker nickname cannot be longer than 50 characters,";
                        }

                    }    

                    // if there is an error, the line number of the error and its relevant message is added into the errorList
                    if (!errorMsg.equals("")) {

                        csvWriter = new CSVWriter(new FileWriter(errFileName, true));
                        if (errCount == 0) {
                            String[] newHeader = new String[header.length+1];
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
                        WorkerNickname workerNickname = new WorkerNickname(finNum, nickname);
                        WorkerComplementsDAO.addNickname(workerNickname);
                        succCount++;
                    }    
                }//while
            
            } else if (fileShortName.equals("passport.csv")) {
                // Loops through each line of the csv with an array of String
                while ((fields = csvReader.readNext()) != null) {
                    // Assigning each field with its appropriate name
                    String finNum = fields[0].trim();
                    String passportNum = fields[1].trim();
                    String passportcountry = fields[2].trim();
                    String issueDateStr = fields[3].trim();
                    String expiryDateStr = fields[4].trim();
                    java.sql.Date issueDate = null;
                    java.sql.Date expiryDate = null;
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
                            errorMsg += "fin number does not exist, ";
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
                        csvWriter = new CSVWriter(new FileWriter(errFileName, true));
                        if (errCount == 0) {
                            String[] newHeader = new String[header.length+1];
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
                        WorkerPassportDetails workerPassportDetails = new WorkerPassportDetails
                                (finNum, passportNum, passportcountry, issueDate, expiryDate);
                        WorkerComplementsDAO.addWorkerPassportDetails(workerPassportDetails);
                        succCount++;
                    }    
                }
            } else if (fileShortName.equals("homecountryph.csv")) {
                // Loops through each line of the csv with an array of String
                while ((fields = csvReader.readNext()) != null) {
                    // Assigning each field with its appropriate name
                    String finNum = fields[0].trim();
                    String homecountryph = fields[1].trim();
                    String owner = fields[2].trim();
                    String obseleteDateStr = fields[3].trim();
                    java.sql.Date obseleteDate = null;
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
                            errorMsg += "FinNumber does not exist, ";
                        }

                        if (!homecountryph.matches("^[\\d\\(\\-\\s\\)+]+$")) {
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
                        csvWriter = new CSVWriter(new FileWriter(errFileName, true));
                        if (errCount == 0) {
                            String[] newHeader = new String[header.length+1];
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
                        WorkerHomeCountryPhNum workerHomeCountryPhNum = new WorkerHomeCountryPhNum
                                (finNum, homecountryph, owner, obseleteDate);
                        WorkerComplementsDAO.addWorkerHomeCountryPhNum(workerHomeCountryPhNum);
                        succCount++;
                    }    
                }
            } else if (fileShortName.equals("sgph.csv")) {
                // Loops through each line of the csv with an array of String
                while ((fields = csvReader.readNext()) != null) {
                    // Assigning each field with its appropriate name
                    String finNum = fields[0].trim();
                    String sgPh = fields[1].trim();
                    String obseleteDateStr = fields[2].trim();
                    java.sql.Date obseleteDate = null;
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
                            errorMsg += "FinNumber does not exist, ";
                        }

                        if (!sgPh.matches("^[\\d\\(\\-\\s\\)+]+$")) {
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
                        csvWriter = new CSVWriter(new FileWriter(errFileName, true));
                        if (errCount == 0) {
                            String[] newHeader = new String[header.length+1];
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
                        WorkerSgPhNum workerSgPhNum = new WorkerSgPhNum
                                (finNum, sgPh, obseleteDate);
                        WorkerComplementsDAO.addWorkerSgPhNum(workerSgPhNum);
                        succCount++;
                    }    
                }
            } else if (fileShortName.equals("homecountryaddress.csv")) {
                // Loops through each line of the csv with an array of String
                while ((fields = csvReader.readNext()) != null) {
                    // Assigning each field with its appropriate name
                    String finNum = fields[0].trim();
                    String homeCountryAddress = fields[1].trim();
                    String obseleteDateStr = fields[2].trim();
                    java.sql.Date obseleteDate = null;
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
                            errorMsg += "FinNumber does not exist, ";
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
                        csvWriter = new CSVWriter(new FileWriter(errFileName, true));
                        if (errCount == 0) {
                            String[] newHeader = new String[header.length+1];
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
                        WorkerHomeCountryAddress workerHomeCountryAddress = new WorkerHomeCountryAddress
                                (finNum, homeCountryAddress, obseleteDate);
                        WorkerComplementsDAO.addWorkerHomeCountryAddress(workerHomeCountryAddress);
                        succCount++;
                    }    
                }
            } else if (fileShortName.equals("sgaddress.csv")) {
                // Loops through each line of the csv with an array of String
                while ((fields = csvReader.readNext()) != null) {
                    // Assigning each field with its appropriate name
                    String finNum = fields[0].trim();
                    String sgAddress = fields[1].trim();
                    String obseleteDateStr = fields[2].trim();
                    java.sql.Date obseleteDate = null;
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
                            errorMsg += "FinNumber does not exist, ";
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
                        csvWriter = new CSVWriter(new FileWriter(errFileName, true));
                        if (errCount == 0) {
                            String[] newHeader = new String[header.length+1];
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
                        WorkerSgAddress workerSgAddress = new WorkerSgAddress
                                (finNum, sgAddress, obseleteDate);
                        WorkerComplementsDAO.addWorkerSgAddress(workerSgAddress);
                        succCount++;
                    }    
                }
            } else if (fileShortName.equals("digitalcontact.csv")) {
                // Loops through each line of the csv with an array of String
                while ((fields = csvReader.readNext()) != null) {
                    // Assigning each field with its appropriate name
                    String finNum = fields[0].trim();
                    String digitalType = fields[1].trim();
                    String digitalTypeOther = fields[2].trim();
                    String digitalDetail = fields[3].trim();
                    String digitalOwner = fields[4].trim();
                    String digitalRemark = fields[5].trim();
                    String obseleteDateStr = fields[6].trim();
                    java.sql.Date obseleteDate = null;
                    
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
                            errorMsg += "FinNumber does not exist, ";
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
                        csvWriter = new CSVWriter(new FileWriter(errFileName, true));
                        if (errCount == 0) {
                            String[] newHeader = new String[header.length+1];
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
                        WorkerDigitalContact workerDigitalContact = new WorkerDigitalContact
                                (finNum, digitalType, digitalTypeOther,digitalDetail, digitalOwner,
                                digitalRemark,obseleteDate );
                        WorkerComplementsDAO.addWorkerDigitalContact(workerDigitalContact);
                        succCount++;
                    }    
                }
            } else if (fileShortName.equals("nextofkin.csv")) {
                // Loops through each line of the csv with an array of String
                while ((fields = csvReader.readNext()) != null) {
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
                            errorMsg += "FinNumber does not exist, ";
                        }

                        if (kinName.length() > 50) {
                            errorMsg += header[1] + " cannot be more than 50 characters, ";
                        }

                        if (!kinDoc.equals("") && kinDoc.length()>200) {
                            errorMsg += header[3]  + " cannot be more than 200 characters, ";
                        }

                        if (!kinRel.equals("") && kinRel.length() > 50) {
                            errorMsg += header[2]  + " cannot be more than 50 characters, ";
                        }

                        
                        if (!kinPhone.equals("") && !kinPhone.matches("^[\\d\\(\\-\\s\\)+]+$")) {
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
                        csvWriter = new CSVWriter(new FileWriter(errFileName, true));
                        if (errCount == 0) {
                            String[] newHeader = new String[header.length+1];
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
                        WorkerNextOfKin workerNextOfKin = new WorkerNextOfKin
                                (finNum, kinName, kinRel ,kinDoc , kinPhone ,
                                kinDigital ,kinAddr ,kinProof ,kinRemark, obseleteDate );
                        WorkerComplementsDAO.addWorkerNextOfKin(workerNextOfKin);
                        succCount++;
                    }    
                }
            } else if (fileShortName.equals("familymember.csv")) {

                // Loops through each line of the csv with an array of String
                while ((fields = csvReader.readNext()) != null) {
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
                            errorMsg += "FinNumber does not exist, ";
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
                        
                        
                        if (!famMemPhone.equals("") && !famMemPhone.matches("^[\\d\\(\\-\\s\\)+]+$")) {
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
                        csvWriter = new CSVWriter(new FileWriter(errFileName, true));
                        if (errCount == 0) {
                            String[] newHeader = new String[header.length+1];
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
                        WorkerFamilyMember workerFamilyMember = new WorkerFamilyMember
                                (finNum, famMemName, famMemRel, famMemWhere, famMemPhone,
                                famMemDigital, famMemRem, obseleteDate );
                        WorkerComplementsDAO.addWorkerFamilyMember(workerFamilyMember);
                        succCount++;
                    }    
                }
            } else if (fileShortName.equals("friend.csv")) {
                // Loops through each line of the csv with an array of String
                while ((fields = csvReader.readNext()) != null) {

                    // Assigning each field with its appropriate name
                    String finNum = fields[0].trim();
                    String frdName = fields[1].trim();
                    String frdPh = fields[2].trim();
                    String frdRel = fields[3].trim();
                    String frdRemark = fields[4].trim();
                    String obseleteDateStr = fields[5].trim();
                    java.sql.Date obseleteDate = null;
                    
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
                            errorMsg += "FinNumber does not exist, ";
                        }

                        if (frdName.length() > 50) {
                            errorMsg += header[1] + " cannot be more than 50 characters, ";
                        }

                        if (!frdPh.equals("") && !frdPh.matches("^[\\d\\(\\-\\s\\)+]+$")) {
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
                        csvWriter = new CSVWriter(new FileWriter(errFileName, true));
                        if (errCount == 0) {
                            String[] newHeader = new String[header.length+1];
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
                        WorkerFriend workerFriend = new WorkerFriend
                                (finNum, frdName, frdPh, frdRel, frdRemark, obseleteDate);
                        WorkerComplementsDAO.addWorkerFriend(workerFriend);
                        succCount++;
                    }    
                }
            } else if (fileShortName.equals("language.csv")) {
                // Loops through each line of the csv with an array of String
                while ((fields = csvReader.readNext()) != null) {
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
                            errorMsg += "FinNumber does not exist, ";
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
                        csvWriter = new CSVWriter(new FileWriter(errFileName, true));
                        if (errCount == 0) {
                            String[] newHeader = new String[header.length+1];
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
                        WorkerLanguage workerLanguage = new WorkerLanguage
                                (finNum, langType, langTypeOther, spokenEnglish, langRemark);
                        WorkerComplementsDAO.addWorkerLanguage(workerLanguage);
                        succCount++;
                    }    
                }
            } else if (fileShortName.equals("bankacct.csv")) {
                 // Loops through each line of the csv with an array of String
                while ((fields = csvReader.readNext()) != null) {
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
                            errorMsg += "FinNumber does not exist, ";
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
                        csvWriter = new CSVWriter(new FileWriter(errFileName, true));
                        if (errCount == 0) {
                            String[] newHeader = new String[header.length+1];
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
                        WorkerBankAcct workerBankAcct = new WorkerBankAcct
                                (finNum, bankAcctName, bankAcctNum, bankName, branchName,
                                branchAddress, branchCode , swiftCode, remark,obseleteDate );
                        WorkerComplementsDAO.addWorkerBankAccountDetails(workerBankAcct);
                        succCount++;
                    }    
                }
            } else if (fileShortName.equals("currentpass.csv")) {
                // Loops through each line of the csv with an array of String
            while ((fields = csvReader.readNext()) != null) {
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
                        errorMsg += "FinNumber does not exist, ";
                    }
                    
                    try {
                        jobKey = Integer.parseInt(jobKeyStr);
                        Job job = JobDAO.retrieveJobByJobId(jobKey);
                        if (job == null) {
                            errorMsg += "jobkey does not exist, ";
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
                    csvWriter = new CSVWriter(new FileWriter(errFileName, true));
                    if (errCount == 0) {
                        String[] newHeader = new String[header.length+1];
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
                    JobPassDetails jobPassDetails = new JobPassDetails
                            (finNum, jobKey, passType, passTypeMore, passNbr, passApplicDate, 
                            passIssueDate, passExpDate, passIssuer, passRemark, obseleteDate);
                    JobComplementsDAO.addJobPassDetails(jobPassDetails);
                    succCount++;
                }    
            }
            } else if (fileShortName.equals("ipa.csv")) {
                // Loops through each line of the csv with an array of String
                while ((fields = csvReader.readNext()) != null) {

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
                    String ipaPeriodStr = fields[9].trim();
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
                    double ipaPeriod = 0.0;
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
                            errorMsg += "FinNumber does not exist, ";
                        }

                        try {
                            jobKey = Integer.parseInt(jobKeyStr);
                            Job job = JobDAO.retrieveJobByJobId(jobKey);
                            if (job == null) {
                                errorMsg += "jobkey does not exist, ";
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
                        
                        if (!ipaPeriodStr.equals("") && !ipaPeriodStr.matches("^\\d+(\\.\\d{1,2})?$")) {
                        errorMsg += "Period must have maximum 2 decimal places,";
                        } else {
                            if (!ipaPeriodStr.equals("")) {
                                try {
                                    ipaPeriod = Double.parseDouble(ipaPeriodStr);
                                } catch (Exception ex) {
                                    errorMsg += "Basic Salry - invalid format,";
                                }
                            }
                        }
                    

                        if (!ipaBasicStr.equals("") && !ipaBasicStr.matches("^\\d+(\\.\\d{1,2})?$")) {
                            errorMsg += header[10] + " must have maximum 2 decimal places,";
                        } else {
                            if (!ipaBasicStr.equals("") ) {
                                try {
                                    ipaBasic = Double.parseDouble(ipaBasicStr);
                                } catch (Exception ex) {
                                    errorMsg += header[10] + " - invalid format,";
                                }
                            }
                        }
                        
                        if (!ipaAllowanceStr.equals("") && !ipaAllowanceStr.matches("^\\d+(\\.\\d{1,2})?$")) {
                            errorMsg += header[11] + " must have maximum 2 decimal places,";
                        } else {
                            if (!ipaAllowanceStr.equals("")) {
                                try {
                                    ipaAllowance = Double.parseDouble(ipaAllowanceStr);
                                } catch (Exception ex) {
                                    errorMsg += header[11] + " - invalid format,";
                                }
                            }
                        }

                        if (!ipaAllowDetails.equals("") && ipaAllowDetails.length() > 200) {
                            errorMsg += header[12] + " cannot be longer than 200 characters,";
                        }

                        if (!ipaDeductionStr.equals("") && !ipaDeductionStr.matches("^\\d+(\\.\\d{1,2})?$")) {
                            errorMsg += header[13] + " must have maximum 2 decimal places,";
                        } else {
                            if (!ipaDeductionStr.equals("")) {
                                try {
                                    ipaDeduction = Double.parseDouble(ipaDeductionStr);
                                } catch (Exception ex) {
                                    errorMsg += header[13] + " - invalid format,";
                                }
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
                        csvWriter = new CSVWriter(new FileWriter(errFileName, true));
                        if (errCount == 0) {
                            String[] newHeader = new String[header.length+1];
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
                        JobIPADetails jobIPADetails = new JobIPADetails
                                (finNum, jobKey, ipaPassType, ipaPassTypeMore, ipaApplicDate, ipaEmployer, 
                                ipaAgent, ipaIndustry, ipaOccupation, ipaPeriod, ipaBasic, ipaAllowance,
                                ipaAllowDetails, ipaDeduction, ipaDeductionDetails, ipaHousing,ipaRemark );
                        JobComplementsDAO.addJobIPADetails(jobIPADetails);
                        succCount++;
                    }    
                }
            } else if (fileShortName.equals("verbalassurance.csv")) {
                // Loops through each line of the csv with an array of String
                while ((fields = csvReader.readNext()) != null) {
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
                            errorMsg += "FinNumber does not exist, ";
                        }

                        try {
                            jobKey = Integer.parseInt(jobKeyStr);
                            Job job = JobDAO.retrieveJobByJobId(jobKey);
                            if (job == null) {
                                errorMsg += "jobkey does not exist, ";
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
                        csvWriter = new CSVWriter(new FileWriter(errFileName, true));
                        if (errCount == 0) {
                            String[] newHeader = new String[header.length+1];
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
                        JobVerbalAssurance jobVerbalAssurance = new JobVerbalAssurance (finNum, jobKey, 
                                verbalName, verbalRel, verbalWhen, verbalWhere, verbalContent);
                        JobComplementsDAO.addJobVerbalAssurance(jobVerbalAssurance);
                        succCount++;
                    }    
                }
            } else if (fileShortName.equals("employmentcontract.csv")) {
                // Loops through each line of the csv with an array of String
                while ((fields = csvReader.readNext()) != null) {
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
                            errorMsg += "FinNumber does not exist, ";
                        }

                        try {
                            jobKey = Integer.parseInt(jobKeyStr);
                            Job job = JobDAO.retrieveJobByJobId(jobKey);
                            if (job == null) {
                                errorMsg += "jobkey does not exist, ";
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
                        csvWriter = new CSVWriter(new FileWriter(errFileName, true));
                        if (errCount == 0) {
                            String[] newHeader = new String[header.length+1];
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
                        JobEmploymentContract jobEmploymentContract = new JobEmploymentContract
                                (finNum, jobKey, null, contractDate, contractWhere, contractLang, contractOppName, 
                                contractOppRel,contractOccup,contractBasic,contractAllow,contractDeduct,
                                contractDuration,contractDuress,contractRemark);
                        JobComplementsDAO.addJobEmploymentContract(jobEmploymentContract);
                        succCount++;
                    }    
                }
            } else if (fileShortName.equals("intermediaryagent.csv")) {
                // Loops through each line of the csv with an array of String
            while ((fields = csvReader.readNext()) != null) {
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
                        errorMsg += "FinNumber does not exist, ";
                    }
                    
                    try {
                        jobKey = Integer.parseInt(jobKeyStr);
                        Job job = JobDAO.retrieveJobByJobId(jobKey);
                        if (job == null) {
                            errorMsg += "jobkey does not exist, ";
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
                        if (!agentAmtPaidStr.equals("") ) {
                            try {
                                agentAmtPaid = Double.parseDouble(agentAmtPaidStr);
                            } catch (Exception ex) {
                                errorMsg += header[8] + " - invalid format,";
                            }
                        }
                    }
                    
                    if (!agentAmtOwnedStr.equals("") && !agentAmtOwnedStr.matches("^\\d+(\\.\\d{1,2})?$")) {
                        errorMsg += header[9] + " must have maximum 2 decimal places,";
                    } else {
                        if (!agentAmtOwnedStr.equals("")) {
                            try {
                                agentAmtOwned = Double.parseDouble(agentAmtOwnedStr);
                            } catch (Exception ex) {
                                errorMsg += header[9] + " - invalid format,";
                            }
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
                    csvWriter = new CSVWriter(new FileWriter(errFileName, true));
                    if (errCount == 0) {
                        String[] newHeader = new String[header.length+1];
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
                    JobIntermediaryAgent jobIntermediaryAgent = new JobIntermediaryAgent
                            (finNum, jobKey, agentCompany, agentPers, agentLocation, agentLocationMore, 
                            agentAddr,agentContact,agentAmtPaid,agentAmtOwned,agentFeeShared,
                            agentFeeTraining,agentFeeAirFare,agentFeeWhen, agentFeeWhere,
                            agentFeeRepay, agentEmployer, agentRemark);
                    JobComplementsDAO.addJobIntermediaryAgent(jobIntermediaryAgent);
                    succCount++;
                }    
            }
            } else if (fileShortName.equals("employer.csv")) {
                // Loops through each line of the csv with an array of String
                while ((fields = csvReader.readNext()) != null) {
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
                            errorMsg += "FinNumber does not exist, ";
                        }

                        try {
                            jobKey = Integer.parseInt(jobKeyStr);
                            Job job = JobDAO.retrieveJobByJobId(jobKey);
                            if (job == null) {
                                errorMsg += "jobkey does not exist, ";
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
                        csvWriter = new CSVWriter(new FileWriter(errFileName, true));
                        if (errCount == 0) {
                            String[] newHeader = new String[header.length+1];
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
                        JobEmployer jobEmployer = new JobEmployer(finNum, jobKey,employerName,employerid,
                                employerAddr,employerContact,employerPers,employerRemark);
                        JobComplementsDAO.addJobEmployer(jobEmployer);
                        succCount++;
                    }    
                }
            } else if (fileShortName.equals("workplace.csv")) {
                // Loops through each line of the csv with an array of String
                while ((fields = csvReader.readNext()) != null) {
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
                            errorMsg += "FinNumber does not exist, ";
                        }

                        try {
                            jobKey = Integer.parseInt(jobKeyStr);
                            Job job = JobDAO.retrieveJobByJobId(jobKey);
                            if (job == null) {
                                errorMsg += "jobkey does not exist, ";
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
                        csvWriter = new CSVWriter(new FileWriter(errFileName, true));
                        if (errCount == 0) {
                            String[] newHeader = new String[header.length+1];
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
                        JobWorkplace jobWorkplace = new JobWorkplace
                                (finNum, jobKey, workplaceType, workplaceTypeMore, workplaceWhose, 
                                workplacePers,workplaceEmpRel,workplaceDirect,workplaceDirectMore,
                                workplaceStart,workplaceEnd,workplaceCond, workplaceSafety,
                                workplaceRemark);
                        JobComplementsDAO.addJobWorkplace(jobWorkplace);
                        succCount++;
                    }    
                }
            } else if (fileShortName.equals("workhistory.csv")) {
                // Loops through each line of the csv with an array of String
                while ((fields = csvReader.readNext()) != null) {
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
                            errorMsg += "FinNumber does not exist, ";
                        }

                        try {
                            jobKey = Integer.parseInt(jobKeyStr);
                            Job job = JobDAO.retrieveJobByJobId(jobKey);
                            if (job == null) {
                                errorMsg += "jobkey does not exist, ";
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
                        csvWriter = new CSVWriter(new FileWriter(errFileName, true));
                        if (errCount == 0) {
                            String[] newHeader = new String[header.length+1];
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
                        JobWorkHistory jobWorkHistory = new JobWorkHistory(finNum, jobKey, workHistoryHow, 
                                workHistHowMore, workHistDate, workHistFirst, workHistYrArrive,
                                workHistPrevious,workHistProblems,workHistRemark);
                        JobComplementsDAO.addJobWorkHistory(jobWorkHistory);
                        succCount++;
                    }    
                }
            } else if (fileShortName.equals("accomodation.csv")) {
                // Loops through each line of the csv with an array of String
                while ((fields = csvReader.readNext()) != null) {
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
                            errorMsg += "FinNumber does not exist, ";
                        }

                        try {
                            jobKey = Integer.parseInt(jobKeyStr);
                            Job job = JobDAO.retrieveJobByJobId(jobKey);
                            if (job == null) {
                                errorMsg += "jobkey does not exist, ";
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
                            if (!accomChargedStr.equals("")) {
                                try {
                                    accomCharged = Double.parseDouble(accomChargedStr);
                                } catch (Exception ex) {
                                    errorMsg += header[8] + " - invalid format,";
                                }
                            }
                        }

                        if (!accomSelfPaidStr.equals("") && !accomSelfPaidStr.matches("^\\d+(\\.\\d{1,2})?$")) {
                            errorMsg += header[9] + " must have maximum 2 decimal places,";
                        } else {
                            if (!accomSelfPaidStr.equals("")) {
                                try {
                                    accomSelfPaid = Double.parseDouble(accomSelfPaidStr);
                                } catch (Exception ex) {
                                    errorMsg += header[9] + " - invalid format,";
                                }
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
                        csvWriter = new CSVWriter(new FileWriter(errFileName, true));
                        if (errCount == 0) {
                            String[] newHeader = new String[header.length+1];
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
                        JobAccomodation jobAccomodation = new JobAccomodation
                                (finNum, jobKey, accomProvided, accomProvidedMore, accomType, 
                                accomTypeMore, accomLocation,accomConditions,accomCharged,
                                accomSelfPaid,accomMeals,accomStart,accomEnd,accomRemark);
                        JobComplementsDAO.addJobAccomodation(jobAccomodation);
                        succCount++;
                    }    
                }
            } else if (fileShortName.equals("aggravatingissue.csv")) {
                // Loops through each line of the csv with an array of String
                while ((fields = csvReader.readNext()) != null) {
                    
                    // Assigning each field with its appropriate name
                    String finNum = fields[0].trim();
                    String jobKeyStr = fields[1].trim();
                    String probKeyStr = fields[2].trim();
                    String aggraIssue = fields[3].trim();
                    String aggraIssueMore = fields[4].trim();
                    String aggraLossStr = fields[5].trim();
                    String aggraRemark = fields[6].trim();

                    int jobKey = 0;
                    int probKey = 0;
                    double aggraLoss = 0;
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
                    if (aggraIssue.equals("")) {
                        errorMsg += header[3] + " is blank,";
                        pass = false;
                    }

                    //proceed only after empty fields validation is passed
                    if (pass) { 

                        // check for any existing worker  with the same finNum. 
                        Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                        if (worker == null) {
                            errorMsg += "FinNumber does not exist, ";
                        }

                        try {
                            jobKey = Integer.parseInt(jobKeyStr);
                            Job job = JobDAO.retrieveJobByJobId(jobKey);
                            if (job == null) {
                                errorMsg += "job key does not exist, ";
                            } else {
                                if (worker != null && 
                                        !(worker.getFinNumber().equals(job.getWorkerFinNum()))) {
                                    errorMsg += "invalid finNumber for this job key, ";
                                }
                            }
                        } catch (Exception ex) {
                            errorMsg += "invalid job key, ";
                        }

                        try {
                            probKey = Integer.parseInt(probKeyStr);
                            Problem problem = ProblemDAO.retrieveProblemByProblemId(probKey);
                            if (problem == null) {
                                errorMsg += "problem key does not exist, ";
                            } else {
                                if (worker != null && 
                                        !(worker.getFinNumber().equals(problem.getWorkerFinNum()))) {
                                    errorMsg += "invalid finNumber for this problem key, ";
                                }
                            }
                        } catch (Exception ex) {
                            errorMsg += "problem key does not exist, ";
                        }

                        ArrayList<String> list = DropdownDAO.retrieveAllDropdownListOfProblems();
                        boolean exit = false;
                        for (String tmp: list) {
                            if (tmp.equalsIgnoreCase(aggraIssue)) {
                                exit = true;
                                break;
                            }
                        }

                        if (!exit) {
                            errorMsg += "invalid Aggravating Issue Type, ";
                        }

                        if (!aggraIssueMore.equals("") && aggraIssueMore.length() > 50){
                            errorMsg += header[4] + " cannot be more than 50 characters,";
                        }
                        
                        if (!aggraLossStr.equals("")) {
                            if (!aggraLossStr.matches("^\\d+(\\.\\d{1,2})?$")) {
                                errorMsg += header[5] + " must have maximum 2 decimal places,";
                            } else {
                                try {
                                    aggraLoss = Double.parseDouble(aggraLossStr);
                                } catch (Exception ex) {
                                    errorMsg += header[5] + " - invalid format,";
                                }
                            }
                        } 

                        if (!aggraRemark.equals("") && aggraRemark.length() > 200) {
                            errorMsg += header[6] + " cannot be longer than 200 characters,";
                        }

                    }   //pass 

                    // if there is an error, the line number of the error and its relevant message is 
                    // added into the errorList
                    if (!errorMsg.equals("")) {
                        csvWriter = new CSVWriter(new FileWriter(errFileName, true));
                        if (errCount == 0) {
                            String[] newHeader = new String[header.length+1];
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
                        ProblemAggravatingIssue problemAggravatingIssue = new ProblemAggravatingIssue
                                (finNum, jobKey, probKey, aggraIssue, aggraIssueMore, aggraLoss, aggraRemark);
                        ProblemComplementsDAO.addProblemAggravatingIssue(problemAggravatingIssue);
                        succCount++;
                    }    
                }
            } else if (fileShortName.equals("leadcaseworker.csv")) {
                //loop through each line of the csv with an array of String
                while ((fields=csvReader.readNext()) != null) {
                    
                    //assigning each field with its approriate name
                    String finNum = fields[0].trim();
                    String jobKeyStr = fields[1].trim();
                    String probKeyStr = fields[2].trim();
                    String leadName = fields[3].trim();
                    String leadStartStr = fields[4].trim();
                    String leadEndStr = fields[5].trim();

                    int jobKey = 0;
                    int probKey = 0;
                    java.sql.Date leadStart = null;
                    java.sql.Date leadEnd = null;
                    

                    //validations for emplty fields
                    boolean pass = true;
                    if(finNum.equals("")) {
                        errorMsg += header[0]+" is blank,";
                        pass = false;
                    }

                    if (jobKeyStr.equals("")) {
                        errorMsg += header[1]+" is blank,";
                        pass = false;
                    }

                    if (probKeyStr.equals("")) {
                        errorMsg += header[2]+" is blank,";
                        pass = false;
                    }

                    if (leadName.equals("")) {
                        errorMsg += header[3]+" is blank,";
                        pass = false;
                    }

                    //proceed only after empty fields validation is passed
                    if (pass) {
                        //check for any existing worker with the same finNum
                        Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                        if (worker==null) {
                            errorMsg += "invalid FinNumber,";
                        }

                        try {
                            jobKey = Integer.parseInt(jobKeyStr);
                            Job job = JobDAO.retrieveJobByJobId(jobKey);
                            if (job==null) {
                                errorMsg += "job key does not exist,";
                            } else {
                                if(worker!=null &&
                                !(worker.getFinNumber().equals(job.getWorkerFinNum()))) {
                                    errorMsg += "invalid FinNumber for this job key,";
                                }
                            }
                        } catch (Exception ex) {
                            errorMsg += "invalid job key,";
                        }

                        try {
                            probKey = Integer.parseInt(probKeyStr);
                            Problem problem = ProblemDAO.retrieveProblemByProblemId(probKey);
                            if(problem==null) {
                                errorMsg += "problem key does not exist,";
                            } else {
                                if(worker!=null &&
                                !(worker.getFinNumber().equals(problem.getWorkerFinNum()))) {
                                    errorMsg += "invalid finNumber for this problem key,";
                                }
                            }
                        } catch (Exception ex) {
                            errorMsg += "invalid problem key,";
                        }

                        //dropdown list of existing users
                        ArrayList<String> list = DropdownDAO.retrieveAllDropdownListOfCaseworkers();
                        boolean exit = false;
                        for(String tmp:list) {
                            if (tmp.equalsIgnoreCase(leadName)) {
                                exit=true;
                                break;
                            }
                        }

                        if(!exit) {
                            errorMsg += "job key does not exist,";
                        }

                        if (!leadStartStr.equals("")) {
                            try {
                                java.util.Date tmp = sdf.parse(leadStartStr);
                                leadStart = new java.sql.Date(tmp.getTime());
                            } catch (ParseException ex) {
                                errorMsg += "Invalid leadStart Date Format,";
                            } 
                        }

                        if (!leadEndStr.equals("")) {
                            try {
                                java.util.Date tmp = sdf.parse(leadEndStr);
                                leadEnd = new java.sql.Date(tmp.getTime());
                            } catch (ParseException ex) {
                                errorMsg += "Invalid leadEnd Date Format,";
                            } 
                        }
                    } //pass

                    // if there is an error, the line number of the error and its relevant message is added into the errorList

                    if (!errorMsg.equals("")) {
                        csvWriter = new CSVWriter(new FileWriter(errFileName, true));
                        if (errCount == 0) {
                            String[] newHeader = new String[header.length+1];
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
                        ProblemLeadCaseWorker problemLeadCaseWorker = new ProblemLeadCaseWorker
                                (finNum, jobKey, probKey, leadName, leadStart, leadEnd );
                        ProblemComplementsDAO.addProblemLeadCaseWorker(problemLeadCaseWorker);
                        succCount++;
                    }    
                }
            } else if (fileShortName.equals("auxiliaryworker.csv")) {
                //loop through each line of the csv with an array of String
                while ((fields=csvReader.readNext()) != null) {
                    
                    //assigning each field with its approriate name
                    String finNum = fields[0].trim();
                    String jobKeyStr = fields[1].trim();
                    String probKeyStr = fields[2].trim();
                    String auxName = fields[3].trim();
                    String auxStartStr = fields[4].trim();
                    String auxEndStr = fields[5].trim();

                    int jobKey = 0;
                    int probKey = 0;
                    java.sql.Date auxStart = null;
                    java.sql.Date auxEnd = null;
                    

                    //validations for emplty fields
                    boolean pass = true;
                    if(finNum.equals("")) {
                        errorMsg += header[0]+" is blank,";
                        pass = false;
                    }

                    if (jobKeyStr.equals("")) {
                        errorMsg += header[1]+" is blank,";
                        pass = false;
                    }

                    if (probKeyStr.equals("")) {
                        errorMsg += header[2]+" is blank,";
                        pass = false;
                    }

                    if (auxName.equals("")) {
                        errorMsg += header[3]+" is blank,";
                        pass = false;
                    }

                    //proceed only after empty fields validation is passed
                    if (pass) {
                        //check for any existing worker with the same finNum
                        Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                        if (worker==null) {
                            errorMsg += "invalid FinNumber,";
                        }

                        try {
                            jobKey = Integer.parseInt(jobKeyStr);
                            Job job = JobDAO.retrieveJobByJobId(jobKey);
                            if (job==null) {
                                errorMsg += "job key does not exist,";
                            } else {
                                if(worker!=null &&
                                !(worker.getFinNumber().equals(job.getWorkerFinNum()))) {
                                    errorMsg += "invalid FinNumber for this job key,";
                                }
                            }
                        } catch (Exception ex) {
                            errorMsg += "invalid job key,";
                        }

                        try {
                            probKey = Integer.parseInt(probKeyStr);
                            Problem problem = ProblemDAO.retrieveProblemByProblemId(probKey);
                            if(problem==null) {
                                errorMsg += "problem key does not exist,";
                            } else {
                                if(worker!=null &&
                                !(worker.getFinNumber().equals(problem.getWorkerFinNum()))) {
                                    errorMsg += "invalid finNumber for this problem key,";
                                }
                            }
                        } catch (Exception ex) {
                            errorMsg += "invalid problem key,";
                        }

                        //dropdown list of existing users
                        ArrayList<String> list = DropdownDAO.retrieveAllDropdownListOfCaseworkers();
                        boolean exit = false;
                        for(String tmp:list) {
                            if (tmp.equalsIgnoreCase(auxName)) {
                                exit=true;
                                break;
                            }
                        }

                        if(!exit) {
                            errorMsg += "case worker does not exist,";
                        }

                        if (!auxStartStr.equals("")) {
                            try {
                                java.util.Date tmp = sdf.parse(auxStartStr);
                                auxStart = new java.sql.Date(tmp.getTime());
                            } catch (ParseException ex) {
                                errorMsg += "Invalid auxStart Date Format,";
                            } 
                        }

                        if (!auxEndStr.equals("")) {
                            try {
                                java.util.Date tmp = sdf.parse(auxEndStr);
                                auxEnd = new java.sql.Date(tmp.getTime());
                            } catch (ParseException ex) {
                                errorMsg += "Invalid auxEnd Date Format,";
                            } 
                        }
                    } //pass

                    // if there is an error, the line number of the error and its relevant message is added into the errorList

                    if (!errorMsg.equals("")) {
                        csvWriter = new CSVWriter(new FileWriter(errFileName, true));
                        if (errCount == 0) {
                            String[] newHeader = new String[header.length+1];
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
                        ProblemAuxiliaryCaseWorker problemAuxiliaryCaseWorker = new ProblemAuxiliaryCaseWorker
                                (finNum, jobKey, probKey, auxName, auxStart, auxEnd );
                        ProblemComplementsDAO.addProblemAuxiliaryCaseWorker(problemAuxiliaryCaseWorker);
                        succCount++;
                    }    
                }
            } else if (fileShortName.equals("salaryrelatedhistory.csv")) {
                // Loops through each line of the csv with an array of String
                while ((fields = csvReader.readNext()) != null) {
                    
                    // Assigning each field with its appropriate name
                    String finNum = fields[0].trim();
                    String jobKeyStr = fields[1].trim();
                    String probKeyStr = fields[2].trim();
                    String salHistBasic = fields[3].trim();
                    String salHistOT = fields[4].trim();
                    String salHistAllowances = fields[5].trim();
                    String salHistDeductions = fields[6].trim();
                    String salHistKickbacks = fields[7].trim();
                    String salHistOther = fields[8].trim();
                    String salMode = fields[9].trim();
                    String salModeMore = fields[10].trim();
                    String salLossTotalStr = fields[11].trim();
                    String salLoss1YrStr = fields[12].trim();
                    String salHistRem = fields[13].trim();

                    int jobKey = 0;
                    int probKey = 0;
                    double salLossTotal = 0;
                    double salLoss1Yr = 0;
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

                    if (salHistBasic.equals("")) {
                        errorMsg += header[3] + " is blank,";
                        pass = false;
                    }

                    //proceed only after empty fields validation is passed
                    if (pass) { 

                        // check for any existing worker  with the same finNum. 
                        Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                        if (worker == null) {
                            errorMsg += "FinNumber does not exist, ";
                        }

                        try {
                            jobKey = Integer.parseInt(jobKeyStr);
                            Job job = JobDAO.retrieveJobByJobId(jobKey);
                            if (job == null) {
                                errorMsg += "job key does not exist, ";
                            } else {
                                if (worker != null && 
                                        !(worker.getFinNumber().equals(job.getWorkerFinNum()))) {
                                    errorMsg += "invalid finNumber for this job key, ";
                                }
                            }
                        } catch (Exception ex) {
                            errorMsg += "invalid job key, ";
                        }

                        try {
                            probKey = Integer.parseInt(probKeyStr);
                            Problem problem = ProblemDAO.retrieveProblemByProblemId(probKey);
                            if (problem == null) {
                                errorMsg += "problem key does not exist, ";
                            } else {
                                if (worker != null && 
                                        !(worker.getFinNumber().equals(problem.getWorkerFinNum()))) {
                                    errorMsg += "invalid finNumber for this problem key, ";
                                }
                            }
                        } catch (Exception ex) {
                            errorMsg += "problem key does not exist, ";
                        }

                        ArrayList<String> list = DropdownDAO.retrieveAllDropdownListOfSalaryMode();
                        boolean exit = false;
                        for (String tmp: list) {
                            if (tmp.equalsIgnoreCase(salMode)) {
                                exit = true;
                                break;
                            }
                        }

                        if (!exit) {
                            errorMsg += "invalid salary payment mode, ";
                        }

                        if (!salHistOT.equals("") && salHistOT.length() > 500){
                            errorMsg += header[4] + " cannot be more than 500 characters,";
                        }

                        if (!salHistAllowances.equals("") && salHistAllowances.length() > 500){
                            errorMsg += header[5] + " cannot be more than 500 characters,";
                        }

                        if (!salHistDeductions.equals("") && salHistDeductions.length() > 500){
                            errorMsg += header[6] + " cannot be more than 500 characters,";
                        }

                        if (!salHistKickbacks.equals("") && salHistKickbacks.length() > 500){
                            errorMsg += header[7] + " cannot be more than 500 characters,";
                        }

                        if (!salHistOther.equals("") && salHistOther.length() > 500){
                            errorMsg += header[8] + " cannot be more than 500 characters,";
                        }

                        if (!salModeMore.equals("") && salModeMore.length() > 50){
                            errorMsg += header[10] + " cannot be more than 50 characters,";
                        }
                        
                        if (!salLossTotalStr.equals("")) {
                            if(!salLossTotalStr.matches("^\\d+(\\.\\d{1,2})?$")) {
                                errorMsg += header[11] + " must have maximum 2 decimal places,";
                            } else {
                                try {
                                    salLossTotal = Double.parseDouble(salLossTotalStr);
                                } catch (Exception ex) {
                                    errorMsg += header[11] + " - invalid format,";
                                }
                            }
                        }

                        if (!salLoss1YrStr.equals("")) {
                            if (!salLoss1YrStr.matches("^\\d+(\\.\\d{1,2})?$")) {
                                errorMsg += header[12] + " must have maximum 2 decimal places,";
                            } else {
                                try {
                                    salLoss1Yr = Double.parseDouble(salLoss1YrStr);
                                } catch (Exception ex) {
                                    errorMsg += header[12] + " - invalid format,";
                                }
                            }
                        }

                        if (!salHistRem.equals("") && salHistRem.length() > 200){
                            errorMsg += header[13] + " cannot be more than 200 characters,";
                        }
                    } //pass

                    // if there is an error, the line number of the error and its relevant message is 
                    // added into the errorList
                    if (!errorMsg.equals("")) {
                        csvWriter = new CSVWriter(new FileWriter(errFileName, true));
                        if (errCount == 0) {
                            String[] newHeader = new String[header.length+1];
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
                        ProblemSalaryRelatedHistory problemSalaryRelatedHistory = new ProblemSalaryRelatedHistory
                                (finNum, jobKey, probKey, salHistBasic, salHistOT, salHistAllowances, salHistDeductions,
                                salHistKickbacks, salHistOther, salMode, salModeMore, salLossTotal, salLoss1Yr, salHistRem);
                        ProblemComplementsDAO.addProblemSalaryRelatedHistory(problemSalaryRelatedHistory);
                        succCount++;
                    }
                }
            } else if (fileShortName.equals("injury.csv")) {
                // Loops through each line of the csv with an array of String
                while ((fields = csvReader.readNext()) != null) {
                    
                    // Assigning each field with its appropriate name
                    String finNum = fields[0].trim();
                    String jobKeyStr = fields[1].trim();
                    String probKeyStr = fields[2].trim();
                    String injDateStr = fields[3].trim();
                    String injTime = fields[4].trim();
                    String injLocation = fields[5].trim();
                    String injDeath = fields[6].trim();
                    String injBodypart = fields[7].trim();
                    String injHow = fields[8].trim();
                    String injAmbulance = fields[9].trim();
                    String injInitialTreatment = fields[10].trim();
                    String injWorkRelated = fields[11].trim();
                    String injRem = fields[12].trim();

                    int jobKey = 0;
                    int probKey = 0;
                    java.sql.Date injDate = null;
                    
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

                    if (injDateStr.equals("")) {
                        errorMsg += header[2] + " is blank,";
                        pass = false;
                    }

                    //proceed only after empty fields validation is passed
                    if (pass) { 

                        // check for any existing worker  with the same finNum. 
                        Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                        if (worker == null) {
                            errorMsg += "FinNumber does not exist, ";
                        }

                        try {
                            jobKey = Integer.parseInt(jobKeyStr);
                            Job job = JobDAO.retrieveJobByJobId(jobKey);
                            if (job == null) {
                                errorMsg += "jobkey does not exist, ";
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
                            probKey = Integer.parseInt(probKeyStr);
                            Problem problem = ProblemDAO.retrieveProblemByProblemId(probKey);
                            if (problem == null) {
                                errorMsg += "problem key does not exist, ";
                            } else {
                                if (worker != null && 
                                        !(worker.getFinNumber().equals(problem.getWorkerFinNum()))) {
                                    errorMsg += "invalid finNumber for this problem key, ";
                                }
                            }
                        } catch (Exception ex) {
                            errorMsg += "invalid problem key, ";
                        }

                        if (!injDateStr.equals("")) {
                            try {
                                java.util.Date tmp = sdf.parse(injDateStr);
                                injDate = new java.sql.Date(tmp.getTime());
                            } catch (ParseException ex) {
                                errorMsg += "Invalid injury Date Format,";
                            } 
                        }

                        if (!injTime.equals("") && injTime.length() > 20){
                            errorMsg += header[4] + " cannot be more than 20 characters,";
                        }

                        if (!injLocation.equals("") && injLocation.length() > 200){
                            errorMsg += header[5] + " cannot be more than 200 characters,";
                        }

                        if (!injDeath.equals("")) {
                            if (injDeath.equals("Yes") || injDeath.equals("No")) {

                            } else {
                                errorMsg += header[6] + " must be either 'Yes' or 'No',";
                            }
                        }

                        if (!injBodypart.equals("") && injBodypart.length() > 500){
                            errorMsg += header[7] + " cannot be more than 500 characters,";
                        }

                        if (!injHow.equals("") && injHow.length() > 1000){
                            errorMsg += header[8] + " cannot be more than 1000 characters,";
                        }

                        if (!injAmbulance.equals("")) {
                            if (injAmbulance.equals("Yes") || injAmbulance.equals("No") || 
                                    injAmbulance.equals("Don't know")) {

                            } else {
                                errorMsg += header[9] + " must be either 'Yes' or 'No' or 'Don't know,";
                            }
                        }

                        if (!injInitialTreatment.equals("") && injInitialTreatment.length() > 200){
                            errorMsg += header[10] + " cannot be more than 200 characters,";
                        }

                        if (!injWorkRelated.equals("")) {
                            if (injWorkRelated.equals("Yes") || injWorkRelated.equals("No") ||
                                    injWorkRelated.equals("Don't know")) {

                            } else {
                                errorMsg += header[11] + " must be either 'Yes' or 'No' or 'Don't know,";
                            }
                        }

                        if (!injRem.equals("") && injRem.length() > 200){
                            errorMsg += header[12] + " cannot be more than 200 characters,";
                        }
                    } //pass

                    // if there is an error, the line number of the error and its relevant message is 
                    // added into the errorList
                    if (!errorMsg.equals("")) {
                        csvWriter = new CSVWriter(new FileWriter(errFileName, true));
                        if (errCount == 0) {
                            String[] newHeader = new String[header.length+1];
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
                        ProblemInjury problemInjury = new ProblemInjury
                                (finNum, jobKey, probKey, injDate, injTime, injLocation, injDeath, injBodypart,
                                injHow, injAmbulance, injInitialTreatment, null, injWorkRelated, injRem);
                        ProblemComplementsDAO.addProblemInjury(problemInjury);
                        succCount++;
                    }    
                }
            } else if (fileShortName.equals("illness.csv")) {
                // Loops through each line of the csv with an array of String
                while ((fields = csvReader.readNext()) != null) {
                    
                    // Assigning each field with its appropriate name
                    String finNum = fields[0].trim();
                    String jobKeyStr = fields[1].trim();
                    String probKeyStr = fields[2].trim();
                    String illnessStartWhen = fields[3].trim();
                    String illnessDiagWhen = fields[4].trim();
                    String illnessDiagWho = fields[5].trim();
                    String illnessNature = fields[6].trim();
                    String illnessWorkRelated = fields[7].trim();
                    String illnessWhy = fields[8].trim();
                    String illnessRem = fields[9].trim();

                    int jobKey = 0;
                    int probKey = 0;

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

                    if (illnessStartWhen.equals("")) {
                        errorMsg += header[3] + " is blank,";
                        pass = false;
                    }

                    //proceed only after empty fields validation is passed
                    if (pass) { 

                        // check for any existing worker  with the same finNum. 
                        Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                        if (worker == null) {
                            errorMsg += "FinNumber does not exist, ";
                        }

                        try {
                            jobKey = Integer.parseInt(jobKeyStr);
                            Job job = JobDAO.retrieveJobByJobId(jobKey);
                            if (job == null) {
                                errorMsg += "job key does not exist, ";
                            } else {
                                if (worker != null && 
                                        !(worker.getFinNumber().equals(job.getWorkerFinNum()))) {
                                    errorMsg += "invalid finNumber for this job key, ";
                                }
                            }
                        } catch (Exception ex) {
                            errorMsg += "invalid job key, ";
                        }

                        try {
                            probKey = Integer.parseInt(probKeyStr);
                            Problem problem = ProblemDAO.retrieveProblemByProblemId(probKey);
                            if (problem == null) {
                                errorMsg += "problem key does not exist, ";
                            } else {
                                if (worker != null && 
                                        !(worker.getFinNumber().equals(problem.getWorkerFinNum()))) {
                                    errorMsg += "invalid finNumber for this problem key, ";
                                }
                            }
                        } catch (Exception ex) {
                            errorMsg += "invalid problem key, ";
                        }

                        if (!illnessStartWhen.equals("") && illnessStartWhen.length() > 50){
                            errorMsg += header[3] + " cannot be more than 50 characters,";
                        }

                        if (!illnessDiagWhen.equals("") && illnessDiagWhen.length() > 50){
                            errorMsg += header[4] + " cannot be more than 50 characters,";
                        }

                        if (!illnessDiagWho.equals("") && illnessDiagWho.length() > 200){
                            errorMsg += header[5] + " cannot be more than 200 characters,";
                        }

                        if (!illnessNature.equals("") && illnessNature.length() > 200){
                            errorMsg += header[6] + " cannot be more than 200 characters,";
                        }

                        if (!illnessWorkRelated.equals("")) {
                            if (illnessWorkRelated.equals("Yes") || illnessWorkRelated.equals("No")
                                    || illnessWorkRelated.equals("Don't know")) {

                            } else {
                                errorMsg += header[7] + " must be either 'Yes' or 'No' or 'Don't know";
                            }
                        }

                        if (!illnessWhy.equals("") && illnessWhy.length() > 500){
                            errorMsg += header[8] + " cannot be more than 500 characters,";
                        }

                        if (!illnessRem.equals("") && illnessRem.length() > 200){
                            errorMsg += header[8] + " cannot be more than 200 characters,";
                        }
                    } //pass

                    // if there is an error, the line number of the error and its relevant message is 
                    // added into the errorList
                    if (!errorMsg.equals("")) {
                        csvWriter = new CSVWriter(new FileWriter(errFileName, true));
                        if (errCount == 0) {
                            String[] newHeader = new String[header.length+1];
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
                        ProblemIllness problemIllness = new ProblemIllness
                                (finNum, jobKey, probKey, illnessStartWhen, illnessDiagWhen, illnessDiagWho,
                                illnessNature, illnessWorkRelated, illnessWhy, illnessRem);
                        ProblemComplementsDAO.addProblemIllness(problemIllness);
                        succCount++;
                    }    
                }
            } else if (fileShortName.equals("otherproblems.csv")) {
                // Loops through each line of the csv with an array of String
                while ((fields = csvReader.readNext()) != null) {
                    
                    // Assigning each field with its appropriate name
                    String finNum = fields[0].trim();
                    String jobKeyStr = fields[1].trim();
                    String probKeyStr = fields[2].trim();
                    String othProblemDesc = fields[3].trim();
                    String othProblemLossStr = fields[4].trim();
                    String othProblemRem = fields[5].trim();

                    int jobKey = 0;
                    int probKey = 0;
                    int othProblemLoss = 0;
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

                    if (othProblemDesc.equals("")) {
                        errorMsg += header[3] + " is blank,";
                        pass = false;
                    }

                    //proceed only after empty fields validation is passed
                    if (pass) { 

                        // check for any existing worker  with the same finNum. 
                        Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                        if (worker == null) {
                            errorMsg += "FinNumber does not exist, ";
                        }

                        try {
                            jobKey = Integer.parseInt(jobKeyStr);
                            Job job = JobDAO.retrieveJobByJobId(jobKey);
                            if (job == null) {
                                errorMsg += "job key does not exist, ";
                            } else {
                                if (worker != null && 
                                        !(worker.getFinNumber().equals(job.getWorkerFinNum()))) {
                                    errorMsg += "invalid finNumber for this job key, ";
                                }
                            }
                        } catch (Exception ex) {
                            errorMsg += "invalid job key, ";
                        }

                        try {
                            probKey = Integer.parseInt(probKeyStr);
                            Problem problem = ProblemDAO.retrieveProblemByProblemId(probKey);
                            if (problem == null) {
                                errorMsg += "problem key does not exist, ";
                            } else {
                                if (worker != null && 
                                        !(worker.getFinNumber().equals(problem.getWorkerFinNum()))) {
                                    errorMsg += "invalid finNumber for this problem key, ";
                                }
                            }
                        } catch (Exception ex) {
                            errorMsg += "invalid problem key, ";
                        }

                        if (!othProblemDesc.equals("") && othProblemDesc.length() > 1000){
                            errorMsg += header[3] + " cannot be more than 1000 characters,";
                        }

                        if (!othProblemLossStr.equals("")) {
                            try {
                                othProblemLoss = Integer.parseInt(othProblemLossStr);
                            } catch (Exception ex) {
                                errorMsg += header[4] + " - invalid format,";
                            }
                        }

                        if (!othProblemRem.equals("") && othProblemRem.length() > 200) {
                            errorMsg += header[5] + " cannot be longer than 200 characters,";
                        }

                    }   //pass 

                    // if there is an error, the line number of the error and its relevant message is 
                    // added into the errorList
                    if (!errorMsg.equals("")) {
                        csvWriter = new CSVWriter(new FileWriter(errFileName, true));
                        if (errCount == 0) {
                            String[] newHeader = new String[header.length+1];
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
                        ProblemOtherProblems problemOtherProblems = new ProblemOtherProblems
                                (finNum, jobKey, probKey, othProblemDesc, othProblemLoss, othProblemRem);
                        ProblemComplementsDAO.addProblemOtherProblems(problemOtherProblems);
                        succCount++;
                    }    
                }
            } else if (fileShortName.equals("salaryclaim.csv")) {
                // Loops through each line of the csv with an array of String
                while ((fields = csvReader.readNext()) != null) {
                    
                    // Assigning each field with its appropriate name
                    String finNum = fields[0].trim();
                    String jobKeyStr = fields[1].trim();
                    String probKeyStr = fields[2].trim();
                    String salClaimDateStr = fields[3].trim();
                    String salClaimLossStr = fields[4].trim();
                    String salClaimBasis = fields[5].trim();

                    int jobKey = 0;
                    int probKey = 0;
                    java.sql.Date salClaimDate = null;
                    
                    double salClaimLoss = 0;
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

                    if (salClaimDateStr.equals("")) {
                        errorMsg += header[3] + " is blank,";
                        pass = false;
                    }

                    //proceed only after empty fields validation is passed
                    if (pass) { 

                        // check for any existing worker  with the same finNum. 
                        Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                        if (worker == null) {
                            errorMsg += "FinNumber does not exist, ";
                        }

                        try {
                            jobKey = Integer.parseInt(jobKeyStr);
                            Job job = JobDAO.retrieveJobByJobId(jobKey);
                            if (job == null) {
                                errorMsg += "jobkey does not exist, ";
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
                            probKey = Integer.parseInt(probKeyStr);
                            Problem problem = ProblemDAO.retrieveProblemByProblemId(probKey);
                            if (problem == null) {
                                errorMsg += "problem key does not exist, ";
                            } else {
                                if (worker != null && 
                                        !(worker.getFinNumber().equals(problem.getWorkerFinNum()))) {
                                    errorMsg += "invalid finNumber for this problem key, ";
                                }
                            }
                        } catch (Exception ex) {
                            errorMsg += "invalid problem key, ";
                        }

                        if(!salClaimDateStr.equals("")) {
                            try {
                                java.util.Date tmp = sdf.parse(salClaimDateStr);
                                salClaimDate = new java.sql.Date(tmp.getTime());
                            } catch (ParseException ex) {
                                errorMsg += "Invalid Salary claim Date Format,";
                            } 
                        }
                        
                        if(!salClaimLossStr.equals("")) {
                            if (!salClaimLossStr.matches("^\\d+(\\.\\d{1,2})?$")) {
                                errorMsg += header[4] + " must have maximum 2 decimal places,"; 
                            } else {
                                try {
                                    salClaimLoss = Double.parseDouble(salClaimLossStr);
                                } catch (Exception ex) {
                                    errorMsg += header[4] + " - invalid format,";
                                }
                            }
                        }

                        if (!salClaimBasis.equals("") && salClaimBasis.length() > 1000) {
                            errorMsg += header[5] + " cannot be longer than 1000 characters,";
                        }
                    }   //pass 

                    // if there is an error, the line number of the error and its relevant message is 
                    // added into the errorList
                    if (!errorMsg.equals("")) {
                        csvWriter = new CSVWriter(new FileWriter(errFileName, true));
                        if (errCount == 0) {
                            String[] newHeader = new String[header.length+1];
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
                        ProblemSalaryClaim problemSalaryClaim = new ProblemSalaryClaim
                                (finNum, jobKey, probKey, salClaimDate, salClaimLoss, salClaimBasis);
                        ProblemComplementsDAO.addProblemSalaryClaim(problemSalaryClaim);
                        succCount++;
                    }    
                }
            } else if (fileShortName.equals("wica.csv")) {
                //Loops through each line of the csv with an array of String
                while ((fields = csvReader.readNext()) != null){
                    
                    //Assigning each field with its appropriate name
                    String finNum = fields[0].trim();
                    String jobKeyStr = fields[1].trim();
                    String probKeyStr = fields[2].trim();
                    String dateStr = fields[3].trim();
                    String status = fields[4].trim();
                    String statusMore = fields[5].trim();
                    String pointsStr = fields[6].trim();
                    String dollarsStr = fields[7].trim();
                    String rem = fields[8].trim();


                    int jobKey = 0;
                    int probKey = 0;
                    double points = 0.0;
                    double dollars = 0.0;
                    java.sql.Date updatedDate = null;
                    

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
                    if (dateStr.equals("")) {
                        errorMsg += header[3] + " is blank,";
                        pass = false;
                    }
                    if (status.equals("")) {
                        errorMsg += header[4] + " is blank,";
                        pass = false;
                    }

                    //proceed only after empty fields validation is passed
                    if (pass) { 

                        // check for any existing worker  with the same finNum. 
                        Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                        if (worker == null) {
                            errorMsg += "FinNumber does not exist, ";
                        }

                        try {
                            jobKey = Integer.parseInt(jobKeyStr);
                            Job job = JobDAO.retrieveJobByJobId(jobKey);
                            if (job == null) {
                                errorMsg += "job key does not exist, ";
                            } else {
                                if (worker != null && 
                                        !(worker.getFinNumber().equals(job.getWorkerFinNum()))) {
                                    errorMsg += "fin number does not exist for this job key, ";
                                }
                            }
                        } catch (Exception ex) {
                            errorMsg += "invalid job key, ";
                        }

                        try {
                            probKey = Integer.parseInt(probKeyStr);
                            Problem problem = ProblemDAO.retrieveProblemByProblemId(probKey);
                            if (problem == null) {
                                errorMsg += "problem key does not exist, ";
                            } else {
                                if (worker != null && 
                                        !(worker.getFinNumber().equals(problem.getWorkerFinNum()))) {
                                    errorMsg += "fin number does not exist for this problem key, ";
                                }
                            }
                        } catch (Exception ex) {
                            errorMsg += "invalid problem key, ";
                        }

                        if (!dateStr.equals("")) {
                            try {
                                java.util.Date tmp = sdf.parse(dateStr);
                                updatedDate = new java.sql.Date(tmp.getTime());
                            } catch (ParseException ex) {
                                errorMsg += "Invalid Updated Wica Date Format,";
                            } 
                        }
                        ArrayList<String> list = DropdownDAO.retrieveAllDropdownListOfWica();
                        boolean exit = false;
                        for (String tmp: list) {
                            if (tmp.equalsIgnoreCase(status)) {
                                exit = true;
                                break;
                            }
                        }

                        if (!exit) {
                            errorMsg += "invalid Wica Status, ";
                        }


                        if (!status.equals("") && status.length() > 30) {
                            errorMsg += header[5] + " cannot be longer than 30 characters,";
                        }

                        if (!statusMore.equals("") && statusMore.length() > 50) {
                            errorMsg += header[6] + " cannot be longer than 50 characters,";
                        }
                        
                        if (!pointsStr.equals("")) {
                            if (!pointsStr.matches("^\\d+(\\.\\d{1,2})?$")) {
                                errorMsg += header[7] + " must have maximum 2 decimal places,";
                            } else {
                                try {
                                    points = Double.parseDouble(pointsStr);
                                } catch (Exception ex) {
                                    errorMsg += header[14] + " - invalid format,";
                                }
                            }
                        }

                        if (!dollarsStr.equals("")) {
                            if (!dollarsStr.matches("^\\d+(\\.\\d{1,2})?$")) {
                                errorMsg += header[8] + " must have maximum 2 decimal places,";
                            } else {
                                try {
                                    dollars = Double.parseDouble(dollarsStr);
                                } catch (Exception ex) {
                                    errorMsg += header[8] + " - invalid format,";
                                }
                            }
                        }


                        if (!rem.equals("") && rem.length() > 200) {
                            errorMsg += header[9] + " cannot be longer than 200 characters,";
                        }


                    } //pass

                    // if there is an error, the line number of the error and its relevant message is 
                    // added into the errorList
                    if (!errorMsg.equals("")) {
                        csvWriter = new CSVWriter(new FileWriter(errFileName, true));
                        if (errCount == 0) {
                            String[] newHeader = new String[header.length+1];
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
                        ProblemWica problemWica = new ProblemWica
                                (finNum, jobKey, probKey, updatedDate, status, statusMore, points, dollars, rem);
                        ProblemComplementsDAO.addProblemWica (problemWica);
                        succCount++;
                    }  

                }
            } else if (fileShortName.equals("wicaclaim.csv")) {
                // Loops through each line of the csv with an array of String
                while ((fields = csvReader.readNext()) != null) {
                    
                    // Assigning each field with its appropriate name
                    String finNum = fields[0].trim();
                    String jobKeyStr = fields[1].trim();
                    String probKeyStr = fields[2].trim();
                    String wicaClaimDateStr = fields[3].trim();
                    String wicaRefNbr = fields[4].trim();
                    String wicaInsurer = fields[5].trim();
                    String wicaPolicyNbr = fields[6].trim();
                    String wicaWhoLodged = fields[7].trim();
                    String wicaClaimRem = fields[8].trim();

                    int jobKey = 0;
                    int probKey = 0;
                    java.sql.Date wicaClaimDate = null;
                    
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

                    if (wicaClaimDateStr.equals("")) {
                        errorMsg += header[3] + " is blank,";
                        pass = false;
                    }

                    //proceed only after empty fields validation is passed
                    if (pass) { 

                        // check for any existing worker  with the same finNum. 
                        Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                        if (worker == null) {
                            errorMsg += "FinNumber does not exist, ";
                        }

                        try {
                            jobKey = Integer.parseInt(jobKeyStr);
                            Job job = JobDAO.retrieveJobByJobId(jobKey);
                            if (job == null) {
                                errorMsg += "jobkey does not exist, ";
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
                            probKey = Integer.parseInt(probKeyStr);
                            Problem problem = ProblemDAO.retrieveProblemByProblemId(probKey);
                            if (problem == null) {
                                errorMsg += "problem key does not exist, ";
                            } else {
                                if (worker != null && 
                                        !(worker.getFinNumber().equals(problem.getWorkerFinNum()))) {
                                    errorMsg += "invalid finNumber for this problem key, ";
                                }
                            }
                        } catch (Exception ex) {
                            errorMsg += "invalid problem key, ";
                        }

                        if (!wicaClaimDateStr.equals("")) {
                            try {
                                java.util.Date tmp = sdf.parse(wicaClaimDateStr);
                                wicaClaimDate = new java.sql.Date(tmp.getTime());
                            } catch (ParseException ex) {
                                errorMsg += "Invalid wica claim Date Format,";
                            } 
                        }

                        if (!wicaRefNbr.equals("") && wicaRefNbr.length() > 30) {
                            errorMsg += header[4] + " cannot be longer than 30 characters,";
                        }

                        if (!wicaInsurer.equals("") && wicaInsurer.length() > 50) {
                            errorMsg += header[5] + " cannot be longer than 50 characters,";
                        }

                        if (!wicaPolicyNbr.equals("") && wicaPolicyNbr.length() > 50) {
                            errorMsg += header[6] + " cannot be longer than 50 characters,";
                        }

                        if (!wicaWhoLodged.equals("") && wicaWhoLodged.length() > 200) {
                            errorMsg += header[7] + " cannot be longer than 200 characters,";
                        }

                        if (!wicaClaimRem.equals("") && wicaClaimRem.length() > 200) {
                            errorMsg += header[8] + " cannot be longer than 200 characters,";
                        }
                    }   //pass 

                    // if there is an error, the line number of the error and its relevant message is 
                    // added into the errorList
                    if (!errorMsg.equals("")) {
                        csvWriter = new CSVWriter(new FileWriter(errFileName, true));
                        if (errCount == 0) {
                            String[] newHeader = new String[header.length+1];
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
                        ProblemWicaClaim problemWicaClaim = new ProblemWicaClaim
                                (finNum, jobKey, probKey, wicaClaimDate, wicaRefNbr, wicaInsurer, wicaPolicyNbr, 
                                wicaWhoLodged, wicaClaimRem);
                        ProblemComplementsDAO.addProblemWicaClaim(problemWicaClaim);
                        succCount++;
                    }    
                }
            } else if (fileShortName.equals("nonwicaclaim.csv")) {
                // Loops through each line of the csv with an array of String
                while ((fields = csvReader.readNext()) != null) {
                    
                    // Assigning each field with its appropriate name
                    String finNum = fields[0].trim();
                    String jobKeyStr = fields[1].trim();
                    String probKeyStr = fields[2].trim();
                    String medClaimDateStr = fields[3].trim();
                    String medClaimLossStr = fields[4].trim();
                    String medClaimInsurer = fields[5].trim();
                    String medClaimPolicyNbr = fields[6].trim();
                    String medClaimBasis = fields[7].trim();
                    String medClaimRem = fields[8].trim();

                    int jobKey = 0;
                    int probKey = 0;
                    java.sql.Date medClaimDate = null;
                    
                    double medClaimLoss = 0.0;
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

                    if (medClaimDateStr.equals("")) {
                        errorMsg += header[3] + " is blank,";
                        pass = false;
                    }

                    //proceed only after empty fields validation is passed
                    if (pass) { 

                        // check for any existing worker  with the same finNum. 
                        Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                        if (worker == null) {
                            errorMsg += "FinNumber does not exist, ";
                        }

                        try {
                            jobKey = Integer.parseInt(jobKeyStr);
                            Job job = JobDAO.retrieveJobByJobId(jobKey);
                            if (job == null) {
                                errorMsg += "jobkey does not exist, ";
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
                            probKey = Integer.parseInt(probKeyStr);
                            Problem problem = ProblemDAO.retrieveProblemByProblemId(probKey);
                            if (problem == null) {
                                errorMsg += "problem key does not exist, ";
                            } else {
                                if (worker != null && 
                                        !(worker.getFinNumber().equals(problem.getWorkerFinNum()))) {
                                    errorMsg += "invalid finNumber for this problem key, ";
                                }
                            }
                        } catch (Exception ex) {
                            errorMsg += "invalid problem key, ";
                        }

                        if (!medClaimDateStr.equals("")) {
                            try {
                                java.util.Date tmp = sdf.parse(medClaimDateStr);
                                medClaimDate = new java.sql.Date(tmp.getTime());
                            } catch (ParseException ex) {
                                errorMsg += "Invalid non-wica medical claim Date Format,";
                            } 
                        }
                        
                        if (!medClaimLossStr.equals("")) {
                            if (!medClaimLossStr.matches("^\\d+(\\.\\d{1,2})?$")) {
                                errorMsg += header[4] + " must have maximum 2 decimal places,";
                            } else {
                                try {
                                    medClaimLoss = Double.parseDouble(medClaimLossStr);
                                } catch (Exception ex) {
                                    errorMsg += header[4] + " - invalid format,";
                                }
                            }
                        }

                        if (!medClaimInsurer.equals("") && medClaimInsurer.length() > 50) {
                            errorMsg += header[5] + " cannot be longer than 50 characters,";
                        }

                        if (!medClaimPolicyNbr.equals("") && medClaimPolicyNbr.length() > 30) {
                            errorMsg += header[6] + " cannot be longer than 30 characters,";
                        }

                        if (!medClaimBasis.equals("") && medClaimBasis.length() > 1000) {
                            errorMsg += header[7] + " cannot be longer than 1000 characters,";
                        }

                        if (!medClaimRem.equals("") && medClaimRem.length() > 1000) {
                            errorMsg += header[8] + " cannot be longer than 1000 characters,";
                        }
                    }   //pass 

                    // if there is an error, the line number of the error and its relevant message is 
                    // added into the errorList
                    if (!errorMsg.equals("")) {
                        csvWriter = new CSVWriter(new FileWriter(errFileName, true));
                        if (errCount == 0) {
                            String[] newHeader = new String[header.length+1];
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
                        ProblemNonWicaClaim problemNonWicaClaim = new ProblemNonWicaClaim
                                (finNum, jobKey, probKey, medClaimDate, medClaimLoss, medClaimInsurer, medClaimPolicyNbr, 
                                medClaimBasis, medClaimRem);
                        ProblemComplementsDAO.addProblemNonWicaClaim(problemNonWicaClaim);
                        succCount++;
                    }    
                }
            } else if (fileShortName.equals("policereport.csv")) {
                // Loops through each line of the csv with an array of String
                while ((fields = csvReader.readNext()) != null) {
                    
                    // Assigning each field with its appropriate name
                    String finNum = fields[0].trim();
                    String jobKeyStr = fields[1].trim();
                    String probKeyStr = fields[2].trim();
                    String policeRptDateStr = fields[3].trim();
                    String policeReptStation = fields[4].trim();
                    String policeRptPers = fields[5].trim();
                    String policeRptNbr = fields[6].trim();
                    String policeRptDetails = fields[7].trim();
                    String policeRptRem = fields[8].trim();

                    int jobKey = 0;
                    int probKey = 0;
                    java.sql.Date policeRptDate = null;
                    
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

                    if (policeRptDateStr.equals("")) {
                        errorMsg += header[3] + " is blank,";
                        pass = false;
                    }

                    //proceed only after empty fields validation is passed
                    if (pass) { 

                        // check for any existing worker  with the same finNum. 
                        Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                        if (worker == null) {
                            errorMsg += "FinNumber does not exist, ";
                        }

                        try {
                            jobKey = Integer.parseInt(jobKeyStr);
                            Job job = JobDAO.retrieveJobByJobId(jobKey);
                            if (job == null) {
                                errorMsg += "jobkey does not exist, ";
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
                            probKey = Integer.parseInt(probKeyStr);
                            Problem problem = ProblemDAO.retrieveProblemByProblemId(probKey);
                            if (problem == null) {
                                errorMsg += "problem key does not exist, ";
                            } else {
                                if (worker != null && 
                                        !(worker.getFinNumber().equals(problem.getWorkerFinNum()))) {
                                    errorMsg += "invalid finNumber for this problem key, ";
                                }
                            }
                        } catch (Exception ex) {
                            errorMsg += "invalid problem key, ";
                        }

                        if (!policeRptDateStr.equals("")) {
                            try {
                                java.util.Date tmp = sdf.parse(policeRptDateStr);
                                policeRptDate = new java.sql.Date(tmp.getTime());
                            } catch (ParseException ex) {
                                errorMsg += "Invalid police report Date Format,";
                            } 
                        }

                        if (!policeReptStation.equals("") && policeReptStation.length() > 50) {
                            errorMsg += header[4] + " cannot be longer than 50 characters,";
                        }

                        if (!policeRptPers.equals("") && policeRptPers.length() > 200) {
                            errorMsg += header[5] + " cannot be longer than 200 characters,";
                        }

                        if (!policeRptNbr.equals("") && policeRptNbr.length() > 30) {
                            errorMsg += header[6] + " cannot be longer than 30 characters,";
                        }

                        if (!policeRptDetails.equals("") && policeRptDetails.length() > 1000) {
                            errorMsg += header[7] + " cannot be longer than 1000 characters,";
                        }

                        if (!policeRptRem.equals("") && policeRptRem.length() > 200) {
                            errorMsg += header[8] + " cannot be longer than 200 characters,";
                        }
                    }   //pass 

                    // if there is an error, the line number of the error and its relevant message is 
                    // added into the errorList
                    if (!errorMsg.equals("")) {
                        csvWriter = new CSVWriter(new FileWriter(errFileName, true));
                        if (errCount == 0) {
                            String[] newHeader = new String[header.length+1];
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
                        ProblemPoliceReport problemPoliceReport = new ProblemPoliceReport
                                (finNum, jobKey, probKey, policeRptDate, policeReptStation, policeRptPers, policeRptNbr, 
                                policeRptDetails, policeRptRem);
                        ProblemComplementsDAO.addProblemPoliceReport(problemPoliceReport);
                        succCount++;
                    }    
                }
            } else if (fileShortName.equals("othercomplaints.csv")) {
                //Loops through each line of the csv with an array of String
                while ((fields = csvReader.readNext()) != null){
                    
                    //Assigning each field with its appropriate name
                    String finNum = fields[0].trim();
                    String jobKeyStr = fields[1].trim();
                    String probKeyStr = fields[2].trim();
                    String dateStr = fields[3].trim();
                    String agency = fields[4].trim();
                    String who = fields[5].trim();
                    String whoMore = fields[6].trim();
                    String mode = fields[7].trim();
                    String modeMore = fields[8].trim();
                    String details = fields[9].trim();
                    String rem = fields[10].trim();

                    int jobKey = 0;
                    int probKey = 0;
                    java.sql.Date complaintDate = null;
                    

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
                    if (dateStr.equals("")) {
                        errorMsg += header[3] + " is blank,";
                        pass = false;
                    }
                    if (agency.equals("")) {
                        errorMsg += header[4] + " is blank,";
                        pass = false;
                    }
                    if (who.equals("")) {
                        errorMsg += header[5] + " is blank,";
                        pass = false;
                    }




                    //proceed only after empty fields validation is passed
                    if (pass) { 

                        // check for any existing worker  with the same finNum. 
                        Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                        if (worker == null) {
                            errorMsg += "FinNumber does not exist, ";
                        }

                        try {
                            jobKey = Integer.parseInt(jobKeyStr);
                            Job job = JobDAO.retrieveJobByJobId(jobKey);
                            if (job == null) {
                                errorMsg += "job key does not exist, ";
                            } else {
                                if (worker != null && 
                                        !(worker.getFinNumber().equals(job.getWorkerFinNum()))) {
                                    errorMsg += "invalid finNumber for this job key, ";
                                }
                            }
                        } catch (Exception ex) {
                            errorMsg += "invalid job key, ";
                        }

                        try {
                            probKey = Integer.parseInt(probKeyStr);
                            Problem problem = ProblemDAO.retrieveProblemByProblemId(probKey);
                            if (problem == null) {
                                errorMsg += "problem key does not exist, ";
                            } else {
                                if (worker != null && 
                                        !(worker.getFinNumber().equals(problem.getWorkerFinNum()))) {
                                    errorMsg += "invalid finNumber for this problem key, ";
                                }
                            }
                        } catch (Exception ex) {
                            errorMsg += "invalid problem key, ";
                        }

                        if (!dateStr.equals("")) {
                            try {
                                java.util.Date tmp = sdf.parse(dateStr);
                                complaintDate = new java.sql.Date(tmp.getTime());
                            } catch (ParseException ex) {
                                errorMsg += "Invalid complaint lodged Date Format,";
                            } 
                        }

                        if (!agency.equals("") && agency.length() > 50) {
                            errorMsg += header[5] + " cannot be longer than 50 characters,";
                        }

                        if (!who.equals("") && who.length() > 12) {
                            errorMsg += header[6] + " cannot be longer than 12 characters,";
                        }

                        if (!whoMore.equals("") && whoMore.length() > 50) {
                            errorMsg += header[7] + " cannot be longer than 50 characters,";
                        }

                        if (!mode.equals("") && mode.length() > 30) {
                            errorMsg += header[8] + " cannot be longer than 30 characters,";
                        }

                        if (!modeMore.equals("") && modeMore.length() > 200) {
                            errorMsg += header[9] + " cannot be longer than 200 characters,";
                        }

                         if (!details.equals("") && details.length() > 1000) {
                            errorMsg += header[10] + " cannot be longer than 1000 characters,";
                        }

                         if (!rem.equals("") && rem.length() > 200) {
                            errorMsg += header[11] + " cannot be longer than 200 characters,";
                        }

                    } //pass

                    // if there is an error, the line number of the error and its relevant message is 
                    // added into the errorList
                    if (!errorMsg.equals("")) {
                        csvWriter = new CSVWriter(new FileWriter(errFileName, true));
                        if (errCount == 0) {
                            String[] newHeader = new String[header.length+1];
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
                        ProblemOtherComplaint problemOtherComplaint = new ProblemOtherComplaint
                                (finNum, jobKey, probKey, complaintDate, agency, who, whoMore, mode, modeMore, details, rem);
                        ProblemComplementsDAO.addProblemOtherComplaint (problemOtherComplaint);
                        succCount++;
                    }  

                }
            } else if (fileShortName.equals("casediscussion.csv")) {
                //Loops through each line of the csv with an array of String
                while ((fields = csvReader.readNext()) != null){
                    
                    //Assigning each field with its appropriate name
                    String finNum = fields[0].trim();
                    String jobKeyStr = fields[1].trim();
                    String probKeyStr = fields[2].trim();
                    String caseDissDateStr = fields[3].trim();
                    String caseDissTime = fields[4].trim();
                    String caseDissWhere = fields[5].trim();
                    String caseDissWhereMore = fields[6].trim();
                    String caseDissWorkerPresent = fields[7].trim();
                    String caseDissTWC1 = fields[8].trim();
                    String caseDissTWC2 = fields[9].trim();
                    String caseDissOtherPerson = fields[10].trim();
                    String caseDissTrasnslator = fields[11].trim();
                    String caseDissTopic = fields[12].trim();
                    String caseDissGist = fields[13].trim();
                    String caseDissAssist = fields[14].trim();
                    String caseDissCalculate = fields[15].trim();
                    String caseDissAction = fields[16].trim();
                    String caseDissRem = fields[17].trim();

                    int jobKey = 0;
                    int probKey = 0;
                    java.sql.Date caseDissDate = null;
                    

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
                    if (caseDissDateStr.equals("")) {
                        errorMsg += header[3] + " is blank,";
                        pass = false;
                    }
                    if (caseDissWhere.equals("")) {
                        errorMsg += header[5] + " is blank,";
                        pass = false;
                    }
                    if (caseDissTWC1.equals("")) {
                        errorMsg += header[8] + " is blank,";
                        pass = false;
                    }
                    if (caseDissTopic.equals("")) {
                        errorMsg += header[12] + " is blank,";
                        pass = false;
                    }

                    //proceed only after empty fields validation is passed
                    if (pass) { 

                        // check for any existing worker  with the same finNum. 
                        Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                        if (worker == null) {
                            errorMsg += "FinNumber does not exist, ";
                        }

                        try {
                            jobKey = Integer.parseInt(jobKeyStr);
                            Job job = JobDAO.retrieveJobByJobId(jobKey);
                            if (job == null) {
                                errorMsg += "job key does not exist, ";
                            } else {
                                if (worker != null && 
                                        !(worker.getFinNumber().equals(job.getWorkerFinNum()))) {
                                    errorMsg += "invalid finNumber for this job key, ";
                                }
                            }
                        } catch (Exception ex) {
                            errorMsg += "invalid job key, ";
                        }

                        try {
                            probKey = Integer.parseInt(probKeyStr);
                            Problem problem = ProblemDAO.retrieveProblemByProblemId(probKey);
                            if (problem == null) {
                                errorMsg += "problem key does not exist, ";
                            } else {
                                if (worker != null && 
                                        !(worker.getFinNumber().equals(problem.getWorkerFinNum()))) {
                                    errorMsg += "invalid finNumber for this problem key, ";
                                }
                            }
                        } catch (Exception ex) {
                            errorMsg += "invalid problem key, ";
                        }

                        if (!caseDissDateStr.equals("")) {
                            try {
                                java.util.Date tmp = sdf.parse(caseDissDateStr);
                                caseDissDate = new java.sql.Date(tmp.getTime());
                            } catch (ParseException ex) {
                                errorMsg += "Invalid Case Discussion Date Format,";
                            } 
                        }

                        ArrayList<String> list = DropdownDAO.retrieveAllDropdownListOfDiscussWhere();
                        boolean exit = false;
                        for (String tmp: list) {
                            if (tmp.equalsIgnoreCase(caseDissWhere)) {
                                exit = true;
                                break;
                            }
                        }

                        if (!exit) {
                            errorMsg += "invalid Case Discussion Location, ";
                        }

                        if (!caseDissTime.equals("") && caseDissTime.length() > 20) {
                            errorMsg += header[5] + " cannot be longer than 20 characters,";
                        }

                        if (!caseDissWhere.equals("") && caseDissWhere.length() > 30) {
                            errorMsg += header[6] + " cannot be longer than 30 characters,";
                        }

                        if (!caseDissWhereMore.equals("") && caseDissWhereMore.length() > 50) {
                            errorMsg += header[7] + " cannot be longer than 50 characters,";
                        }

                        if (!caseDissWorkerPresent.equals("")) {
                            if (caseDissWorkerPresent.equalsIgnoreCase("Yes") || 
                                    caseDissWorkerPresent.equalsIgnoreCase("No")) {            
                            } else {
                                errorMsg += header[8] + " can only be 'Yes' or 'No',";
                            }
                        }

                        if (!caseDissTWC1.equals("") && caseDissTWC1.length() > 200) {
                            errorMsg += header[9] + " cannot be longer than 200 characters,";
                        }

                         if (!caseDissTWC2.equals("") && caseDissTWC2.length() > 200) {
                            errorMsg += header[10] + " cannot be longer than 200 characters,";
                        }

                         if (!caseDissOtherPerson.equals("") && caseDissOtherPerson.length() > 200) {
                            errorMsg += header[11] + " cannot be longer than 200 characters,";
                        }

                        if (!caseDissTrasnslator.equals("") && caseDissTrasnslator.length() > 50) {
                            errorMsg += header[12] + " cannot be longer than 50 characters,";
                        }

                        if (!caseDissTopic.equals("") && caseDissTopic.length() > 200) {
                            errorMsg += header[13] + " cannot be longer than 200 characters,";
                        }

                        if (!caseDissGist.equals("") && caseDissGist.length() > 1000) {
                            errorMsg += header[14] + " cannot be longer than 1000 characters,";
                        }

                        if (!caseDissAssist.equals("") && caseDissAssist.length() > 1000) {
                            errorMsg += header[15] + " cannot be longer than 1000 characters,";
                        }

                        if (!caseDissCalculate.equals("") && caseDissCalculate.length() > 1000) {
                            errorMsg += header[16] + " cannot be longer than 1000 characters,";
                        }

                        if (!caseDissAction.equals("") && caseDissAction.length() > 500) {
                            errorMsg += header[17] + " cannot be longer than 500 characters,";
                        }

                        if (!caseDissRem.equals("") && caseDissRem.length() > 500) {
                            errorMsg += header[18] + " cannot be longer than 500 characters,";
                        }

                    } //pass

                    // if there is an error, the line number of the error and its relevant message is 
                    // added into the errorList
                    if (!errorMsg.equals("")) {
                        csvWriter = new CSVWriter(new FileWriter(errFileName, true));
                        if (errCount == 0) {
                            String[] newHeader = new String[header.length+1];
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
                        ProblemCaseDiscussion problemCaseDiscussion = new ProblemCaseDiscussion
                                (finNum, jobKey, probKey, caseDissDate, caseDissTime, caseDissWhere, 
                                caseDissWhereMore, caseDissWorkerPresent, caseDissTWC1, caseDissTWC2, 
                                caseDissOtherPerson, caseDissTrasnslator, caseDissTopic, caseDissGist, 
                                caseDissAssist, caseDissCalculate, caseDissAction, caseDissRem);
                        ProblemComplementsDAO.addProblemCaseDiscussion (problemCaseDiscussion);
                        succCount++;
                    }  

                }
            } else if (fileShortName.equals("hospital.csv")) {
                //Loops through each line of the csv with an array of String
                while ((fields = csvReader.readNext()) != null){
                    
                    //Assigning each field with its appropriate name
                    String finNum = fields[0].trim();
                    String jobKeyStr = fields[1].trim();
                    String probKeyStr = fields[2].trim();
                    String dateStr = fields[3].trim();
                    String hospName = fields[4].trim();
                    String hospNameMore = fields[5].trim();
                    String doctor = fields[6].trim();
                    String rem = fields[7].trim();

                    int jobKey = 0;
                    int probKey = 0;
                    java.sql.Date hospDate = null;
                    

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
                    if (dateStr.equals("")) {
                        errorMsg += header[3] + " is blank,";
                        pass = false;
                    }
                    if (hospName.equals("")) {
                        errorMsg += header[4] + " is blank,";
                        pass = false;
                    }



                    //proceed only after empty fields validation is passed
                    if (pass) { 

                        // check for any existing worker  with the same finNum. 
                        Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                        if (worker == null) {
                            errorMsg += "FinNumber does not exist, ";
                        }

                        try {
                            jobKey = Integer.parseInt(jobKeyStr);
                            Job job = JobDAO.retrieveJobByJobId(jobKey);
                            if (job == null) {
                                errorMsg += "job key does not exist, ";
                            } else {
                                if (worker != null && 
                                        !(worker.getFinNumber().equals(job.getWorkerFinNum()))) {
                                    errorMsg += "invalid finNumber for this job key, ";
                                }
                            }
                        } catch (Exception ex) {
                            errorMsg += "invalid job key, ";
                        }

                        try {
                            probKey = Integer.parseInt(probKeyStr);
                            Problem problem = ProblemDAO.retrieveProblemByProblemId(probKey);
                            if (problem == null) {
                                errorMsg += "problem key does not exist, ";
                            } else {
                                if (worker != null && 
                                        !(worker.getFinNumber().equals(problem.getWorkerFinNum()))) {
                                    errorMsg += "invalid finNumber for this problem key, ";
                                }
                            }
                        } catch (Exception ex) {
                            errorMsg += "invalid problem key, ";
                        }

                        if (!dateStr.equals("")) {
                            try {
                                java.util.Date tmp = sdf.parse(dateStr);
                                hospDate = new java.sql.Date(tmp.getTime());
                            } catch (ParseException ex) {
                                errorMsg += "Invalid Updated Date Format,";
                            } 
                        }

                        ArrayList<String> list = DropdownDAO.retrieveAllDropdownListOfHosptialType();
                        boolean exit = false;
                        for (String tmp: list) {
                            if (tmp.equalsIgnoreCase(hospName)) {
                                exit = true;
                                break;
                            }
                        }

                        if (!exit) {
                            errorMsg += "invalid Hospital Name, ";
                        }

                        if (!hospNameMore.equals("") && hospNameMore.length() > 50) {
                            errorMsg += header[6] + " cannot be longer than 50 characters,";
                        }

                        if (!doctor.equals("") && doctor.length() > 200) {
                            errorMsg += header[7] + " cannot be longer than 200 characters,";
                        }

                        if (!rem.equals("") && rem.length() > 200) {
                            errorMsg += header[8] + " cannot be longer than 200 characters,";
                        }


                    } //pass

                    // if there is an error, the line number of the error and its relevant message is 
                    // added into the errorList
                    if (!errorMsg.equals("")) {
                        csvWriter = new CSVWriter(new FileWriter(errFileName, true));
                        if (errCount == 0) {
                            String[] newHeader = new String[header.length+1];
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
                        ProblemHospital problemHospital = new ProblemHospital
                                (finNum, jobKey, probKey, hospDate, hospName, hospNameMore, doctor, rem);
                        ProblemComplementsDAO.addProblemHospital (problemHospital);
                        succCount++;
                    }  

                }
            } else if (fileShortName.equals("mcstatus.csv")) {
                //Loops through each line of the csv with an array of String
                while ((fields = csvReader.readNext()) != null){
                    
                    //Assigning each field with its appropriate name
                    String finNum = fields[0].trim();
                    String jobKeyStr = fields[1].trim();
                    String probKeyStr = fields[2].trim();
                    String dateStr = fields[3].trim();
                    String mcStatus = fields[4].trim();
                    String mcStatusMore = fields[5].trim();
                    String expDateStr = fields[6].trim();
                    String mcDaysCumStr = fields[7].trim();
                    String mcRem = fields[8].trim();

                    int jobKey = 0;
                    int probKey = 0;
                    java.sql.Date mcDate = null;
                    java.sql.Date expDate = null;
                    int mcDaysCum = 0;
                    

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
                    if (dateStr.equals("")) {
                        errorMsg += header[3] + " is blank,";
                        pass = false;
                    }
                    if (mcStatus.equals("")) {
                        errorMsg += header[4] + " is blank,";
                        pass = false;
                    }

                    //proceed only after empty fields validation is passed
                    if (pass) { 

                        // check for any existing worker  with the same finNum. 
                        Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                        if (worker == null) {
                            errorMsg += "FinNumber does not exist, ";
                        }

                        try {
                            jobKey = Integer.parseInt(jobKeyStr);
                            Job job = JobDAO.retrieveJobByJobId(jobKey);
                            if (job == null) {
                                errorMsg += "job key does not exist, ";
                            } else {
                                if (worker != null && 
                                        !(worker.getFinNumber().equals(job.getWorkerFinNum()))) {
                                    errorMsg += "invalid finNumber for this job key, ";
                                }
                            }
                        } catch (Exception ex) {
                            errorMsg += "invalid job key, ";
                        }

                        try {
                            probKey = Integer.parseInt(probKeyStr);
                            Problem problem = ProblemDAO.retrieveProblemByProblemId(probKey);
                            if (problem == null) {
                                errorMsg += "problem key does not exist, ";
                            } else {
                                if (worker != null && 
                                        !(worker.getFinNumber().equals(problem.getWorkerFinNum()))) {
                                    errorMsg += "invalid finNumber for this problem key, ";
                                }
                            }
                        } catch (Exception ex) {
                            errorMsg += "invalid problem key, ";
                        }

                        if (!dateStr.equals("")) {
                            try {
                                java.util.Date tmp = sdf.parse(dateStr);
                                mcDate = new java.sql.Date(tmp.getTime());
                            } catch (ParseException ex) {
                                errorMsg += "Invalid Updated Date Format,";
                            } 
                        }

                        if (!expDateStr.equals("")) {
                            try {
                                java.util.Date tmp = sdf.parse(expDateStr);
                                expDate = new java.sql.Date(tmp.getTime());
                            } catch (ParseException ex) {
                                errorMsg += "Invalid Expiry Date Format,";
                            } 
                        }

                        if (!mcStatus.equals("") && mcStatus.length() > 20) {
                            errorMsg += header[5] + " cannot be longer than 20 characters,";
                        }

                        if (!mcStatusMore.equals("") && mcStatusMore.length() > 50) {
                            errorMsg += header[6] + " cannot be longer than 50 characters,";
                        }

                        if (!mcRem.equals("") && mcRem.length() > 200) {
                            errorMsg += header[8] + " cannot be longer than 200 characters,";
                        }

                        if (!mcDaysCumStr.equals("")) {
                            try {
                                mcDaysCum = Integer.parseInt(mcDaysCumStr);
                            } catch (Exception ex) {
                                errorMsg += header[7] + " must be an integer,";
                            }    
                        }

                    } //pass

                    // if there is an error, the line number of the error and its relevant message is 
                    // added into the errorList
                    if (!errorMsg.equals("")) {
                        csvWriter = new CSVWriter(new FileWriter(errFileName, true));
                        if (errCount == 0) {
                            String[] newHeader = new String[header.length+1];
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
                        ProblemMCStatus problemMCStatus = new ProblemMCStatus
                                (finNum, jobKey, probKey, mcDate, mcStatus, mcStatusMore, expDate, mcDaysCum, mcRem);
                        ProblemComplementsDAO.addProblemMCStatus (problemMCStatus);
                        succCount++;
                    }
                }
            } else if (fileShortName.equals("r2r.csv")) {
                //Loops through each line of the csv with an array of String
                while ((fields = csvReader.readNext()) != null){
                    
                    //Assigning each field with its appropriate name
                    String finNum = fields[0].trim();
                    String jobKeyStr = fields[1].trim();
                    String probKeyStr = fields[2].trim();
                    String r2rDateStr = fields[3].trim();
                    String r2rTime = fields[4].trim();
                    String r2rHosp = fields[5].trim();
                    String r2rDept = fields[6].trim();
                    String r2r1 = fields[7].trim();
                    String r2r2 = fields[8].trim();
                    String purpose = fields[9].trim();
                    String preApptNotes = fields[10].trim();
                    String postApptNotes = fields[11].trim();
                    String feedback = fields[12].trim();
                    String medCostStr = fields[13].trim();
                    String outlayStr = fields[14].trim();

                    int jobKey = 0;
                    int probKey = 0;
                    java.sql.Date r2rDate = null;
                    double medCost = 0.0;
                    double outlay = 0.0;
                    

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
                    if (r2rDateStr.equals("")) {
                        errorMsg += header[3] + " is blank,";
                        pass = false;
                    }
                    if (r2rHosp.equals("")) {
                        errorMsg += header[5] + " is blank,";
                        pass = false;
                    }

                    //proceed only after empty fields validation is passed
                    if (pass) { 

                        // check for any existing worker  with the same finNum. 
                        Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                        if (worker == null) {
                            errorMsg += "FinNumber does not exist, ";
                        }

                        try {
                            jobKey = Integer.parseInt(jobKeyStr);
                            Job job = JobDAO.retrieveJobByJobId(jobKey);
                            if (job == null) {
                                errorMsg += "job key does not exist, ";
                            } else {
                                if (worker != null && 
                                        !(worker.getFinNumber().equals(job.getWorkerFinNum()))) {
                                    errorMsg += "invalid finNumber for this job key, ";
                                }
                            }
                        } catch (Exception ex) {
                            errorMsg += "invalid job key, ";
                        }

                        try {
                            probKey = Integer.parseInt(probKeyStr);
                            Problem problem = ProblemDAO.retrieveProblemByProblemId(probKey);
                            if (problem == null) {
                                errorMsg += "problem key does not exist, ";
                            } else {
                                if (worker != null && 
                                        !(worker.getFinNumber().equals(problem.getWorkerFinNum()))) {
                                    errorMsg += "invalid finNumber for this problem key, ";
                                }
                            }
                        } catch (Exception ex) {
                            errorMsg += "invalid problem key, ";
                        }

                        if (!r2rDateStr.equals("")) {
                            try {
                                java.util.Date tmp = sdf.parse(r2rDateStr);
                                r2rDate = new java.sql.Date(tmp.getTime());
                            } catch (ParseException ex) {
                                errorMsg += "Invalid R2R Date Format,";
                            } 
                        }
                        
                        if (!medCostStr.equals("")) {
                            if (!medCostStr.matches("^\\d+(\\.\\d{1,2})?$")) {
                            errorMsg += header[14] + " must have maximum 2 decimal places,";
                            } else {
                                try {
                                    medCost = Double.parseDouble(medCostStr);
                                } catch (Exception ex) {
                                    errorMsg += header[14] + " - invalid format,";
                                }
                            }
                        }    

                        if (!outlayStr.equals("")) {
                            if (!outlayStr.matches("^\\d+(\\.\\d{1,2})?$")) {
                                errorMsg += header[15] + " must have maximum 2 decimal places,";
                            } else {
                                try {
                                    outlay = Double.parseDouble(outlayStr);
                                } catch (Exception ex) {
                                    errorMsg += header[14] + " - invalid format,";
                                }
                            }    
                        }

                        if (!r2rTime.equals("") && r2rTime.length() > 20) {
                            errorMsg += header[5] + " cannot be longer than 20 characters,";
                        }

                        if (!r2rHosp.equals("") && r2rHosp.length() > 20) {
                            errorMsg += header[6] + " cannot be longer than 20 characters,";
                        }

                        if (!r2rDept.equals("") && r2rDept.length() > 50) {
                            errorMsg += header[7] + " cannot be longer than 50 characters,";
                        }

                        if (!r2r1.equals("") && r2r1.length() > 20) {
                            errorMsg += header[8] + " cannot be longer than 20 characters,";
                        }

                        if (!r2r2.equals("") && r2r2.length() > 20) {
                            errorMsg += header[9] + " cannot be longer than 20 characters,";
                        }

                         if (!purpose.equals("") && purpose.length() > 50) {
                            errorMsg += header[10] + " cannot be longer than 50 characters,";
                        }

                         if (!preApptNotes.equals("") && preApptNotes.length() > 200) {
                            errorMsg += header[11] + " cannot be longer than 200 characters,";
                        }

                        if (!postApptNotes.equals("") && postApptNotes.length() > 200) {
                            errorMsg += header[12] + " cannot be longer than 200 characters,";
                        }

                        if (!feedback.equals("") && feedback.length() > 200) {
                            errorMsg += header[13] + " cannot be longer than 200 characters,";
                        }


                    } //pass

                    // if there is an error, the line number of the error and its relevant message is 
                    // added into the errorList
                    if (!errorMsg.equals("")) {
                        csvWriter = new CSVWriter(new FileWriter(errFileName, true));
                        if (errCount == 0) {
                            String[] newHeader = new String[header.length+1];
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
                        ProblemR2R problemR2R = new ProblemR2R
                                (finNum, jobKey, probKey, r2rDate, r2rTime, r2rHosp, r2rDept, r2r1, r2r2, purpose, preApptNotes, postApptNotes, feedback, medCost, outlay);
                        ProblemComplementsDAO.addProblemR2R (problemR2R);
                        succCount++;
                    }  
                }
            } else if (fileShortName.equals("lawyer.csv")) {
                //Loops through each line of the csv with an array of String
                while ((fields = csvReader.readNext()) != null){
                    
                    //Assigning each field with its appropriate name
                    String finNum = fields[0].trim();
                    String jobKeyStr = fields[1].trim();
                    String probKeyStr = fields[2].trim();
                    String dateStr = fields[3].trim();
                    String firmName = fields[4].trim();
                    String firmNameMore = fields[5].trim();
                    String lawyerName = fields[6].trim();
                    String rem = fields[7].trim();


                    int jobKey = 0;
                    int probKey = 0;
                    java.sql.Date lawyerDate = null;
                    

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
                    if (dateStr.equals("")) {
                        errorMsg += header[3] + " is blank,";
                        pass = false;
                    }
                    if (firmName.equals("")) {
                        errorMsg += header[4] + " is blank,";
                        pass = false;
                    }

                    //proceed only after empty fields validation is passed
                    if (pass) { 

                        // check for any existing worker  with the same finNum. 
                        Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                        if (worker == null) {
                            errorMsg += "FinNumber does not exist, ";
                        }

                        try {
                            jobKey = Integer.parseInt(jobKeyStr);
                            Job job = JobDAO.retrieveJobByJobId(jobKey);
                            if (job == null) {
                                errorMsg += "job key does not exist, ";
                            } else {
                                if (worker != null && 
                                        !(worker.getFinNumber().equals(job.getWorkerFinNum()))) {
                                    errorMsg += "invalid finNumber for this job key, ";
                                }
                            }
                        } catch (Exception ex) {
                            errorMsg += "invalid job key, ";
                        }

                        try {
                            probKey = Integer.parseInt(probKeyStr);
                            Problem problem = ProblemDAO.retrieveProblemByProblemId(probKey);
                            if (problem == null) {
                                errorMsg += "problem key does not exist, ";
                            } else {
                                if (worker != null && 
                                        !(worker.getFinNumber().equals(problem.getWorkerFinNum()))) {
                                    errorMsg += "invalid finNumber for this problem key, ";
                                }
                            }
                        } catch (Exception ex) {
                            errorMsg += "invalid problem key, ";
                        }

                        if (!dateStr.equals("")) {
                            try {
                                java.util.Date tmp = sdf.parse(dateStr);
                                lawyerDate = new java.sql.Date(tmp.getTime());
                            } catch (ParseException ex) {
                                errorMsg += "Invalid Updated Lawyer Date Format,";
                            } 
                        }
                        ArrayList<String> list = DropdownDAO.retrieveAllDropdownListOfLawFirms();
                        boolean exit = false;
                        for (String tmp: list) {
                            if (tmp.equalsIgnoreCase(firmName)) {
                                exit = true;
                                break;
                            }
                        }

                        if (!exit) {
                            errorMsg += "invalid Law Firm Name, ";
                        }



                        if (!firmName.equals("") && firmName.length() > 30) {
                            errorMsg += header[5] + " cannot be longer than 30 characters,";
                        }

                        if (!firmNameMore.equals("") && firmNameMore.length() > 50) {
                            errorMsg += header[6] + " cannot be longer than 50 characters,";
                        }

                        if (!lawyerName.equals("") && lawyerName.length() > 200) {
                            errorMsg += header[7] + " cannot be longer than 200 characters,";
                        }

                        if (!rem.equals("") && rem.length() > 200) {
                            errorMsg += header[8] + " cannot be longer than 200 characters,";
                        }


                    } //pass

                    // if there is an error, the line number of the error and its relevant message is 
                    // added into the errorList
                    if (!errorMsg.equals("")) {
                        csvWriter = new CSVWriter(new FileWriter(errFileName, true));
                        if (errCount == 0) {
                            String[] newHeader = new String[header.length+1];
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
                        ProblemLawyer problemLawyer = new ProblemLawyer
                                (finNum, jobKey, probKey, lawyerDate, firmName, firmNameMore, lawyerName, rem);
                        ProblemComplementsDAO.addProblemLawyer (problemLawyer);
                        succCount++;
                    }

                }
            } else if (fileShortName.equals("casemilestonenc.csv")) {
                //Loops through each line of the csv with an array of String
                while ((fields = csvReader.readNext()) != null){
                    
                    //Assigning each field with its appropriate name
                    String finNum = fields[0].trim();
                    String jobKeyStr = fields[1].trim();
                    String probKeyStr = fields[2].trim();
                    String dateStr = fields[3].trim();
                    String reached = fields[4].trim();
                    String reachedMore = fields[5].trim();
                    String rem = fields[6].trim();


                    int jobKey = 0;
                    int probKey = 0;
                    java.sql.Date ncDate = null;
                    

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
                    if (dateStr.equals("")) {
                        errorMsg += header[3] + " is blank,";
                        pass = false;
                    }
                    if (reached.equals("")) {
                        errorMsg += header[4] + " is blank,";
                        pass = false;
                    }

                    //proceed only after empty fields validation is passed
                    if (pass) { 

                        // check for any existing worker  with the same finNum. 
                        Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                        if (worker == null) {
                            errorMsg += "FinNumber does not exist, ";
                        }

                        try {
                            jobKey = Integer.parseInt(jobKeyStr);
                            Job job = JobDAO.retrieveJobByJobId(jobKey);
                            if (job == null) {
                                errorMsg += "job key does not exist, ";
                            } else {
                                if (worker != null && 
                                        !(worker.getFinNumber().equals(job.getWorkerFinNum()))) {
                                    errorMsg += "invalid finNumber for this job key, ";
                                }
                            }
                        } catch (Exception ex) {
                            errorMsg += "invalid job key, ";
                        }

                        try {
                            probKey = Integer.parseInt(probKeyStr);
                            Problem problem = ProblemDAO.retrieveProblemByProblemId(probKey);
                            if (problem == null) {
                                errorMsg += "problem key does not exist, ";
                            } else {
                                if (worker != null && 
                                        !(worker.getFinNumber().equals(problem.getWorkerFinNum()))) {
                                    errorMsg += "invalid finNumber for this problem key, ";
                                }
                            }
                        } catch (Exception ex) {
                            errorMsg += "invalid problem key, ";
                        }

                        if (!dateStr.equals("")) {
                            try {
                                java.util.Date tmp = sdf.parse(dateStr);
                                ncDate = new java.sql.Date(tmp.getTime());
                            } catch (ParseException ex) {
                                errorMsg += "Invalid Milestone NC Reached Date Format,";
                            } 
                        }
                        ArrayList<String> list = DropdownDAO.retrieveAllDropdownListOfMilestoneNonCriminal();
                        boolean exit = false;
                        for (String tmp: list) {
                            if (tmp.equalsIgnoreCase(reached)) {
                                exit = true;
                                break;
                            }
                        }

                        if (!exit) {
                            errorMsg += "invalid Milestone Name, ";
                        }



                        if (!reached.equals("") && reached.length() > 50) {
                            errorMsg += header[5] + " cannot be longer than 50 characters,";
                        }

                        if (!reachedMore.equals("") && reachedMore.length() > 200) {
                            errorMsg += header[6] + " cannot be longer than 200 characters,";
                        }

                        if (!rem.equals("") && rem.length() > 200) {
                            errorMsg += header[7] + " cannot be longer than 200 characters,";
                        }


                    } //pass

                    // if there is an error, the line number of the error and its relevant message is 
                    // added into the errorList
                    if (!errorMsg.equals("")) {
                        csvWriter = new CSVWriter(new FileWriter(errFileName, true));
                        if (errCount == 0) {
                            String[] newHeader = new String[header.length+1];
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
                        ProblemCaseMilestoneNC problemCaseMilestoneNC = new ProblemCaseMilestoneNC
                                (finNum, jobKey, probKey,ncDate, reached, reachedMore, rem);
                        ProblemComplementsDAO.addProblemCaseMilestoneNC (problemCaseMilestoneNC);
                        succCount++;
                    }  
                }
            } else if (fileShortName.equals("casemilestonecr.csv")) {
                //Loops through each line of the csv with an array of String
                while ((fields = csvReader.readNext()) != null){
                    
                    //Assigning each field with its appropriate name
                    String finNum = fields[0].trim();
                    String jobKeyStr = fields[1].trim();
                    String probKeyStr = fields[2].trim();
                    String dateStr = fields[3].trim();
                    String reached = fields[4].trim();
                    String reachedMore = fields[5].trim();
                    String charges = fields[6].trim();
                    String sentence = fields[7].trim();
                    String rem = fields[8].trim();


                    int jobKey = 0;
                    int probKey = 0;
                    java.sql.Date crDate = null;
                    

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
                    if (dateStr.equals("")) {
                        errorMsg += header[3] + " is blank,";
                        pass = false;
                    }
                    if (reached.equals("")) {
                        errorMsg += header[4] + " is blank,";
                        pass = false;
                    }



                    //proceed only after empty fields validation is passed
                    if (pass) { 

                        // check for any existing worker  with the same finNum. 
                        Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                        if (worker == null) {
                            errorMsg += "FinNumber does not exist, ";
                        }

                        try {
                            jobKey = Integer.parseInt(jobKeyStr);
                            Job job = JobDAO.retrieveJobByJobId(jobKey);
                            if (job == null) {
                                errorMsg += "job key does not exist, ";
                            } else {
                                if (worker != null && 
                                        !(worker.getFinNumber().equals(job.getWorkerFinNum()))) {
                                    errorMsg += "invalid finNumber for this job key, ";
                                }
                            }
                        } catch (Exception ex) {
                            errorMsg += "invalid job key, ";
                        }

                        try {
                            probKey = Integer.parseInt(probKeyStr);
                            Problem problem = ProblemDAO.retrieveProblemByProblemId(probKey);
                            if (problem == null) {
                                errorMsg += "problem key does not exist, ";
                            } else {
                                if (worker != null && 
                                        !(worker.getFinNumber().equals(problem.getWorkerFinNum()))) {
                                    errorMsg += "invalid finNumber for this problem key, ";
                                }
                            }
                        } catch (Exception ex) {
                            errorMsg += "invalid problem key, ";
                        }

                        if (!dateStr.equals("")) {
                            try {
                                java.util.Date tmp = sdf.parse(dateStr);
                                crDate = new java.sql.Date(tmp.getTime());
                            } catch (ParseException ex) {
                                errorMsg += "Invalid Milestone CR Reached Date Format,";
                            } 
                        }
                        ArrayList<String> list = DropdownDAO.retrieveAllDropdownListOfMilestoneCriminal();
                        boolean exit = false;
                        for (String tmp: list) {
                            if (tmp.equalsIgnoreCase(reached)) {
                                exit = true;
                                break;
                            }
                        }

                        if (!exit) {
                            errorMsg += "invalid Milestone Name, ";
                        }



                        if (!reached.equals("") && reached.length() > 50) {
                            errorMsg += header[5] + " cannot be longer than 50 characters,";
                        }

                        if (!reachedMore.equals("") && reachedMore.length() > 200) {
                            errorMsg += header[6] + " cannot be longer than 200 characters,";
                        }

                        if (!charges.equals("") && charges.length() > 200) {
                            errorMsg += header[7] + " cannot be longer than 200 characters,";
                        }

                        if (!sentence.equals("") && sentence.length() > 200) {
                            errorMsg += header[8] + " cannot be longer than 200 characters,";
                        }

                        if (!rem.equals("") && rem.length() > 200) {
                            errorMsg += header[9] + " cannot be longer than 200 characters,";
                        }


                    } //pass

                    // if there is an error, the line number of the error and its relevant message is 
                    // added into the errorList
                    if (!errorMsg.equals("")) {
                        csvWriter = new CSVWriter(new FileWriter(errFileName, true));
                        if (errCount == 0) {
                            String[] newHeader = new String[header.length+1];
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
                        ProblemCaseMilestoneCR problemCaseMilestoneCR = new ProblemCaseMilestoneCR
                                (finNum, jobKey, probKey,crDate, reached, reachedMore, charges, sentence, rem);
                        ProblemComplementsDAO.addProblemCaseMilestoneCR (problemCaseMilestoneCR);
                        succCount++;
                    }  
                }
            } else if (fileShortName.equals("ttr.csv")) {
                //Loops through each line of the csv with an array of String
                while ((fields = csvReader.readNext()) != null){
                    
                    //Assigning each field with its appropriate name
                    String finNum = fields[0].trim();
                    String jobKeyStr = fields[1].trim();
                    String probKeyStr = fields[2].trim();
                    String dateStr = fields[3].trim();
                    String status = fields[4].trim();
                    String statusMore = fields[5].trim();
                    String departureDateStr = fields[6].trim();
                    String nameNew = fields[7].trim();
                    String newJob = fields[8].trim();
                    String rem = fields[9].trim();


                    int jobKey = 0;
                    int probKey = 0;
                    java.sql.Date updatedDate = null;
                    java.sql.Date depatureDate = null;
                    

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
                    if (dateStr.equals("")) {
                        errorMsg += header[3] + " is blank,";
                        pass = false;
                    }
                    if (status.equals("")) {
                        errorMsg += header[4] + " is blank,";
                        pass = false;
                    }

                    //proceed only after empty fields validation is passed
                    if (pass) { 

                        // check for any existing worker  with the same finNum. 
                        Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                        if (worker == null) {
                            errorMsg += "FinNumber does not exist, ";
                        }

                        try {
                            jobKey = Integer.parseInt(jobKeyStr);
                            Job job = JobDAO.retrieveJobByJobId(jobKey);
                            if (job == null) {
                                errorMsg += "job key does not exist, ";
                            } else {
                                if (worker != null && 
                                        !(worker.getFinNumber().equals(job.getWorkerFinNum()))) {
                                    errorMsg += "invalid finNumber for this job key, ";
                                }
                            }
                        } catch (Exception ex) {
                            errorMsg += "invalid job key, ";
                        }

                        try {
                            probKey = Integer.parseInt(probKeyStr);
                            Problem problem = ProblemDAO.retrieveProblemByProblemId(probKey);
                            if (problem == null) {
                                errorMsg += "problem key does not exist, ";
                            } else {
                                if (worker != null && 
                                        !(worker.getFinNumber().equals(problem.getWorkerFinNum()))) {
                                    errorMsg += "invalid finNumber for this problem key, ";
                                }
                            }
                        } catch (Exception ex) {
                            errorMsg += "invalid problem key, ";
                        }

                        if (!dateStr.equals("")) {
                            try {
                                java.util.Date tmp = sdf.parse(dateStr);
                                updatedDate = new java.sql.Date(tmp.getTime());
                            } catch (ParseException ex) {
                                errorMsg += "Invalid Updated TTR Date Format,";
                            } 
                        }
                        ArrayList<String> list = DropdownDAO.retrieveAllDropdownListOfTTRStatus();
                        boolean exit = false;
                        for (String tmp: list) {
                            if (tmp.equalsIgnoreCase(status)) {
                                exit = true;
                                break;
                            }
                        }

                        if (!exit) {
                            errorMsg += "invalid TTR Status, ";
                        }



                        if (!status.equals("") && status.length() > 50) {
                            errorMsg += header[5] + " cannot be longer than 50 characters,";
                        }

                        if (!statusMore.equals("") && statusMore.length() > 200) {
                            errorMsg += header[6] + " cannot be longer than 200 characters,";
                        }

                        if (!departureDateStr.equals("") && departureDateStr.length() > 50) {
                            errorMsg += header[7] + " cannot be longer than 50 characters,";
                        }


                        if (!nameNew.equals("") && nameNew.length() > 50) {
                            errorMsg += header[8] + " cannot be longer than 50 characters,";
                        }

                        if (!newJob.equals("") && newJob.length() > 200) {
                            errorMsg += header[9] + " cannot be longer than 50 characters,";
                        }

                        if (!rem.equals("") && rem.length() > 200) {
                            errorMsg += header[10] + " cannot be longer than 200 characters,";
                        }


                    } //pass

                    // if there is an error, the line number of the error and its relevant message is 
                    // added into the errorList
                    if (!errorMsg.equals("")) {
                        csvWriter = new CSVWriter(new FileWriter(errFileName, true));
                        if (errCount == 0) {
                            String[] newHeader = new String[header.length+1];
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
                        ProblemTTR problemTTR = new ProblemTTR
                                (finNum, jobKey, probKey, updatedDate, status, statusMore, departureDateStr, nameNew, newJob, rem);
                        ProblemComplementsDAO.addProblemTTR (problemTTR);
                        succCount++;
                    } 

                }
            } else if (fileShortName.equals("benefit.csv")) {
                //Loops through each line of the csv with an array of String
                while ((fields = csvReader.readNext()) != null){
                    
                    //Assigning each field with its appropriate name
                    String finNum = fields[0].trim();
                    String jobKeyStr = fields[1].trim();
                    String probKeyStr = fields[2].trim();
                    String beneDateStr = fields[3].trim();
                    String beneGiver = fields[4].trim();
                    String beneType = fields[5].trim();
                    String beneTypeMore = fields[6].trim();
                    String beneSerial = fields[7].trim();
                    String benePurpose = fields[8].trim();
                    String beneRem = fields[9].trim();
                    String beneValueStr = fields[10].trim();
                    
                    int jobKey = 0;
                    int probKey = 0;
                    Double beneValue = 0.0;
                    java.sql.Date beneDate = null;
                    

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
                    if (beneDateStr.equals("")) {
                        errorMsg += header[3] + " is blank,";
                        pass = false;
                    }
                    if (beneGiver.equals("")) {
                        errorMsg += header[4] + " is blank,";
                        pass = false;
                    }
                    
                    if (beneType.equals("")) {
                        errorMsg += header[5] + " is blank,";
                        pass = false;
                    }



                    //proceed only after empty fields validation is passed
                    if (pass) { 

                        // check for any existing worker  with the same finNum. 
                        Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                        if (worker == null) {
                            errorMsg += "FinNumber does not exist, ";
                        }

                        try {
                            jobKey = Integer.parseInt(jobKeyStr);
                            Job job = JobDAO.retrieveJobByJobId(jobKey);
                            if (job == null) {
                                errorMsg += "job key does not exist, ";
                            } else {
                                if (worker != null && 
                                        !(worker.getFinNumber().equals(job.getWorkerFinNum()))) {
                                    errorMsg += "invalid finNumber for this job key, ";
                                }
                            }
                        } catch (Exception ex) {
                            errorMsg += "invalid job key, ";
                        }

                        try {
                            probKey = Integer.parseInt(probKeyStr);
                            Problem problem = ProblemDAO.retrieveProblemByProblemId(probKey);
                            if (problem == null) {
                                errorMsg += "problem key does not exist, ";
                            } else {
                                if (worker != null && 
                                        !(worker.getFinNumber().equals(problem.getWorkerFinNum()))) {
                                    errorMsg += "invalid finNumber for this problem key, ";
                                }
                            }
                        } catch (Exception ex) {
                            errorMsg += "invalid problem key, ";
                        }

                        if (!beneDateStr.equals("")) {
                            try {
                                java.util.Date tmp = sdf.parse(beneDateStr);
                                beneDate = new java.sql.Date(tmp.getTime());
                            } catch (ParseException ex) {
                                errorMsg += "Invalid Benefit Given Date Format,";
                            } 
                        }
                        ArrayList<String> list = DropdownDAO.retrieveAllDropdownListByType("Bene_type");
                        boolean exit = false;
                        for (String tmp: list) {
                            if (tmp.equalsIgnoreCase(beneType)) {
                                exit = true;
                                break;
                            }
                        }

                        if (!exit) {
                            errorMsg += "invalid Benefit Type, ";
                        }


                        if (beneGiver != null && beneGiver.length() > 20) {
                            errorMsg += "Benefit Giver cannot be more than 20 characters.";
                        }
                        if (beneSerial != null && beneSerial.length() > 30) {
                            errorMsg += "Benefit Serial cannot be more than 30 characters.";
                        }

                        if (benePurpose != null && benePurpose.length() > 200) {
                            errorMsg += "Benefit Purpose cannot be more than 200 characerers.";
                        }

                        if (beneRem != null && beneRem.length() > 500) {
                            errorMsg += "Benefit Remark cannot be more than 500 characters.";
                        }

                        if (!beneValueStr.equals("")) {
                            try {
                                beneValue = Double.parseDouble(beneValueStr);
                            } catch (Exception ex) {
                                pass = false;
                                errorMsg += "Benefit Value must have maximum 2 decimal place.";

                            }
                        }


                    } //pass

                    // if there is an error, the line number of the error and its relevant message is 
                    // added into the errorList
                    if (!errorMsg.equals("")) {
                        csvWriter = new CSVWriter(new FileWriter(errFileName, true));
                        if (errCount == 0) {
                            String[] newHeader = new String[header.length+1];
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
                        Benefit benefit = new Benefit(finNum, jobKey, probKey, beneDate, beneGiver,
                        beneType, beneTypeMore, beneSerial, benePurpose, beneRem, beneValue);
                        //add  to db  
                        BenefitDAO.addBenefit(benefit);
                        succCount++;
                    }  
                }
            }   
            returnMsg = fileShortName + ":" + succCount + "," + errCount;
            csvReader.close();
            
        } catch (IOException ex) {
            
          //fileNotFoundExcepton
        } finally {
           
        }
        
        return returnMsg;
    }
}
