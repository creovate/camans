/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.controller;

import camans.dao.*;
import camans.entity.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
/**
 *
 * @author Nyein Su
 */
public class processAddJobComplement extends HttpServlet {

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
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            String complementName = request.getParameter("complementName");
            String workerFinNum = request.getParameter("workerFinNum");
            int jobKey = Integer.parseInt(request.getParameter("jobkey"));
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
            
            User _user = (User) request.getSession().getAttribute("userLogin");
            String auditChange = "";
            String idStr = request.getParameter("Id");
            String action = "";
            
            //to keep track of selected problem
            String probKeyStr = request.getParameter("selectedProb");
            
            //=======================================//
            //   Server Side Validation Parameters
            //=======================================//
            String errorMsg = ""; //to store error msg
            String success = "";//to store success msgf
            
            /*Job Pass Details*/
            if (complementName.equals("JobPassDetails")) {

                //get all the parameters for passport
                String passType = "";
                String passTypeMore = "";
                String passNum = "";
                String issuer = "";
                String apDateStr = "";
                String isDateStr = "";
                String exDateStr = "";
                String remark = "";
                String obsoleteDateStr = "";
                java.sql.Date apDate = null;
                java.sql.Date isDate = null;
                java.sql.Date exDate = null;
                java.sql.Date obDate = null;
                if (idStr == null) {
                    passType = request.getParameter("npasstype");
                    passTypeMore = request.getParameter("npasstypeMore");
                    passNum = request.getParameter("npassno");
                    issuer = request.getParameter("nissuer");
                    apDateStr = request.getParameter("napdate");
                    isDateStr = request.getParameter("nisdate");
                    exDateStr = request.getParameter(("nexdate"));
                    remark = request.getParameter("nremark");
                    obsoleteDateStr = request.getParameter("nobsoleteDate");
                } else {
                    passType = request.getParameter("passtype");
                    passTypeMore = request.getParameter("passtypeMore");
                    passNum = request.getParameter("passno");
                    issuer = request.getParameter("issuer");
                    apDateStr = request.getParameter("apdate");
                    isDateStr = request.getParameter("isdate");
                    exDateStr = request.getParameter(("exdate"));
                    remark = request.getParameter("remark");
                    obsoleteDateStr = request.getParameter("obsoleteDate");
                }
                //**Server Validation**//
                boolean pass = true; //assume validation pass first;
                
                if (passType.equals("")) {
                    errorMsg += "Pass Type is blank,";
                    pass = false;
                }
                if (passNum.equals("")) {
                    errorMsg += "Pass Number is blank,";
                    pass = false;
                }

                //proceed only after empty fields validation is passed
                if (pass) { 
                    
                    if (!passTypeMore.equals("") && passTypeMore.length() > 255){
                        errorMsg += "Explain if above is other must not exceed 255 characters,";
                    }
                    
                    if (passNum.length() > 20) {
                        errorMsg += "Pass Number must not exceed 20 characters,";
                    }
                    if (!apDateStr.equals("")) {
                        try {
                            java.util.Date tmp = sdf.parse(apDateStr);
                            apDate = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                            errorMsg += "Invalid Pass Application Date Format,";
                        } 
                    }
                    
                    if (!isDateStr.equals("")) {
                        try {
                            java.util.Date tmp = sdf.parse(isDateStr);
                            isDate = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                            errorMsg += "Invalid Pass Issue Date Format,";
                        } 
                    }
                    
                    if (!exDateStr.equals("")) {
                        try {
                            java.util.Date tmp = sdf.parse(exDateStr);
                            exDate = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                            errorMsg += "Invalid Pass Expiry Date Format,";
                        } 
                    }
                    
                    if (!issuer.equals("") && issuer.length() > 20) {
                        errorMsg += "pass issuer must not exceed 20 characters,";
                    }
                    
                    if (!remark.equals("") && remark.length() > 200) {
                        errorMsg += "pass remark must not exceed 200 characters,";
                    }
                    
                    if (!obsoleteDateStr.equals("")) {
                        try {
                            java.util.Date tmp = sdf.parse(obsoleteDateStr);
                            obDate = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                            errorMsg += "Invalid Obselete Date Format,";
                        } 
                    }

                }   //pass 

                if (errorMsg.equals("")) {
                    if (idStr == null) {
                        //create new pass details
                        JobPassDetails passdetails = new JobPassDetails(workerFinNum, jobKey, passType, 
                                passTypeMore, passNum, apDate, isDate, exDate, issuer, remark, obDate);

                        //add into db
                        JobComplementsDAO.addJobPassDetails(passdetails);

                        //log the audit
                        auditChange = passdetails.toString2();
                        //successdisplay
                        success = "Worker Current Pass Details has been successfully added!";
                        
                    } else {
                        int id = Integer.parseInt(request.getParameter("Id"));

                        //create new pass details
                        JobPassDetails passdetails = new JobPassDetails(id, workerFinNum, jobKey, passType, 
                                passTypeMore, passNum, apDate, isDate, exDate, issuer, remark, obDate);

                        //update to db
                        JobComplementsDAO.updateJobPassDetails(passdetails);
                        //log the audit
                        auditChange = passdetails.toString2();
                        //successdisplay
                        success = "Worker Current Pass Details has been successfully updated!";
                    }
                
                }
             /* Employer Details */   
            } else if (complementName.equals("EmployerDetails")) {
                //get all the parameters
                String name = "";
                String person = "";
                String employerId = "";
                String contact = "";
                String remark = "";
                String address = "";
                if (idStr == null) {
                    name = request.getParameter("nname");
                    person = request.getParameter("nperson");
                    employerId = request.getParameter("nempid");
                    contact = request.getParameter("ncontact");
                    remark = request.getParameter("nremark");
                    address = request.getParameter("naddress");
                } else {
                    name = request.getParameter("name");
                    person = request.getParameter("person");
                    employerId = request.getParameter("empid");
                    contact = request.getParameter("contact");
                    remark = request.getParameter("remark");
                    address = request.getParameter("address");
                }
                //**Server Validation**//
                boolean pass = true; //assume validation pass first;
                if (name.equals("")) {
                    errorMsg += "Employer Name is blank,";
                    pass = false;
                }

                //proceed only after empty fields validation is passed
                if (pass) { 

                    if (name.length() > 50) {
                        errorMsg += "Employer Name must not exceed 50 characters,";
                    }

                    if (!employerId.equals("") && employerId.length() > 50) {
                        errorMsg += "Employer ID must not exceed 50 characters,";
                    }

                    if (!address.equals("") && address.length() > 200) {
                        errorMsg += "Employer Address must not exceed 200 characters,";
                    }

                    if (!contact.equals("") && contact.length() > 200) {
                        errorMsg += "Employer Contact must not exceed 200 characters,";
                    }

                    if (!person.equals("") && person.length() > 200) {
                        errorMsg += "Employer Person must not exceed 200 characters,";
                    }

                    if (!remark.equals("") && remark.length() > 200) {
                        errorMsg += "Remark must not exceed 200 characters,";
                    }


                }   //pass
                
                if (errorMsg.equals("")) {
                    if (idStr == null) {
                        JobEmployer employer = new JobEmployer(workerFinNum, jobKey, name, employerId, address,
                                contact, person, remark);

                        //add into db
                        JobComplementsDAO.addJobEmployer(employer);
                        //log the audit
                        auditChange = employer.toString2();
                        //successdisplay
                        success = "Worker Employer Details has been successfully added!";
                    } else {
                        int id = Integer.parseInt(request.getParameter("Id"));
                
                        JobEmployer employer = new JobEmployer(id, workerFinNum, jobKey, name, 
                                employerId, address, contact, person, remark);

                        //add into db
                        JobComplementsDAO.updateJobEmployer(employer);
                        //log the audit
                        auditChange = employer.toString2();
                        //successdisplay
                        success = "Worker Employer Details has been successfully updated!";
                    }
                }
            /* Contract Details */    
            } else if (complementName.equals("ContractDetails")) {
                //get all the parameters
                String shortName = "";
                String contractDateStr = "";
                String contractWhere = "";
                String contractOpName = "";
                String opRelation = "";
                String language = "";
                String occupation = "";
                String salary = "";
                String allowance ="";
                String deduction = "";
                String duress = "";
                String duration = "";
                String remark = "";
                java.sql.Date contractDate = null;
                if (idStr == null) {
                    shortName = request.getParameter("nname");
                    contractDateStr = request.getParameter("ncontdate");
                    contractWhere = request.getParameter("nlocation");
                    contractOpName = request.getParameter("nopname");
                    opRelation = request.getParameter("noprelation");
                    language = request.getParameter("nlanguage");
                    occupation = request.getParameter("noccupation");
                    salary = request.getParameter("nsalary");
                    allowance = request.getParameter("nallowance");
                    deduction = request.getParameter("ndeduction");
                    duress = request.getParameter("nduress");
                    duration = request.getParameter("nduration");
                    remark = request.getParameter("nremark");
                } else {
                    shortName = request.getParameter("name");
                    contractDateStr = request.getParameter("contdate");
                    contractWhere = request.getParameter("location");
                    contractOpName = request.getParameter("opname");
                    opRelation = request.getParameter("oprelation");
                    language = request.getParameter("language");
                    occupation = request.getParameter("occupation");
                    salary = request.getParameter("salary");
                    allowance = request.getParameter("allowance");
                    deduction = request.getParameter("deduction");
                    duress = request.getParameter("duress");
                    duration = request.getParameter("duration");
                    remark = request.getParameter("remark");
                }
                
                //Server Validation
                boolean pass = true; //assume validation pass first;

                if (contractDateStr.equals("")) {
                    errorMsg += "Contract Date is blank,";
                    pass = false;
                }

                //proceed only after empty fields validation is passed
                if (pass) { 

                    try {
                        java.util.Date tmp = sdf.parse(contractDateStr);
                        contractDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        errorMsg += "Invalid Contract Date Date Format,";
                    } 


                    if (!contractWhere.equals("") && contractWhere.length() > 200) {
                        errorMsg += "Contract Location must not exceed 200 characters,";
                    }

                    if (!language.equals("") && language.length() > 50) {
                        errorMsg += "Language must not exceed 50 characters,";
                    }

                    if (!contractOpName.equals("") && contractOpName.length() > 50) {
                        errorMsg += "Contract Oppoiste Name must not exceed 50 characters,";
                    }

                    if (!opRelation.equals("") && opRelation.length() > 200) {
                        errorMsg += "Relation must not exceed 200 characters,";
                    }

                    if (!occupation.equals("") && occupation.length() > 200) {
                        errorMsg += "Occupation must not exceed 200 characters,";
                    }

                    if (!salary.equals("") && salary.length() > 50) {
                        errorMsg += "Salary must not exceed 50 characters,";
                    }

                    if (!allowance.equals("") && allowance.length() > 500) {
                        errorMsg += "Allowance must not exceed 500 characters,";
                    }

                    if (!deduction.equals("") && deduction.length() > 500) {
                        errorMsg += "DEduction must not exceed 500 characters,";
                    }

                    if (!duration.equals("") && duration.length() > 20) {
                        errorMsg += "Duration must not exceed 20 characters,";
                    }

                    if (!duress.equals("") && duress.length() > 500) {
                        errorMsg += "Duress must not exceed 500 characters,";
                    }

                    if (!remark.equals("") && remark.length() > 200) {
                        errorMsg += "Remark must not exceed 200 characters,";
                    }

                }   //pass 

                if (errorMsg.equals("")) {
                    if (idStr == null) {
                        //create new compelment new JobEmployer( workerFinNum, nt jobKey,  employerOfficialName, String employerID,  employerAddress,  employerContacts,  employerPersons,  employerRemarks
                        JobEmploymentContract contract = new JobEmploymentContract(workerFinNum, jobKey, 
                                shortName, contractDate, contractWhere, language, contractOpName, 
                                opRelation, occupation, salary, allowance, deduction, duration, 
                                duress, remark);

                        //add into db
                        JobComplementsDAO.addJobEmploymentContract(contract);
                        //log the audit
                        auditChange = contract.toString2();
                        //successdisplay
                        success = "Employment contract has been successfully added!";
                        
                    } else {
                        int id = Integer.parseInt(request.getParameter("Id"));
                        JobEmploymentContract contract = new JobEmploymentContract(id, workerFinNum, 
                                jobKey, shortName, 
                                contractDate, contractWhere, language, contractOpName, 
                                opRelation, occupation, salary, allowance, deduction, 
                                duration, duress, remark);

                        //update in the db
                        JobComplementsDAO.updateJobEmploymentContract(contract);
                        //log the audit
                        auditChange = contract.toString2();
                        //successdisplay
                        success = "Employement contract has been successfully updated!";
                    }
                }
            /*Intermediary Agent */
            } else if (complementName.equals("Agent")) {
                //get all the parameters
                String agentCompany = "";
                String agentPersonName = "";
                String agentLocation = "";
                String agentlocationMore = "";
                String agentAddress = "";
                String agentContact = "";
                String agentAmtPaidStr = "";
                String agentAmtOwedStr = "";
                String agentFeeShared = "";
                String agentFeeTraining = "";
                String agentFeeAirfare = "";
                String agentFeeWhere = "";
                String agentFeeWhen = "";
                String agentFeeRepay = "";
                String agentEmployer = "";
                String agentRemarks = "";
                Double agentAmtPaid = 0.0;
                Double agentAmtOwed = 0.0;
                if (idStr == null) {
                    agentCompany = request.getParameter("ncompany");
                    agentPersonName = request.getParameter("nagperson");
                    agentLocation = request.getParameter("naglocation");
                    agentlocationMore = request.getParameter("naglocationMore");
                    agentAddress = request.getParameter("naddress");
                    agentContact = request.getParameter("ncontact");
                    agentAmtPaidStr = request.getParameter("namtpaid");
                    agentAmtOwedStr = request.getParameter("namtowed");
                    agentFeeShared = request.getParameter("nfeeshared");
                    agentFeeTraining = request.getParameter("nfeetraining");
                    agentFeeAirfare = request.getParameter("nfeeairfare");
                    agentFeeWhere = request.getParameter("nfeewhere");
                    agentFeeWhen = request.getParameter("nfeewhen");
                    agentFeeRepay = request.getParameter("nfeerepay");
                    agentEmployer = request.getParameter("nemp");
                    agentRemarks = request.getParameter("nagremark");
                } else {
                    agentCompany = request.getParameter("company");
                    agentPersonName = request.getParameter("agperson");
                    agentLocation = request.getParameter("aglocation");
                    agentlocationMore = request.getParameter("aglocationMore");
                    agentAddress = request.getParameter("address");
                    agentContact = request.getParameter("contact");
                    agentAmtPaidStr = request.getParameter("amtpaid");
                    agentAmtOwedStr = request.getParameter("amtowed");
                    agentFeeShared = request.getParameter("feeshared");
                    agentFeeTraining = request.getParameter("feetraining");
                    agentFeeAirfare = request.getParameter("feeairfare");
                    agentFeeWhere = request.getParameter("feewhere");
                    agentFeeWhen = request.getParameter("feewhen");
                    agentFeeRepay = request.getParameter("feerepay");
                    agentEmployer = request.getParameter("emp");
                    agentRemarks = request.getParameter("agremark");
                }
                boolean pass = true; //assume validation pass first;

                if (agentCompany.equals("")) {
                    errorMsg += "Agent Company is blank,";
                    pass = false;
                }

                //proceed only after empty fields validation is passed
                if (pass) { 

                    
                    if (agentCompany.length() > 50) {
                        errorMsg += "Agent company must not exceed 50 characters,";
                    }
                         
                    if (!agentPersonName.equals("") && agentPersonName.length() > 50) {
                        errorMsg += "Agent Person Name must not exceed 50 characters,";
                    }
                    
                    if (!agentlocationMore.equals("") && agentlocationMore.length() > 50) {
                        errorMsg += "Explain if above is other must not exceed 50 characters,";
                    }
                    
                    if (!agentAddress.equals("") && agentAddress.length() > 300) {
                        errorMsg += "Agent Address must not exceed 300 characters,";
                    }
                    
                    if (!agentContact.equals("") && agentContact.length() > 200) {
                        errorMsg += "Agent Contact must not exceed 200 characters,";
                    }
                    
                    
                    if (!agentAmtPaidStr.equals("")) {
                        agentAmtPaidStr = agentAmtPaidStr.replace(",","");
                        if (!agentAmtPaidStr.matches("^\\d+(\\.\\d{1,2})?$")) {
                            errorMsg += "Amount Paid must have maximum 2 decimal places,";
                        } else {
                            if (!agentAmtPaidStr.equals("")) {
                                try {
                                    agentAmtPaid = Double.parseDouble(agentAmtPaidStr);
                                } catch (Exception ex) {
                                    errorMsg += "Amount Paid - invalid format,";
                                }
                            }
                        }
                    }
                    
                    
                    if (!agentAmtOwedStr.equals("")) {
                        agentAmtOwedStr = agentAmtOwedStr.replace(",","");
                        if (!agentAmtOwedStr.matches("^\\d+(\\.\\d{1,2})?$")) {
                        errorMsg += "Agent Owed must have maximum 2 decimal places,";
                        } else {
                            if (!agentAmtOwedStr.equals("")) {
                                try {
                                    agentAmtOwed = Double.parseDouble(agentAmtOwedStr);
                                } catch (Exception ex) {
                                    errorMsg += "Agent Owed - invalid format,";
                                }
                            }
                        }
                    }
                    
                    if (agentFeeShared != null && !agentFeeShared.equals("") && agentFeeShared.length() > 200) {
                        errorMsg += "Agent Fee Shared must not exceed 200 characters,";
                    }
                    
                    if (agentFeeTraining != null && !agentFeeTraining.equals("") && agentFeeTraining.length() > 50) {
                        errorMsg += "Agent Fee Training must not exceed 50 characters,";
                    }
                    
                    if (agentFeeAirfare != null && !agentFeeAirfare.equals("") && agentFeeAirfare.length() > 50) {
                        errorMsg += "Agent Fee Airfare must not exceed 50 characters,";
                    }
                    
                    if (agentFeeWhen != null && !agentFeeWhen.equals("") && agentFeeWhen.length() > 50) {
                        errorMsg += "When Agent Fee paid must not exceed 50 characters,";
                    }
                    
                    if (agentFeeWhere != null && !agentFeeWhere.equals("") && agentFeeWhere.length() > 50) {
                        errorMsg += "Where Agent Field must not exceed 50 characters,";
                    }
                    
                    if (agentFeeRepay != null && !agentFeeRepay.equals("") && agentFeeRepay.length() > 200) {
                        errorMsg += "Agent Fee Repay must not exceed 200 characters,";
                    }
                    
                    if (agentEmployer != null && !agentEmployer.equals("") && agentEmployer.length() > 200) {
                        errorMsg += "Agent Employer must not exceed 200 characters,";
                    }
                    
                    if (agentRemarks != null && !agentRemarks.equals("") && agentRemarks.length() > 1000) {
                        errorMsg += "Agent Remarks must not exceed 1000 characters,";
                    }
                    
                }   //pass   
                
                if (errorMsg.equals("")) {
                    if (idStr == null) {
                        JobIntermediaryAgent agent = new JobIntermediaryAgent(workerFinNum, jobKey, agentCompany, 
                                agentPersonName, agentLocation, agentlocationMore, agentAddress, agentContact, 
                                agentAmtPaid, agentAmtOwed, agentFeeShared, agentFeeTraining, agentFeeAirfare, 
                                agentFeeWhere, agentFeeWhen, agentFeeRepay, agentEmployer, agentRemarks);
                        //add into db
                        JobComplementsDAO.addJobIntermediaryAgent(agent);
                        //log the audit
                        auditChange = agent.toString2();
                        //string
                        success = "Intermediary Agent has been successfully added!";
                    } else {
                        int id = Integer.parseInt(request.getParameter("Id"));

                        JobIntermediaryAgent agent = new JobIntermediaryAgent(id, workerFinNum, jobKey, 
                                agentCompany, agentPersonName, agentLocation, agentlocationMore, 
                                agentAddress, agentContact, agentAmtPaid, agentAmtOwed, agentFeeShared, 
                                agentFeeTraining, agentFeeAirfare, agentFeeWhere, agentFeeWhen, agentFeeRepay, agentEmployer, agentRemarks);
                        //add into db
                        JobComplementsDAO.updateJobIntermediaryAgent(agent);
                        //log the audit
                        auditChange = agent.toString2();
                        //success
                        success = "Intermediary Agent has been successfully updated!";
                    }
                } 
            /*Verbal Assurance of Previous Job */    
            } else if (complementName.equals("VerbalAssurance")) {
                //get all the parameters
                String verbalName = "";
                String VerbalRelationship = "";
                String when = "";
                String where = "";
                String content = "";
                if (idStr == null) {
                    verbalName = request.getParameter("nname");
                    VerbalRelationship = request.getParameter("nrelation");
                    when = request.getParameter("nvaWhen");
                    where = request.getParameter("nvaWhere");
                    content = request.getParameter("nvaContent");
                } else {
                    verbalName = request.getParameter("name");
                    VerbalRelationship = request.getParameter("relation");
                    when = request.getParameter("vaWhen");
                    where = request.getParameter("vaWhere");
                    content = request.getParameter("vaContent");
                }

                //Server validation
                boolean pass = true; //assume validation pass first;

                if (verbalName.equals("")) {
                    errorMsg += "verbalName  is blank,";
                    pass = false;
                }

                //proceed only after empty fields validation is passed
                if (pass) { 


                    if (verbalName.length() > 50){
                        errorMsg += " verbalName must not exceed 50 characters,";
                    }

                    if (!VerbalRelationship.equals("") && VerbalRelationship.length() > 200) {
                        errorMsg += "Relationship must not exceed 200 characters,";
                    }

                    if (when != null && !when.equals("") && when.length() > 50) {
                        errorMsg += "When discussed must not exceed 50 characters,";
                    }

                    if (where != null && !where.equals("") && where.length() > 50) {
                        errorMsg += "Where discusssed must not exceed 50 characters,";
                    }

                    if (content != null && !content.equals("") && content.length() > 1000) {
                        errorMsg += "Content must not exceed 1000 characters,";
                    }

                }   //pass 
                
                if (errorMsg.equals("")) {
                    if (idStr == null) {
                        //create new compelment new JobEmployer( workerFinNum, nt jobKey,  employerOfficialName, String employerID,  employerAddress,  employerContacts,  employerPersons,  employerRemarks
                        JobVerbalAssurance assurance = new JobVerbalAssurance(workerFinNum, jobKey, verbalName, VerbalRelationship, when, where, content);
                        //add into db
                        JobComplementsDAO.addJobVerbalAssurance(assurance);
                        //log the audit
                        auditChange = assurance.toString2();
                        //success
                        success = "Verbal Assurance has been successfully added!";
                    } else {
                        int id = Integer.parseInt(request.getParameter("Id"));
                
                        JobVerbalAssurance assurance = new JobVerbalAssurance(id, workerFinNum, jobKey, 
                                verbalName, VerbalRelationship, when, where, content);
                        //add into db
                        JobComplementsDAO.updateJobVerbalAssurance(assurance);

                        //log the audit
                        auditChange = assurance.toString2();
                        //success
                        success = "Verbal Assurance has been successfully updated!";
                    }
                } 
                
            /*Work Place Details*/    
            } else if (complementName.equals("WorkPlace")) {
                //get all the parameters of workplace
                String workplaceType = "";
                String workplaceTypeMore = "";
                String workplaceWhose = "";
                String workplacePerson = "";
                String workplaceRelationship = "";
                String workplaceDirect = "";
                String workplaceDirectMore = "";
                String workplaceStart = "";
                String workplaceEnd = "";
                String workplaceCondition = "";
                String workplaceSafety = "";
                String workplaceRemark = "";
                if (idStr == null) {
                    workplaceType = request.getParameter("nwpType");
                    workplaceTypeMore = request.getParameter("nwpTypeMore");
                    workplaceWhose = request.getParameter("nwhose");
                    workplacePerson = request.getParameter("npersonDetails");
                    workplaceRelationship = request.getParameter("nrelation");
                    workplaceDirect = request.getParameter("ndirect");
                    workplaceDirectMore = request.getParameter("ndirectMore");
                    workplaceStart = request.getParameter("nstart");
                    workplaceEnd = request.getParameter("nend");
                    workplaceCondition = request.getParameter("ncondition");
                    workplaceSafety = request.getParameter("nsafety");
                    workplaceRemark = request.getParameter("nremark");
                } else {
                    workplaceType = request.getParameter("wpType");
                    workplaceTypeMore = request.getParameter("wpTypeMore");
                    workplaceWhose = request.getParameter("whose");
                    workplacePerson = request.getParameter("personDetails");
                    workplaceRelationship = request.getParameter("relation");
                    workplaceDirect = request.getParameter("direct");
                    workplaceDirectMore = request.getParameter("directMore");
                    workplaceStart = request.getParameter("start");
                    workplaceEnd = request.getParameter("end");
                    workplaceCondition = request.getParameter("condition");
                    workplaceSafety = request.getParameter("safety");
                    workplaceRemark = request.getParameter("remark");
                }
                //Sever Validation
                boolean pass = true; //assume validation pass first;


                if (workplaceType.equals("")) {
                    errorMsg += "Work place Type is blank,";
                    pass = false;
                }

                if (workplaceDirect.equals("")) {
                    errorMsg += "Who direct is blank,";
                    pass = false;
                }

                //proceed only after empty fields validation is passed
                if (pass) { 

                    if (!workplaceTypeMore.equals("") && workplaceTypeMore.length() > 200) {
                        errorMsg += "Explain if above is other must not exceed 200 characters,";
                    }

                    if (!workplaceWhose.equals("") && workplaceWhose.length() > 50) {
                        errorMsg += "Whose workplace must not exceed 50 characters,";
                    }


                    if (!workplacePerson.equals("") && workplacePerson.length() > 200) {
                        errorMsg += "Person must not exceed 200 characters,";
                    }

                    if (!workplaceRelationship.equals("") && workplaceRelationship.length() > 50) {
                        errorMsg += "Relation must not exceed 50 characters,";
                    }

                    if (!workplaceDirectMore.equals("") && workplaceDirectMore.length() > 200) {
                        errorMsg += "Explain if above is other must not exceed 200 characters,";
                    }

                    if (!workplaceStart.equals("") && workplaceStart.length() > 50) {
                        errorMsg += "Start date must not exceed 50 characters,";
                    }

                    if (!workplaceEnd.equals("") && workplaceEnd.length() > 50) {
                        errorMsg += "End date must not exceed 50 characters,";
                    }

                    if (!workplaceCondition.equals("") && workplaceCondition.length() > 500) {
                        errorMsg += "Work place condition must not exceed 500 characters,";
                    }

                    if (!workplaceSafety.equals("") && workplaceSafety.length() > 200) {
                        errorMsg += "Workplace Safety must not exceed 50 characters,";
                    }

                    if (!workplaceRemark.equals("") && workplaceRemark.length() > 200) {
                        errorMsg += "Remark must not exceed 50 characters,";
                    }

                }   //pass 
                
                if (errorMsg.equals("")) {
                    if (idStr == null) {
                        //Create new workplace  , int , String workplaceType, String workplaceTypeMore, String workplaceWhose, String workpladePersons, String workplaceEmployerRelationship, String workplaceDirect, String workplaceDirectMore, String workplaceStart, String workplaceEnd, String workplaceCondition, String workplaceSafety, String workplaceRemarks)
                        JobWorkplace jobWorkplace = new JobWorkplace(workerFinNum, jobKey, workplaceType, 
                                workplaceTypeMore, workplaceWhose, workplacePerson, workplaceRelationship, 
                                workplaceDirect, workplaceDirectMore, workplaceStart, workplaceEnd, workplaceCondition, 
                                workplaceSafety, workplaceRemark);
                        //add to db
                        JobComplementsDAO.addJobWorkplace(jobWorkplace);
                        //log the audit
                        auditChange = jobWorkplace.toString2();
                        //success
                        success = "Work place has been successfully added!";
                    } else {
                        int id = Integer.parseInt(request.getParameter("Id"));
                        JobWorkplace jobWorkplace = new JobWorkplace(id, workerFinNum, jobKey, workplaceType, 
                                workplaceTypeMore, workplaceWhose, workplacePerson, 
                                workplaceRelationship, workplaceDirect, workplaceDirectMore, 
                                workplaceStart, workplaceEnd, workplaceCondition, workplaceSafety, workplaceRemark);
                        //add to db
                        JobComplementsDAO.updateJobWorkplace(jobWorkplace);
                        //log the audit
                        auditChange = jobWorkplace.toString2();
                        success = "Work place has been successfully updated!";
                    }
                }
                
            /*Work History */    
            } else if (complementName.equals("WorkHistory")) {
                //get parameters of workHistory
                String workHistHow = "";
                String workHistHowMore = "";
                String strHistDate = "";
                String workHistFirst = "";
                String workHistYearArrive = "";
                String workHistPreviousJob = "";
                String workHistPreviousProb = "";
                String workHistRemark = "";
                java.sql.Date histDate = null;
                if (idStr == null) {
                    workHistHow = request.getParameter("nhow");
                    workHistHowMore = request.getParameter("nhowMore");
                    strHistDate = request.getParameter("narrivalDate");
                    workHistFirst = request.getParameter("nisFirstJob");
                    workHistYearArrive = request.getParameter("narrivalYear");
                    workHistPreviousJob = request.getParameter("nprevJob");
                    workHistPreviousProb = request.getParameter("nprevProb");
                    workHistRemark = request.getParameter("nremark");
                } else {
                    workHistHow = request.getParameter("how");
                    workHistHowMore = request.getParameter("howMore");
                    strHistDate = request.getParameter("arrivalDate");
                    workHistFirst = request.getParameter("isFirstJob");
                    workHistYearArrive = request.getParameter("arrivalYear");
                    workHistPreviousJob = request.getParameter("prevJob");
                    workHistPreviousProb = request.getParameter("prevProb");
                    workHistRemark = request.getParameter("remark");
                }
                
                //Server Validation
                boolean pass = true; //assume validation pass first;

                if (workHistHow.equals("")) {
                    errorMsg += "How Work History is blank,";
                    pass = false;
                }

                //proceed only after empty fields validation is passed
                if (pass) { 


                    if (workHistHow.length() > 50) {
                        errorMsg += "How must not exceed 50 characters,";
                    }

                    if (!workHistHowMore.equals("") && workHistHowMore.length() > 200) {
                        errorMsg += "Explain if above is other must not exceed 200 characters,";
                    }

                    if (!strHistDate.equals("")) {
                        try {
                            java.util.Date tmp = sdf.parse(strHistDate);
                            histDate = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                            errorMsg += "Invalid Work History Date Format,";
                        } 
                    }


                    if (!workHistYearArrive.equals("")) {
                        try {
                            int tmp = Integer.parseInt(workHistYearArrive);
                        } catch (Exception ex) {
                            errorMsg += "Year Arrived must be a number,";
                        }
                    }

                    if (!workHistPreviousJob.equals("") && workHistPreviousJob.length() > 1000) {
                        errorMsg += "Previous Job must not exceed 1000 characters,";
                    }

                    if (!workHistPreviousProb.equals("") && workHistPreviousProb.length() > 1000) {
                        errorMsg += "Previous Problem must not exceed 1000 characters,";
                    }

                    if (!workHistRemark.equals("") && workHistRemark.length() > 200) {
                        errorMsg += "Remark must not exceed 200 characters,";
                    }

                }   //pass 

                if (errorMsg.equals("")) {
                    if (idStr == null) {
                        //create new JobWorkHistory
                        JobWorkHistory hist = new JobWorkHistory(workerFinNum, jobKey, workHistHow, workHistHowMore, 
                                histDate, workHistFirst, workHistYearArrive, workHistPreviousJob, workHistPreviousProb, 
                                workHistRemark);
                        JobComplementsDAO.addJobWorkHistory(hist);
                        //log the audit
                        auditChange = hist.toString2();
                        //success
                        success = "Work History has been successfully added!";
                    } else {
                         int id = Integer.parseInt(request.getParameter("Id"));
                        //create new JobWorkHistory
                        JobWorkHistory hist = new JobWorkHistory(id, workerFinNum, jobKey, workHistHow, 
                                workHistHowMore, histDate, workHistFirst, workHistYearArrive, 
                                workHistPreviousJob, workHistPreviousProb, workHistRemark);


                        // update to db
                        JobComplementsDAO.updateJobWorkHistory(hist);
                        //log the audit
                        auditChange = hist.toString2();
                        //success
                        success = "Work History has been successfully updated!";
                    }
                }
                
            /*Accommodation During Work */            
            } else if (complementName.equals("Accommodation")) {

                //get parameters for Accomodation
                String accProvided = "";
                String accProvidedMore = "";
                String accType = "";
                String accTypeMore = "";
                String accLocation = "";
                String accCondition = "";
                String accChargedStr = "";
                String accPaidStr = "";
                String accMeal = "";
                String accStart = "";
                String accEnd = "";
                String accRemark = "";
                double accCharged = 0.0;
                double accPaid = 0.0;
                
                if (idStr == null) {
                    accProvided = request.getParameter("nisProvided");
                    accProvidedMore = request.getParameter("nisProvidedMore");
                    accType = request.getParameter("ntype");
                    accTypeMore = request.getParameter("ntypeMore");
                    accLocation = request.getParameter("nlocationAccom");
                    accCondition = request.getParameter("ncondition");
                    accChargedStr = request.getParameter("naccCharged");
                    accPaidStr = request.getParameter("naccPaid");
                    accMeal = request.getParameter("nmeal");
                    accStart = request.getParameter("nfrom");
                    accEnd = request.getParameter("nto");
                    accRemark = request.getParameter("nremark");
                } else {
                    accProvided = request.getParameter("isProvided");
                    accProvidedMore = request.getParameter("isProvidedMore");
                    accType = request.getParameter("type");
                    accTypeMore = request.getParameter("typeMore");
                    accLocation = request.getParameter("locationAccom");
                    accCondition = request.getParameter("condition");
                    accChargedStr = request.getParameter("accCharged");
                    accPaidStr = request.getParameter("accPaid");
                    accMeal = request.getParameter("meal");
                    accStart = request.getParameter("from");
                    accEnd = request.getParameter("to");
                    accRemark = request.getParameter("remark");
                }
                
                //server validation
                 boolean pass = true; //assume validation pass first;

                if (accProvided.equals("")) {
                    errorMsg += "Accomodation Provided is blank,";
                    pass = false;
                }

                //proceed only after empty fields validation is passed
                if (pass) { 

                    if (accProvidedMore != null & !accProvidedMore.equals("") && accProvidedMore.length() > 200) {
                        errorMsg += "Provided Other must not exceed 200 characters,";
                    }


                    if (accTypeMore != null && !accTypeMore.equals("") && accTypeMore.length() > 300) {
                        errorMsg += "Explain if above is other must not exceed 300 characters,";
                    }

                    if (accLocation != null && !accLocation.equals("") && accLocation.length() > 200) {
                        errorMsg += "Location must not exceed 200 characters,";
                    }

                    if (accCondition != null && !accCondition.equals("") && accCondition.length() > 500) {
                        errorMsg += "Condition must not exceed 500 characters,";
                    }
                    
                    if (accChargedStr != null && !accChargedStr.equals("")) {
                        accChargedStr = accChargedStr.replace(",", "");
                        if (!accChargedStr.matches("^\\d+(\\.\\d{1,2})?$")) {
                            errorMsg += "Amount Charged must have maximum 2 decimal places,";
                        } else {
                            if (!accChargedStr.equals("")) {
                                try {
                                    accCharged = Double.parseDouble(accChargedStr);
                                } catch (Exception ex) {
                                    errorMsg += "Amount Charged - invalid format,";
                                }
                            }
                        }
                    }
                    
                    if (accPaidStr != null && !accPaidStr.equals("")) {
                        accPaidStr = accPaidStr.replace(",","");
                        if (!accPaidStr.matches("^\\d+(\\.\\d{1,2})?$")) {
                            errorMsg += "Self paid amount must have maximum 2 decimal places,";
                        } else {
                            if (!accPaidStr.equals("") ) {
                                try {
                                    accPaid = Double.parseDouble(accPaidStr);
                                } catch (Exception ex) {
                                    errorMsg += "Self paid amount - invalid format,";
                                }
                            }
                        }
                    }

                    if (accMeal != null && !accMeal.equals("") && accMeal.length() > 200) {
                        errorMsg += "meal must not exceed 200 characters,";
                    }

                    if (accStart != null && !accStart.equals("") && accStart.length() > 50) {
                        errorMsg += "start date must not exceed 50 characters,";
                    }

                    if (accEnd != null && !accEnd.equals("") && accEnd.length() > 50) {
                        errorMsg += "end date must not exceed 50 characters,";
                    }

                    if (accRemark != null && !accRemark.equals("") && accRemark.length() > 200) {
                        errorMsg += "remark must not exceed 200 characters,";
                    }


                }   //pass 
                if (errorMsg.equals("")) {    
                    
                    if (idStr == null) {
                        //create new JobAccomodation
                        JobAccomodation accomodation = new JobAccomodation(workerFinNum, jobKey, accProvided,
                                accProvidedMore, accType, accTypeMore, accLocation, accCondition, accCharged, 
                                accPaid, accMeal, accStart, accEnd, accRemark);

                        //add to db
                        JobComplementsDAO.addJobAccomodation(accomodation);
                        //log the audit
                        auditChange = accomodation.toString2();
                        //success
                        success = "Work Accomodation has been successfully added!";
                    } else {
                        int id = Integer.parseInt(request.getParameter("Id"));
                        //create new JobAccomodation
                        JobAccomodation accomodation = new JobAccomodation(id, workerFinNum, jobKey, 
                                accProvided, accProvidedMore, accType, accTypeMore, accLocation, 
                                accCondition, accCharged, accPaid, accMeal, accStart, accEnd, accRemark);
                        //add to db
                        JobComplementsDAO.updateJobAccomodation(accomodation);  
                        //log the audit
                        auditChange = accomodation.toString2();
                        //success
                        success = "Work Accomodation has been successfully updated!";
                    }
                }
            /*IPA Details */    
            } else if (complementName.equals("IPA")) {
                //get parameters from IPA
                String ipaPassType = "";
                String ipaPassTypeMore = "";
                String ipaDateStr = "";
                String ipaEmpName = "";
                String ipaAgentName = "";
                String ipaIndustry = "";
                String ipaOccupation = "";
                String ipaPeriodsStr = "";
                String ipaBasicSalaryStr = "";
                String ipaTotalAllowanceStr = "";
                String ipaTotalAllowanceDetails = "";
                String ipaDeductionStr = "";
                String ipaDeductionDetails = "";
                String ipaHousingProvided = "";
                String ipaRemark = "";
                double ipaBasicSalary = 0.0;
                double ipaTotalAllowance = 0.0;
                double ipaDeduction = 0.0;
                double ipaPeriods = 0.0;
                java.sql.Date ipaDate = null;
                if (idStr == null) {
                    ipaPassType = request.getParameter("nworkpassType");
                    ipaPassTypeMore = request.getParameter("nworkpassTypeMore");
                    ipaDateStr = request.getParameter("nappDate");
                    ipaEmpName = request.getParameter("nempName");
                    ipaAgentName = request.getParameter("nagentName");
                    ipaIndustry = request.getParameter("nindustry");
                    ipaOccupation = request.getParameter("nipaoccupation");
                    ipaPeriodsStr = request.getParameter("nperiods");
                    ipaBasicSalaryStr = request.getParameter("nbasicSalary");
                    ipaTotalAllowanceStr = request.getParameter("ntotalAllowance");
                    ipaTotalAllowanceDetails = request.getParameter("nallowanceDetails");
                    ipaDeductionStr = request.getParameter("ntotalDeduction");
                    ipaDeductionDetails = request.getParameter("ndeductionDetails");
                    ipaHousingProvided = request.getParameter("nisHousingProvided");
                    ipaRemark = request.getParameter("nremark");
                } else {
                    ipaPassType = request.getParameter("workpassType");
                    ipaPassTypeMore = request.getParameter("workpassTypeMore");
                    ipaDateStr = request.getParameter("appDate");
                    ipaEmpName = request.getParameter("empName");
                    ipaAgentName = request.getParameter("agentName");
                    ipaIndustry = request.getParameter("industry");
                    ipaOccupation = request.getParameter("ipaoccupation");
                    ipaPeriodsStr = request.getParameter("periods");
                    ipaBasicSalaryStr = request.getParameter("basicSalary");
                    ipaTotalAllowanceStr = request.getParameter("totalAllowance");
                    ipaTotalAllowanceDetails = request.getParameter("nallowanceDetails");
                    ipaDeductionStr = request.getParameter("totalDeduction");
                    ipaDeductionDetails = request.getParameter("deductionDetails");
                    ipaHousingProvided = request.getParameter("isHousingProvided");
                    ipaRemark = request.getParameter("remark");
                }
                
                //server validation
                boolean pass = true; //assume validation pass first;

                if (ipaPassType.equals("")) {
                    errorMsg += "IPA Pass Type is blank,";
                    pass = false;
                }

                //proceed only after empty fields validation is passed
                if (pass) { 

                    if (!ipaPassTypeMore.equals("") && ipaPassTypeMore.length() > 50){
                        errorMsg += "Explain if above is other must not exceed 50 characters,";
                    }

                    if (!ipaDateStr.equals("")) {
                        try {
                            java.util.Date tmp = sdf.parse(ipaDateStr);
                            ipaDate = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                            errorMsg += "Invalid IPA Application Date Format,";
                        } 
                    }

                    if (!ipaEmpName.equals("") && ipaEmpName.length() > 50) {
                        errorMsg += "Employer Name must not exceed 50 characters,";
                    }

                    if (!ipaAgentName.equals("") && ipaAgentName.length() > 50) {
                        errorMsg += "Agent Name must not exceed 50 characters,";
                    }

                    if (!ipaIndustry .equals("") && ipaIndustry.length() > 50) {
                        errorMsg += "Industry must not exceed 50 characters,";
                    }

                    if (!ipaOccupation .equals("") && ipaOccupation.length() > 30) {
                        errorMsg += "Occupation must not exceed 30 characters,";
                    }
                    /*
                    if (!ipaPeriods.equals("") && ipaPeriods.matches("^\\d+(\\.\\d{1,2})?$")) {
                        errorMsg += "Period must have maximum 2 decimal places,";
                    }*/
                    
                    if (!ipaPeriodsStr.equals("")) {
                        ipaPeriodsStr = ipaPeriodsStr.replace(",", "");
                        if (!ipaPeriodsStr.matches("^\\d+(\\.\\d{1,2})?$")) {
                            errorMsg += "Period must have maximum 2 decimal places,";
                        } else {
                            try {
                                ipaPeriods = Double.parseDouble(ipaPeriodsStr);
                            } catch (Exception ex) {
                                errorMsg += "Basic Salry - invalid format,";
                            }
                        }
                    }
                    
                    if (!ipaBasicSalaryStr.equals("")) {
                        ipaBasicSalaryStr = ipaBasicSalaryStr.replace(",", "");
                        if (!ipaBasicSalaryStr.matches("^\\d+(\\.\\d{1,2})?$")) {
                            errorMsg += "Basic Salary must have maximum 2 decimal places,";
                        } else {
                            if (!ipaBasicSalaryStr.equals("")) {
                                try {
                                    ipaBasicSalary = Double.parseDouble(ipaBasicSalaryStr);
                                } catch (Exception ex) {
                                    errorMsg += "Basic Salry - invalid format,";
                                }
                            }
                        }
                    }   
                    
                    if (!ipaTotalAllowanceStr.equals("")) {
                        ipaTotalAllowanceStr = ipaTotalAllowanceStr.replace(",", "");
                        if (!ipaTotalAllowanceStr.matches("^\\d+(\\.\\d{1,2})?$")) {
                            errorMsg += "allowance must have maximum 2 decimal places,";
                        } else {
                            if (!ipaTotalAllowanceStr.equals("")) {
                            try {
                                    ipaTotalAllowance = Double.parseDouble(ipaTotalAllowanceStr);
                                } catch (Exception ex) {
                                    errorMsg += "allowance - invalid format,";
                                }
                            }
                        }    
                    }
                    
                    if (!ipaTotalAllowanceDetails.equals("") && ipaTotalAllowanceDetails.length() > 200) {
                        errorMsg += "Allowance details must not exceed 200 characters,";
                    }
                    
                    if (!ipaDeductionStr.equals("")) {
                        ipaDeductionStr = ipaDeductionStr.replace(",", "");
                        if (!ipaDeductionStr.matches("^\\d+(\\.\\d{1,2})?$")) {
                            errorMsg += "deduction amount must have maximum 2 decimal places,";
                        } else {
                            if (!ipaDeductionStr.equals("")) {
                                try {
                                    ipaDeduction = Double.parseDouble(ipaDeductionStr);
                                } catch (Exception ex) {
                                    errorMsg += "deduction amount - invalid format,";
                                }
                            }
                        }
                    }
                    
                    if (ipaDeductionDetails!= null && !ipaDeductionDetails.equals("") && ipaDeductionDetails.length() > 200) {
                        errorMsg += "deduction details must not exceed 200 characters,";
                    } 


                    if (ipaRemark != null && !ipaRemark.equals("") && ipaRemark.length() > 200) {
                        errorMsg += "remark must not exceed 200 characters,";
                    } 

                }   //pass 

                if (errorMsg.equals("")) {
                    if (idStr == null) {
                        //create new JobIPADetails workerFinNum, int jobKey, String ip, String ipaAgentName, String industry, String occuupation, String periodYears, double basicSalary, double ipaAllowances, String ipaAllowancesDetails, double ipaDeduction, String ipaDeductionDetails, String housingProvided, String ipaRemarks
                        JobIPADetails ipa = new JobIPADetails(workerFinNum, jobKey, ipaPassType, 
                                ipaPassTypeMore, ipaDate, ipaEmpName, ipaAgentName, ipaIndustry, 
                                ipaOccupation, ipaPeriods, ipaBasicSalary, ipaTotalAllowance, 
                                ipaTotalAllowanceDetails, ipaDeduction, ipaDeductionDetails, 
                                ipaHousingProvided, ipaRemark);
                         //add to db
                        JobComplementsDAO.addJobIPADetails(ipa);
                        //log the audit
                        auditChange = ipa.toString2();
                        //success
                        success = "IPA details has been successfully added!";
                    } else {
                        int id = Integer.parseInt(request.getParameter("Id"));
                        JobIPADetails ipa = new JobIPADetails(id, workerFinNum, jobKey, ipaPassType, 
                                ipaPassTypeMore, ipaDate, ipaEmpName, ipaAgentName, ipaIndustry, 
                                ipaOccupation, ipaPeriods, ipaBasicSalary, ipaTotalAllowance, 
                                ipaTotalAllowanceDetails, ipaDeduction, ipaDeductionDetails, 
                                ipaHousingProvided, ipaRemark);
                        JobComplementsDAO.updateJobIPADetails(ipa);
                        //log the audit
                        auditChange = ipa.toString2();
                        //success
                        success = "IPA details has been successfully updated!";
                    }
                } 
            }
            if (errorMsg.equals("")) {
                //log to audit
                auditChange = auditChange.replace("{", " [");
                auditChange = auditChange.replace("}", "]");


                if (idStr == null) {
                    action = "Added";
                } else {
                    action = "Edited";
                }
                //log to audit
                UserAuditLog userAuditLog = new UserAuditLog(_user.getUsername(), jobKey + "", 
                        workerFinNum, action, "Job Complement: " + auditChange);

                UserAuditLogDAO.addUserAuditLog(userAuditLog);  
            }
            request.getSession().setAttribute("successJobCompMsg", success);
            request.getSession().setAttribute("errorJobCompMsg", errorMsg);
            request.getSession().setAttribute("tabIndicator", "job");
            request.getSession().setAttribute("worker",workerFinNum);
            request.getSession().setAttribute("selectedProb",probKeyStr);
            request.getSession().setAttribute("selectedJob", jobKey + "");
            response.sendRedirect("viewWorker.jsp");
        } catch (Exception ex) {
            out.println(ex);
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
        processRequest(request, response);
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
        processRequest(request, response);
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
