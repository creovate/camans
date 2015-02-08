/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.controller;

import camans.dao.BenefitDAO;
import camans.dao.JobComplementsDAO;
import camans.dao.ProblemComplementsDAO;
import camans.dao.WorkerComplementsDAO;
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
            if (name.equals("worker")) {
                //1. Nickname
                if (complement.equals("nickname")) {
                    WorkerComplementsDAO.deleteNickname(id);
                    success = "Worker Nickname has been successfully deleted!";
                //2. passport
                } else if (complement.equals("passport")) {
                    WorkerComplementsDAO.deletePassportDetails(id);
                    success = "Worker Passport has been successfully deleted!";
                //3. sg phone
                } else if (complement.equals("sgphone")) {
                    WorkerComplementsDAO.deleteWorkerSgPhNum(id);
                    success = "Worker Sg Phone has been successfully deleted!";
                //4. Home Country Phone   
                } else if (complement.equals("homephone")) {
                    WorkerComplementsDAO.deleteHomeCountryPhNumber(id);
                    success = "Worker Home Phone has been successfully deleted!";
                //5. Singapore Address
                } else if (complement.equals("sgadd")) {
                    WorkerComplementsDAO.deleteWorkerSgAddress(id);
                    success = "Worker Sg address has been successfully deleted!";
                //6. Home Country Address
                } else if (complement.equals("homeadd")) {
                    WorkerComplementsDAO.deleteWorkerHomeCountryAddress(id);
                    success = "Worker home address has been successfully deleted!";
                //7. Digital Contact
                } else if (complement.equals("digcontact")) {
                    WorkerComplementsDAO.deleteWorkerDigitalContact(id);
                    success = "Worker digital contact has been successfully deleted!";
                //8. Next of Kin
                } else if (complement.equals("nok")) {
                    WorkerComplementsDAO.deleteWorkerNextOfKin(id);
                    success = "Worker next of kin has been successfully deleted!";
                //9. Family Member 
                } else if (complement.equals("familymember")) {
                    WorkerComplementsDAO.deleteFamilyMember(id);
                    success = "Worker family member has been successfully deleted!";
                //10. Friend 
                } else if (complement.equals("sgfri")) {
                    WorkerComplementsDAO.deleteWorkerFriend(id);
                    success = "Worker sg friend has been successfully deleted!";
                //11. Language    
                } else if (complement.equals("language")) {
                    WorkerComplementsDAO.deleteWorkerLanguage(id);
                    success = "Worker language has been successfully deleted!";
                //12. Bank Account    
                } else if (complement.equals("bankacc")) {
                    WorkerComplementsDAO.deleteBankAccountDetails(id);
                    success = "Worker bank account has been successfully deleted!";
                }
                request.getSession().setAttribute("successWrkCompMsg", success);
                response.sendRedirect("viewWorker.jsp?worker=" + workerFinNum);
            } else if (name.equals("job")) {
                int jobKey = Integer.parseInt(request.getParameter("jobkey"));
                if (complement.equals("passdetails")) {
                    JobComplementsDAO.deleteJobPassDetails(id);
                    success = "Worker Current Pass has been successfully deleted!";
                } else if (complement.equals("empdetails")) {
                    JobComplementsDAO.deleteJobEmployer(id);
                    success = "Employer Details has been successfully deleted!";
                } else if (complement.equals("empcontract")) {
                    JobComplementsDAO.deleteJobEmploymentContract(id);
                    success = "Employment Contract has been successfully deleted!";
                } else if (complement.equals("agent")) {
                    JobComplementsDAO.deleteJobIntermediaryAgent(id);
                    success = "Intermediary Agent has been successfully deleted!";
                } else if (complement.equals("assurance")) {
                    JobComplementsDAO.deleteJobVerbalAssurance(id);
                    success = "Verbal Assurance has been successfully deleted!";
                } else if (complement.equals("wplace")) {
                    JobComplementsDAO.deleteJobWorkplace(id);
                    success = "Worker workplace has been successfully deleted!";
                } else if (complement.equals("whistory")) {
                    JobComplementsDAO.deleteJobWorkHistory(id);
                    success = "Work History has been successfully deleted!";
                } else if (complement.equals("waccom")) {
                    JobComplementsDAO.deleteJobAccomodation(id);
                    success = "Work Accomodation has been successfully deleted!";
                } else if (complement.equals("ipa")) {
                    JobComplementsDAO.deleteJobIPADetails(id);
                    success = "IPA Details has been successfully deleted!";
                }
                request.getSession().setAttribute("successJobCompMsg", success);
                response.sendRedirect("viewWorker.jsp?worker=" + workerFinNum + "&selectedJob=" + jobKey);
            } else if (name.equals("problem")) {
                int problemKey = Integer.parseInt(request.getParameter("probKey"));
                if (complement.equals("aggravissue")) {
                    ProblemComplementsDAO.deleteProblemAggravatingIssue(id);
                    success = "Aggravating Issue has been successfully deleted!";
                } else if (complement.equals("leadcaseworker")) {
                    ProblemComplementsDAO.deleteProblemLeadCaseWorker(id);
                    success = "Lead Case Worker has been successfully deleted!";
                } else if (complement.equals("auxcaseworker")) {
                    ProblemComplementsDAO.deleteProblemAuxiliaryCaseWorker(id);
                    success = "Auxiliary Case Worker has been successfully deleted!";
                } else if (complement.equals("casediscussion")) {
                    ProblemComplementsDAO.deleteProblemCaseDiscussion(id);
                    success = "Case discussion has been successfully deleted!";
                } else if (complement.equals("lawyer")) {
                    ProblemComplementsDAO.deleteProblemLawyer(id);
                    success = "Lawyer details has been successfully deleted!";
                } else if (complement.equals("salaryhistory")) {
                    ProblemComplementsDAO.deleteProblemSalaryRelatedHistory(id);
                    success = "Salary History has been successfully deleted!";
                } else if (complement.equals("salarycalim")) {
                    ProblemComplementsDAO.deleteProblemSalaryClaim(id);
                    success = "Salary claim has been successfully deleted!";
                } else if (complement.equals("injurycase")) {
                    ProblemComplementsDAO.deleteProblemInjury(id);
                    success = "Injury Case has been successfully deleted!";
                } else if (complement.equals("illnesscase")) {
                    ProblemComplementsDAO.deleteProblemIllness(id);
                    success = "Illness case has been successfully deleted!";
                } else if (complement.equals("wicaclaim")) {
                    ProblemComplementsDAO.deleteProblemWicaClaim(id);
                    success = "WICA claim has been successfully deleted!";
                } else if (complement.equals("nonwicaclaim")) {
                    ProblemComplementsDAO.deleteProblemNonWicaClaim(id);
                    success = "Non-WICA claim has been successfully deleted!";
                } else if (complement.equals("wica")) {
                    ProblemComplementsDAO.deleteAllProblemWicas();
                    success = "WICA status has been successfully deleted!";
                } else if (complement.equals("hospital")) {
                    ProblemComplementsDAO.deleteProblemHospital(id);
                    success = "Hospital Details has been successfully deleted!";
                } else if (complement.equals("mc")) {
                    ProblemComplementsDAO.deleteProblemMCStatus(id);
                    success = "MC Status has been successfully deleted!";
                } else if (complement.equals("r2r")) {
                    ProblemComplementsDAO.deleteProblemR2R(id);
                    success = "R2R Details has been successfully deleted!";
                } else if (complement.equals("othercase")) {
                    ProblemComplementsDAO.deleteProblemOtherProblem(id);
                    success = "Other Case has been successfully deleted!";
                } else if (complement.equals("policareport")) {
                    ProblemComplementsDAO.deleteProblemPoliceReport(id);
                    success = "Police Report has been successfully deleted!";
                } else if (complement.equals("othercomplaint")) {
                    ProblemComplementsDAO.deleteProblemOtherComplaint(id);
                    success = "Other Complaint has been successfully deleted!";
                } else if (complement.equals("ncmilestone")) {
                    ProblemComplementsDAO.deleteProblemCaseMilestoneNC(id);
                    success = "Non-criminal milestone has been successfully deleted!";
                } else if (complement.equals("cmilestone")) {
                    ProblemComplementsDAO.deleteProblemCaseMilestoneCR(id);
                    success = "Criminal milestone has been successfully deleted!";
                } else if (complement.equals("ttr")) {
                    ProblemComplementsDAO.deleteProblemTTR(id);
                    success = "TTR Details has been successfully deleted!";
                }
                request.getSession().setAttribute("successProbCompMsg", success);
                response.sendRedirect("viewWorker.jsp?worker=" + workerFinNum + "&selectedProb=" + problemKey);
            } else if (name.equals("benefit")) {
                int problemKey = Integer.parseInt(request.getParameter("probKey"));
                BenefitDAO.deleteBenefit(id);
                success = "Benefit Details has been successfully deleted!";
                request.getSession().setAttribute("successBenefitMsg", success);
                response.sendRedirect("viewWorker.jsp?worker=" + workerFinNum + "&selectedBenefit=" + problemKey);
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
