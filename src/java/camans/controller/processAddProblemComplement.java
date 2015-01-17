/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.controller;

import camans.dao.ProblemComplementsDAO;
import camans.dao.UserAuditLogDAO;
import camans.entity.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;

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
            String jobKeyStr = request.getParameter("jobkey");
            String probKeyStr = request.getParameter("probKey");
            int jobKey = Integer.parseInt(request.getParameter("jobkey"));
            int problemKey = Integer.parseInt(request.getParameter("probKey"));
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
            
            User _user = (User) request.getSession().getAttribute("userLogin");
            String auditChange = "";
            //=======================================//
            //          Common Problem Complements  
            //=======================================//
            //          1. Aggravating Issue
            //=======================================//
            if (complementName.equals("aggravissue")) {
                //get all the parameters for Aggravating Issue
                String aggraIssue = request.getParameter("naggravissueType");
                String aggraIssueMore = request.getParameter("naggravissueTypeMore");
                String aggraLossStr = request.getParameter("naggravLoss");
                Double aggraLoss = 0.0;
                if (aggraLossStr != null && !aggraLossStr.equals("")) {
                    try {
                        aggraLoss = Double.parseDouble(aggraLossStr);
                    } catch (Exception ex) {
                        out.println(ex);
                    }
                }
                String aggraRemark = request.getParameter("nremark");
                
                //create object
                ProblemAggravatingIssue problemAggraIssue = new ProblemAggravatingIssue(workerFinNum,
                        jobKey, problemKey, aggraIssue, aggraIssueMore, aggraLoss, aggraRemark);
                //add to db
                ProblemComplementsDAO.addProblemAggravatingIssue(problemAggraIssue);  
                //log the audit
                auditChange = problemAggraIssue.toString2();
            //=======================================//
            //          2. Lead Case Worker
            //=======================================//    
            } else if (complementName.equals("leadcaseworker")) {
                //get all the parameters for lead case worker
                String leadName = request.getParameter("nleadCaseWorkerName");
                String leadStartStr = request.getParameter("nstartDate");
                String leadEndStr = request.getParameter("nendDate");
                          
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
                //create object
                ProblemLeadCaseWorker problemLeadCaseWrk = new ProblemLeadCaseWorker(workerFinNum,
                        jobKey, problemKey, leadName, leadStart, leadEnd);
                //add into db
                ProblemComplementsDAO.addProblemLeadCaseWorker(problemLeadCaseWrk);
                //log the audit
                auditChange = problemLeadCaseWrk.toString2();
            //=======================================//    
            //          3. Auxiliary Case Worker
            //=======================================//    
            } else if (complementName.equals("auxcaseworker"))  {
                //get all the parameters
                String auxName = request.getParameter("nauxiliaryCaseWorkerName");
                String auxStartStr = request.getParameter("nstartDate");
                String auxEndStr = request.getParameter("nendDate");
                
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
                //create object
                ProblemAuxiliaryCaseWorker problemAuxiCaseWrk = new ProblemAuxiliaryCaseWorker(
                        workerFinNum,jobKey, problemKey, auxName, auxStart, auxEnd);
                
                //add to db
                ProblemComplementsDAO.addProblemAuxiliaryCaseWorker(problemAuxiCaseWrk);
            
                //log the audit
                auditChange = problemAuxiCaseWrk.toString2();
            //=======================================//    
            //          4. Case Discussion  
            //=======================================//    
            } else if (complementName.equals("casediscussion")) {
                //get all the parameters
                String discussDateStr = request.getParameter("ndate");
                String discussTime = request.getParameter("ndiscussionTime");
                String discussWhere = request.getParameter("ndiscussionWhere");
                String discussWhereMore = request.getParameter("ndiscussionWhereOther");
                String discussWorkerPresent = request.getParameter("ndiscussionWorkerPresent");
                String discussTWC2Pers1 = request.getParameter("ndiscussionTWC2P1");
                String discussTWC2Pers2 = request.getParameter("ndiscussionTWC2P2");
                String discussOthPers = request.getParameter("ndiscussionOtherPerson");
                String discussTranslator = request.getParameter("ndiscussionTranslator");
                String discussTopic = request.getParameter("ndiscussionTopic");
                String discussGit = request.getParameter("ndiscussionGist");
                String discussAssist = request.getParameter("ndiscussionAssist");
                String discussCalculate = request.getParameter("ndiscussionCal");
                String discussAction = request.getParameter("ndiscussionAction");
                String discussRem =request.getParameter("nremark");
                
                java.sql.Date discussDate = null;
                if (!discussDateStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(discussDateStr);
                        discussDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }
                //create object
                ProblemCaseDiscussion problemCaseDiscuss = new ProblemCaseDiscussion (
                        workerFinNum, jobKey, problemKey, discussDate, discussTime, discussWhere,
                        discussWhereMore, discussWorkerPresent, discussTWC2Pers1, discussTWC2Pers2,
                        discussOthPers, discussTranslator, discussTopic, discussGit, discussAssist,
                        discussCalculate, discussAction, discussRem);
                //add to db
                ProblemComplementsDAO.addProblemCaseDiscussion(problemCaseDiscuss);
            
                //log the audit
                auditChange = problemCaseDiscuss.toString2();
            //=======================================//    
            //          5. Lawyer  
            //=======================================//    
            } else if (complementName.equals("lawyer")) {
                //get all the parameters
                String lawFirmDateStr = request.getParameter("ndate");
                String lawFirmName = request.getParameter("nlawyerFirm");
                String lawFirmNameMore = request.getParameter("nlawyerFirmMore");
                String lawFirmLawyer = request.getParameter("nlawyerName");
                String lawFirmRem = request.getParameter("nremark");
                
                java.sql.Date lawFirmDate = null;
                if (!lawFirmDateStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(lawFirmDateStr);
                        lawFirmDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }
                //create object
                ProblemLawyer problemLawyer = new ProblemLawyer(workerFinNum, jobKey, problemKey,
                        lawFirmDate,lawFirmName, lawFirmNameMore,lawFirmLawyer, lawFirmRem);
                //add to db
                ProblemComplementsDAO.addProblemLawyer(problemLawyer);
                //log the audit
                auditChange = problemLawyer.toString2();
            }
            //=======================================//
            //          Salary Problem Complements  
            //=======================================//
            //          6. Salary Related History
            //=======================================//
              else if (complementName.equals("salaryhistory")) {
                  //get all the parameters
                  String salHistBasic = request.getParameter("nbasicSal");
                  String salHistOt = request.getParameter("novertime");
                  String salHistAllowance = request.getParameter("nallowance");
                  String salHistDeduction = request.getParameter("ndeduction");
                  String salHistKickbacks = request.getParameter("nkickbacks");
                  String salHistOther = request.getParameter("notherSal");
                  String salMode = request.getParameter("nmode");
                  String salModeMore = request.getParameter("nmodeMore");
                  String salLossTotalStr = request.getParameter("ntotalLoss");
                  String salLossYearStr = request.getParameter("noneYearLoss");
                  String salHistRemark = request.getParameter("nremark");
                  
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
                    
                  //create object
                  ProblemSalaryRelatedHistory salHist = new ProblemSalaryRelatedHistory(workerFinNum, 
                          jobKey, problemKey, salHistBasic, salHistOt, salHistAllowance, salHistDeduction,
                          salHistKickbacks, salHistOther, salMode, salModeMore, salLossTotal, 
                          salLossYear, salHistRemark);
                  //add to db
                  ProblemComplementsDAO.addProblemSalaryRelatedHistory(salHist);
                  
                  //log the audit
                auditChange = salHist.toString2();;
            
            //=======================================//      
            //          7. Salary Claimed Lodged    
            //=======================================//
            } else if (complementName.equals("salarycalim")) {
                String salClaimDateStr = request.getParameter("ndate");
                String salClaimLossStr = request.getParameter("nloss");
                String salClaimBasic = request.getParameter("nbasis");
                
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
                //create object
                ProblemSalaryClaim salaryClaim = new ProblemSalaryClaim(workerFinNum, jobKey,
                        problemKey, salClaimDate, salClaimLoss, salClaimBasic);
                //add to db
                ProblemComplementsDAO.addProblemSalaryClaim(salaryClaim);

                //log the audit
                auditChange = salaryClaim.toString2();
                
            }    
            //=======================================//
            //          Medical Problem Complements  
            //=======================================//
            //          8. Injury History 
            //=======================================//
              else if (complementName.equals("injurycase")) {
                  String injuryDateStr = request.getParameter("ndate");
                  String injuryTime = request.getParameter("ntime");
                  String injuryLocation = request.getParameter("nlocation");
                  String injuryDeath = request.getParameter("ndeath");
                  String injuryBodyPart = request.getParameter("nbodyPart");
                  String injuryHow = request.getParameter("nhow");
                  String injuryAmbulance = request.getParameter("nambulance");
                  String injuryInitialTreatement = request.getParameter("ntreatement");
                  String injuryInitialTreatementMore = request.getParameter("ntreatementMore");
                  String injuryWorkRelated = request.getParameter("nworkRelated");
                  String injuryRemark = request.getParameter("nremark");
                  
                 java.sql.Date injuryDate = null;
                if (!injuryDateStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(injuryDateStr);
                        injuryDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }
                
                //create object
                ProblemInjury injury = new ProblemInjury(workerFinNum, jobKey,
                        problemKey, injuryDate, injuryTime, injuryLocation,injuryDeath,
                        injuryBodyPart,injuryHow,injuryAmbulance,injuryInitialTreatement,
                        injuryInitialTreatementMore,injuryWorkRelated,injuryRemark);
                
                //add to db
                ProblemComplementsDAO.addProblemInjury(injury);
                
                //log the audit
                auditChange = injury.toString2();
            //=======================================//
            //          9. Illness History  
            //=======================================//
            } else if (complementName.equals("illnesscase")) {
                String illnessStart = request.getParameter("nstartTime");
                String illnessdiaTime = request.getParameter("ndiagnoseTime");
                String illnessdiaPerson = request.getParameter("ndiagnosePerson");
                String illnessNature = request.getParameter("nnature");
                String illnessWorkRelated = request.getParameter("nworkRelated");
                String illnessWhy = request.getParameter("workRelatedYes");
                String illnessRemark = request.getParameter("nremark");
                
                //create object
                ProblemIllness illness = new ProblemIllness(workerFinNum, jobKey, problemKey,
                        illnessStart, illnessdiaTime, illnessdiaPerson, illnessNature,
                        illnessWorkRelated, illnessWhy, illnessRemark);
                
                //addto db
                ProblemComplementsDAO.addProblemIllness(illness);
                
                //log the audit
                auditChange = illness.toString2();;
                
            //=======================================//
            //          10. WICA Claim Lodged    
            //=======================================//    
            } else if (complementName.equals("wicaclaim")) {
                //get all parameters
                String wicaClaimDateStr = request.getParameter("ndate");
                String wicaClaimRefNum = request.getParameter("nrefNumber");
                String wicaInsurer = request.getParameter("ninsurer");
                String wicaPolicyNbr = request.getParameter("npolicyNumber");
                String wicaClaimReason = request.getParameter("nreason");
                String wicaClaimRemark = request.getParameter("nremark");
                
                java.sql.Date wicaClaimDate = null;
                if (!wicaClaimDateStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(wicaClaimDateStr);
                        wicaClaimDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }
                //create object
                ProblemWicaClaim wicaClaim = new ProblemWicaClaim(workerFinNum, jobKey, problemKey,
                        wicaClaimDate, wicaClaimRefNum, wicaInsurer, wicaPolicyNbr,
                        wicaClaimReason, wicaClaimRemark);
                //add to db
                ProblemComplementsDAO.addProblemWicaClaim(wicaClaim);
                
                //log the audit
                auditChange = wicaClaim.toString2();
            //=======================================//
            //          11. Non-WICA Claim Lodged  
            //=======================================//    
            } else if (complementName.equals("nonwicaclaim")) {
                //get all the parameters
                String nonwicaClaimDateStr = request.getParameter("ndate");
                String nonwicaClaimLossStr = request.getParameter("nloss");
                String nonwicaClaimInsurer = request.getParameter("ninsurer");
                String nonwicaClaimPolicyNbr = request.getParameter("npolicyNumber");
                String nonwicaClaimBasic = request.getParameter("nbasis");
                String remark = request.getParameter("nremark");
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
                
                //create object
                ProblemNonWicaClaim problemNonWicaClaim = new ProblemNonWicaClaim(workerFinNum, jobKey,
                        problemKey, nonwicaClaimDate, nonwicaClaimLoss, nonwicaClaimInsurer,
                        nonwicaClaimPolicyNbr, nonwicaClaimBasic,remark);
                
                ProblemComplementsDAO.addProblemNonWicaClaim(problemNonWicaClaim);
                
                //log the audit
                auditChange = problemNonWicaClaim.toString2();
                
            //=======================================//
            //          12. WICA Monthly Status   
            //=======================================//    
            } else if (complementName.equals("wica")) {
                String wicaUpdateDateStr = request.getParameter("ndate");
                String wicaStatus = request.getParameter("nwicaStatus");
                String wicaStatusMore = request.getParameter("nwicaStatusMore");
                String wicaPointsStr = request.getParameter("nwicaPoints");
                String wicaDollarsStr = request.getParameter("nwicaDollars");
                String wicaRemarks = request.getParameter("nremark");
                
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
                //create object
                ProblemWica problemWica = new ProblemWica(workerFinNum, jobKey, problemKey,
                        wicaUpdateDate, wicaStatus, wicaStatusMore, wicaPoints, wicaDollars,
                        wicaRemarks);
                ProblemComplementsDAO.addProblemWica(problemWica);
                
                //log the audit
                auditChange = problemWica.toString2();
               
            //=======================================//
            //          13. Hospital Providing Treatment  
            //=======================================//    
            } else if (complementName.equals("hospital")) {
                String hospitalUpdateDateStr = request.getParameter("ndate");
                String hospitalName = request.getParameter("nhospName");
                String hospitalNameMore = request.getParameter("nhospNameMore");
                String hospitalDoctor = request.getParameter("nhospDoctor");
                String hospitalRemark = request.getParameter("nremark");
                
                java.sql.Date hospitalUpdateDate = null;
                if (!hospitalUpdateDateStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(hospitalUpdateDateStr);
                        hospitalUpdateDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }
                //create object
                ProblemHospital hospital = new ProblemHospital(workerFinNum, jobKey, problemKey,
                        hospitalUpdateDate, hospitalName, hospitalNameMore, hospitalDoctor, hospitalRemark);
                
                //add into db
                ProblemComplementsDAO.addProblemHospital(hospital);
                
                //log the audit
                auditChange = hospital.toString2();
            //=======================================//
            //          14. MC/Light Duty Status 
            //=======================================//    
            } else if (complementName.equals("mc")) {

                String mcUpdateDateStr = request.getParameter("ndate");
                String mcStatus = request.getParameter("nmcStatus");
                String mcStatusMore = request.getParameter("nmcStatusMore");
                String mcExpireDateStr = request.getParameter("nexpDate");
                String mcDaysCumStr = request.getParameter("nexpCum");
                String mcRemark = request.getParameter("nremark");
                
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
                
                //create object
                ProblemMCStatus problemMCStatus = new ProblemMCStatus(workerFinNum, jobKey, problemKey,
                        mcUpdateDate, mcStatus, mcStatusMore, mcExpireDate, mcDaysCum, mcRemark);
                
                ProblemComplementsDAO.addProblemMCStatus(problemMCStatus);
               
                //log the audit
                auditChange = problemMCStatus.toString2();
                
            //=======================================//
            //          15. R2R Appointments  
            //=======================================//    
            } else if (complementName.equals("r2r")) {
                String r2rDateStr = request.getParameter("ndate");
                String r2rTime = request.getParameter("nr2rTime");
                String r2rHosp = request.getParameter("nr2rHosp");
                String r2rDept = request.getParameter("nr2rDept");
                String r2r1 = request.getParameter("nr2r1");
                String r2r2 = request.getParameter("nr2r2");
                String r2rPurpose = request.getParameter("nr2rPurpose");
                String r2rPreApptNotes = request.getParameter("nr2rPreApptNotes");
                String r2rPostApptNotes = request.getParameter("nr2rPostApptNotes");
                String r2rFeedback = request.getParameter("nr2rFeedback");
                String r2rMedCostStr = request.getParameter("nr2rMed");
                String r2rOutlayStr = request.getParameter("nr2rOut");
                
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
                //create object
                ProblemR2R problemR2R = new ProblemR2R (workerFinNum, jobKey, problemKey, r2rDate, 
                        r2rTime, r2rHosp, r2rDept, r2r1, r2r2, r2rPurpose, r2rPreApptNotes,
                        r2rPostApptNotes, r2rFeedback, r2rMedCost, r2rOutlay);
                //add to db
                ProblemComplementsDAO.addProblemR2R(problemR2R);
            
                //log the audit
                auditChange = problemR2R.toString2();
            }
            //=======================================//
            //          Other Complements   
            //=======================================//
            //=======================================//
            //  16. Details & History of Other Problem 
            //=======================================//
            else if (complementName.equals("othercase")) {
                String otherProblemDesc = request.getParameter("nother");
                String otherProblemLossStr = request.getParameter("nloss");
                String otherProblemRemark = request.getParameter("nremark");
                
                Double otherProblemLoss = 0.0;
                if (!otherProblemLossStr.equals("")) {
                    try {
                        otherProblemLoss = Double.parseDouble(otherProblemLossStr);
                    } catch (Exception ex) {
                        out.println(ex);
                    }
                }
                
                //create object
                ProblemOtherProblems other = new ProblemOtherProblems(workerFinNum, jobKey, problemKey,
                        otherProblemDesc,otherProblemLoss, otherProblemRemark);
                
                ProblemComplementsDAO.addProblemOtherProblems(other);
                
                //log the audit
                auditChange = other.toString2();
            //=======================================//
            //          18. Police Report Lodged  
            //=======================================//
            } else if (complementName.equals("policareport")) {
                String policeReportDateStr = request.getParameter("ndate");
                String policeReportStation = request.getParameter("npoliceReportStation");
                String policeReportPerson = request.getParameter("nperson");
                String policeReportRefNumber = request.getParameter("npoliceReportRefNumber");
                String policeReportRefDetails = request.getParameter("npoliceReportDetails");
                String policeReportRemark = request.getParameter("nremark");
                
                java.sql.Date policeReportDate = null;
                if (!policeReportDateStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(policeReportDateStr);
                        policeReportDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }
                
                //create object
                ProblemPoliceReport policeReport = new ProblemPoliceReport(workerFinNum, jobKey,
                        problemKey, policeReportDate, policeReportStation, policeReportPerson,
                        policeReportRefNumber, policeReportRefDetails, policeReportRemark);
                
                //add to db
                ProblemComplementsDAO.addProblemPoliceReport(policeReport);
                
                //log the audit
                auditChange = policeReport.toString2();
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
                if (!otherComplaintDateStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(otherComplaintDateStr);
                        otherComplaintDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }
                
                //create object
                ProblemOtherComplaint otherComplaint = new ProblemOtherComplaint (workerFinNum, jobKey,
                        problemKey, otherComplaintDate, otherComplaintAgency, otherComplaintWho,
                        otherComplaintWhoMore, otherComplaintMode, otherComplaintModeMore,
                        otherComplaintDetails, otherComplaintRemark);
                //add to db
                ProblemComplementsDAO.addProblemOtherComplaint(otherComplaint);
                
                //log the audit
                auditChange = otherComplaint.toString2();
            //=======================================//
            //20. Case Milestone Reached(non-criminal) 
            //=======================================//    
            } else if (complementName.equals("ncmilestone")) {
                String ncmileStoneDateStr = request.getParameter("ndate");
                String ncmileStoneReach = request.getParameter("nmilestoneNCReached");
                String ncmileStoneReachMore =request.getParameter("nmilestoneNCReachedMore");
                String ncmileStoneRemark = request.getParameter("nremark");
                
                java.sql.Date ncmileStoneDate = null;
                if (!ncmileStoneDateStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(ncmileStoneDateStr);
                        ncmileStoneDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }
                
                //create object
                ProblemCaseMilestoneNC problemCaseMilestoneNC = new ProblemCaseMilestoneNC (workerFinNum, jobKey,
                        problemKey, ncmileStoneDate, ncmileStoneReach, ncmileStoneReachMore, 
                        ncmileStoneRemark);
                //add to db
                ProblemComplementsDAO.addProblemCaseMilestoneNC(problemCaseMilestoneNC);
                
                //log the audit
                auditChange = problemCaseMilestoneNC.toString2();
                
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
                if (!cmileStoneDateStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(cmileStoneDateStr);
                        cmileStoneDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }
                
                //create object
                ProblemCaseMilestoneCR problemCaseMilestoneCR = new ProblemCaseMilestoneCR (workerFinNum, jobKey,
                        problemKey, cmileStoneDate, cmileStoneReach, cmileStoneReachMore,
                        cmileStoneCharge, cmileStoneSentence, cmileStoneRemark);
                //add to db
                ProblemComplementsDAO.addProblemCaseMilestoneCR(problemCaseMilestoneCR);
               
                //log the audit
                auditChange = problemCaseMilestoneCR.toString2();
                
            //=======================================//
            //      22. Transfer, TJS & Repatriation    
            //=======================================//    
            } else if (complementName.equals("ttr")) {
                String ttrUpdateDateStr = request.getParameter("ndate");
                String ttrStatus = request.getParameter("nttrStatus");
                String ttrStatusMore = request.getParameter("nttrStatusMore");
                String ttrDepatureDateStr = request.getParameter("nttrDepartureDate");
                String ttrNewEmployer = request.getParameter("nttrEmployerName");
                String ttrNewJob = request.getParameter("nttrJob");
                String ttrRemark = request.getParameter("nremark");
                
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
                
                //create object
                ProblemTTR problemTTR = new ProblemTTR(workerFinNum, jobKey, problemKey, ttrUpdateDate,
                        ttrStatus, ttrStatusMore, ttrDepatureDate, ttrNewEmployer, ttrNewJob,
                        ttrRemark);
                //add to db
                ProblemComplementsDAO.addProblemTTR(problemTTR);
              
                //log the audit
                auditChange = problemTTR.toString2();
            }
            
            //log to audit
            UserAuditLog userAuditLog = new UserAuditLog(_user.getUsername(), problemKey + "", 
                    workerFinNum, "Added", "Problem Complement: " + auditChange);

            UserAuditLogDAO.addUserAuditLog(userAuditLog);              
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
