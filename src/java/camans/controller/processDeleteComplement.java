/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.controller;

import camans.dao.BenefitDAO;
import camans.dao.JobComplementsDAO;
import camans.dao.ProblemComplementsDAO;
import camans.dao.ProblemDAO;
import camans.dao.UserAuditLogDAO;
import camans.dao.WorkerComplementsDAO;
import camans.entity.Problem;
import camans.entity.User;
import camans.entity.UserAuditLog;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author soemyatmyat
 */
@WebServlet(name = "processDeleteComplement", urlPatterns = {"/deleteComplement.do"})
public class processDeleteComplement extends HttpServlet {

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
            String workerFinNum = request.getParameter("workerFinNum");
            String name = request.getParameter("name");
            int id = Integer.parseInt(request.getParameter("id"));
            String complement = request.getParameter("complement");
            String success = "";
            User _user = (User) request.getSession().getAttribute("userLogin");
            String auditChange = "";
            String tabIndicator = "job";
            String jobKeyStr = request.getParameter("jobKey");
            String probKeyStr = request.getParameter("probKey");
            
            if (name.equals("worker")) {
                //1. Nickname
                if (complement.equals("nickname")) {
                    //log the audit
                    auditChange = WorkerComplementsDAO.retrieveWorkerNicknameById(id).toString2();
                    WorkerComplementsDAO.deleteNickname(id);
                    success = "Worker Nickname has been successfully deleted!";
                //2. passport
                } else if (complement.equals("passport")) {
                    auditChange = WorkerComplementsDAO.retrieveWorkerPassportDetailsById(id).toString2();
                    WorkerComplementsDAO.deletePassportDetails(id);
                    success = "Worker Passport has been successfully deleted!";
                //3. sg phone
                } else if (complement.equals("sgphone")) {
                    auditChange = WorkerComplementsDAO.retrieveWorkerSgPhNumById(id).toString2();
                    WorkerComplementsDAO.deleteWorkerSgPhNum(id);
                    success = "Worker Sg Phone has been successfully deleted!";
                //4. Home Country Phone   
                } else if (complement.equals("homephone")) {
                    auditChange = WorkerComplementsDAO.retrieveWorkerHomeCountryPhNumById(id).toString2();
                    WorkerComplementsDAO.deleteHomeCountryPhNumber(id);
                    success = "Worker Home Phone has been successfully deleted!";
                //5. Singapore Address
                } else if (complement.equals("sgadd")) {
                    auditChange = WorkerComplementsDAO.retrieveWorkerSgAddressById(id).toString2();
                    WorkerComplementsDAO.deleteWorkerSgAddress(id);
                    success = "Worker Sg address has been successfully deleted!";
                //6. Home Country Address
                } else if (complement.equals("homeadd")) {
                    auditChange = WorkerComplementsDAO.retrieveWorkerHomeCountryAddressById(id).toString2();
                    WorkerComplementsDAO.deleteWorkerHomeCountryAddress(id);
                    success = "Worker home address has been successfully deleted!";
                //7. Digital Contact
                } else if (complement.equals("digcontact")) {
                    auditChange = WorkerComplementsDAO.retrieveWorkerDigitalContactById(id).toString2();
                    WorkerComplementsDAO.deleteWorkerDigitalContact(id);
                    success = "Worker digital contact has been successfully deleted!";
                //8. Next of Kin
                } else if (complement.equals("nok")) {
                    auditChange = WorkerComplementsDAO.retrieveWorkerNextOfKinById(id).toString2();
                    WorkerComplementsDAO.deleteWorkerNextOfKin(id);
                    success = "Worker next of kin has been successfully deleted!";
                //9. Family Member 
                } else if (complement.equals("familymember")) {
                    auditChange = WorkerComplementsDAO.retrieveWorkerFamilyMemberById(id).toString2();
                    WorkerComplementsDAO.deleteFamilyMember(id);
                    success = "Worker family member has been successfully deleted!";
                //10. Friend 
                } else if (complement.equals("sgfri")) {
                    auditChange = WorkerComplementsDAO.retrieveWorkerFriendById(id).toString2();
                    WorkerComplementsDAO.deleteWorkerFriend(id);
                    success = "Worker sg friend has been successfully deleted!";
                //11. Language    
                } else if (complement.equals("language")) {
                    auditChange = WorkerComplementsDAO.retrieveWorkerLanguageById(id).toString2();
                    WorkerComplementsDAO.deleteWorkerLanguage(id);
                    success = "Worker language has been successfully deleted!";
                //12. Bank Account    
                } else if (complement.equals("bankacc")) {
                    auditChange = WorkerComplementsDAO.retrieveBankAccountDetailsById(id).toString2();
                    WorkerComplementsDAO.deleteBankAccountDetails(id);
                    success = "Worker bank account has been successfully deleted!";
                }
                //log to audit
                auditChange = auditChange.replace("{", " [");
                auditChange = auditChange.replace("}", "]");
                UserAuditLog userAuditLog = new UserAuditLog(_user.getUsername(), id + "", 
                        workerFinNum, "Deleted", "Worker Complement: " + auditChange );

                UserAuditLogDAO.addUserAuditLog(userAuditLog); 
                request.getSession().setAttribute("successWrkCompMsg", success);
                request.getSession().setAttribute("successWrkCompMsg", success);
                request.getSession().setAttribute("worker", workerFinNum);
                request.getSession().setAttribute("selectedJob", jobKeyStr);
                request.getSession().setAttribute("selectedProb", probKeyStr);
                response.sendRedirect("viewWorker.jsp?worker=" + workerFinNum);
            } else if (name.equals("job")) {
                int jobKey = Integer.parseInt(request.getParameter("jobkey"));
                if (complement.equals("passdetails")) {
                    auditChange = JobComplementsDAO.retrieveJobPassDetailsById(id).toString2();
                    JobComplementsDAO.deleteJobPassDetails(id);
                    success = "Worker Current Pass has been successfully deleted!";
                } else if (complement.equals("empdetails")) {
                    auditChange = JobComplementsDAO.retrieveJobEmployerById(id).toString2();
                    JobComplementsDAO.deleteJobEmployer(id);
                    success = "Employer Details has been successfully deleted!";
                } else if (complement.equals("empcontract")) {
                    auditChange = JobComplementsDAO.retrieveEmploymentContractById(id).toString2();
                    JobComplementsDAO.deleteJobEmploymentContract(id);
                    success = "Employment Contract has been successfully deleted!";
                } else if (complement.equals("agent")) {
                    auditChange = JobComplementsDAO.retrieveJobIntermediaryAgentById(id).toString2();
                    JobComplementsDAO.deleteJobIntermediaryAgent(id);
                    success = "Intermediary Agent has been successfully deleted!";
                } else if (complement.equals("assurance")) {
                    auditChange = JobComplementsDAO.retrieveVerbalAssuranceDetailsById(id).toString2();
                    JobComplementsDAO.deleteJobVerbalAssurance(id);
                    success = "Verbal Assurance has been successfully deleted!";
                } else if (complement.equals("wplace")) {
                    auditChange = JobComplementsDAO.retrieveJobWorkplaceById(id).toString2();
                    JobComplementsDAO.deleteJobWorkplace(id);
                    success = "Worker workplace has been successfully deleted!";
                } else if (complement.equals("whistory")) {
                    auditChange = JobComplementsDAO.retrieveJobWorkHistoryById(id).toString2();
                    JobComplementsDAO.deleteJobWorkHistory(id);
                    success = "Work History has been successfully deleted!";
                } else if (complement.equals("waccom")) {
                    auditChange = JobComplementsDAO.retrieveJobAccomodationById(id).toString2();
                    JobComplementsDAO.deleteJobAccomodation(id);
                    success = "Work Accomodation has been successfully deleted!";
                } else if (complement.equals("ipa")) {
                    auditChange = JobComplementsDAO.retrieveJobIPADetailsById(id).toString2();
                    JobComplementsDAO.deleteJobIPADetails(id);
                    success = "IPA Details has been successfully deleted!";
                }
                //log to audit
                auditChange = auditChange.replace("{", " [");
                auditChange = auditChange.replace("}", "]");
                UserAuditLog userAuditLog = new UserAuditLog(_user.getUsername(), id + "", 
                        workerFinNum, "Deleted", "Job Complement: " + auditChange );

                UserAuditLogDAO.addUserAuditLog(userAuditLog); 
                request.getSession().setAttribute("successJobCompMsg", success);
                request.getSession().setAttribute("tabIndicator", "job");
                request.getSession().setAttribute("worker", workerFinNum);
                request.getSession().setAttribute("selectedJob", jobKey + "");
                request.getSession().setAttribute("selectedProb", probKeyStr);
                response.sendRedirect("viewWorker.jsp");
            } else if (name.equals("problem")) {
                
                int problemKey = Integer.parseInt(request.getParameter("probKey"));
                if (complement.equals("aggravissue")) {
                    auditChange = ProblemComplementsDAO.retrieveProblemAggravatingIssueById(id).toString2();
                    ProblemComplementsDAO.deleteProblemAggravatingIssue(id);
                    success = "Aggravating Issue has been successfully deleted!";
                } else if (complement.equals("leadcaseworker")) {
                    auditChange = ProblemComplementsDAO.retrieveProblemLeadCaseWorkerById(id).toString2();
                    ProblemComplementsDAO.deleteProblemLeadCaseWorker(id);
                    success = "Lead Case Worker has been successfully deleted!";
                } else if (complement.equals("auxcaseworker")) {
                    auditChange = ProblemComplementsDAO.retrieveProblemAuxiliaryCaseWorkerById(id).toString2();
                    ProblemComplementsDAO.deleteProblemAuxiliaryCaseWorker(id);
                    success = "Auxiliary Case Worker has been successfully deleted!";
                } else if (complement.equals("casediscussion")) {
                    auditChange = ProblemComplementsDAO.retrieveProblemCaseDiscussionById(id).toString2();
                    ProblemComplementsDAO.deleteProblemCaseDiscussion(id);
                    success = "Case discussion has been successfully deleted!";
                } else if (complement.equals("lawyer")) {
                    auditChange = ProblemComplementsDAO.retrieveProblemLawyerById(id).toString2();
                    ProblemComplementsDAO.deleteProblemLawyer(id);
                    success = "Lawyer details has been successfully deleted!";
                } else if (complement.equals("salaryhistory")) {
                    auditChange = ProblemComplementsDAO.retrieveProblemSalaryRelatedHistoryById(id).toString2();
                    ProblemComplementsDAO.deleteProblemSalaryRelatedHistory(id);
                    success = "Salary History has been successfully deleted!";
                } else if (complement.equals("salarycalim")) {
                    auditChange = ProblemComplementsDAO.retrieveProblemSalaryClaimById(id).toString2();
                    ProblemComplementsDAO.deleteProblemSalaryClaim(id);
                    success = "Salary claim has been successfully deleted!";
                } else if (complement.equals("injurycase")) {
                    auditChange = ProblemComplementsDAO.retrieveProblemInjuryById(id).toString2();
                    ProblemComplementsDAO.deleteProblemInjury(id);
                    success = "Injury Case has been successfully deleted!";
                } else if (complement.equals("illnesscase")) {
                    auditChange = ProblemComplementsDAO.retrieveProblemIllnesseById(id).toString2();
                    ProblemComplementsDAO.deleteProblemIllness(id);
                    success = "Illness case has been successfully deleted!";
                } else if (complement.equals("wicaclaim")) {
                    auditChange = ProblemComplementsDAO.retrieveProblemWicaClaimById(id).toString2();
                    ProblemComplementsDAO.deleteProblemWicaClaim(id);
                    success = "WICA claim has been successfully deleted!";
                } else if (complement.equals("nonwicaclaim")) {
                    auditChange = ProblemComplementsDAO.retrieveProblemNonWicaClaimById(id).toString2();
                    ProblemComplementsDAO.deleteProblemNonWicaClaim(id);
                    success = "Non-WICA claim has been successfully deleted!";
                } else if (complement.equals("wica")) {
                    auditChange = ProblemComplementsDAO.retrieveProblemWicaById(id).toString2();
                    ProblemComplementsDAO.deleteAllProblemWicas();
                    success = "WICA status has been successfully deleted!";
                } else if (complement.equals("hospital")) {
                    auditChange = ProblemComplementsDAO.retrieveProblemHospitalById(id).toString2();
                    ProblemComplementsDAO.deleteProblemHospital(id);
                    success = "Hospital Details has been successfully deleted!";
                } else if (complement.equals("mc")) {
                    auditChange = ProblemComplementsDAO.retrieveProblemMCStatusById(id).toString2();
                    ProblemComplementsDAO.deleteProblemMCStatus(id);
                    success = "MC Status has been successfully deleted!";
                } else if (complement.equals("r2r")) {
                    auditChange = ProblemComplementsDAO.retrieveProblemR2RById(id).toString2();
                    ProblemComplementsDAO.deleteProblemR2R(id);
                    success = "R2R Details has been successfully deleted!";
                } else if (complement.equals("othercase")) {
                    auditChange = ProblemComplementsDAO.retrieveProblemOtherProblemsById(id).toString2();
                    ProblemComplementsDAO.deleteProblemOtherProblem(id);
                    success = "Other Problem has been successfully deleted!";
                } else if (complement.equals("policareport")) {
                    auditChange = ProblemComplementsDAO.retrieveProblemPoliceReportById(id).toString2();
                    ProblemComplementsDAO.deleteProblemPoliceReport(id);
                    success = "Police Report has been successfully deleted!";
                } else if (complement.equals("othercomplaint")) {
                    auditChange = ProblemComplementsDAO.retrieveProblemOtherComplaintById(id).toString2();
                    ProblemComplementsDAO.deleteProblemOtherComplaint(id);
                    success = "Other Complaint has been successfully deleted!";
                } else if (complement.equals("ncmilestone")) {
                    auditChange = ProblemComplementsDAO.retrieveProblemCaseMilestoneNCById(id).toString2();
                    ProblemComplementsDAO.deleteProblemCaseMilestoneNC(id);
                    success = "Non-criminal milestone has been successfully deleted!";
                } else if (complement.equals("cmilestone")) {
                    auditChange = ProblemComplementsDAO.retrieveProblemCaseMilestoneCRById(id).toString2();
                    ProblemComplementsDAO.deleteProblemCaseMilestoneCR(id);
                    success = "Criminal milestone has been successfully deleted!";
                } else if (complement.equals("ttr")) {
                    auditChange = ProblemComplementsDAO.retrieveProblemTTRById(id).toString2();
                    ProblemComplementsDAO.deleteProblemTTR(id);
                    success = "TTR Details has been successfully deleted!";
                }
               
                //log to audit
                auditChange = auditChange.replace("{", " [");
                auditChange = auditChange.replace("}", "]");
                UserAuditLog userAuditLog = new UserAuditLog(_user.getUsername(), id + "", 
                        workerFinNum, "Deleted", "Problem Complement: " + auditChange );
                
                UserAuditLogDAO.addUserAuditLog(userAuditLog); 
                request.getSession().setAttribute("successProbCompMsg", success);
                request.getSession().setAttribute("successProbCompMsg", success);
                request.getSession().setAttribute("tabIndicator", "problem");
                request.getSession().setAttribute("worker", workerFinNum);
                request.getSession().setAttribute("selectedProb", problemKey + "");
                response.sendRedirect("viewWorker.jsp");
            } else if (name.equals("benefit")) {
                tabIndicator = "benefit";
                int problemKey = Integer.parseInt(request.getParameter("probKey"));
                
                auditChange = BenefitDAO.retrieveBenefitById(id).toString2();
                auditChange = auditChange.replace("{", " [");
                auditChange = auditChange.replace("}", "]");
                
                BenefitDAO.deleteBenefit(id);
                success = "Benefit Details has been successfully deleted!";
                //log to audit
                UserAuditLog userAuditLog = new UserAuditLog(_user.getUsername(), id + "", 
                        workerFinNum, "Deleted", "Benefit: " + auditChange );

                UserAuditLogDAO.addUserAuditLog(userAuditLog); 
                request.getSession().setAttribute("successBenefitMsg", success);
                request.getSession().setAttribute("tabIndicator", "benefit");
                request.getSession().setAttribute("worker", workerFinNum);
                request.getSession().setAttribute("selectedProb", probKeyStr);
                request.getSession().setAttribute("selectedJob", jobKeyStr);;
                
                response.sendRedirect("viewWorker.jsp");
            }
            
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
