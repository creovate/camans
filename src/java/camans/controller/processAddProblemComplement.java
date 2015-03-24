/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.controller;

import camans.dao.CaseManagementDAO;
import camans.dao.ProblemComplementsDAO;
import camans.dao.ProblemDAO;
import camans.dao.UserAuditLogDAO;
import camans.dao.UserDAO;
import camans.entity.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author soemyatmyat
 */
public class processAddProblemComplement extends HttpServlet {

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
            int problemKey = Integer.parseInt(request.getParameter("probKey"));
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");

            User _user = (User) request.getSession().getAttribute("userLogin");
            String idStr = request.getParameter("Id");

            String isAssociate = request.getParameter("associate");

            String auditChange = "";
            String action = "";
            //=======================================//
            //          Sucess & Error Parameters  
            //=======================================//
            String success = "";
            String errorMsg = "";

            //=======================================//
            //          Common Problem Complements  
            //=======================================//
            //          1. Aggravating Issue
            //=======================================//
            if (complementName.equals("aggravissue")) {
                //get all the parameters for Aggravating Issue
                String aggraIssue = "";
                String aggraIssueMore = "";
                String aggraLossStr = "";
                Double aggraLoss = 0.0;
                String aggraRemark = "";

                if (idStr == null) {
                    aggraIssue = request.getParameter("naggravissueType");
                    aggraIssueMore = request.getParameter("naggravissueTypeMore");
                    aggraLossStr = request.getParameter("naggravLoss");
                    aggraRemark = request.getParameter("nremark");
                } else {
                    aggraIssue = request.getParameter("aggravissueType");
                    aggraIssueMore = request.getParameter("aggravissueTypeMore");
                    aggraLossStr = request.getParameter("aggravLoss");
                    aggraRemark = request.getParameter("remark");
                }

                /**
                 * Server Validation *
                 */
                boolean pass = true; //assume validation pass first;

                if (aggraIssue.equals("")) {
                    errorMsg += "Aggravating Issue Type is blank,";
                    pass = false;
                }

                //proceed only after empty fields validation is passed
                if (pass) {


                    if (!aggraIssueMore.equals("") && aggraIssueMore.length() > 50) {
                        errorMsg += "Explain if above other cannot be more than 50 characters,";
                    }

                    if (!aggraLossStr.equals("")) {
                        aggraLossStr = aggraLossStr.replace(",", "");
                        if (!aggraLossStr.matches("^\\d+(\\.\\d{1,2})?$")) {
                            errorMsg += "Aggravating Loss Value must have maximum 2 decimal places,";
                        } else {
                            try {
                                aggraLoss = Double.parseDouble(aggraLossStr);
                            } catch (Exception ex) {
                                errorMsg += "Aggravating Loss - invalid format,";
                            }
                        }
                    }

                    if (!aggraRemark.equals("") && aggraRemark.length() > 200) {
                        errorMsg += "Remark cannot be longer than 200 characters,";
                    }

                }   //pass 

                /**
                 * Server Validation End*
                 */
                if (errorMsg.equals("")) {

                    if (idStr == null) {

                        //create object
                        ProblemAggravatingIssue problemAggraIssue = new ProblemAggravatingIssue(workerFinNum,
                                jobKey, problemKey, aggraIssue, aggraIssueMore, aggraLoss, aggraRemark);
                        //add to db
                        ProblemComplementsDAO.addProblemAggravatingIssue(problemAggraIssue);
                        //log the audit
                        auditChange = problemAggraIssue.toString2();
                        //success display
                        success = "Aggravating Issue has been successfully added!";

                    } else {
                        int id = Integer.parseInt(request.getParameter("Id"));
                        //create object
                        ProblemAggravatingIssue problemAggravatingIssue = new ProblemAggravatingIssue(id, workerFinNum,
                                jobKey, problemKey, aggraIssue, aggraIssueMore, aggraLoss, aggraRemark);
                        //add to db
                        ProblemComplementsDAO.updateProblemAggravatingIssue(problemAggravatingIssue);
                        //log the audit
                        auditChange = problemAggravatingIssue.toString2();
                        //success display
                        success = "Aggravating Issue has been successfully updated!";

                    }
                }
                //=======================================//
                //          2. Lead Case Worker
                //=======================================//    
            } else if (complementName.equals("leadcaseworker")) {
                //get all the parameters for lead case worker
                String leadName = "";
                String leadStartStr = "";
                String leadEndStr = "";
                java.sql.Date leadStart = null;
                java.sql.Date leadEnd = null;

                if (idStr == null) {
                    leadName = request.getParameter("nleadCaseWorkerName");
                    leadStartStr = request.getParameter("nstartDate");
                    leadEndStr = request.getParameter("nendDate");
                } else {
                    leadName = request.getParameter("leadCaseWorkerName");
                    leadStartStr = request.getParameter("startDate");
                    leadEndStr = request.getParameter("endDate");
                }
                /**
                 * server validation *
                 */
                boolean pass = true;

                if (leadName.equals("")) {
                    errorMsg += "Name is blank,";
                    pass = false;
                }

                //proceed only after empty fields validation is passed
                if (pass) {

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
                /**
                 * end server validation *
                 */
                if (errorMsg.equals("")) {

                    if (idStr == null) {
                        //create object
                        ProblemLeadCaseWorker problemLeadCaseWrk = new ProblemLeadCaseWorker(workerFinNum,
                                jobKey, problemKey, leadName, leadStart, leadEnd);

                        CaseManagementDAO.terminateLeadCaseWorker(problemKey);

                        //add into db
                        ProblemComplementsDAO.addProblemLeadCaseWorker(problemLeadCaseWrk);

                        //update leadcaseworker
                        User leadCaseWorker = UserDAO.retrieveUserByUsername(leadName);

                        CaseManagementDAO.assignCase(leadCaseWorker, ProblemDAO.retrieveProblemByProblemId(problemKey));


                        //log the audit
                        auditChange = problemLeadCaseWrk.toString2();
                        //success display
                        success = "Lead Case Worker has been successfully added!";
                    } else {
                        int id = Integer.parseInt(request.getParameter("Id"));

                        if (!leadEndStr.equals("")) {
                            CaseManagementDAO.terminateLeadCaseWorker(problemKey);
                        } else {
                            //create object
                            ProblemLeadCaseWorker problemLeadCaseWrk = new ProblemLeadCaseWorker(id, workerFinNum,
                                    jobKey, problemKey, leadName, leadStart, leadEnd);
                            //add into db
                            out.println("added");
                            ProblemComplementsDAO.updateProblemLeadCaseWorker(problemLeadCaseWrk);
                            //log the audit
                            auditChange = problemLeadCaseWrk.toString2();
                        }

                        //success display
                        success = "Lead Case Worker has been successfully updated!";
                    }
                }
                //=======================================//    
                //          3. Auxiliary Case Worker
                //=======================================//    
            } else if (complementName.equals("auxcaseworker")) {
                //get all the parameters
                String auxName = "";
                String auxStartStr = "";
                String auxEndStr = "";
                java.sql.Date auxStart = null;
                java.sql.Date auxEnd = null;

                if (idStr == null) {
                    auxName = request.getParameter("nauxiliaryCaseWorkerName");
                    auxStartStr = request.getParameter("nstartDate");
                    auxEndStr = request.getParameter("nendDate");


                } else {
                    auxName = request.getParameter("auxiliaryCaseWorkerName");
                    auxStartStr = request.getParameter("startDate");
                    auxEndStr = request.getParameter("endDate");
                }

                /**
                 * server validation *
                 */
                boolean pass = true;

                if (auxName.equals("")) {
                    errorMsg += "Name is blank,";
                    pass = false;
                }

                //proceed only after empty fields validation is passed
                if (pass) {

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



                /**
                 * server validation end *
                 */
                if (errorMsg.equals("")) {
                    if (idStr == null) {
                        //create object
                        ProblemAuxiliaryCaseWorker problemAuxiCaseWrk = new ProblemAuxiliaryCaseWorker(
                                workerFinNum, jobKey, problemKey, auxName, auxStart, auxEnd);

                        //add to db
                        ProblemComplementsDAO.addProblemAuxiliaryCaseWorker(problemAuxiCaseWrk);

                        //log the audit
                        auditChange = problemAuxiCaseWrk.toString2();

                        //success display
                        success = "Auxiliary Case Worker has been successfully added!";

                    } else {

                        int id = Integer.parseInt(request.getParameter("Id"));
                        //create object
                        ProblemAuxiliaryCaseWorker problemAuxiCaseWrk = new ProblemAuxiliaryCaseWorker(
                                id, workerFinNum, jobKey, problemKey, auxName, auxStart, auxEnd);

                        //add to db
                        ProblemComplementsDAO.updateProblemAuxiliaryCaseWorker(problemAuxiCaseWrk);

                        //log the audit
                        auditChange = problemAuxiCaseWrk.toString2();

                        //success display
                        success = "Auxiliary Case Worker has been successfully updated!";
                    }

                }

                //=======================================//    
                //          4. Case Discussion  
                //=======================================//    
            } else if (complementName.equals("casediscussion")) {
                //get all the parameters
                String discussDateStr = "";
                String discussTime = "";
                String discussWhere = "";
                String discussWhereMore = "";
                String discussWorkerPresent = "";
                String discussTWC2Pers1 = "";
                String discussTWC2Pers2 = "";
                String discussOthPers = "";
                String discussTranslator = "";
                String discussTopic = "";
                String discussGit = "";
                String discussAssist = "";
                String discussCalculate = "";
                String discussAction = "";
                String discussRem = "";
                java.sql.Date discussDate = null;


                if (idStr == null) {
                    discussDateStr = request.getParameter("ndate");
                    discussTime = request.getParameter("ndiscussionTime");
                    discussWhere = request.getParameter("ndiscussionWhere");
                    discussWhereMore = request.getParameter("ndiscussionWhereMore");
                    discussWorkerPresent = request.getParameter("ndiscussionWorkerPresent");
                    discussTWC2Pers1 = request.getParameter("ndiscussionTWC2P1");
                    discussTWC2Pers2 = request.getParameter("ndiscussionTWC2P2");
                    discussOthPers = request.getParameter("ndiscussionOtherPerson");
                    discussTranslator = request.getParameter("ndiscussionTranslator");
                    discussTopic = request.getParameter("ndiscussionTopic");
                    discussGit = request.getParameter("ndiscussionGist");
                    discussAssist = request.getParameter("ndiscussionAssist");
                    discussCalculate = request.getParameter("ndiscussionCal");
                    discussAction = request.getParameter("ndiscussionAction");
                    discussRem = request.getParameter("ninternalRemarks");

                } else {

                    discussDateStr = request.getParameter("date");
                    discussTime = request.getParameter("discussionTime");
                    discussWhere = request.getParameter("discussionWhere");
                    discussWhereMore = request.getParameter("discussionWhereMore");
                    discussWorkerPresent = request.getParameter("discussionWorkerPresent");
                    discussTWC2Pers1 = request.getParameter("discussionTWC2P1");
                    discussTWC2Pers2 = request.getParameter("discussionTWC2P2");
                    discussOthPers = request.getParameter("discussionOtherPerson");
                    discussTranslator = request.getParameter("discussionTranslator");
                    discussTopic = request.getParameter("discussionTopic");
                    discussGit = request.getParameter("discussionGist");
                    discussAssist = request.getParameter("discussionAssist");
                    discussCalculate = request.getParameter("discussionCal");
                    discussAction = request.getParameter("discussionAction");
                    discussRem = request.getParameter("internalRemarks");
                }

                /**
                 * server validation *
                 */
                boolean pass = true;

                //assume validation pass first;

                if (discussDateStr.equals("")) {
                    errorMsg += "Discussion Date is blank,";
                    pass = false;
                }
                if (discussWhere.equals("")) {
                    errorMsg += "Discussion Location is blank,";
                    pass = false;
                }
                if (discussTWC2Pers1.equals("")) {
                    errorMsg += "TWC2 Person 1 is blank,";
                    pass = false;
                }
                if (discussTopic.equals("")) {
                    errorMsg += "Case Topic is blank,";
                    pass = false;
                }

                //proceed only after empty fields validation is passed
                if (pass) {

                    if (!discussDateStr.equals("")) {
                        try {
                            java.util.Date tmp = sdf.parse(discussDateStr);
                            discussDate = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                            errorMsg += "Invalid Case Discussion Date Format,";
                        }
                    }

                    if (!discussTime.equals("") && discussTime.length() > 20) {
                        errorMsg += "Discussion Time cannot be longer than 20 characters,";
                    }

                    if (!discussWhere.equals("") && discussWhere.length() > 30) {
                        errorMsg += "Discussion Locatin cannot be longer than 30 characters,";
                    }

                    if (discussWhereMore != null && !discussWhereMore.equals("") && discussWhereMore.length() > 50) {
                        errorMsg += "Explain if above is other cannot be longer than 50 characters,";
                    }

                    if (!discussWorkerPresent.equals("")) {
                        if (discussWorkerPresent.equalsIgnoreCase("Yes")
                                || discussWorkerPresent.equalsIgnoreCase("No")) {
                        } else {
                            errorMsg += "Worker Present can only be 'Yes' or 'No',";
                        }
                    }

                    if (!discussTWC2Pers1.equals("") && discussTWC2Pers1.length() > 200) {
                        errorMsg += "TWC2 Person 1 cannot be longer than 200 characters,";
                    }

                    if (!discussTWC2Pers2.equals("") && discussTWC2Pers2.length() > 200) {
                        errorMsg += "TWC2 Person 2 cannot be longer than 200 characters,";
                    }

                    if (!discussOthPers.equals("") && discussOthPers.length() > 200) {
                        errorMsg += "Other Person cannot be longer than 200 characters,";
                    }

                    if (!discussTranslator.equals("") && discussTranslator.length() > 50) {
                        errorMsg += "Translator cannot be longer than 50 characters,";
                    }

                    if (!discussTopic.equals("") && discussTopic.length() > 200) {
                        errorMsg += "Discuss Topic cannot be longer than 200 characters,";
                    }

                    if (!discussGit.equals("") && discussGit.length() > 1000) {
                        errorMsg += "Discuss Gist cannot be longer than 1000 characters,";
                    }

                    if (!discussAssist.equals("") && discussAssist.length() > 1000) {
                        errorMsg += "Discuss Assistant cannot be longer than 1000 characters,";
                    }

                    if (!discussCalculate.equals("") && discussCalculate.length() > 1000) {
                        errorMsg += "Calcuate cannot be longer than 1000 characters,";
                    }

                    if (!discussAction.equals("") && discussAction.length() > 500) {
                        errorMsg += "Action cannot be longer than 500 characters,";
                    }

                    if (!discussRem.equals("") && discussRem.length() > 500) {
                        errorMsg += "Remark cannot be longer than 500 characters,";
                    }

                } //pass

                /**
                 * server validation end *
                 */
                if (errorMsg.equals("")) {
                    if (idStr == null) {

                        //create object
                        ProblemCaseDiscussion problemCaseDiscuss = new ProblemCaseDiscussion(
                                workerFinNum, jobKey, problemKey, discussDate, discussTime, discussWhere,
                                discussWhereMore, discussWorkerPresent, discussTWC2Pers1, discussTWC2Pers2,
                                discussOthPers, discussTranslator, discussTopic, discussGit, discussAssist,
                                discussCalculate, discussAction, discussRem);
                        //add to db
                        ProblemComplementsDAO.addProblemCaseDiscussion(problemCaseDiscuss);

                        //log the audit
                        auditChange = problemCaseDiscuss.toString2();
                        //success display
                        success = "Case Discussion has been successfully added!";

                    } else {
                        int id = Integer.parseInt(request.getParameter("Id"));
                        //create object
                        ProblemCaseDiscussion problemCaseDiscussion = new ProblemCaseDiscussion(
                                id, workerFinNum, jobKey, problemKey, discussDate, discussTime, discussWhere,
                                discussWhereMore, discussWorkerPresent, discussTWC2Pers1, discussTWC2Pers2,
                                discussOthPers, discussTranslator, discussTopic, discussGit, discussAssist,
                                discussCalculate, discussAction, discussRem);
                        //add to db
                        ProblemComplementsDAO.updateProblemCaseDiscussion(problemCaseDiscussion);
                        //log the audit
                        auditChange = problemCaseDiscussion.toString2();
                        //success display
                        success = "Case Discussion has been successfully updated!";
                    }

                }

                //=======================================//    
                //          5. Lawyer  
                //=======================================//    
            } else if (complementName.equals("lawyer")) {
                //get all the parameters
                String lawFirmDateStr = "";
                String lawFirmName = "";
                String lawFirmNameMore = "";
                String lawFirmLawyer = "";
                String lawFirmRem = "";
                java.sql.Date lawFirmDate = null;

                if (idStr == null) {
                    lawFirmDateStr = request.getParameter("ndate");
                    lawFirmName = request.getParameter("nlawyerFirm");
                    lawFirmNameMore = request.getParameter("nlawyerFirmMore");
                    lawFirmLawyer = request.getParameter("nlawyerName");
                    lawFirmRem = request.getParameter("nremark");

                } else {
                    lawFirmDateStr = request.getParameter("date");
                    lawFirmName = request.getParameter("lawyerFirm");
                    lawFirmNameMore = request.getParameter("lawyerFirmMore");
                    lawFirmLawyer = request.getParameter("lawyerName");
                    lawFirmRem = request.getParameter("remark");
                }

                /**
                 * server validation *
                 */
                boolean pass = true; //assume validation pass first;

                if (lawFirmDateStr.equals("")) {
                    errorMsg += "Law Firm Date is blank,";
                    pass = false;
                }
                if (lawFirmName.equals("")) {
                    errorMsg += "Law Firm Name is blank,";
                    pass = false;
                }

                //proceed only after empty fields validation is passed
                if (pass) {

                    // check for any existing worker  with the same finNum. 


                    if (!lawFirmDateStr.equals("")) {
                        try {
                            java.util.Date tmp = sdf.parse(lawFirmDateStr);
                            lawFirmDate = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                            errorMsg += "Invalid Updated Lawyer Date Format,";
                        }
                    }

                    if (!lawFirmName.equals("") && lawFirmName.length() > 30) {
                        errorMsg += "Law Firm Name cannot be longer than 30 characters,";
                    }

                    if (lawFirmNameMore != null && !lawFirmNameMore.equals("") && lawFirmNameMore.length() > 50) {
                        errorMsg += "Explain if above is other cannot be longer than 50 characters,";
                    }

                    if (lawFirmLawyer != null && !lawFirmLawyer.equals("") && lawFirmLawyer.length() > 200) {
                        errorMsg += "Lawyer Name cannot be longer than 200 characters,";
                    }

                    if (lawFirmRem != null && !lawFirmRem.equals("") && lawFirmRem.length() > 200) {
                        errorMsg += "Remark cannot be longer than 200 characters,";
                    }


                } //pass

                /**
                 * server validation end *
                 */
                if (errorMsg.equals("")) {
                    if (idStr == null) {
                        //for associate
                        if (lawFirmLawyer == null && lawFirmRem == null) {
                            lawFirmLawyer = "";
                            lawFirmRem = "";
                        }
                        //create object
                        ProblemLawyer problemLawyer = new ProblemLawyer(workerFinNum, jobKey, problemKey,
                                lawFirmDate, lawFirmName, lawFirmNameMore, lawFirmLawyer, lawFirmRem);
                        //add to db
                        ProblemComplementsDAO.addProblemLawyer(problemLawyer);
                        //log the audit
                        auditChange = problemLawyer.toString2();
                        //success display
                        success = "Lawyer has been successfully added!";
                    } else {
                        int id = Integer.parseInt(request.getParameter("Id"));
                        //create object
                        ProblemLawyer problemLawyer = new ProblemLawyer(id, workerFinNum, jobKey, problemKey,
                                lawFirmDate, lawFirmName, lawFirmNameMore, lawFirmLawyer, lawFirmRem);
                        //add to db
                        ProblemComplementsDAO.updateProblemLawyer(problemLawyer);
                        //log the audit
                        auditChange = problemLawyer.toString2();
                        //success display
                        success = "Lawyer has been successfully updated!";
                    }

                }
                //=======================================//
                //          Salary Problem Complements  
                //=======================================//
                //          6. Salary Related History
                //=======================================//
            } else if (complementName.equals("salaryhistory")) {
                //get all the parameters
                String salHistBasic = "";
                String salHistOt = "";
                String salHistAllowance = "";
                String salHistDeduction = "";
                String salHistKickbacks = "";
                String salHistOther = "";
                String salMode = "";
                String salModeMore = "";
                String salLossTotalStr = "";
                String salLossYearStr = "";
                String salHistRemark = "";
                Double salLossTotal = 0.0;
                Double salLossYear = 0.0;

                if (idStr == null) {
                    salHistBasic = request.getParameter("nbasicSal");
                    salHistOt = request.getParameter("novertime");
                    salHistAllowance = request.getParameter("nallowance");
                    salHistDeduction = request.getParameter("ndeduction");
                    salHistKickbacks = request.getParameter("nkickbacks");
                    salHistOther = request.getParameter("notherSal");
                    salMode = request.getParameter("nmode");
                    salModeMore = request.getParameter("nmodeMore");
                    salLossTotalStr = request.getParameter("ntotalLoss");
                    salLossYearStr = request.getParameter("noneYearLoss");
                    salHistRemark = request.getParameter("nremark");

                } else {
                    salHistBasic = request.getParameter("basicSal");
                    salHistOt = request.getParameter("overtime");
                    salHistAllowance = request.getParameter("allowance");
                    salHistDeduction = request.getParameter("deduction");
                    salHistKickbacks = request.getParameter("kickbacks");
                    salHistOther = request.getParameter("otherSal");
                    salMode = request.getParameter("mode");
                    salModeMore = request.getParameter("modeMore");
                    salLossTotalStr = request.getParameter("totalLoss");
                    salLossYearStr = request.getParameter("oneYearLoss");
                    salHistRemark = request.getParameter("remark");

                }

                /**
                 * server validation *
                 */
                boolean pass = true; //assume validation pass first;

                if (salHistBasic.equals("")) {
                    errorMsg += "Salary is blank,";
                    pass = false;
                }

                //proceed only after empty fields validation is passed
                if (pass) {


                    if (!salHistOt.equals("") && salHistOt.length() > 500) {
                        errorMsg += "OT cannot be more than 500 characters,";
                    }

                    if (!salHistAllowance.equals("") && salHistAllowance.length() > 500) {
                        errorMsg += "Allowance cannot be more than 500 characters,";
                    }

                    if (!salHistDeduction.equals("") && salHistDeduction.length() > 500) {
                        errorMsg += "Deduction cannot be more than 500 characters,";
                    }

                    if (!salHistKickbacks.equals("") && salHistKickbacks.length() > 500) {
                        errorMsg += "Kickbacks cannot be more than 500 characters,";
                    }

                    if (!salHistOther.equals("") && salHistOther.length() > 500) {
                        errorMsg += "History Other cannot be more than 500 characters,";
                    }

                    if (!salModeMore.equals("") && salModeMore.length() > 50) {
                        errorMsg += "Salary Mode cannot be more than 50 characters,";
                    }

                    if (!salLossTotalStr.equals("")) {
                        salLossTotalStr = salLossTotalStr.replace(",", "");
                        if (!salLossTotalStr.matches("^\\d+(\\.\\d{1,2})?$")) {
                            errorMsg += "Salary Loss Total must have maximum 2 decimal places,";
                        } else {
                            try {
                                salLossTotal = Double.parseDouble(salLossTotalStr);
                            } catch (Exception ex) {
                                errorMsg += "Salary Loss Total - invalid format,";
                            }
                        }
                    }

                    if (!salLossYearStr.equals("")) {
                        salLossYearStr = salLossYearStr.replace(",", "");
                        if (!salLossYearStr.matches("^\\d+(\\.\\d{1,2})?$")) {
                            errorMsg += "Salary Loss Year must have maximum 2 decimal places,";
                        } else {
                            try {
                                salLossYear = Double.parseDouble(salLossYearStr);
                            } catch (Exception ex) {
                                errorMsg += "Salary Loss Year - invalid format,";
                            }
                        }
                    }

                    if (!salHistRemark.equals("") && salHistRemark.length() > 200) {
                        errorMsg += "Remark cannot be more than 200 characters,";
                    }
                } //pass

                /**
                 * server validation end *
                 */
                if (errorMsg.equals("")) {
                    if (idStr == null) {
                        //create object
                        ProblemSalaryRelatedHistory salHist = new ProblemSalaryRelatedHistory(workerFinNum,
                                jobKey, problemKey, salHistBasic, salHistOt, salHistAllowance, salHistDeduction,
                                salHistKickbacks, salHistOther, salMode, salModeMore, salLossTotal,
                                salLossYear, salHistRemark);
                        //add to db
                        ProblemComplementsDAO.addProblemSalaryRelatedHistory(salHist);

                        //log the audit
                        auditChange = salHist.toString2();;

                        //success display
                        success = "Salaryhistory has been successfully added!";
                    } else {
                        int id = Integer.parseInt(request.getParameter("Id"));
                        //create object
                        ProblemSalaryRelatedHistory problemSalaryRelatedHistory = new ProblemSalaryRelatedHistory(id, workerFinNum,
                                jobKey, problemKey, salHistBasic, salHistOt, salHistAllowance, salHistDeduction,
                                salHistKickbacks, salHistOther, salMode, salModeMore, salLossTotal,
                                salLossYear, salHistRemark);
                        //add to db
                        ProblemComplementsDAO.updateProblemSalaryRelatedHistory(problemSalaryRelatedHistory);

                        //log the audit
                        auditChange = problemSalaryRelatedHistory.toString2();
                        //success display
                        success = "Salaryhistory has been successfully updated!";
                    }
                }

                //=======================================//      
                //          7. Salary Claimed Lodged    
                //=======================================//
            } else if (complementName.equals("salarycalim")) {
                String salClaimDateStr = "";
                String salClaimLossStr = "";
                String salClaimBasic = "";
                java.sql.Date salClaimDate = null;
                Double salClaimLoss = 0.0;

                if (idStr == null) {
                    salClaimDateStr = request.getParameter("ndate");
                    salClaimLossStr = request.getParameter("nloss");
                    salClaimBasic = request.getParameter("nbasis");

                } else {
                    salClaimDateStr = request.getParameter("date");
                    salClaimLossStr = request.getParameter("loss");
                    salClaimBasic = request.getParameter("basis");
                }
                /**
                 * server validation *
                 */
                boolean pass = true; //assume validation pass first;

                if (salClaimDateStr.equals("")) {
                    errorMsg += "Salary Claim Date is blank,";
                    pass = false;
                }

                //proceed only after empty fields validation is passed
                if (pass) {

                    if (!salClaimDateStr.equals("")) {
                        try {
                            java.util.Date tmp = sdf.parse(salClaimDateStr);
                            salClaimDate = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                            errorMsg += "Invalid Salary claim Date Format,";
                        }
                    }

                    if (!salClaimLossStr.equals("")) {
                        salClaimLossStr = salClaimLossStr.replace(",", "");
                        if (!salClaimLossStr.matches("^\\d+(\\.\\d{1,2})?$")) {
                            errorMsg += "Salary Claim Loss must have maximum 2 decimal places,";
                        } else {
                            try {
                                salClaimLoss = Double.parseDouble(salClaimLossStr);
                            } catch (Exception ex) {
                                errorMsg += "Salary Claim Loss - invalid format,";
                            }
                        }
                    }

                    if (!salClaimBasic.equals("") && salClaimBasic.length() > 1000) {
                        errorMsg += "Salary Claim Basic cannot be longer than 1000 characters,";
                    }
                }   //pass 
                /**
                 * server validation end *
                 */
                if (errorMsg.equals("")) {
                    if (idStr == null) {
                        //create object
                        ProblemSalaryClaim salaryClaim = new ProblemSalaryClaim(workerFinNum, jobKey,
                                problemKey, salClaimDate, salClaimLoss, salClaimBasic);
                        //add to db
                        ProblemComplementsDAO.addProblemSalaryClaim(salaryClaim);

                        //log the audit
                        auditChange = salaryClaim.toString2();

                        //success display
                        success = "salary Claim has been successfully added!";
                    } else {
                        int id = Integer.parseInt(request.getParameter("Id"));
                        //create object
                        ProblemSalaryClaim salaryClaim = new ProblemSalaryClaim(id, workerFinNum, jobKey,
                                problemKey, salClaimDate, salClaimLoss, salClaimBasic);
                        //add to db
                        ProblemComplementsDAO.updateProblemSalaryClaim(salaryClaim);

                        //log the audit
                        auditChange = salaryClaim.toString2();

                        //success display
                        success = "Salary Claim has been successfully updated!";
                    }
                }

                //=======================================//
                //          Medical Problem Complements  
                //=======================================//
                //          8. Injury History 
                //=======================================//
            } else if (complementName.equals("injurycase")) {
                String injuryDateStr = "";
                String injuryTime = "";
                String injuryLocation = "";
                String injuryDeath = "";
                String injuryBodyPart = "";
                String injuryHow = "";
                String injuryAmbulance = "";
                String injuryInitialTreatement = "";
                String injuryInitialTreatementMore = "";
                String injuryWorkRelated = "";
                String injuryRemark = "";
                java.sql.Date injuryDate = null;

                if (idStr == null) {
                    injuryDateStr = request.getParameter("ndate");
                    injuryTime = request.getParameter("ntime");
                    injuryLocation = request.getParameter("nlocation");
                    injuryDeath = request.getParameter("ndeath");
                    injuryBodyPart = request.getParameter("nbodyPart");
                    injuryHow = request.getParameter("nhowinjury");
                    injuryAmbulance = request.getParameter("nambulance");
                    injuryInitialTreatement = request.getParameter("ntreatement");
                    injuryInitialTreatementMore = request.getParameter("ntreatementMore");
                    injuryWorkRelated = request.getParameter("nworkRelated");
                    injuryRemark = request.getParameter("nremark");

                } else {
                    injuryDateStr = request.getParameter("date");
                    injuryTime = request.getParameter("time");
                    injuryLocation = request.getParameter("location");
                    injuryDeath = request.getParameter("death");
                    injuryBodyPart = request.getParameter("bodyPart");
                    injuryHow = request.getParameter("howinjury");
                    injuryAmbulance = request.getParameter("ambulance");
                    injuryInitialTreatement = request.getParameter("treatement");
                    injuryInitialTreatementMore = request.getParameter("treatementMore");
                    injuryWorkRelated = request.getParameter("workRelated");
                    injuryRemark = request.getParameter("remark");

                }
                /**
                 * server validation *
                 */
                boolean pass = true; //assume validation pass first

                if (injuryDateStr.equals("")) {
                    errorMsg += "Injury Date is blank,";
                    pass = false;
                }

                //proceed only after empty fields validation is passed
                if (pass) {

                    if (!injuryDateStr.equals("")) {
                        try {
                            java.util.Date tmp = sdf.parse(injuryDateStr);
                            injuryDate = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                            errorMsg += "Invalid injury Date Format,";
                        }
                    }

                    if (!injuryTime.equals("") && injuryTime.length() > 20) {
                        errorMsg += "Injury Time cannot be more than 20 characters,";
                    }

                    if (!injuryLocation.equals("") && injuryLocation.length() > 200) {
                        errorMsg += "Injury Location cannot be more than 200 characters,";
                    }

                    if (!injuryDeath.equals("")) {
                        if (injuryDeath.equals("Yes") || injuryDeath.equals("No")) {
                        } else {
                            errorMsg += "Death Invovled must be either 'Yes' or 'No',";
                        }
                    }

                    if (!injuryBodyPart.equals("") && injuryBodyPart.length() > 500) {
                        errorMsg += "Injury Body Part cannot be more than 500 characters,";
                    }

                    if (!injuryHow.equals("") && injuryHow.length() > 1000) {
                        errorMsg += "How Injury cannot be more than 1000 characters,";
                    }

                    if (!injuryAmbulance.equals("")) {
                        if (injuryAmbulance.equals("Yes") || injuryAmbulance.equals("No")
                                || injuryAmbulance.equals("Don't know")) {
                        } else {
                            errorMsg += "Ambulance invovled must be either 'Yes' or 'No' or 'Don't know,";
                        }
                    }

                    if (!injuryInitialTreatement.equals("") && injuryInitialTreatement.length() > 200) {
                        errorMsg += "Initial Treatment cannot be more than 200 characters,";
                    }

                    if (!injuryWorkRelated.equals("")) {
                        if (injuryWorkRelated.equals("Yes") || injuryWorkRelated.equals("No")
                                || injuryWorkRelated.equals("Don't know")) {
                        } else {
                            errorMsg += "Is work related must be either 'Yes' or 'No' or 'Don't know,";
                        }
                    }

                    if (!injuryRemark.equals("") && injuryRemark.length() > 200) {
                        errorMsg += "Injury Remark cannot be more than 200 characters,";
                    }
                } //pass
                /**
                 * server validation end *
                 */
                if (errorMsg.equals("")) {

                    if (idStr == null) {
                        //create object
                        ProblemInjury injury = new ProblemInjury(workerFinNum, jobKey,
                                problemKey, injuryDate, injuryTime, injuryLocation, injuryDeath,
                                injuryBodyPart, injuryHow, injuryAmbulance, injuryInitialTreatement,
                                injuryInitialTreatementMore, injuryWorkRelated, injuryRemark);

                        //add to db
                        ProblemComplementsDAO.addProblemInjury(injury);

                        //log the audit
                        auditChange = injury.toString2();
                        //success display
                        success = "Injury History has been successfully added!";

                    } else {
                        int id = Integer.parseInt(request.getParameter("Id"));
                        //create object
                        ProblemInjury problemInjury = new ProblemInjury(id, workerFinNum, jobKey,
                                problemKey, injuryDate, injuryTime, injuryLocation, injuryDeath,
                                injuryBodyPart, injuryHow, injuryAmbulance, injuryInitialTreatement,
                                injuryInitialTreatementMore, injuryWorkRelated, injuryRemark);

                        //add to db
                        ProblemComplementsDAO.updateProblemInjury(problemInjury);
                        //log the audit
                        auditChange = problemInjury.toString2();
                        //success display
                        success = "Injury History has been successfully updated!";
                    }
                }

                //=======================================//
                //          9. Illness History  
                //=======================================//
            } else if (complementName.equals("illnesscase")) {
                String illnessStart = "";
                String illnessdiaTime = "";
                String illnessdiaPerson = "";
                String illnessNature = "";
                String illnessWorkRelated = "";
                String illnessWhy = "";
                String illnessRemark = "";

                if (idStr == null) {
                    illnessStart = request.getParameter("nstartTime");
                    illnessdiaTime = request.getParameter("ndiagnoseTime");
                    illnessdiaPerson = request.getParameter("ndiagnosePerson");
                    illnessNature = request.getParameter("nnature");
                    illnessWorkRelated = request.getParameter("nworkRelated");
                    illnessWhy = request.getParameter("nworkRelatedYes");
                    illnessRemark = request.getParameter("nremark");

                } else {
                    illnessStart = request.getParameter("startTime");
                    illnessdiaTime = request.getParameter("diagnoseTime");
                    illnessdiaPerson = request.getParameter("diagnosePerson");
                    illnessNature = request.getParameter("nature");
                    illnessWorkRelated = request.getParameter("workRelated");
                    illnessWhy = request.getParameter("workRelatedYes");
                    illnessRemark = request.getParameter("remark");

                }
                /**
                 * server validation *
                 */
                boolean pass = true; //assume validation pass first;

                if (illnessStart.equals("")) {
                    errorMsg += "when illness start is blank,";
                    pass = false;
                }

                //proceed only after empty fields validation is passed
                if (pass) {

                    if (!illnessStart.equals("") && illnessStart.length() > 50) {
                        errorMsg += "when illness start cannot be more than 50 characters,";
                    }

                    if (!illnessdiaTime.equals("") && illnessdiaTime.length() > 50) {
                        errorMsg += "diagnosis time cannot be more than 50 characters,";
                    }

                    if (!illnessdiaPerson.equals("") && illnessdiaPerson.length() > 200) {
                        errorMsg += "diagnosis person cannot be more than 200 characters,";
                    }

                    if (!illnessNature.equals("") && illnessNature.length() > 200) {
                        errorMsg += "illness nature cannot be more than 200 characters,";
                    }

                    if (!illnessWorkRelated.equals("")) {
                        if (illnessWorkRelated.equals("Yes") || illnessWorkRelated.equals("No")
                                || illnessWorkRelated.equals("Don't know")) {
                        } else {
                            errorMsg += "illness work related must be either 'Yes' or 'No' or 'Don't know";
                        }
                    }

                    if (!illnessWhy.equals("") && illnessWhy.length() > 500) {
                        errorMsg += "why illness cannot be more than 500 characters,";
                    }

                    if (!illnessRemark.equals("") && illnessRemark.length() > 200) {
                        errorMsg += "Illness remark cannot be more than 200 characters,";
                    }
                } //pass

                /**
                 * server validation end *
                 */
                if (errorMsg.equals("")) {
                    if (idStr == null) {
                        //create object
                        ProblemIllness illness = new ProblemIllness(workerFinNum, jobKey, problemKey,
                                illnessStart, illnessdiaTime, illnessdiaPerson, illnessNature,
                                illnessWorkRelated, illnessWhy, illnessRemark);

                        //addto db
                        ProblemComplementsDAO.addProblemIllness(illness);

                        //log the audit
                        auditChange = illness.toString2();;
                        //success display
                        success = "Illness has been successfully added!";

                    } else {
                        int id = Integer.parseInt(request.getParameter("Id"));
                        //create object
                        ProblemIllness illness = new ProblemIllness(id, workerFinNum, jobKey, problemKey,
                                illnessStart, illnessdiaTime, illnessdiaPerson, illnessNature,
                                illnessWorkRelated, illnessWhy, illnessRemark);

                        //addto db
                        ProblemComplementsDAO.updateProblemIllness(illness);
                        //log the audit
                        auditChange = illness.toString2();
                        //success display
                        success = "Illness has been successfully updated!";

                    }
                }

                //=======================================//
                //          10. WICA Claim Lodged    
                //=======================================//    
            } else if (complementName.equals("wicaclaim")) {
                //get all parameters
                String wicaClaimDateStr = "";
                String wicaClaimRefNum = "";
                String wicaInsurer = "";
                String wicaPolicyNbr = "";
                String wicaClaimReason = "";
                String wicaClaimRemark = "";
                java.sql.Date wicaClaimDate = null;

                if (idStr == null) {
                    wicaClaimDateStr = request.getParameter("ndateWica");
                    wicaClaimRefNum = request.getParameter("nrefNumber");
                    wicaInsurer = request.getParameter("ninsurer");
                    wicaPolicyNbr = request.getParameter("npolicyNumber");
                    wicaClaimReason = request.getParameter("nreason");
                    wicaClaimRemark = request.getParameter("nremark");
                } else {
                    wicaClaimDateStr = request.getParameter("dateWica");
                    wicaClaimRefNum = request.getParameter("refNumber");
                    wicaInsurer = request.getParameter("insurer");
                    wicaPolicyNbr = request.getParameter("policyNumber");
                    wicaClaimReason = request.getParameter("reason");
                    wicaClaimRemark = request.getParameter("remark");
                }

                /**
                 * server validation *
                 */
                boolean pass = true; //assume validation pass first;

                if (wicaClaimRefNum.equals("")) {
                    errorMsg += "WICA Reference Number is blank,";
                    pass = false;
                }

                //proceed only after empty fields validation is passed
                if (pass) {

                    if (!wicaClaimDateStr.equals("")) {
                        try {
                            java.util.Date tmp = sdf.parse(wicaClaimDateStr);
                            wicaClaimDate = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                            errorMsg += "Invalid wica claim Date Format,";
                        }
                    }

                    if (!wicaClaimRefNum.equals("") && wicaClaimRefNum.length() > 30) {
                        errorMsg += "Reference number cannot be longer than 30 characters,";
                    }

                    if (!wicaInsurer.equals("") && wicaInsurer.length() > 50) {
                        errorMsg += "Insurer cannot be longer than 50 characters,";
                    }

                    if (!wicaPolicyNbr.equals("") && wicaPolicyNbr.length() > 50) {
                        errorMsg += "Policy Number cannot be longer than 50 characters,";
                    }

                    if (!wicaClaimReason.equals("") && wicaClaimReason.length() > 200) {
                        errorMsg += "Reason cannot be longer than 200 characters,";
                    }

                    if (!wicaClaimRemark.equals("") && wicaClaimRemark.length() > 200) {
                        errorMsg += "Remark cannot be longer than 200 characters,";
                    }
                }   //pass 

                /**
                 * server validation end *
                 */
                if (errorMsg.equals("")) {
                    if (idStr == null) {
                        //create object
                        ProblemWicaClaim wicaClaim = new ProblemWicaClaim(workerFinNum, jobKey, problemKey,
                                wicaClaimDate, wicaClaimRefNum, wicaInsurer, wicaPolicyNbr,
                                wicaClaimReason, wicaClaimRemark);
                        //add to db
                        ProblemComplementsDAO.addProblemWicaClaim(wicaClaim);

                        //log the audit
                        auditChange = wicaClaim.toString2();
                        //success display
                        success = "WICA Claim has been successfully added!";


                    } else {
                        int id = Integer.parseInt(request.getParameter("Id"));
                        //create object
                        ProblemWicaClaim problemWicaClaim = new ProblemWicaClaim(id, workerFinNum, jobKey, problemKey,
                                wicaClaimDate, wicaClaimRefNum, wicaInsurer, wicaPolicyNbr,
                                wicaClaimReason, wicaClaimRemark);
                        //add to db
                        ProblemComplementsDAO.updateProblemWicaClaim(problemWicaClaim);
                        //log the audit
                        auditChange = problemWicaClaim.toString2();
                        //success display
                        success = "Wica Claim has been successfully updated!";

                    }

                }

                //=======================================//
                //          11. Non-WICA Claim Lodged  
                //=======================================//    
            } else if (complementName.equals("nonwicaclaim")) {
                //get all the parameters
                String nonwicaClaimDateStr = "";
                String nonwicaClaimLossStr = "";
                String nonwicaClaimInsurer = "";
                String nonwicaClaimPolicyNbr = "";
                String nonwicaClaimBasic = "";
                String remark = "";
                java.sql.Date nonwicaClaimDate = null;
                Double nonwicaClaimLoss = 0.0;

                if (idStr == null) {
                    nonwicaClaimDateStr = request.getParameter("ndate");
                    nonwicaClaimLossStr = request.getParameter("nloss");
                    nonwicaClaimInsurer = request.getParameter("ninsurer");
                    nonwicaClaimPolicyNbr = request.getParameter("npolicyNumber");
                    nonwicaClaimBasic = request.getParameter("nbasis");
                    remark = request.getParameter("nNWicaremark");
                } else {
                    nonwicaClaimDateStr = request.getParameter("date");
                    nonwicaClaimLossStr = request.getParameter("loss");
                    nonwicaClaimInsurer = request.getParameter("insurer");
                    nonwicaClaimPolicyNbr = request.getParameter("policyNumber");
                    nonwicaClaimBasic = request.getParameter("basis");
                    remark = request.getParameter("NWICAremark");

                }

                /**
                 * server validation *
                 */
                boolean pass = true; //assume validation pass first;

                if (nonwicaClaimDateStr.equals("")) {
                    errorMsg += "Claim date is blank,";
                    pass = false;
                }

                //proceed only after empty fields validation is passed
                if (pass) {

                    if (nonwicaClaimDateStr != null && !nonwicaClaimDateStr.equals("")) {
                        try {
                            java.util.Date tmp = sdf.parse(nonwicaClaimDateStr);
                            nonwicaClaimDate = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                            errorMsg += "Invalid non-wica medical claim Date Format,";
                        }
                    }

                    if (nonwicaClaimLossStr != null && !nonwicaClaimLossStr.equals("")) {
                        nonwicaClaimLossStr = nonwicaClaimLossStr.replace(",", "");
                        if (!nonwicaClaimLossStr.matches("^\\d+(\\.\\d{1,2})?$")) {
                            errorMsg += "Non WICA Claim Loss must have maximum 2 decimal places,";
                        } else {
                            try {
                                nonwicaClaimLoss = Double.parseDouble(nonwicaClaimLossStr);
                            } catch (Exception ex) {
                                errorMsg += "Non WICA Claim Loss - invalid format,";
                            }
                        }
                    }

                    if (nonwicaClaimInsurer != null && !nonwicaClaimInsurer.equals("") && nonwicaClaimInsurer.length() > 50) {
                        errorMsg += "Insurer cannot be longer than 50 characters,";
                    }

                    if (nonwicaClaimPolicyNbr != null && !nonwicaClaimPolicyNbr.equals("") && nonwicaClaimPolicyNbr.length() > 30) {
                        errorMsg += "Policy Number cannot be longer than 30 characters,";
                    }

                    if (nonwicaClaimBasic != null && !nonwicaClaimBasic.equals("") && nonwicaClaimBasic.length() > 1000) {
                        errorMsg += "Claim Baisc cannot be longer than 1000 characters,";
                    }

                    if (remark != null && !remark.equals("") && remark.length() > 1000) {
                        errorMsg += "Remark cannot be longer than 1000 characters,";
                    }
                }   //pass 

                /**
                 * server validation end *
                 */
                if (errorMsg.equals("")) {
                    if (idStr == null) {
                        //create object
                        ProblemNonWicaClaim problemNonWicaClaim = new ProblemNonWicaClaim(workerFinNum, jobKey,
                                problemKey, nonwicaClaimDate, nonwicaClaimLoss, nonwicaClaimInsurer,
                                nonwicaClaimPolicyNbr, nonwicaClaimBasic, remark);

                        ProblemComplementsDAO.addProblemNonWicaClaim(problemNonWicaClaim);

                        //log the audit
                        auditChange = problemNonWicaClaim.toString2();
                        //success display
                        success = "Non Wica Claim has been successfully added!";


                    } else {

                        int id = Integer.parseInt(request.getParameter("Id"));
                        //create object
                        ProblemNonWicaClaim nonwicaClaim = new ProblemNonWicaClaim(id, workerFinNum, jobKey,
                                problemKey, nonwicaClaimDate, nonwicaClaimLoss, nonwicaClaimInsurer,
                                nonwicaClaimPolicyNbr, nonwicaClaimBasic, remark);

                        ProblemComplementsDAO.updateProblemNonWicaClaim(nonwicaClaim);
                        //log the audit
                        auditChange = nonwicaClaim.toString2();
                        //success display
                        success = "Non Wica Claim has been successfully updated!";

                    }

                }

                //=======================================//
                //          12. WICA Monthly Status   
                //=======================================//    
            } else if (complementName.equals("wica")) {
                String wicaUpdateDateStr = "";
                String wicaStatus = "";
                String wicaStatusMore = "";
                String wicaPointsStr = "";
                String wicaDollarsStr = "";
                String wicaRemarks = "";
                java.sql.Date wicaUpdateDate = null;
                Double wicaPoints = 0.0;
                Double wicaDollars = 0.0;

                if (idStr == null) {
                    wicaUpdateDateStr = request.getParameter("ndate");
                    wicaStatus = request.getParameter("nwicaStatus");
                    wicaStatusMore = request.getParameter("nwicaStatusMore");
                    wicaPointsStr = request.getParameter("nwicaPoints");
                    wicaDollarsStr = request.getParameter("nwicaDollars");
                    wicaRemarks = request.getParameter("nremark");
                } else {
                    wicaUpdateDateStr = request.getParameter("date");
                    wicaStatus = request.getParameter("wicaStatus");
                    wicaStatusMore = request.getParameter("wicaStatusMore");
                    wicaPointsStr = request.getParameter("wicaPoints");
                    wicaDollarsStr = request.getParameter("wicaDollars");
                    wicaRemarks = request.getParameter("remark");

                }


                /**
                 * server validation *
                 */
                boolean pass = true; //assume validation pass first;

                if (wicaUpdateDateStr.equals("")) {
                    errorMsg += "Updated Date is blank,";
                    pass = false;
                }
                if (wicaStatus.equals("")) {
                    errorMsg += "WICA Status is blank,";
                    pass = false;
                }

                //proceed only after empty fields validation is passed
                if (pass) {

                    if (!wicaUpdateDateStr.equals("")) {
                        try {
                            java.util.Date tmp = sdf.parse(wicaUpdateDateStr);
                            wicaUpdateDate = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                            errorMsg += "Invalid Updated Wica Date Format,";
                        }
                    }
                    /*
                     if (!wicaStatus.equals("") && wicaStatus.length() > 30) {
                     errorMsg += "WICA Status cannot be longer than 30 characters,";
                     }*/

                    if (!wicaStatusMore.equals("") && wicaStatusMore.length() > 200) {
                        errorMsg += "explain if above is other cannot be longer than 200 characters,";
                    }

                    if (!wicaPointsStr.equals("")) {
                        wicaPointsStr = wicaPointsStr.replace(",", "");
                        if (!wicaPointsStr.matches("^\\d+(\\.\\d{1,2})?$")) {
                            errorMsg += "WICA point must have maximum 2 decimal places,";
                        } else {
                            try {
                                wicaPoints = Double.parseDouble(wicaPointsStr);
                            } catch (Exception ex) {
                                errorMsg += "WICA point - invalid format,";
                            }
                        }
                    }

                    if (!wicaDollarsStr.equals("")) {
                        wicaDollarsStr = wicaDollarsStr.replace(",", "");
                        if (!wicaDollarsStr.matches("^\\d+(\\.\\d{1,2})?$")) {
                            errorMsg += "WICA Dollar must have maximum 2 decimal places,";
                        } else {
                            try {
                                wicaDollars = Double.parseDouble(wicaDollarsStr);
                            } catch (Exception ex) {
                                errorMsg += "WICA Dollar - invalid format,";
                            }
                        }
                    }


                    if (!wicaRemarks.equals("") && wicaRemarks.length() > 200) {
                        errorMsg += "remark cannot be longer than 200 characters,";
                    }


                } //pass

                /**
                 * server validation end *
                 */
                if (errorMsg.equals("")) {
                    if (idStr == null) {
                        //create object
                        ProblemWica problemWica = new ProblemWica(workerFinNum, jobKey, problemKey,
                                wicaUpdateDate, wicaStatus, wicaStatusMore, wicaPoints, wicaDollars,
                                wicaRemarks);
                        ProblemComplementsDAO.addProblemWica(problemWica);

                        //log the audit
                        auditChange = problemWica.toString2();
                        //success display
                        success = "Wica Monthly Status has been successfully added!";


                    } else {
                        int id = Integer.parseInt(request.getParameter("Id"));
                        //create object
                        ProblemWica problemWica = new ProblemWica(id, workerFinNum, jobKey, problemKey,
                                wicaUpdateDate, wicaStatus, wicaStatusMore, wicaPoints, wicaDollars,
                                wicaRemarks);
                        ProblemComplementsDAO.updateProblemWica(problemWica);
                        //log the audit
                        auditChange = problemWica.toString2();
                        //success display
                        success = "Wica Monthly Status has been successfully updated!";


                    }
                }


                //=======================================//
                //          13. Hospital Providing Treatment  
                //=======================================//    
            } else if (complementName.equals("hospital")) {
                String hospitalUpdateDateStr = "";
                String hospitalName = "";
                String hospitalNameMore = "";
                String hospitalDoctor = "";
                String hospitalRemark = "";
                java.sql.Date hospitalUpdateDate = null;

                if (idStr == null) {
                    hospitalUpdateDateStr = request.getParameter("ndate");
                    hospitalName = request.getParameter("nhospName");
                    hospitalNameMore = request.getParameter("nhospNameMore");
                    hospitalDoctor = request.getParameter("nhospDoctor");
                    hospitalRemark = request.getParameter("nremark");

                } else {
                    hospitalUpdateDateStr = request.getParameter("date");
                    hospitalName = request.getParameter("hospName");
                    hospitalNameMore = request.getParameter("hospNameMore");
                    hospitalDoctor = request.getParameter("hospDoctor");
                    hospitalRemark = request.getParameter("remark");

                }

                /**
                 * server validation *
                 */
                boolean pass = true; //assume validation pass first;

                if (hospitalUpdateDateStr.equals("")) {
                    errorMsg += "Updated Date is blank,";
                    pass = false;
                }
                if (hospitalName.equals("")) {
                    errorMsg += "Hospital Name is blank,";
                    pass = false;
                }

                //proceed only after empty fields validation is passed
                if (pass) {

                    if (!hospitalUpdateDateStr.equals("")) {
                        try {
                            java.util.Date tmp = sdf.parse(hospitalUpdateDateStr);
                            hospitalUpdateDate = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                            errorMsg += "Invalid Updated Date Format,";
                        }
                    }

                    if (!hospitalName.equals("") && hospitalName.length() > 30) {
                        errorMsg += "Hosptial Name cannot be longer than 30 characters,";
                    }

                    if (hospitalNameMore != null && !hospitalNameMore.equals("") && hospitalNameMore.length() > 50) {
                        errorMsg += "Explain if above is other cannot be longer than 50 characters,";
                    }

                    if (hospitalDoctor != null && !hospitalDoctor.equals("") && hospitalDoctor.length() > 200) {
                        errorMsg += "Doctor Name cannot be longer than 200 characters,";
                    }

                    if (hospitalRemark != null && !hospitalRemark.equals("") && hospitalRemark.length() > 200) {
                        errorMsg += "remark cannot be longer than 200 characters,";
                    }


                } //pass


                /**
                 * server validation end *
                 */
                if (errorMsg.equals("")) {
                    if (idStr == null) {

                        //for associate
                        if (hospitalDoctor == null && hospitalRemark == null) {
                            hospitalDoctor = "";
                            hospitalRemark = "";
                        }

                        //create object
                        ProblemHospital hospital = new ProblemHospital(workerFinNum, jobKey, problemKey,
                                hospitalUpdateDate, hospitalName, hospitalNameMore, hospitalDoctor, hospitalRemark);

                        //add into db
                        ProblemComplementsDAO.addProblemHospital(hospital);

                        //log the audit
                        auditChange = hospital.toString2();

                        //success display
                        success = "Hospital Providing Treatment has been successfully added!";
                    } else {
                        int id = Integer.parseInt(request.getParameter("Id"));
                        //create object
                        ProblemHospital hospital = new ProblemHospital(id, workerFinNum, jobKey, problemKey,
                                hospitalUpdateDate, hospitalName, hospitalNameMore, hospitalDoctor, hospitalRemark);

                        //add into db
                        ProblemComplementsDAO.updateProblemHospital(hospital);
                        //log the audit
                        auditChange = hospital.toString2();
                        //success display
                        success = "Hospital Providing Treatment has been successfully updated!";
                    }
                }


                //=======================================//
                //          14. MC/Light Duty Status 
                //=======================================//    
            } else if (complementName.equals("mc")) {

                String mcUpdateDateStr = "";
                String mcStatus = "";
                String mcStatusMore = "";
                String mcExpireDateStr = "";
                String mcDaysCumStr = "";
                String mcRemark = "";
                java.sql.Date mcUpdateDate = null;
                java.sql.Date mcExpireDate = null;
                int mcDaysCum = 0;

                if (idStr == null) {
                    mcUpdateDateStr = request.getParameter("ndate");
                    mcStatus = request.getParameter("nmcStatus");
                    mcStatusMore = request.getParameter("nmcStatusMore");
                    mcExpireDateStr = request.getParameter("nexpDate");
                    mcDaysCumStr = request.getParameter("nexpCum");
                    mcRemark = request.getParameter("nremark");
                } else {
                    mcUpdateDateStr = request.getParameter("date");
                    mcStatus = request.getParameter("mcStatus");
                    mcStatusMore = request.getParameter("mcStatusMore");
                    mcExpireDateStr = request.getParameter("expDate");
                    mcDaysCumStr = request.getParameter("expCum");
                    mcRemark = request.getParameter("remark");
                }

                /**
                 * server validation *
                 */
                boolean pass = true; //assume validation pass first;

                if (mcUpdateDateStr.equals("")) {
                    errorMsg += "Updated Date is blank,";
                    pass = false;
                }
                if (mcStatus.equals("")) {
                    errorMsg += "MC Status is blank,";
                    pass = false;
                }

                //proceed only after empty fields validation is passed
                if (pass) {

                    if (!mcUpdateDateStr.equals("")) {
                        try {
                            java.util.Date tmp = sdf.parse(mcUpdateDateStr);
                            mcUpdateDate = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                            errorMsg += "Invalid Updated Date Format,";
                        }
                    }

                    if (!mcExpireDateStr.equals("")) {
                        try {
                            java.util.Date tmp = sdf.parse(mcExpireDateStr);
                            mcExpireDate = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                            errorMsg += "Invalid Expiry Date Format,";
                        }
                    }

                    if (!mcStatus.equals("") && mcStatus.length() > 20) {
                        errorMsg += "MC Status cannot be longer than 20 characters,";
                    }

                    if (!mcStatusMore.equals("") && mcStatusMore.length() > 50) {
                        errorMsg += "Explain if above is other cannot be longer than 50 characters,";
                    }

                    if (!mcRemark.equals("") && mcRemark.length() > 200) {
                        errorMsg += "remark cannot be longer than 200 characters,";
                    }

                    if (!mcDaysCumStr.equals("")) {
                        try {
                            mcDaysCum = Integer.parseInt(mcDaysCumStr);
                        } catch (Exception ex) {
                            errorMsg += "MC cumulative days must be an integer,";
                        }
                    }

                } //pass


                /**
                 * server validation end *
                 */
                if (errorMsg.equals("")) {
                    if (idStr == null) {

                        //create object
                        ProblemMCStatus problemMCStatus = new ProblemMCStatus(workerFinNum, jobKey, problemKey,
                                mcUpdateDate, mcStatus, mcStatusMore, mcExpireDate, mcDaysCum, mcRemark);

                        ProblemComplementsDAO.addProblemMCStatus(problemMCStatus);

                        //log the audit
                        auditChange = problemMCStatus.toString2();

                        //success display
                        success = "MC/light Duty Status has been successfully added!";

                    } else {
                        int id = Integer.parseInt(request.getParameter("Id"));
                        //create object
                        ProblemMCStatus problemMCStatus = new ProblemMCStatus(id, workerFinNum, jobKey, problemKey,
                                mcUpdateDate, mcStatus, mcStatusMore, mcExpireDate, mcDaysCum, mcRemark);

                        ProblemComplementsDAO.updateProblemMCStatus(problemMCStatus);
                        //log the audit
                        auditChange = problemMCStatus.toString2();

                        //success display
                        success = "MC/light Duty Status has been successfully updated!";

                    }
                }

                //=======================================//
                //          15. R2R Appointments  
                //=======================================//    
            } else if (complementName.equals("r2r")) {
                String r2rDateStr = "";
                String r2rTime = "";
                String r2rHosp = "";
                String r2rDept = "";
                String r2r1 = "";
                String r2r2 = "";
                String r2rPurpose = "";
                String r2rPreApptNotes = "";
                String r2rPostApptNotes = "";
                String r2rFeedback = "";
                String r2rMedCostStr = "";
                String r2rOutlayStr = "";
                java.sql.Date r2rDate = null;
                Double r2rMedCost = 0.0;
                Double r2rOutlay = 0.0;

                if (idStr == null) {
                    r2rDateStr = request.getParameter("ndate");
                    r2rTime = request.getParameter("nr2rTime");
                    r2rHosp = request.getParameter("nr2rHosp");
                    r2rDept = request.getParameter("nr2rDept");
                    r2r1 = request.getParameter("nr2r1");
                    r2r2 = request.getParameter("nr2r2");
                    r2rPurpose = request.getParameter("nr2rPurpose");
                    r2rPreApptNotes = request.getParameter("nr2rPreApptNotes");
                    r2rPostApptNotes = request.getParameter("nr2rPostApptNotes");
                    r2rFeedback = request.getParameter("nr2rFeedback");
                    r2rMedCostStr = request.getParameter("nr2rMed");
                    r2rOutlayStr = request.getParameter("nr2rOut");

                } else {
                    r2rDateStr = request.getParameter("date");
                    r2rTime = request.getParameter("r2rTime");
                    r2rHosp = request.getParameter("r2rHosp");
                    r2rDept = request.getParameter("r2rDept");
                    r2r1 = request.getParameter("r2r1");
                    r2r2 = request.getParameter("r2r2");
                    r2rPurpose = request.getParameter("r2rPurpose");
                    r2rPreApptNotes = request.getParameter("r2rPreApptNotes");
                    r2rPostApptNotes = request.getParameter("r2rPostApptNotes");
                    r2rFeedback = request.getParameter("r2rFeedback");
                    r2rMedCostStr = request.getParameter("r2rMed");
                    r2rOutlayStr = request.getParameter("r2rOut");
                }

                /**
                 * server validation *
                 */
                boolean pass = true; //assume validation pass first;

                if (r2rDateStr.equals("")) {
                    errorMsg += "Date is blank,";
                    pass = false;
                }
                if (r2rHosp.equals("")) {
                    errorMsg += "Hospital Name is blank,";
                    pass = false;
                }

                //proceed only after empty fields validation is passed
                if (pass) {

                    if (!r2rDateStr.equals("")) {
                        try {
                            java.util.Date tmp = sdf.parse(r2rDateStr);
                            r2rDate = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                            errorMsg += "Invalid R2R Date Format,";
                        }
                    }

                    if (r2rMedCostStr != null && !r2rMedCostStr.equals("")) {
                        r2rMedCostStr = r2rMedCostStr.replace(",", "");
                        if (!r2rMedCostStr.matches("^\\d+(\\.\\d{1,2})?$")) {
                            errorMsg += "Medical Cost must have maximum 2 decimal places,";
                        } else {
                            try {
                                r2rMedCost = Double.parseDouble(r2rMedCostStr);
                            } catch (Exception ex) {
                                errorMsg += "Medical Cost - invalid format,";
                            }
                        }
                    }

                    if (r2rOutlayStr != null && !r2rOutlayStr.equals("")) {
                        r2rOutlayStr = r2rOutlayStr.replace(",", "");
                        if (!r2rOutlayStr.matches("^\\d+(\\.\\d{1,2})?$")) {
                            errorMsg += "Outlay Cost must have maximum 2 decimal places,";
                        } else {
                            try {
                                r2rOutlay = Double.parseDouble(r2rOutlayStr);
                            } catch (Exception ex) {
                                errorMsg += "Outlay Cost - invalid format,";
                            }
                        }
                    }

                    if (r2rTime != null && !r2rTime.equals("") && r2rTime.length() > 20) {
                        errorMsg += "Time cannot be longer than 20 characters,";
                    }

                    if (r2rHosp != null && !r2rHosp.equals("") && r2rHosp.length() > 20) {
                        errorMsg += "Hospital cannot be longer than 20 characters,";
                    }

                    if (r2rDept != null && !r2rDept.equals("") && r2rDept.length() > 50) {
                        errorMsg += "Department cannot be longer than 50 characters,";
                    }

                    if (r2r1 != null && !r2r1.equals("") && r2r1.length() > 20) {
                        errorMsg += "R2R person cannot be longer than 20 characters,";
                    }

                    if (r2r2 != null && !r2r2.equals("") && r2r2.length() > 20) {
                        errorMsg += "R2R person cannot be longer than 20 characters,";
                    }

                    if (r2rPurpose != null && !r2rPurpose.equals("") && r2rPurpose.length() > 50) {
                        errorMsg += "Purpose cannot be longer than 50 characters,";
                    }

                    if (r2rPreApptNotes != null && !r2rPreApptNotes.equals("") && r2rPreApptNotes.length() > 200) {
                        errorMsg += "Pre appointment note cannot be longer than 200 characters,";
                    }

                    if (r2rPostApptNotes != null && !r2rPostApptNotes.equals("") && r2rPostApptNotes.length() > 200) {
                        errorMsg += "post appointment note cannot be longer than 200 characters,";
                    }

                    if (r2rFeedback != null && !r2rFeedback.equals("") && r2rFeedback.length() > 200) {
                        errorMsg += "feedback cannot be longer than 200 characters,";
                    }

                } //pass


                /**
                 * server validation end *
                 */
                if (errorMsg.equals("")) {
                    if (idStr == null) {


                        //create object
                        ProblemR2R problemR2R = new ProblemR2R(workerFinNum, jobKey, problemKey, r2rDate,
                                r2rTime, r2rHosp, r2rDept, r2r1, r2r2, r2rPurpose, r2rPreApptNotes,
                                r2rPostApptNotes, r2rFeedback, r2rMedCost, r2rOutlay);
                        //add to db
                        ProblemComplementsDAO.addProblemR2R(problemR2R);

                        //log the audit
                        auditChange = problemR2R.toString2();

                        //success display
                        success = "R2R Appointments has been successfully added!";

                    } else {
                        int id = Integer.parseInt(request.getParameter("Id"));
                        //create object
                        ProblemR2R problemR2R = new ProblemR2R(id, workerFinNum, jobKey, problemKey, r2rDate,
                                r2rTime, r2rHosp, r2rDept, r2r1, r2r2, r2rPurpose, r2rPreApptNotes,
                                r2rPostApptNotes, r2rFeedback, r2rMedCost, r2rOutlay);
                        //add to db
                        ProblemComplementsDAO.updateProblemR2R(problemR2R);
                        //log the audit
                        auditChange = problemR2R.toString2();

                        //success display
                        success = "R2R Appointments has been successfully updated!";

                    }

                }

                //=======================================//
                //          Other Complements   
                //=======================================//
                //=======================================//
                //  16. Details & History of Other Problem 
                //=======================================//
            } else if (complementName.equals("othercase")) {
                String otherProblemDesc = "";
                String otherProblemLossStr = "";
                String otherProblemRemark = "";
                Double otherProblemLoss = 0.0;

                if (idStr == null) {
                    otherProblemDesc = request.getParameter("nother");
                    otherProblemLossStr = request.getParameter("nloss");
                    otherProblemRemark = request.getParameter("nremark");
                } else {
                    otherProblemDesc = request.getParameter("other");
                    otherProblemLossStr = request.getParameter("loss");
                    otherProblemRemark = request.getParameter("remark");

                }

                /**
                 * server validation *
                 */
                boolean pass = true; //assume validation pass first;
                if (otherProblemDesc.equals("")) {
                    errorMsg += "Description is blank,";
                    pass = false;
                }

                //proceed only after empty fields validation is passed
                if (pass) {

                    if (!otherProblemDesc.equals("") && otherProblemDesc.length() > 1000) {
                        errorMsg += "Description cannot be more than 1000 characters,";
                    }

                    if (!otherProblemLossStr.equals("")) {
                        try {
                            otherProblemLoss = Double.parseDouble(otherProblemLossStr);
                        } catch (Exception ex) {
                            errorMsg += "Loss Amount - invalid format,";
                        }
                    }

                    if (!otherProblemRemark.equals("") && otherProblemRemark.length() > 200) {
                        errorMsg += "remark cannot be longer than 200 characters,";
                    }

                }   //pass 

                /**
                 * server validation end *
                 */
                if (errorMsg.equals("")) {
                    if (idStr == null) {

                        //create object
                        ProblemOtherProblems other = new ProblemOtherProblems(workerFinNum, jobKey, problemKey,
                                otherProblemDesc, otherProblemLoss, otherProblemRemark);

                        ProblemComplementsDAO.addProblemOtherProblems(other);

                        //log the audit
                        auditChange = other.toString2();

                        //success display
                        success = "Details and History of Other Problem has been successfully added!";
                    } else {

                        int id = Integer.parseInt(request.getParameter("Id"));
                        //create object
                        ProblemOtherProblems other = new ProblemOtherProblems(id, workerFinNum, jobKey, problemKey,
                                otherProblemDesc, otherProblemLoss, otherProblemRemark);

                        ProblemComplementsDAO.updateProblemOtherProblems(other);
                        //log the audit
                        auditChange = other.toString2();
                        //success display
                        success = "Details and History of Other Problem has been successfully updated!";
                    }
                }
                //=======================================//
                //          18. Police Report Lodged  
                //=======================================//
            } else if (complementName.equals("policareport")) {
                String policeReportDateStr = request.getParameter("ndate");
                String policeReportStation = request.getParameter("npoliceReportStation");
                String policeReportPerson = request.getParameter("npoliceReportPerson");
                String policeReportRefNumber = request.getParameter("npoliceReportRefNumber");
                String policeReportRefDetails = request.getParameter("npoliceReportDetails");
                String policeReportRemark = request.getParameter("nremark");
                java.sql.Date policeReportDate = null;

                if (idStr == null) {
                    policeReportDateStr = request.getParameter("ndate");
                    policeReportStation = request.getParameter("npoliceReportStation");
                    policeReportPerson = request.getParameter("npoliceReportPerson");
                    policeReportRefNumber = request.getParameter("npoliceReportRefNumber");
                    policeReportRefDetails = request.getParameter("npoliceReportDetails");
                    policeReportRemark = request.getParameter("nremark");

                } else {
                    policeReportDateStr = request.getParameter("date");
                    policeReportStation = request.getParameter("policeReportStation");
                    policeReportPerson = request.getParameter("policeReportPerson");
                    policeReportRefNumber = request.getParameter("policeReportRefNumber");
                    policeReportRefDetails = request.getParameter("policeReportDetails");
                    policeReportRemark = request.getParameter("remark");

                }

                /**
                 * server validation *
                 */
                boolean pass = true; //assume validation pass first;

                if (policeReportDateStr.equals("")) {
                    errorMsg += "reported date is blank,";
                    pass = false;
                }

                //proceed only after empty fields validation is passed
                if (pass) {

                    if (!policeReportDateStr.equals("")) {
                        try {
                            java.util.Date tmp = sdf.parse(policeReportDateStr);
                            policeReportDate = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                            errorMsg += "Invalid police report Date Format,";
                        }
                    }

                    if (!policeReportStation.equals("") && policeReportStation.length() > 50) {
                        errorMsg += "report station cannot be longer than 50 characters,";
                    }

                    if (!policeReportPerson.equals("") && policeReportPerson.length() > 200) {
                        errorMsg += "report person cannot be longer than 200 characters,";
                    }

                    if (!policeReportRefNumber.equals("") && policeReportRefNumber.length() > 30) {
                        errorMsg += "reference number cannot be longer than 30 characters,";
                    }

                    if (!policeReportRefDetails.equals("") && policeReportRefDetails.length() > 1000) {
                        errorMsg += "report reference details cannot be longer than 1000 characters,";
                    }

                    if (!policeReportRemark.equals("") && policeReportRemark.length() > 200) {
                        errorMsg += "remark cannot be longer than 200 characters,";
                    }
                }   //pass

                /**
                 * server validation end *
                 */
                if (errorMsg.equals("")) {
                    if (idStr == null) {

                        //create object
                        ProblemPoliceReport policeReport = new ProblemPoliceReport(workerFinNum, jobKey,
                                problemKey, policeReportDate, policeReportStation, policeReportPerson,
                                policeReportRefNumber, policeReportRefDetails, policeReportRemark);

                        //add to db
                        ProblemComplementsDAO.addProblemPoliceReport(policeReport);

                        //log the audit
                        auditChange = policeReport.toString2();

                        //success display
                        success = "Police Report has been added successfully!";

                    } else {
                        int id = Integer.parseInt(request.getParameter("Id"));
                        //create object
                        ProblemPoliceReport policeReport = new ProblemPoliceReport(id, workerFinNum, jobKey,
                                problemKey, policeReportDate, policeReportStation, policeReportPerson,
                                policeReportRefNumber, policeReportRefDetails, policeReportRemark);

                        //add to db
                        ProblemComplementsDAO.updateProblemPoliceReport(policeReport);

                        auditChange = policeReport.toString2();

                        //success display
                        success = "Police Report has been updated successfully!";
                    }
                }

                //=======================================//
                //          19. Other Complaint Lodged
                //=======================================//    
            } else if (complementName.equals("othercomplaint")) {
                String otherComplaintDateStr = request.getParameter("ndate");
                String otherComplaintAgency = request.getParameter("ncomplaintAgency");
                String otherComplaintWho = request.getParameter("ncomplaintWho");
                String otherComplaintWhoMore = request.getParameter("ncomplaintWhoMore");
                String otherComplaintMode = request.getParameter("ncomplaintMode");
                String otherComplaintModeMore = request.getParameter("ncomplaintModeMore");
                String otherComplaintDetails = request.getParameter("ncomplaintDetails");
                String otherComplaintRemark = request.getParameter("nremark");
                java.sql.Date otherComplaintDate = null;

                if (idStr == null) {
                    otherComplaintDateStr = request.getParameter("ndate");
                    otherComplaintAgency = request.getParameter("ncomplaintAgency");
                    otherComplaintWho = request.getParameter("ncomplaintWho");
                    otherComplaintWhoMore = request.getParameter("ncomplaintWhoMore");
                    otherComplaintMode = request.getParameter("ncomplaintMode");
                    otherComplaintModeMore = request.getParameter("ncomplaintModeMore");
                    otherComplaintDetails = request.getParameter("ncomplaintDetails");
                    otherComplaintRemark = request.getParameter("nremark");
                } else {
                    otherComplaintDateStr = request.getParameter("date");
                    otherComplaintAgency = request.getParameter("complaintAgency");
                    otherComplaintWho = request.getParameter("complaintWho");
                    otherComplaintWhoMore = request.getParameter("complaintWhoMore");
                    otherComplaintMode = request.getParameter("complaintMode");
                    otherComplaintModeMore = request.getParameter("complaintModeMore");
                    otherComplaintDetails = request.getParameter("complaintDetails");
                    otherComplaintRemark = request.getParameter("remark");

                }

                /**
                 * server validation *
                 */
                boolean pass = true; //assume validation pass first;

                if (otherComplaintDateStr.equals("")) {
                    errorMsg += "date is blank,";
                    pass = false;
                }
                if (otherComplaintAgency.equals("")) {
                    errorMsg += "agency name is blank,";
                    pass = false;
                }
                if (otherComplaintWho.equals("")) {
                    errorMsg += "complaint to who is blank,";
                    pass = false;
                }

                //proceed only after empty fields validation is passed
                if (pass) {

                    if (!otherComplaintDateStr.equals("")) {
                        try {
                            java.util.Date tmp = sdf.parse(otherComplaintDateStr);
                            otherComplaintDate = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                            errorMsg += "Invalid complaint lodged Date Format,";
                        }
                    }

                    if (!otherComplaintAgency.equals("") && otherComplaintAgency.length() > 50) {
                        errorMsg += "Complaint Agency cannot be longer than 50 characters,";
                    }

                    if (!otherComplaintWho.equals("") && otherComplaintWho.length() > 12) {
                        errorMsg += "Who Complain cannot be longer than 12 characters,";
                    }

                    if (!otherComplaintWhoMore.equals("") && otherComplaintWhoMore.length() > 50) {
                        errorMsg += "Explain if above is cannot be longer than 50 characters,";
                    }

                    if (!otherComplaintMode.equals("") && otherComplaintMode.length() > 30) {
                        errorMsg += "Complaint Mode cannot be longer than 30 characters,";
                    }

                    if (!otherComplaintModeMore.equals("") && otherComplaintModeMore.length() > 200) {
                        errorMsg += "Explain if above is other cannot be longer than 200 characters,";
                    }

                    if (!otherComplaintDetails.equals("") && otherComplaintDetails.length() > 1000) {
                        errorMsg += "Details cannot be longer than 1000 characters,";
                    }

                    if (!otherComplaintRemark.equals("") && otherComplaintRemark.length() > 200) {
                        errorMsg += "remark cannot be longer than 200 characters,";
                    }

                } //pass

                /**
                 * server validation end *
                 */
                if (errorMsg.equals("")) {
                    if (idStr == null) {
                        //create object
                        ProblemOtherComplaint otherComplaint = new ProblemOtherComplaint(workerFinNum, jobKey,
                                problemKey, otherComplaintDate, otherComplaintAgency, otherComplaintWho,
                                otherComplaintWhoMore, otherComplaintMode, otherComplaintModeMore,
                                otherComplaintDetails, otherComplaintRemark);
                        //add to db
                        ProblemComplementsDAO.addProblemOtherComplaint(otherComplaint);

                        //log the audit
                        auditChange = otherComplaint.toString2();

                        //success display
                        success = "Other Complaint has been successfully added!";

                    } else {
                        int id = Integer.parseInt(request.getParameter("Id"));
                        //create object
                        ProblemOtherComplaint problemOtherComplaint = new ProblemOtherComplaint(id, workerFinNum, jobKey,
                                problemKey, otherComplaintDate, otherComplaintAgency, otherComplaintWho,
                                otherComplaintWhoMore, otherComplaintMode, otherComplaintModeMore,
                                otherComplaintDetails, otherComplaintRemark);
                        //add to db
                        ProblemComplementsDAO.updateProblemOtherComplaint(problemOtherComplaint);
                        //log the audit
                        auditChange = problemOtherComplaint.toString2();
                        //success display
                        success = "Other Complaint has been successfully updated!";
                    }
                }


                //=======================================//
                //20. Case Milestone Reached(non-criminal) 
                //=======================================//    
            } else if (complementName.equals("ncmilestone")) {
                String ncmileStoneDateStr = request.getParameter("ndate");
                String ncmileStoneReach = request.getParameter("nmilestoneNCReached");
                String ncmileStoneReachMore = request.getParameter("nmilestoneNCReachedMore");
                String ncmileStoneRemark = request.getParameter("nremark");
                java.sql.Date ncmileStoneDate = null;

                if (idStr == null) {
                    ncmileStoneDateStr = request.getParameter("ndate");
                    ncmileStoneReach = request.getParameter("nmilestoneNCReached");
                    ncmileStoneReachMore = request.getParameter("nmilestoneNCReachedMore");
                    ncmileStoneRemark = request.getParameter("nremark");
                } else {
                    ncmileStoneDateStr = request.getParameter("date");
                    ncmileStoneReach = request.getParameter("milestoneNCReached");
                    ncmileStoneReachMore = request.getParameter("milestoneNCReachedMore");
                    ncmileStoneRemark = request.getParameter("remark");
                }

                /**
                 * server validation *
                 */
                boolean pass = true; //assume validation pass first;

                if (ncmileStoneDateStr.equals("")) {
                    errorMsg += "Date is blank,";
                    pass = false;
                }
                if (ncmileStoneReach.equals("")) {
                    errorMsg += "Mile Stone Reached is blank,";
                    pass = false;
                }

                //proceed only after empty fields validation is passed
                if (pass) {

                    if (!ncmileStoneDateStr.equals("")) {
                        try {
                            java.util.Date tmp = sdf.parse(ncmileStoneDateStr);
                            ncmileStoneDate = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                            errorMsg += "Invalid Milestone NC Reached Date Format,";
                        }
                    }

                    if (ncmileStoneReach != null && !ncmileStoneReach.equals("") && ncmileStoneReach.length() > 50) {
                        errorMsg += "Mile Stone reach cannot be longer than 50 characters,";
                    }

                    if (ncmileStoneReachMore != null && !ncmileStoneReachMore.equals("") && ncmileStoneReachMore.length() > 200) {
                        errorMsg += "Explain if above is other cannot be longer than 200 characters,";
                    }

                    if (ncmileStoneRemark != null && !ncmileStoneRemark.equals("") && ncmileStoneRemark.length() > 200) {
                        errorMsg += "remark cannot be longer than 200 characters,";
                    }


                } //pass

                /**
                 * server validation end *
                 */
                if (errorMsg.equals("")) {
                    if (idStr == null) {

                        //create object
                        ProblemCaseMilestoneNC problemCaseMilestoneNC = new ProblemCaseMilestoneNC(workerFinNum, jobKey,
                                problemKey, ncmileStoneDate, ncmileStoneReach, ncmileStoneReachMore,
                                ncmileStoneRemark);
                        //add to db
                        ProblemComplementsDAO.addProblemCaseMilestoneNC(problemCaseMilestoneNC);

                        //log the audit
                        auditChange = problemCaseMilestoneNC.toString2();

                        //success display
                        success = "Case Milestone reached (non-criminal) has been successfully added!";
                    } else {
                        int id = Integer.parseInt(request.getParameter("Id"));
                        //create object
                        ProblemCaseMilestoneNC problemCaseMilestoneNC = new ProblemCaseMilestoneNC(id, workerFinNum, jobKey,
                                problemKey, ncmileStoneDate, ncmileStoneReach, ncmileStoneReachMore,
                                ncmileStoneRemark);
                        //add to db
                        ProblemComplementsDAO.updateProblemCaseMilestoneNC(problemCaseMilestoneNC);
                        //log the audit
                        auditChange = problemCaseMilestoneNC.toString2();
                        //success display
                        success = "Case Milestone reached (non-criminal) has been successfully updated!";

                    }
                }

                //=======================================//
                //21. Case Milestone Reached(Criminal)     
                //=======================================//    
            } else if (complementName.equals("cmilestone")) {
                String cmileStoneDateStr = request.getParameter("ndate");
                String cmileStoneReach = request.getParameter("nmilestoneCRReached");
                String cmileStoneReachMore = request.getParameter("nmilestoneCRReachedMore");
                String cmileStoneCharge = request.getParameter("nmilestoneCRCharges");
                String cmileStoneSentence = request.getParameter("nmilestoneCRSentence");
                String cmileStoneRemark = request.getParameter("nremark");
                java.sql.Date cmileStoneDate = null;

                if (idStr == null) {
                    cmileStoneDateStr = request.getParameter("ndate");
                    cmileStoneReach = request.getParameter("nmilestoneCRReached");
                    cmileStoneReachMore = request.getParameter("nmilestoneCRReachedMore");
                    cmileStoneCharge = request.getParameter("nmilestoneCRCharges");
                    cmileStoneSentence = request.getParameter("nmilestoneCRSentence");
                    cmileStoneRemark = request.getParameter("nremark");
                } else {
                    cmileStoneDateStr = request.getParameter("date");
                    cmileStoneReach = request.getParameter("milestoneCRReached");
                    cmileStoneReachMore = request.getParameter("milestoneCRReachedMore");
                    cmileStoneCharge = request.getParameter("milestoneCRCharges");
                    cmileStoneSentence = request.getParameter("milestoneCRSentence");
                    cmileStoneRemark = request.getParameter("remark");

                }

                /**
                 * server validation *
                 */
                boolean pass = true; //assume validation pass first;

                if (cmileStoneDateStr.equals("")) {
                    errorMsg += "Date is blank,";
                    pass = false;
                }
                if (cmileStoneReach.equals("")) {
                    errorMsg += "Reach is blank,";
                    pass = false;
                }



                //proceed only after empty fields validation is passed
                if (pass) {

                    if (!cmileStoneDateStr.equals("")) {
                        try {
                            java.util.Date tmp = sdf.parse(cmileStoneDateStr);
                            cmileStoneDate = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                            errorMsg += "Invalid Milestone CR Reached Date Format,";
                        }
                    }

                    if (!cmileStoneReach.equals("") && cmileStoneReach.length() > 50) {
                        errorMsg += "Milestone reach cannot be longer than 50 characters,";
                    }

                    if (!cmileStoneReachMore.equals("") && cmileStoneReachMore.length() > 200) {
                        errorMsg += "explain if above is other cannot be longer than 200 characters,";
                    }

                    if (!cmileStoneCharge.equals("") && cmileStoneCharge.length() > 200) {
                        errorMsg += "Milestone charge cannot be longer than 200 characters,";
                    }

                    if (!cmileStoneSentence.equals("") && cmileStoneSentence.length() > 200) {
                        errorMsg += "Mile Stone Sentence cannot be longer than 200 characters,";
                    }

                    if (!cmileStoneRemark.equals("") && cmileStoneRemark.length() > 200) {
                        errorMsg += "Remark cannot be longer than 200 characters,";
                    }

                } //pass

                /**
                 * server validation end *
                 */
                if (errorMsg.equals("")) {
                    if (idStr == null) {
                        //create object
                        ProblemCaseMilestoneCR problemCaseMilestoneCR = new ProblemCaseMilestoneCR(workerFinNum, jobKey,
                                problemKey, cmileStoneDate, cmileStoneReach, cmileStoneReachMore,
                                cmileStoneCharge, cmileStoneSentence, cmileStoneRemark);
                        //add to db
                        ProblemComplementsDAO.addProblemCaseMilestoneCR(problemCaseMilestoneCR);

                        //log the audit
                        auditChange = problemCaseMilestoneCR.toString2();

                        //success display
                        success = "Case Milestone reached (Criminal) has been successfully added!";
                    } else {
                        int id = Integer.parseInt(request.getParameter("Id"));
                        //create object
                        ProblemCaseMilestoneCR problemCaseMilestoneCR = new ProblemCaseMilestoneCR(
                                id, workerFinNum, jobKey,
                                problemKey, cmileStoneDate, cmileStoneReach, cmileStoneReachMore,
                                cmileStoneCharge, cmileStoneSentence, cmileStoneRemark);
                        //add to db
                        ProblemComplementsDAO.updateProblemCaseMilestoneCR(problemCaseMilestoneCR);
                        //log the audit
                        auditChange = problemCaseMilestoneCR.toString2();
                        //success display
                        success = "Case Milestone reached (Criminal) has been successfully updated!";


                    }
                }

                //=======================================//
                //      22. Transfer, TJS & Repatriation    
                //=======================================//    
            } else if (complementName.equals("ttr")) {
                String ttrUpdateDateStr = "";
                String ttrStatus = "";
                String ttrStatusMore = "";
                String ttrDepatureDateStr = "";
                String ttrNewEmployer = "";
                String ttrNewJob = "";
                String ttrRemark = "";
                java.sql.Date ttrUpdateDate = null;
                java.sql.Date ttrDepatureDate = null;

                if (idStr == null) {
                    ttrUpdateDateStr = request.getParameter("ndate");
                    ttrStatus = request.getParameter("nttrStatus");
                    ttrStatusMore = request.getParameter("nttrStatusMore");
                    ttrDepatureDateStr = request.getParameter("nttrDepartureDate");
                    ttrNewEmployer = request.getParameter("nttrEmployerName");
                    ttrNewJob = request.getParameter("nttrJob");
                    ttrRemark = request.getParameter("nttrremark");
                } else {
                    ttrUpdateDateStr = request.getParameter("date");
                    ttrStatus = request.getParameter("ttrStatus");
                    ttrStatusMore = request.getParameter("ttrStatusMore");
                    ttrDepatureDateStr = request.getParameter("ttrDepartureDate");
                    ttrNewEmployer = request.getParameter("ttrEmployerName");
                    ttrNewJob = request.getParameter("ttrJob");
                    ttrRemark = request.getParameter("ttrremark");

                }

                /**
                 * server validation *
                 */
                boolean pass = true; //assume validation pass first;

                if (ttrUpdateDateStr.equals("")) {
                    errorMsg += "Updated Date is blank,";
                    pass = false;
                }
                if (ttrStatus.equals("")) {
                    errorMsg += "TTR Status is blank,";
                    pass = false;
                }

                //proceed only after empty fields validation is passed
                if (pass) {

                    if (!ttrUpdateDateStr.equals("")) {
                        try {
                            java.util.Date tmp = sdf.parse(ttrUpdateDateStr);
                            ttrUpdateDate = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                            errorMsg += "Invalid Updated TTR Date Format,";
                        }
                    }

                    if (!ttrStatus.equals("") && ttrStatus.length() > 50) {
                        errorMsg += "TTR Status cannot be longer than 50 characters,";
                    }

                    if (ttrStatusMore != null && !ttrStatusMore.equals("") && ttrStatusMore.length() > 200) {
                        errorMsg += "explain if above is other cannot be longer than 200 characters,";
                    }

                    if (!ttrDepatureDateStr.equals("") && ttrDepatureDateStr.length() > 50) {
                        errorMsg += "Departure date cannot be longer than 50 characters,";
                    }

//                    if (!ttrDepatureDateStr.equals("")) {
//                        try {
//                            java.util.Date tmp = sdf.parse(ttrDepatureDateStr);
//                            ttrDepatureDate = new java.sql.Date(tmp.getTime());
//                        } catch (ParseException ex) {
//                            errorMsg += "Invalid depatureDate Date Format,";
//                        } 
//                    }


                    if (ttrNewEmployer != null && !ttrNewEmployer.equals("") && ttrNewEmployer.length() > 50) {
                        errorMsg += "new employer name cannot be longer than 50 characters,";
                    }

                    if (ttrNewJob != null && !ttrNewJob.equals("") && ttrNewJob.length() > 200) {
                        errorMsg += "new job cannot be longer than 50 characters,";
                    }

                    if (ttrRemark != null && !ttrRemark.equals("") && ttrRemark.length() > 200) {
                        errorMsg += "remark cannot be longer than 200 characters,";
                    }


                } //pass

                /**
                 * server validation end *
                 */
                if (errorMsg.equals("")) {
                    if (idStr == null) {
                        //create object
                        ProblemTTR problemTTR = new ProblemTTR(workerFinNum, jobKey, problemKey, ttrUpdateDate,
                                ttrStatus, ttrStatusMore, ttrDepatureDateStr, ttrNewEmployer, ttrNewJob,
                                ttrRemark);
                        //add to db
                        ProblemComplementsDAO.addProblemTTR(problemTTR);

                        //log the audit
                        auditChange = problemTTR.toString2();


                        //success display
                        success = "TTR has been successfully added!";
                    } else {

                        int id = Integer.parseInt(request.getParameter("Id"));
                        //create object
                        ProblemTTR problemTTR = new ProblemTTR(id, workerFinNum, jobKey, problemKey, ttrUpdateDate,
                                ttrStatus, ttrStatusMore, ttrDepatureDateStr, ttrNewEmployer, ttrNewJob,
                                ttrRemark);
                        //add to db
                        ProblemComplementsDAO.updateProblemTTR(problemTTR);
                        //log the audit
                        auditChange = problemTTR.toString2();
                        //success display
                        success = "TTR has been successfully updated!";
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
                //log to audit
                UserAuditLog userAuditLog = new UserAuditLog(_user.getUsername(), problemKey + "",
                        workerFinNum, action, auditChange + " has been " + action.toLowerCase()
                        + "ed to worker " + workerFinNum + ".");

                UserAuditLogDAO.addUserAuditLog(userAuditLog);

            }

            request.getSession().setAttribute("successProbCompMsg", success);
            request.getSession().setAttribute("errorProbCompMsg", errorMsg);
            request.getSession().setAttribute("tabIndicator", "problem");
            request.getSession().setAttribute("worker", workerFinNum);
            request.getSession().setAttribute("selectedProb", problemKey + "");

            if (isAssociate != null) {
                if (complementName.equals("r2r")) {
                    response.sendRedirect("associate/issueBenefit.jsp");
                } else {
                    response.sendRedirect("associate/caseSummary.jsp");
                }
            } else {
                response.sendRedirect("viewWorker.jsp");
            }

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
