/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.controller;

import camans.dao.DropdownDAO;
import camans.dao.UserAuditLogDAO;
import camans.dao.WorkerComplementsDAO;
import camans.dao.WorkerDAO;
import camans.entity.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class processAddWorkerComplement extends HttpServlet {

    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ParseException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {

            String complementName = request.getParameter("complementName");
            String workerFinNum = request.getParameter("workerFinNum");
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
            User _user = (User) request.getSession().getAttribute("userLogin");
            String action = "";
            String auditChange = "";
            String idStr = request.getParameter("Id");
            
            //to keep track of chosen job and problem
            String jobKeyStr = request.getParameter("selectedJob");
            String probKeyStr = request.getParameter("selectedProb");
            
            String isAssociate = request.getParameter("associate");
            
            //=======================================//
            //   Server Side Validation Parameters
            //=======================================//
            String errorMsg = ""; //to store error msg
            String success = "";//to store success msgf
            
            //=======================================//
            //          Nick Name 
            //=======================================//            
            if (complementName.equals("WorkerNickname")) {

                String nickName = "";
                //get all the parameters for Nickname
                if (idStr == null) {
                    nickName = request.getParameter("nNickName");
                } else {
                    nickName = request.getParameter("nickName");
                }

                //server side validaton 
                if (nickName.equals("")) {
                    errorMsg += "Nick name is blank,";
                }
                if (nickName.length() > 50) {
                    errorMsg += "worker nickname cannot be longer than 50 characters,";
                }

                if (errorMsg.equals("")) {

                    if (idStr == null) {
                        //create nickname object
                        WorkerNickname workerNickname = new WorkerNickname(workerFinNum, nickName);
                        //addInto Database
                        WorkerComplementsDAO.addNickname(workerNickname);

                        //log the audit
                        auditChange = workerNickname.toString2();

                        //success display
                        success = "Worker Nickname has been succesfully added!";
                    } else {     
                        int id = Integer.parseInt(request.getParameter("Id"));
                        WorkerNickname workerNickname = new WorkerNickname(workerFinNum,id, nickName);
                        //update in the Database
                        WorkerComplementsDAO.updateNickname(workerNickname); 

                        //log the audit
                        auditChange = workerNickname.toString2();

                        //success display
                        success = "Worker Nickname has been successfully updated!";
                    }
                } //no error
                    
            //=======================================//
            //          Passport Details  
            //=======================================// 
            } else if (complementName.equals("WorkerPassportDetails")) {

                //get all the parameters for passport
                String passportCountry = "";
                String passportNum = "";
                String issueDateStr = "";
                String expiryDateStr = "";
                java.sql.Date issueDate = null;
                java.sql.Date expiryDate = null;
                
                if (idStr == null) {
                    passportCountry = request.getParameter("nPassportCountry");
                    passportNum = request.getParameter("nPassportNum");
                    issueDateStr = request.getParameter("nPassportIssueDate");
                    expiryDateStr = request.getParameter("nPassportExpiryDate");
                } else {
                    passportCountry = request.getParameter("passportCountry");
                    passportNum = request.getParameter("passportNum");
                    issueDateStr = request.getParameter("passportIssueDate");
                    expiryDateStr = request.getParameter("passportExpiryDate");
                }
                
                /** Server Validation **/
                boolean pass = true; //assume validation pass first;

                if (passportNum.equals("")) {
                    errorMsg += "Passport Number is blank,";
                    pass = false;
                }
                if (passportCountry.equals("")) {
                    errorMsg += "Passport Country is blank,";
                    pass = false;
                }

                //proceed only after empty fields validation is passed
                if (pass) { 

                    if (passportNum.length() > 20) {
                        errorMsg += "passport num cannot be longer than 20 characters,";
                    }

                    if (passportCountry.length() > 30) {
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
                /*Server Validation Ends*/
                
                if (errorMsg.equals("")) {
                    if (idStr == null) {
                        //create passport object
                        WorkerPassportDetails workerPassportDetails = new WorkerPassportDetails(workerFinNum,
                                passportNum, passportCountry, issueDate, expiryDate);
                        //addInto Database
                        WorkerComplementsDAO.addWorkerPassportDetails(workerPassportDetails);
                        //log the audit
                        auditChange = workerPassportDetails.toString2();

                        //success display
                        success = "Worker Passport Details has been succesfully added!";
                    } else {
                        int id = Integer.parseInt(request.getParameter("Id"));
                                                //create passport object
                        WorkerPassportDetails workerPassportDetails = new WorkerPassportDetails(workerFinNum,
                                id, passportNum, passportCountry, issueDate, expiryDate);
                        //update in the Database
                        WorkerComplementsDAO.updatePassportDetails(workerPassportDetails);

                        //log the audit
                        auditChange = workerPassportDetails.toString2();
                        //success display
                        success = "Worker Passport Details has been succesfully updated!";
                    }
                }
            //=======================================//
            //          Home Country Phone Number  
            //=======================================//
            } else if (complementName.equals("WorkerHomeCountryPhNum")) {

                String phNum = "";
                String phOwner = "";
                String obseleteDateStr = "";
                java.sql.Date obseleteDate = null;
                
                //get all the parameters for HomeCountry
                if (idStr == null) {
                    phNum = request.getParameter("nPhNum");
                    phOwner = request.getParameter("nPhOwner");
                    obseleteDateStr = request.getParameter("nObseleteDate");
                } else {
                    phNum = request.getParameter("phNum");
                    phOwner = request.getParameter("phOwner");
                    obseleteDateStr = request.getParameter("obseleteDate");
                }
                
                /**Server Validation**/
                boolean pass = true; //assume validation pass first;
                if (phNum.equals("")) {
                    errorMsg += "Phone Number is blank,";
                    pass = false;
                }

                //proceed only after empty fields validation is passed
                if (pass) { 
                    
                    if (!phNum.matches("^[\\d\\(\\-\\s\\)+]+$")) {
                        errorMsg += "invalid phone number, ";
                    }

                    if (!phOwner.equals("") && phOwner.length() > 20) {
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

                if (errorMsg.equals("")) {
                    if (idStr == null) {
                        //create object
                        WorkerHomeCountryPhNum obj = new WorkerHomeCountryPhNum(workerFinNum,
                                phNum, phOwner, obseleteDate);
                        //add into db
                        WorkerComplementsDAO.addWorkerHomeCountryPhNum(obj);
                        //log the audit
                        auditChange = obj.toString2();

                        //success display
                        success = "Home Country Phone Number has been succesfully added!";
                    } else {
                        int id = Integer.parseInt(request.getParameter("Id"));
                        WorkerHomeCountryPhNum obj = new WorkerHomeCountryPhNum(workerFinNum, id, 
                                phNum, phOwner, obseleteDate);
                        //update in the Database
                        WorkerComplementsDAO.updateWorkerHomeCountryPhNum(obj);

                        //log the audit
                        auditChange = obj.toString2();
                        
                        //success Display
                        success = "Home Country Phone Number has been succesfully updated!";
                    }
                }
            //=======================================//
            //          Singapore Phone Number  
            //=======================================//
            } else if (complementName.equals("WorkerSgPhNum")) {
                //get all the parameters for HomeCountry
                String phNum = "";
                String obseleteDateStr = "";
                java.sql.Date obseleteDate = null;
                
                if (idStr == null) {
                    phNum = request.getParameter("nsgPhNum");
                    obseleteDateStr = request.getParameter("nObseleteDate");
                } else {
                    phNum = request.getParameter("sgPhNum");
                    obseleteDateStr = request.getParameter("obseleteDate");
                }

                /**Server Validation**/
                boolean pass = true; //assume validation pass first;
                if (phNum.equals("")) {
                    errorMsg += "Phone Number is blank,";
                    pass = false;
                }

                //proceed only after empty fields validation is passed
                if (pass) { 
                    
                    if (!phNum.matches("^[\\d\\(\\-\\s\\)+]+$")) {
                        errorMsg += "invalid phone number, ";
                    }

                    if (obseleteDateStr != null && !obseleteDateStr.equals("")) {
                        try {
                            java.util.Date tmp = sdf.parse(obseleteDateStr);
                            obseleteDate = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                            errorMsg += "Invalid Obselete Date Format,";
                        } 
                    }
                }   //pass 
                
                if (errorMsg.equals("")) {
                    if (idStr == null) {
                        WorkerSgPhNum obj = new WorkerSgPhNum(workerFinNum, phNum, obseleteDate);
                        //add into db
                        WorkerComplementsDAO.addWorkerSgPhNum(obj);
                        //log the audit
                        auditChange = obj.toString2();
                        //success display
                        success = "Worker's Singapore Phone Number has been succesfully added!";
                    } else {
                        int id = Integer.parseInt(request.getParameter("Id"));
                        WorkerSgPhNum obj = new WorkerSgPhNum(workerFinNum, id, phNum,obseleteDate);
                        //update in the Database
                        WorkerComplementsDAO.updateWorkerSgPhNum(obj);

                        //log the audit
                        auditChange = obj.toString2();
                        //success display
                        success = "Worker's Singapore Phone Number has been succesfully updated!";
                    }
                }
            //=======================================//
            //          Singapore Address  
            //=======================================//
            } else if (complementName.equals("WorkerSgAddress")) {
                //get all the parameters for HomeCountry
                String address = "";
                String obseleteDateStr = "";
                java.sql.Date obseleteDate = null;
                
                if (idStr == null) {
                    address = request.getParameter("nAddress");
                    obseleteDateStr = request.getParameter("nObseleteDate");
                } else {
                    address = request.getParameter("address");
                    obseleteDateStr = request.getParameter("obseleteDate");
                }

                /**Server Validation**/
                boolean pass = true; //assume validation pass first;
                if (address.equals("")) {
                    errorMsg += "Address is blank,";
                    pass = false;
                }

                //proceed only after empty fields validation is passed
                if (pass) { 

                    if (address.length()>200) {
                        errorMsg += "sg address must not exceed 200 characters, ";
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

                if (errorMsg.equals("")) {
                    if (idStr == null) {
                        //add into db//create object
                        WorkerSgAddress obj = new WorkerSgAddress(workerFinNum, address, obseleteDate);
                        WorkerComplementsDAO.addWorkerSgAddress(obj);
                        //log the audit
                        auditChange = obj.toString2();
                        //success display
                        success = "Worker's Singapore Address has been succesfully added!";
                    } else {
                        int id = Integer.parseInt(request.getParameter("Id"));
                        WorkerSgAddress obj = new WorkerSgAddress(workerFinNum, id, address,obseleteDate);
                        //update in the Database
                        WorkerComplementsDAO.updateWorkerSgAddress(obj);

                        //log the audit
                        auditChange = obj.toString2();
                        //success Display
                        success = "Worker's Singapore Address has been succesfully updated!";
                    }
                }
            //=======================================//
            //          Home Country Address   
            //=======================================//
            } else if (complementName.equals("WorkerHomeCountryAddress")) {
                //get all the parameters for HomeCountry
                String address = "";
                String obseleteDateStr = "";
                java.sql.Date obseleteDate = null;
                if (idStr == null) {
                    address = request.getParameter("nAddress");
                    obseleteDateStr = request.getParameter("nObseleteDate");
                } else {
                    address = request.getParameter("address");
                    obseleteDateStr = request.getParameter("obseleteDate");
                }

                /**Server Validation**/
                boolean pass = true; //assume validation pass first;

                if (address.equals("")) {
                    errorMsg += "address is blank,";
                    pass = false;
                }

                //proceed only after empty fields validation is passed
                if (pass) { 

                    if (address.length()> 300) {
                        errorMsg += "home country address must not exceed 300 characters, ";
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
               
                if (errorMsg.equals("")) {
                    if (idStr == null) {
                        //add into db
                        WorkerHomeCountryAddress obj = new WorkerHomeCountryAddress(workerFinNum, address, obseleteDate);
                        WorkerComplementsDAO.addWorkerHomeCountryAddress(obj);
                        //log the audit
                        auditChange = obj.toString2();
                        //success display
                        success = "Worker's Home Country Address has been succesfully added!";
                    } else {
                        int id = Integer.parseInt(request.getParameter("Id"));
                        WorkerHomeCountryAddress obj = new WorkerHomeCountryAddress(workerFinNum, 
                                        id, address,obseleteDate);
                        //update in the Database
                        WorkerComplementsDAO.updateWorkerHomeCountryAddress(obj);

                        //log the audit
                        auditChange = obj.toString2();
                        //success display
                        success = "Worker's Home Country Address has been succesfully updated!";
                    }
                }
            //=======================================//
            //          Digital Contacts  
            //=======================================//
            } else if (complementName.equals("WorkerDigitalContact")) {

                //get all the parameters 
                String digitalType = "";
                String digitalTypeOther = "";
                String digitalDetail = "";
                String digitalOwner = "";
                String digitalRemark = "";
                String obseleteDateStr = "";
                java.sql.Date obseleteDate = null;
                
                if (idStr == null) {
                
                    digitalType = request.getParameter("nDigitalContactType");
                    digitalTypeOther = request.getParameter("nDigitalMore");
                    digitalDetail = request.getParameter("nDigitalDetails");
                    digitalOwner = request.getParameter("nDigitalOwner");
                    digitalRemark = request.getParameter("nRemark");
                    obseleteDateStr = request.getParameter("nObseleteDate");
                
                } else {
                    digitalType = request.getParameter("digitalContactType");
                    digitalTypeOther = request.getParameter("digitalMore");
                    digitalDetail = request.getParameter("digitalDetails");
                    digitalOwner = request.getParameter("digitalOwner");
                    digitalRemark = request.getParameter("remark");
                    obseleteDateStr = request.getParameter("obseleteDate"); 
                }
                
                /**Server Validation**/
                boolean pass = true; //assume validation pass first;
                
                if (digitalType.equals("")) {
                    errorMsg += "Digital Type is blank,";
                    pass = false;
                }
                if (digitalDetail.equals("")) {
                    errorMsg += "Digital Details is blank,";
                    pass = false;
                }

                //proceed only after empty fields validation is passed
                if (pass) { 

                    if (!digitalTypeOther.equals("") && digitalTypeOther.length()>50) {
                        errorMsg += "Explain if other must not exceed 50 characters, ";
                    }

                    if (digitalDetail.length() > 50) {
                        errorMsg += "Digital Details must not exceed 50 characters, ";
                    }

                    if (!digitalOwner.equals("") && digitalOwner.length() > 50) {
                        errorMsg += "Digital Owner must not exceed 50 characters, ";
                    }

                    if (!digitalRemark.equals("") && digitalRemark.length() > 200) {
                        errorMsg += "Digital Remark must not exceed 200 characters, ";
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
                
                if (errorMsg.equals("")) {
                    if (idStr == null) {
                        //create object
                        WorkerDigitalContact obj = new WorkerDigitalContact(workerFinNum, digitalType,
                                digitalTypeOther, digitalDetail, digitalOwner, digitalRemark, obseleteDate);

                        //add into db
                        WorkerComplementsDAO.addWorkerDigitalContact(obj);
                        //log the audit
                        auditChange = obj.toString2();
                        //success display
                        success = "Worker's Digital Contact has been succesfully added!";
                    } else {
                       int id = Integer.parseInt(request.getParameter("Id"));
                        WorkerDigitalContact obj = new WorkerDigitalContact(workerFinNum, id, digitalType,
                                digitalTypeOther, digitalDetail, digitalOwner, digitalRemark, obseleteDate);      

                        //update in the Database
                        WorkerComplementsDAO.updateWorkerDigitalContact(obj);

                        //log the audit
                        auditChange = obj.toString2();
                        //success display
                        success = "Worker's Digital Contact has been successfully updated!";
                    }
                } 
            //=======================================//
            //          Next of Kin  
            //=======================================//
            } else if (complementName.equals("WorkerNextOfKin")) {

                //get all the parameters for next of kin
                String name = "";
                String relation = "";
                String phNum = "";
                String digitalContact = "";
                String docReference = "";
                String address = "";
                String proofDoc = "";
                String remark = "";
                String obseleteDateStr = "";
                java.sql.Date obseleteDate = null;
                
                if (idStr == null) {
                    name = request.getParameter("nName");
                    relation = request.getParameter("nRelation");
                    phNum = request.getParameter("nNOKPhNum");
                    digitalContact = request.getParameter("nDigitalContact");
                    docReference = request.getParameter("nDocReference");
                    address = request.getParameter("nNOKAddress");
                    proofDoc = request.getParameter("nProofDoc");
                    remark = request.getParameter("nRemark");
                    obseleteDateStr = request.getParameter("nObseleteDate");
                } else {
                    name = request.getParameter("name");
                    relation = request.getParameter("relation");
                    phNum = request.getParameter("nokphNum");
                    digitalContact = request.getParameter("digitalContact");
                    docReference = request.getParameter("docReference");
                    address = request.getParameter("nokaddress");
                    proofDoc = request.getParameter("proofDoc");
                    remark = request.getParameter("remark");
                    obseleteDateStr = request.getParameter("obseleteDate");
                }
                
                /**Server Validation**/
                boolean pass = true; //assume validation pass first;
                if (name.equals("")) {
                    errorMsg += "Next of Kin name is blank,";
                    pass = false;
                }

                //proceed only after empty fields validation is passed
                if (pass) { 

                    if (name.length() > 50) {
                        errorMsg += "Next of Kin name must not exceed 50 characters, ";
                    }

                    if (!docReference.equals("") && docReference.length()>200) {
                        errorMsg += "Doc Referece must not exceed 200 characters, ";
                    }

                    if (!relation.equals("") && relation.length() > 50) {
                        errorMsg += "Relation must not exceed 50 characters, ";
                    }
                    
                    if (!phNum.equals("") && !phNum.matches("^[\\d\\(\\-\\s\\)+]+$")) {
                        errorMsg += "Phone number - invalid format, ";
                    }

                    if (!digitalContact.equals("") && digitalContact.length() > 200) {
                        errorMsg += "Digital Contact must not exceed 200 characters, ";
                    }

                    if (!address.equals("") && address.length() > 200) {
                        errorMsg += "Address must not exceed 200 characters, ";
                    }

                    if (!proofDoc.equals("") && proofDoc.length() > 200) {
                        errorMsg += "Proof Document must not exceed 200 characters, ";
                    }

                    if (!remark.equals("") && remark.length() > 200) {
                        errorMsg += "Remark must not exceed 200 characters, ";
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
                
                if (errorMsg.equals("")) {
                    if (idStr == null) {
                        //create object
                        WorkerNextOfKin obj = new WorkerNextOfKin(workerFinNum, name,
                                relation, docReference, phNum, digitalContact, address,
                                proofDoc, remark, obseleteDate);
                        WorkerComplementsDAO.addWorkerNextOfKin(obj);
                        //log the audit
                        auditChange = obj.toString2();
                        //success
                        success = "Worker's Next of Kin has been successfully added!";
                    } else {
                        int id = Integer.parseInt(request.getParameter("Id"));
                        //create object
                        WorkerNextOfKin obj = new WorkerNextOfKin(workerFinNum, id, name,
                                relation, docReference ,phNum, digitalContact, address, 
                                proofDoc, remark, obseleteDate);
                        WorkerComplementsDAO.updateWorkerNextOfKin(obj);
                        //log the audit
                        auditChange = obj.toString2();
                        //success
                        success = "Worker's Next of Kin has been successfully updated!";
                    }
                }
            //=======================================//
            //          Family Members   
            //=======================================//                
            } else if (complementName.equals("WorkerFamilyMember")) {

                //get all the parameters for next of kin
                String name = "";
                String relation = "";
                String address = "";
                String phNum = "";
                String digitalContact = "";
                String remark = "";
                String obseleteDateStr = "";
                java.sql.Date obseleteDate = null;
                
                if (idStr == null) {
                    name = request.getParameter("nName");
                    relation = request.getParameter("nRelation");
                    address = request.getParameter("nFamilyAddress");
                    phNum = request.getParameter("nFamilyPhNum");
                    digitalContact = request.getParameter("nDigitalContact");
                    remark = request.getParameter("nRemark");
                    obseleteDateStr = request.getParameter("nObseleteDate");
                } else {
                    name = request.getParameter("name");
                    relation = request.getParameter("relation");
                    address = request.getParameter("familyAddress");
                    phNum = request.getParameter("familyphNum");
                    digitalContact = request.getParameter("digitalContact");
                    remark = request.getParameter("remark");
                    obseleteDateStr = request.getParameter("obseleteDate");
                }

                boolean pass = true; //assume validation pass first;

                if (name.equals("")) {
                    errorMsg += "name is blank,";
                    pass = false;
                }

                //proceed only after empty fields validation is passed
                if (pass) { 

                    if (name.length() > 50) {
                        errorMsg += "name must not exceed 50 characters, ";
                    }

                    if (!relation.equals("") && relation.length()>50) {
                        errorMsg += "Relation must not exceed 50 characters, ";
                    }

                    if (address != null && 
                            !address.equals("") && address.length() > 20) {
                        errorMsg += "Is family member in singapore must not exceed 20 characters, ";
                    }
                    
                    if (!phNum.equals("") && !phNum.matches("^[\\d\\(\\-\\s\\)+]+$")) {
                        errorMsg += "Phone Number - invalid format, ";
                    }

                    if (!digitalContact.equals("") && digitalContact.length() > 200) {
                        errorMsg += "digital Contact must not exceed 200 characters, ";
                    }

                    if (!remark.equals("") && remark.length() > 200) {
                        errorMsg += "Remark must not exceed 200 characters, ";
                    }

                    if (!obseleteDateStr.equals("")) {
                        try {
                            java.util.Date tmp = sdf.parse(obseleteDateStr);
                            obseleteDate = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                            errorMsg += "Invalid Obselete Date Format,";
                        } 
                    }
                } //pass    
                if (errorMsg.equals("")) {
                    if (idStr == null) {
                        //add into db                //create object
                        WorkerFamilyMember obj = new WorkerFamilyMember(workerFinNum, name,
                                relation, address, phNum, digitalContact, remark, obseleteDate);
                        WorkerComplementsDAO.addWorkerFamilyMember(obj);
                        //log the audit
                        auditChange = obj.toString2();
                        //success
                        success = "Worker's Family Member has been successfully updated!";
                    } else {
                        int id = Integer.parseInt(request.getParameter("Id"));
                        WorkerFamilyMember obj = new WorkerFamilyMember(workerFinNum, id, name,
                                relation, address,phNum, digitalContact, remark, obseleteDate);                    
                        //update in the Database
                        WorkerComplementsDAO.updateWorkerFamilyMember(obj);

                        //log the audit
                        auditChange = obj.toString2();
                        //success
                        success = "Worker's Family Member has been successfully updated!";
                    }
                } 
            //=======================================//
            //          Friends In Singapore 
            //=======================================//               
            } else if (complementName.equals("WorkerFriend")) {

                //get all the parameters for next of kin
                String name = "";
                String relation = "";
                String phNum = "";
                String remark = "";
                String obseleteDateStr = "";
                java.sql.Date obseleteDate = null;
                if (idStr == null) {
                    name = request.getParameter("nName");
                    relation = request.getParameter("nRelation");
                    phNum = request.getParameter("nFriendPhNum");
                    remark = request.getParameter("nRemark");
                    obseleteDateStr = request.getParameter("nObseleteDate");
                } else {
                    name = request.getParameter("name");
                    relation = request.getParameter("relation");
                    phNum = request.getParameter("friendPhNum");
                    remark = request.getParameter("remark");
                    obseleteDateStr = request.getParameter("obseleteDate");
                }
                
                boolean pass = true; //assume validation pass first;
                if (name.equals("")) {
                    errorMsg += "name is blank,";
                    pass = false;
                }

                //proceed only after empty fields validation is passed
                if (pass) { 

                    if (name.length() > 50) {
                        errorMsg += "name must not exceed 50 characters, ";
                    }

                    
                    if (!phNum.equals("") && !phNum.matches("^[\\d\\(\\-\\s\\)+]+$")) {
                        errorMsg += "Phone Number - invalid format, ";
                    }

                    if (!relation.equals("") && relation.length() > 50) {
                        errorMsg += "Relation must not exceed 50 characters, ";
                    }

                    if (!remark.equals("") && remark.length() > 200) {
                        errorMsg += "Remark must not exceed 200 characters, ";
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

                if (errorMsg.equals("")) {
                    if (idStr == null) {
                        //add into db                //create object
                        WorkerFriend obj = new WorkerFriend(workerFinNum, name,
                                phNum, relation, remark, obseleteDate);
                        WorkerComplementsDAO.addWorkerFriend(obj);
                        //log the audit
                        auditChange = obj.toString2();
                        //success display
                        success = "Worker's Friend record has been succesfully added!";
                    } else {
                        int id = Integer.parseInt(request.getParameter("Id"));
                        WorkerFriend obj = new WorkerFriend(workerFinNum, id, name,
                                phNum, relation, remark, obseleteDate);
                        WorkerComplementsDAO.updateWorkerFriend(obj);

                        //log the audit
                        auditChange = obj.toString2();
                        //succes display
                        success = "Worker's Friend record has been succesfully updated!";
                    }
                }
            //=======================================//
            //          Language 
            //=======================================//
            } else if (complementName.equals("WorkerLanguage")) {

                //get all the parameters for next of kin
                String mainLanguage = "";
                String languageMore = "";
                String englishStandard = "";
                String remark = "";
                
                if (idStr == null) {
                    mainLanguage = request.getParameter("nMainLanguage");
                    languageMore = request.getParameter("nLanguageMore");
                    englishStandard = request.getParameter("nEnglishStandard");
                    remark = request.getParameter("nRemark");
                } else {
                    mainLanguage = request.getParameter("mainLanguage");
                    languageMore = request.getParameter("languageMore");
                    englishStandard = request.getParameter("englishStandard");
                    remark = request.getParameter("remark");
                }
                
                boolean pass = true; //assume validation pass first;
                if (mainLanguage.equals("")) {
                    errorMsg += "Language is blank,";
                    pass = false;
                }

                //proceed only after empty fields validation is passed
                if (pass) { 

                    if (!languageMore.equals("") && languageMore.length() > 50) {
                        errorMsg += "Explain if other must not exceed 50 characters, ";
                    }

                    if (!remark.equals("") && remark.length() > 200) {
                        errorMsg += "Remark must not exceed 200 characters, ";
                    }

                }   //pass 
                if (errorMsg.equals("")) {
                    if (idStr == null) {
                        //add into db                //create object
                        WorkerLanguage obj = new WorkerLanguage(workerFinNum, mainLanguage,
                                languageMore, englishStandard, remark);
                        WorkerComplementsDAO.addWorkerLanguage(obj);
                        //log the audit
                        auditChange = obj.toString2();
                        //success display
                        success = "Worker's Language has been succesfully added!";
                    } else {
                        int id = Integer.parseInt(request.getParameter("Id"));
                        WorkerLanguage obj = new WorkerLanguage(workerFinNum,id, mainLanguage,
                                languageMore, englishStandard, remark);
                        WorkerComplementsDAO.updateWorkerLanguage(obj);

                        //log the audit
                        auditChange = obj.toString2();
                        //success
                        success = "Worker's Language has been succesfully updated!";
                    }
                }
            //=======================================//
            //          Bank Account Details  
            //=======================================//
            } else if (complementName.equals("WorkerBankAcct")) {
                //get all the parameters for next of kin
                String bankAcctName = "";
                String bankAcctNum = "";
                String bankName = "";
                String bankBranch = "";
                String bankBranchAddress = "";
                String bankBranchCode = "";
                String bankSwift = "";
                String remark = "";
                String obseleteDateStr = "";
                java.sql.Date obseleteDate = null;
                
                if (idStr == null) {
                    bankAcctName = request.getParameter("nBankAcctName");
                    bankAcctNum = request.getParameter("nBankAcctNum");
                    bankName = request.getParameter("nBankName");
                    bankBranch = request.getParameter("nBankBranch");
                    bankBranchAddress = request.getParameter("nBankBranchAddress");
                    bankBranchCode = request.getParameter("nBankBranchCode");
                    bankSwift = request.getParameter("nBankSwift");
                    remark = request.getParameter("nRemark");
                    obseleteDateStr = request.getParameter("nObseleteDate");
                } else {
                    bankAcctName = request.getParameter("bankAcctName");
                    bankAcctNum = request.getParameter("bankAcctNum");
                    bankName = request.getParameter("bankName");
                    bankBranch = request.getParameter("bankBranch");
                    bankBranchAddress = request.getParameter("bankBranchAddress");
                    bankBranchCode = request.getParameter("bankBranchCode");
                    bankSwift = request.getParameter("bankSwift"); 
                    remark = request.getParameter("remark");
                    obseleteDateStr = request.getParameter("obseleteDate");
                }
                
                //**Server Validaiton**//
                boolean pass = true; //assume validation pass first;

                if (bankAcctName.equals("")) {
                    errorMsg += "bank Account name is blank,";
                    pass = false;
                }

                if (bankAcctNum.equals("")) {
                    errorMsg += "bank account num is blank,";
                    pass = false;
                }

                if (bankName.equals("")) {
                    errorMsg += "bank name is blank,";
                    pass = false;
                }

                //proceed only after empty fields validation is passed
                if (pass) { 

                    if (bankAcctName.length() > 50) {
                        errorMsg += "bank account name must not exceed 50 characters, ";
                    }

                    if (bankAcctNum.length() > 50) {
                        errorMsg += "bank account number must not exceed 50 characters, ";
                    }

                    if (bankName.length() > 50) {
                        errorMsg += "bank name must not exceed 50 characters, ";
                    }

                    if (!bankBranch.equals("") && bankBranch.length() > 50) {
                        errorMsg += "bank branch must not exceed 50 characters, ";
                    }

                    if (!bankBranchAddress.equals("") && bankBranchAddress.length() > 300) {
                        errorMsg += "bank branch address must not exceed 300 characters, ";
                    }

                    if (!bankBranchCode.equals("") && bankBranchCode.length() > 50) {
                        errorMsg += "bank branch code must not exceed 50 characters, ";
                    }

                    if (!bankSwift.equals("") && bankSwift.length() > 50) {
                        errorMsg += "bank swift must not exceed 50 characters, ";
                    }

                    if (!remark.equals("") && remark.length() > 200) {
                        errorMsg += "remark must not exceed 200 characters, ";
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

                if (errorMsg.equals("")){
                    if (idStr == null) {
                        //create object
                        WorkerBankAcct obj = new WorkerBankAcct(workerFinNum, bankAcctName,
                                bankAcctNum, bankName, bankBranch, bankBranchAddress,
                                bankBranchCode, bankSwift, remark, obseleteDate);
                        WorkerComplementsDAO.addWorkerBankAccountDetails(obj);

                        //log the audit
                        auditChange = obj.toString2();
                        //success display
                        success = "Worker's Bank Account Details has been succesfully added!";
                    } else {
                        int id = Integer.parseInt(request.getParameter("Id"));
                        //create object
                        WorkerBankAcct obj = new WorkerBankAcct(workerFinNum, id, bankAcctName,
                                bankAcctNum, bankName,bankBranch, bankBranchAddress,
                                bankBranchCode,bankSwift , remark,obseleteDate);                    
                        WorkerComplementsDAO.updateWorkerBankAccountDetails(obj);

                        //log the audit
                        auditChange = obj.toString2();
                        //success display
                        success = "Worker's Bank Account Details has been succesfully updated!";
                    }
                }
            }
            
            if (errorMsg.equals("")) {
                //log to audit

                if (idStr == null) {
                    action = "Added";
                } else {
                    action = "Edited";
                }

                UserAuditLog userAuditLog = new UserAuditLog(_user.getUsername(), workerFinNum, 
                        workerFinNum, action, auditChange + " has been " + action.toLowerCase() + 
                                "ed to worker " + workerFinNum + ".");

                UserAuditLogDAO.addUserAuditLog(userAuditLog);  
            }
            request.getSession().setAttribute("successWrkCompMsg", success);
            request.getSession().setAttribute("errorWrkCompMsg", errorMsg);
            request.getSession().setAttribute("worker",workerFinNum);
            request.getSession().setAttribute("selectedJob",jobKeyStr);
            request.getSession().setAttribute("selectedProb",probKeyStr);
            
            if (isAssociate != null) {
                response.sendRedirect("associate/caseSummary.jsp");
            } else {
                response.sendRedirect("viewWorker.jsp");
            }
            
        } catch (Exception e) {
            //error = "Worker Complement is not added. There is a parsing error.";
            //log to logfile
            out.println(e);
            
        } finally {
            out.close();
        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP
     * <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ParseException ex) {
            Logger.getLogger(processAddWorkerComplement.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP
     * <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ParseException ex) {
            Logger.getLogger(processAddWorkerComplement.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
