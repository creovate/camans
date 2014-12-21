/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.controller;

import camans.dao.ConnectionManager;
import camans.dao.ProblemComplementsDAO;
import camans.entity.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
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
public class processEditProblemComplement extends HttpServlet {

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
            int problemKey = Integer.parseInt(request.getParameter("jobkey"));
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
            //=======================================//
            //          Common Problem Complements  
            //=======================================//
            //          1. Aggravating Issue
            //=======================================//
            if (complementName.equals("aggravissue")) {
                //get all the parameters for Aggravating Issue
                
                String aggraIssue = request.getParameter("aggravissueType");
                String aggraIssueMore = request.getParameter("aggravissueTypeMore");
                String aggraLoss = request.getParameter("aggravLoss");
                String aggraRemark = request.getParameter("remark");
                
                int id = Integer.parseInt(request.getParameter("Id"));
                //create object
                ProblemAggravatingIssue problemAggravatingIssue = new ProblemAggravatingIssue(id, workerFinNum,
                        jobKey, problemKey, aggraIssue, aggraIssueMore, aggraLoss, aggraRemark);
                out.println("here");
                //add to db
                ProblemComplementsDAO.updateProblemAggravatingIssue(problemAggravatingIssue); 
                //out.println("here");

            //=======================================//
            //          2. Lead Case Worker
            //=======================================//    
            } else if (complementName.equals("leadcaseworker")) {
                out.println("here");
                //get all the parameters for lead case worker
                String leadName = request.getParameter("leadCaseWorkerName");
                String leadStartStr = request.getParameter("startDate");
                String leadEndStr = request.getParameter("endDate");
                          
                java.sql.Date leadStart = null;
                if (!leadStartStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(leadStartStr);
                        leadStart = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }
                
                java.sql.Date leadEnd = null;
                if (!leadEndStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(leadEndStr);
                        leadEnd = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }
                int id = Integer.parseInt(request.getParameter("Id"));
                //create object
                ProblemLeadCaseWorker problemLeadCaseWrk = new ProblemLeadCaseWorker(id, workerFinNum,
                        jobKey, problemKey, leadName, leadStart, leadEnd);
                //add into db
                out.println("added");
                ProblemComplementsDAO.updateProblemLeadCaseWorker(problemLeadCaseWrk);
            //=======================================//    
            //          3. Auxiliary Case Worker
            //=======================================//    
            } else if (complementName.equals("auxcaseworker"))  {
                //get all the parameters
                String auxName = request.getParameter("auxiliaryCaseWorkerName");
                String auxStartStr = request.getParameter("startDate");
                String auxEndStr = request.getParameter("endDate");
                
                java.sql.Date auxStart = null;
                if (!auxStartStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(auxStartStr);
                        auxStart = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }
                
                java.sql.Date auxEnd = null;
                if (!auxEndStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(auxEndStr);
                        auxEnd = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }
                
                int id = Integer.parseInt(request.getParameter("Id"));
                //create object
                ProblemAuxiliaryCaseWorker problemAuxiCaseWrk = new ProblemAuxiliaryCaseWorker(
                        id, workerFinNum,jobKey, problemKey, auxName, auxStart, auxEnd);
                
                //add to db
                ProblemComplementsDAO.updateProblemAuxiliaryCaseWorker(problemAuxiCaseWrk);
            
            //=======================================//    
            //          4. Case Discussion  
            //=======================================//    
            } else if (complementName.equals("casediscussion")) {
                //get all the parameters
                String discussDateStr = request.getParameter("date");
                String discussTime = request.getParameter("discussionTime");
                String discussWhere = request.getParameter("discussionWhere");
                String discussWhereMore = request.getParameter("discussionWhereOther");
                String discussWorkerPresent = request.getParameter("discussionWorkerPresent");
                String discussTWC2Pers1 = request.getParameter("discussionTWC2P1");
                String discussTWC2Pers2 = request.getParameter("discussionTWC2P2");
                String discussOthPers = request.getParameter("discussionOtherPerson");
                String discussTranslator = request.getParameter("discussionTranslator");
                String discussTopic = request.getParameter("discussionTopic");
                String discussGit = request.getParameter("discussionGist");
                String discussAssist = request.getParameter("discussionAssist");
                String discussCalculate = request.getParameter("discussionCal");
                String discussAction = request.getParameter("discussionAction");
                String discussRem =request.getParameter("remark");
                
                java.sql.Date discussDate = null;
                if (!discussDateStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(discussDateStr);
                        discussDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }
                int id = Integer.parseInt(request.getParameter("Id"));
                //create object
                ProblemCaseDiscussion problemCaseDiscussion = new ProblemCaseDiscussion (
                        id, workerFinNum, jobKey, problemKey, discussDate, discussTime, discussWhere,
                        discussWhereMore, discussWorkerPresent, discussTWC2Pers1, discussTWC2Pers2,
                        discussOthPers, discussTranslator, discussTopic, discussGit, discussAssist,
                        discussCalculate, discussAction, discussRem);
                out.println("here2");
                //add to db
                ProblemComplementsDAO.updateProblemCaseDiscussion(problemCaseDiscussion);
       
            //=======================================//    
            //          5. Lawyer  
            //=======================================//    
            } else if (complementName.equals("lawyer")) {
                //get all the parameters
                String lawFirmDateStr = request.getParameter("date");
                String lawFirmName = request.getParameter("lawyerFirm");
                String lawFirmNameMore = request.getParameter("lawyerFirmMore");
                String lawFirmLawyer = request.getParameter("lawyerName");
                String lawFirmRem = request.getParameter("remark");
                
                java.sql.Date lawFirmDate = null;
                if (!lawFirmDateStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(lawFirmDateStr);
                        lawFirmDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }
                
                int id = Integer.parseInt(request.getParameter("Id"));
                //create object
                ProblemLawyer problemLawyer = new ProblemLawyer(id, workerFinNum, jobKey, problemKey,
                        lawFirmDate,lawFirmName, lawFirmNameMore,lawFirmLawyer, lawFirmRem);
                //add to db
                ProblemComplementsDAO.updateProblemLawyer(problemLawyer);
                
            }
            //=======================================//
            //          Salary Problem Complements  
            //=======================================//
            //          6. Salary Related History
            //=======================================//
              else if (complementName.equals("salaryhistory")) {
                  
                  //get all the parameters
                  String salHistBasic = request.getParameter("basicSal");
                  String salHistOt = request.getParameter("overtime");
                  String salHistAllowance = request.getParameter("allowance");
                  String salHistDeduction = request.getParameter("deduction");
                  String salHistKickbacks = request.getParameter("kickbacks");
                  String salHistOther = request.getParameter("otherSal");
                  String salMode = request.getParameter("mode");
                  String salModeMore = request.getParameter("modeMore");
                  String salLossTotalStr = request.getParameter("totalLoss");
                  String salLossYearStr = request.getParameter("oneYearLoss");
                  String salHistRemark = request.getParameter("remark");
                  
                  Double salLossTotal = 0.0;
                    if (!salLossTotalStr.equals("")) {
                        try {
                            salLossTotal = Double.parseDouble(salLossTotalStr);
                        } catch (Exception ex) {
                            out.println(ex);
                        }
                    }
                    
                    
                    Double salLossYear = 0.0;
                    if (!salLossYearStr.equals("")) {
                        try {
                            salLossYear = Double.parseDouble(salLossYearStr);
                        } catch (Exception ex) {
                            out.println(ex);
                        }
                    } 
                    
                  int id = Integer.parseInt(request.getParameter("Id"));  
                  //create object
                  ProblemSalaryRelatedHistory problemSalaryRelatedHistory = new ProblemSalaryRelatedHistory(id, workerFinNum, 
                          jobKey, problemKey, salHistBasic, salHistOt, salHistAllowance, salHistDeduction,
                          salHistKickbacks, salHistOther, salMode, salModeMore, salLossTotal, 
                          salLossYear, salHistRemark);
                  //add to db
                  ProblemComplementsDAO.updateProblemSalaryRelatedHistory(problemSalaryRelatedHistory);
                  

            
            //=======================================//      
            //          7. Salary Claimed Lodged    
            //=======================================//
            } else if (complementName.equals("salarycalim")) {
                String salClaimDateStr = request.getParameter("date");
                String salClaimLossStr = request.getParameter("loss");
                String salClaimBasic = request.getParameter("basis");
                
                java.sql.Date salClaimDate = null;
                if (!salClaimDateStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(salClaimDateStr);
                        salClaimDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }
                
                Double salClaimLoss = 0.0;
                if (!salClaimLossStr.equals("")) {
                    try {
                        salClaimLoss = Double.parseDouble(salClaimLossStr);
                    } catch (Exception ex) {
                        out.println(ex);
                    }
                } 
                
                int id = Integer.parseInt(request.getParameter("Id"));
                //create object
                ProblemSalaryClaim salaryClaim = new ProblemSalaryClaim(id, workerFinNum, jobKey,
                        problemKey, salClaimDate, salClaimLoss, salClaimBasic);
                //add to db
                ProblemComplementsDAO.updateProblemSalaryClaim(salaryClaim);

                
            }    
            //=======================================//
            //          Medical Problem Complements  
            //=======================================//
            //          8. Injury History 
            //=======================================//
              else if (complementName.equals("injurycase")) {
                  String injuryDateStr = request.getParameter("date");
                  String injuryTime = request.getParameter("time");
                  String injuryLocation = request.getParameter("location");
                  String injuryDeath = request.getParameter("death");
                  String injuryBodyPart = request.getParameter("bodyPart");
                  String injuryHow = request.getParameter("how");
                  String injuryAmbulance = request.getParameter("ambulance");
                  String injuryInitialTreatement = request.getParameter("treatement");
                  String injuryInitialTreatementMore = request.getParameter("treatementMore");
                  String injuryWorkRelated = request.getParameter("workRelated");
                  String injuryRemark = request.getParameter("remark");
                  
                 java.sql.Date injuryDate = null;
                if (!injuryDateStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(injuryDateStr);
                        injuryDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }
                
                int id = Integer.parseInt(request.getParameter("Id"));
                //create object
                ProblemInjury problemInjury = new ProblemInjury(id, workerFinNum, jobKey,
                        problemKey, injuryDate, injuryTime, injuryLocation,injuryDeath,
                        injuryBodyPart,injuryHow,injuryAmbulance,injuryInitialTreatement,
                        injuryInitialTreatementMore,injuryWorkRelated,injuryRemark);
                
                //add to db
                ProblemComplementsDAO.updateProblemInjury(problemInjury);
           
            //=======================================//
            //          9. Illness History  
            //=======================================//
            } else if (complementName.equals("illnesscase")) {
                String illnessStart = request.getParameter("startTime");
                String illnessdiaTime = request.getParameter("diagnoseTime");
                String illnessdiaPerson = request.getParameter("diagnosePerson");
                String illnessNature = request.getParameter("nature");
                String illnessWorkRelated = request.getParameter("workRelated");
                String illnessWhy = request.getParameter("workRelatedYes");
                String illnessRemark = request.getParameter("remark");
                
                int id = Integer.parseInt(request.getParameter("Id"));
                //create object
                ProblemIllness illness = new ProblemIllness(id, workerFinNum, jobKey, problemKey,
                        illnessStart, illnessdiaTime, illnessdiaPerson, illnessNature,
                        illnessWorkRelated, illnessWhy, illnessRemark);
                
                //addto db
                ProblemComplementsDAO.updateProblemIllness(illness);
                
            //=======================================//
            //          10. WICA Claim Lodged    
            //=======================================//    
            } else if (complementName.equals("wicaclaim")) {
                //get all parameters
                String wicaClaimDateStr = request.getParameter("date");
                String wicaClaimRefNum = request.getParameter("refNumber");
                String wicaInsurer = request.getParameter("insurer");
                String wicaPolicyNbr = request.getParameter("policyNumber");
                String wicaClaimReason = request.getParameter("reason");
                String wicaClaimRemark = request.getParameter("remark");
                
                java.sql.Date wicaClaimDate = null;
                if (!wicaClaimDateStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(wicaClaimDateStr);
                        wicaClaimDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }
                
                int id = Integer.parseInt(request.getParameter("Id"));
                //create object
                ProblemWicaClaim problemWicaClaim = new ProblemWicaClaim(id, workerFinNum, jobKey, problemKey,
                        wicaClaimDate, wicaClaimRefNum, wicaInsurer, wicaPolicyNbr,
                        wicaClaimReason, wicaClaimRemark);
                //add to db
                ProblemComplementsDAO.updateProblemWicaClaim(problemWicaClaim);
                
            //=======================================//
            //          11. Non-WICA Claim Lodged  
            //=======================================//    
            } else if (complementName.equals("nonwicaclaim")) {
                //get all the parameters
                String nonwicaClaimDateStr = request.getParameter("date");
                String nonwicaClaimLossStr = request.getParameter("loss");
                String nonwicaClaimInsurer = request.getParameter("insurer");
                String nonwicaClaimPolicyNbr = request.getParameter("policyNumber");
                String nonwicaClaimBasic = request.getParameter("basis");
                String remark = request.getParameter("remark");
                java.sql.Date nonwicaClaimDate = null;
                if (!nonwicaClaimDateStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(nonwicaClaimDateStr);
                        nonwicaClaimDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }
                
                Double nonwicaClaimLoss = 0.0;
                if (!nonwicaClaimLossStr.equals("")) {
                    try {
                        nonwicaClaimLoss = Double.parseDouble(nonwicaClaimLossStr);
                    } catch (Exception ex) {
                        out.println(ex);
                    }
                }
                
                
                int id = Integer.parseInt(request.getParameter("Id"));
                //create object
                ProblemNonWicaClaim nonwicaClaim = new ProblemNonWicaClaim(id, workerFinNum, jobKey,
                        problemKey, nonwicaClaimDate, nonwicaClaimLoss, nonwicaClaimInsurer,
                        nonwicaClaimPolicyNbr, nonwicaClaimBasic, remark);
                
                ProblemComplementsDAO.updateProblemNonWicaClaim(nonwicaClaim);
                
                
            //=======================================//
            //          12. WICA Monthly Status   
            //=======================================//    
            } else if (complementName.equals("wica")) {
                String wicaUpdateDateStr = request.getParameter("date");
                String wicaStatus = request.getParameter("wicaStatus");
                String wicaStatusMore = request.getParameter("wicaStatusMore");
                String wicaPointsStr = request.getParameter("wicaPoints");
                String wicaDollarsStr = request.getParameter("wicaDollars");
                String wicaRemarks = request.getParameter("remark");
                
                java.sql.Date wicaUpdateDate = null;
                if (!wicaUpdateDateStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(wicaUpdateDateStr);
                        wicaUpdateDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }
                
                Double wicaPoints = 0.0;
                if (!wicaPointsStr.equals("")) {
                    try {
                        wicaPoints = Double.parseDouble(wicaPointsStr);
                    } catch (Exception ex) {
                        out.println(ex);
                    }
                }
                
                Double wicaDollars = 0.0;
                if (!wicaDollarsStr.equals("")) {
                    try {
                        wicaDollars = Double.parseDouble(wicaDollarsStr);
                    } catch (Exception ex) {
                        out.println(ex);
                    }
                }
                
                int id = Integer.parseInt(request.getParameter("Id"));
                //create object
                ProblemWica problemWica = new ProblemWica(id, workerFinNum, jobKey, problemKey,
                        wicaUpdateDate, wicaStatus, wicaStatusMore, wicaPoints, wicaDollars,
                        wicaRemarks);
                ProblemComplementsDAO.updateProblemWica(problemWica);
                
                
               
            //=======================================//
            //          13. Hospital Providing Treatment  
            //=======================================//    
            } else if (complementName.equals("hospital")) {
                String hospitalUpdateDateStr = request.getParameter("date");
                String hospitalName = request.getParameter("hospName");
                String hospitalNameMore = request.getParameter("hospNameMore");
                String hospitalDoctor = request.getParameter("hospDoctor");
                String hospitalRemark = request.getParameter("remark");
                
                java.sql.Date hospitalUpdateDate = null;
                if (!hospitalUpdateDateStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(hospitalUpdateDateStr);
                        hospitalUpdateDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }
                
                int id = Integer.parseInt(request.getParameter("Id"));
                //create object
                ProblemHospital hospital = new ProblemHospital(id, workerFinNum, jobKey, problemKey,
                        hospitalUpdateDate, hospitalName, hospitalNameMore, hospitalDoctor, hospitalRemark);
                
                //add into db
                ProblemComplementsDAO.updateProblemHospital(hospital);
            //=======================================//
            //          14. MC/Light Duty Status 
            //=======================================//    
            } else if (complementName.equals("mc")) {

                String mcUpdateDateStr = request.getParameter("date");
                String mcStatus = request.getParameter("mcStatus");
                String mcStatusMore = request.getParameter("mcStatusMore");
                String mcExpireDateStr = request.getParameter("expDate");
                String mcDaysCumStr = request.getParameter("expCum");
                String mcRemark = request.getParameter("remark");
                
                java.sql.Date mcUpdateDate = null;
                if (!mcUpdateDateStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(mcUpdateDateStr);
                        mcUpdateDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }

                java.sql.Date mcExpireDate = null;


                if (!mcExpireDateStr.equals("")) {
                    out.println("e");
                    try {
                        java.util.Date tmp = sdf.parse(mcExpireDateStr);
                        mcExpireDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }

                int mcDaysCum = 0;
                if (!mcDaysCumStr.equals("")) {
                    try {
                        mcDaysCum = Integer.parseInt(mcDaysCumStr);
                    } catch (Exception ex) {
                        out.println(ex);
                    }
                }
                
                int id = Integer.parseInt(request.getParameter("Id"));
                //create object
                ProblemMCStatus problemMCStatus = new ProblemMCStatus(id, workerFinNum, jobKey, problemKey,
                        mcUpdateDate, mcStatus, mcStatusMore, mcExpireDate, mcDaysCum, mcRemark);
                
                ProblemComplementsDAO.updateProblemMCStatus(problemMCStatus);
               
                
            //=======================================//
            //          15. R2R Appointments  
            //=======================================//    
            } else if (complementName.equals("r2r")) {
                String r2rDateStr = request.getParameter("date");
                String r2rTime = request.getParameter("r2rTime");
                String r2rHosp = request.getParameter("r2rHosp");
                String r2rDept = request.getParameter("r2rDept");
                String r2r1 = request.getParameter("r2r1");
                String r2r2 = request.getParameter("r2r2");
                String r2rPurpose = request.getParameter("r2rPurpose");
                String r2rPreApptNotes = request.getParameter("r2rPreApptNotes");
                String r2rPostApptNotes = request.getParameter("r2rPostApptNotes");
                String r2rFeedback = request.getParameter("r2rFeedback");
                String r2rMedCostStr = request.getParameter("r2rMed");
                String r2rOutlayStr = request.getParameter("r2rOut");
                
                java.sql.Date r2rDate = null;
                if (!r2rDateStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(r2rDateStr);
                        r2rDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }
                
                Double r2rMedCost = 0.0;
                if (!r2rMedCostStr.equals("")) {
                    try {
                        r2rMedCost = Double.parseDouble(r2rMedCostStr);
                    } catch (Exception ex) {
                        out.println(ex);
                    }
                }
                
                Double r2rOutlay = 0.0;
                if (!r2rOutlayStr.equals("")) {
                    try {
                        r2rOutlay = Double.parseDouble(r2rOutlayStr);
                    } catch (Exception ex) {
                        out.println(ex);
                    }
                }
                
                int id = Integer.parseInt(request.getParameter("Id"));
                //create object
                ProblemR2R problemR2R = new ProblemR2R (id, workerFinNum, jobKey, problemKey, r2rDate, 
                        r2rTime, r2rHosp, r2rDept, r2r1, r2r2, r2rPurpose, r2rPreApptNotes,
                        r2rPostApptNotes, r2rFeedback, r2rMedCost, r2rOutlay);
                //add to db
                ProblemComplementsDAO.updateProblemR2R(problemR2R);
                
            
            }
            //=======================================//
            //          Other Complements   
            //=======================================//
            //=======================================//
            //  16. Details & History of Other Problem 
            //=======================================//
            else if (complementName.equals("othercase")) {
                String otherProblemDesc = request.getParameter("other");
                String otherProblemLossStr = request.getParameter("loss");
                String otherProblemRemark = request.getParameter("remark");
                
                Double otherProblemLoss = 0.0;
                if (!otherProblemLossStr.equals("")) {
                    try {
                        otherProblemLoss = Double.parseDouble(otherProblemLossStr);
                    } catch (Exception ex) {
                        out.println(ex);
                    }
                }
                
                int id = Integer.parseInt(request.getParameter("Id"));
                //create object
                ProblemOtherProblems other = new ProblemOtherProblems(id, workerFinNum, jobKey, problemKey,
                        otherProblemDesc,otherProblemLoss, otherProblemRemark);
                
                ProblemComplementsDAO.updateProblemOtherProblems(other);
                
            //=======================================//
            //      17. Trafficking Indication   
            //=======================================//    
            } else if (complementName.equals("trafficking")) {
                String assessDateStr = request.getParameter("date");
                String assessName = request.getParameter("person");
                String tipi21 = request.getParameter("tipi21");
                String tipi22 = request.getParameter("tipi22");
                String tipi23 = request.getParameter("tipi23");
                String tipi24 = request.getParameter("tipi24");
                String tipi25 = request.getParameter("tipi25");
                String tipi26 = request.getParameter("tipi26");
                String tipi27 = request.getParameter("tipi27");
                String tipi28 = request.getParameter("tipi28");
                String tipi41 = request.getParameter("tipi41");
                String tipi42 = request.getParameter("tipi42");
                String tipi43 = request.getParameter("tipi43");
                String tipi44 = request.getParameter("tipi44");
                String tipi45 = request.getParameter("tipi45");
                String tipi46 = request.getParameter("tipi46");
                String tipi47 = request.getParameter("tipi47");
                String tipi48 = request.getParameter("tipi48");
                String tipi49 = request.getParameter("tipi49");
                String tipi50 = request.getParameter("tipi50");
                String tipi51 = request.getParameter("tipi51");
                String tipi61 = request.getParameter("tipi61");
                String tipi62 = request.getParameter("tipi62");
                String tipi63 = request.getParameter("tipi63");
                String tipi64 = request.getParameter("tipi64");
                String tipi65 = request.getParameter("tipi65");
                String tipi66 = request.getParameter("tipi66");
                String tipi67 = request.getParameter("tipi67");
                String tipi81 = request.getParameter("tipi81");
                String tipi82 = request.getParameter("tipi82");
                
                java.sql.Date assessDate = null;
                if (!assessDateStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(assessDateStr);
                        assessDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }
                
                int id = Integer.parseInt(request.getParameter("Id"));
                //create object
                ProblemTraffickingIndicator problemTraffickingIndicator = new ProblemTraffickingIndicator(
                        id, workerFinNum, jobKey,
                        problemKey, assessDate, assessName, tipi21,tipi22,tipi23,tipi24,tipi25,tipi26,
                        tipi27,tipi28,tipi41,tipi42,tipi43,tipi44,tipi45,tipi46,tipi47,
                        tipi48,tipi49,tipi50,tipi51,tipi61,tipi62,tipi63,tipi64,tipi65,tipi66,tipi67,tipi81,
                        tipi82); 
                //add to db
                ProblemComplementsDAO.updateProblemTraffickingIndicator(problemTraffickingIndicator);
                

            //=======================================//
            //          18. Police Report Lodged  
            //=======================================//
            } else if (complementName.equals("policareport")) {
                String policeReportDateStr = request.getParameter("date");
                String policeReportStation = request.getParameter("policeReportStation");
                String policeReportPerson = request.getParameter("person");
                String policeReportRefNumber = request.getParameter("policeReportRefNumber");
                String policeReportRefDetails = request.getParameter("policeReportDetails");
                String policeReportRemark = request.getParameter("remark");
                
                java.sql.Date policeReportDate = null;
                if (!policeReportDateStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(policeReportDateStr);
                        policeReportDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }
                
                int id = Integer.parseInt(request.getParameter("Id"));
                //create object
                ProblemPoliceReport policeReport = new ProblemPoliceReport(id, workerFinNum, jobKey,
                        problemKey, policeReportDate, policeReportStation, policeReportPerson,
                        policeReportRefNumber, policeReportRefDetails, policeReportRemark);
                
                //add to db
                ProblemComplementsDAO.updateProblemPoliceReport(policeReport);
            //=======================================//
            //          19. Other Complaint Lodged
            //=======================================//    
            } else if (complementName.equals("othercomplaint")) {
                String otherComplaintDateStr = request.getParameter("date");
                String otherComplaintAgency = request.getParameter("complaintAgency");
                String otherComplaintWho = request.getParameter("complaintWho");
                String otherComplaintWhoMore = request.getParameter("complaintWhoMore");
                String otherComplaintMode = request.getParameter("complaintMode");
                String otherComplaintModeMore = request.getParameter("complaintModeMore");
                String otherComplaintDetails = request.getParameter("complaintDetails");
                String otherComplaintRemark = request.getParameter("remark");
                
                java.sql.Date otherComplaintDate = null;
                if (!otherComplaintDateStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(otherComplaintDateStr);
                        otherComplaintDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }
                
                int id = Integer.parseInt(request.getParameter("Id"));
                //create object
                ProblemOtherComplaint problemOtherComplaint = new ProblemOtherComplaint (id, workerFinNum, jobKey,
                        problemKey, otherComplaintDate, otherComplaintAgency, otherComplaintWho,
                        otherComplaintWhoMore, otherComplaintMode, otherComplaintModeMore,
                        otherComplaintDetails, otherComplaintRemark);
                //add to db
                ProblemComplementsDAO.updateProblemOtherComplaint(problemOtherComplaint);
                
                
            //=======================================//
            //20. Case Milestone Reached(non-criminal) 
            //=======================================//    
            } else if (complementName.equals("ncmilestone")) {
                String ncmileStoneDateStr = request.getParameter("date");
                String ncmileStoneReach = request.getParameter("milestoneNCReached");
                String ncmileStoneReachMore =request.getParameter("milestoneNCReachedMore");
                String ncmileStoneRemark = request.getParameter("remark");
                
                java.sql.Date ncmileStoneDate = null;
                if (!ncmileStoneDateStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(ncmileStoneDateStr);
                        ncmileStoneDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }
                
                
                int id = Integer.parseInt(request.getParameter("Id"));
                //create object
                ProblemCaseMilestoneNC problemCaseMilestoneNC = new ProblemCaseMilestoneNC (id, workerFinNum, jobKey,
                        problemKey, ncmileStoneDate, ncmileStoneReach, ncmileStoneReachMore, 
                        ncmileStoneRemark);
                //add to db
                ProblemComplementsDAO.updateProblemCaseMilestoneNC(problemCaseMilestoneNC);
                
            //=======================================//
            //21. Case Milestone Reached(Criminal)     
            //=======================================//    
            } else if (complementName.equals("cmilestone")) {
                String cmileStoneDateStr = request.getParameter("date");
                String cmileStoneReach = request.getParameter("milestoneCRReached");
                String cmileStoneReachMore = request.getParameter("milestoneCRReachedMore");
                String cmileStoneCharge = request.getParameter("milestoneCRCharges");
                String cmileStoneSentence = request.getParameter("milestoneCRSentence");
                String cmileStoneRemark = request.getParameter("remark");
                
                java.sql.Date cmileStoneDate = null;
                if (!cmileStoneDateStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(cmileStoneDateStr);
                        cmileStoneDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }
                
                int id = Integer.parseInt(request.getParameter("Id"));
                //create object
                ProblemCaseMilestoneCR problemCaseMilestoneCR = new ProblemCaseMilestoneCR (
                        id, workerFinNum, jobKey,
                        problemKey, cmileStoneDate, cmileStoneReach, cmileStoneReachMore,
                        cmileStoneCharge, cmileStoneSentence, cmileStoneRemark);
                //add to db
                ProblemComplementsDAO.updateProblemCaseMilestoneCR(problemCaseMilestoneCR);
               
                
            //=======================================//
            //      22. Transfer, TJS & Repatriation    
            //=======================================//    
            } else if (complementName.equals("ttr")) {
                String ttrUpdateDateStr = request.getParameter("date");
                String ttrStatus = request.getParameter("ttrStatus");
                String ttrStatusMore = request.getParameter("ttrStatusMore");
                String ttrDepatureDateStr = request.getParameter("ttrDepartureDate");
                String ttrNewEmployer = request.getParameter("ttrEmployerName");
                String ttrNewJob = request.getParameter("ttrJob");
                String ttrRemark = request.getParameter("remark");
                
                java.sql.Date ttrUpdateDate = null;
                if (!ttrUpdateDateStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(ttrUpdateDateStr);
                        ttrUpdateDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }
                
                java.sql.Date ttrDepatureDate = null;
                if (!ttrDepatureDateStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(ttrDepatureDateStr);
                        ttrDepatureDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }
                
                int id = Integer.parseInt(request.getParameter("Id"));
                //create object
                ProblemTTR problemTTR = new ProblemTTR(id, workerFinNum, jobKey, problemKey, ttrUpdateDate,
                        ttrStatus, ttrStatusMore, ttrDepatureDate, ttrNewEmployer, ttrNewJob,
                        ttrRemark);
                //add to db
                ProblemComplementsDAO.updateProblemTTR(problemTTR);
              
            }
           response.sendRedirect("viewWorker.jsp?worker=" + workerFinNum + "&selectedProb=" + problemKey);
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