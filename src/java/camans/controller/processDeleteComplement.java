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
            out.println(name);
            out.println(id);
            out.println(complement);
            if (name.equals("worker")) {
                //1. Nickname
                if (complement.equals("nickname")) {
                    WorkerComplementsDAO.deleteNickname(id);
                //2. passport
                } else if (complement.equals("passport")) {
                    WorkerComplementsDAO.deletePassportDetails(id);
                //3. sg phone
                } else if (complement.equals("sgphone")) {
                    WorkerComplementsDAO.deleteWorkerSgPhNum(id);
                //4. Home Country Phone   
                } else if (complement.equals("homephone")) {
                    WorkerComplementsDAO.deleteHomeCountryPhNumber(id);
                //5. Singapore Address
                } else if (complement.equals("sgadd")) {
                    WorkerComplementsDAO.deleteWorkerSgAddress(id);
                //6. Home Country Address
                } else if (complement.equals("homeadd")) {
                    WorkerComplementsDAO.deleteWorkerHomeCountryAddress(id);
                //7. Digital Contact
                } else if (complement.equals("digcontact")) {
                    WorkerComplementsDAO.deleteWorkerDigitalContact(id);
                //8. Next of Kin
                } else if (complement.equals("nok")) {
                    WorkerComplementsDAO.deleteWorkerNextOfKin(id);
                //9. Family Member 
                } else if (complement.equals("familymember")) {
                    WorkerComplementsDAO.deleteFamilyMember(id);
                //10. Friend 
                } else if (complement.equals("sgfri")) {
                    WorkerComplementsDAO.deleteWorkerFriend(id);
                //11. Language    
                } else if (complement.equals("language")) {
                    WorkerComplementsDAO.deleteWorkerLanguage(id);
                //12. Bank Account    
                } else if (complement.equals("bankacc")) {
                    WorkerComplementsDAO.deleteBankAccountDetails(id);
                }
                response.sendRedirect("viewWorker.jsp?worker=" + workerFinNum);
            } else if (name.equals("job")) {
                int jobKey = Integer.parseInt(request.getParameter("jobkey"));
                if (complement.equals("passdetails")) {
                    JobComplementsDAO.deleteJobPassDetails(id);
                } else if (complement.equals("empdetails")) {
                    JobComplementsDAO.deleteJobEmployer(id);
                } else if (complement.equals("empcontract")) {
                    JobComplementsDAO.deleteJobEmploymentContract(id);
                } else if (complement.equals("agent")) {
                    JobComplementsDAO.deleteJobIntermediaryAgent(id);
                } else if (complement.equals("assurance")) {
                    JobComplementsDAO.deleteJobVerbalAssurance(id);
                } else if (complement.equals("wplace")) {
                    JobComplementsDAO.deleteJobWorkplace(id);
                } else if (complement.equals("whistory")) {
                    JobComplementsDAO.deleteJobWorkHistory(id);
                } else if (complement.equals("waccom")) {
                    JobComplementsDAO.deleteJobAccomodation(id);
                } else if (complement.equals("ipa")) {
                    JobComplementsDAO.deleteJobIPADetails(id);
                }
                response.sendRedirect("viewWorker.jsp?worker=" + workerFinNum + "&selectedJob=" + jobKey);
            } else if (name.equals("problem")) {
                int problemKey = Integer.parseInt(request.getParameter("probKey"));
                if (complement.equals("aggravissue")) {
                    ProblemComplementsDAO.deleteProblemAggravatingIssue(id);
                } else if (complement.equals("leadcaseworker")) {
                    ProblemComplementsDAO.deleteProblemLeadCaseWorker(id);
                } else if (complement.equals("auxcaseworker")) {
                    ProblemComplementsDAO.deleteProblemAuxiliaryCaseWorker(id);
                } else if (complement.equals("casediscussion")) {
                    ProblemComplementsDAO.deleteProblemCaseDiscussion(id);
                } else if (complement.equals("lawyer")) {
                    ProblemComplementsDAO.deleteProblemLawyer(id);
                } else if (complement.equals("salaryhistory")) {
                    ProblemComplementsDAO.deleteProblemSalaryRelatedHistory(id);
                } else if (complement.equals("salarycalim")) {
                    ProblemComplementsDAO.deleteProblemSalaryClaim(id);
                } else if (complement.equals("injurycase")) {
                    ProblemComplementsDAO.deleteProblemInjury(id);
                } else if (complement.equals("illnesscase")) {
                    ProblemComplementsDAO.deleteProblemIllness(id);
                } else if (complement.equals("wicaclaim")) {
                    ProblemComplementsDAO.deleteProblemWicaClaim(id);
                } else if (complement.equals("nonwicaclaim")) {
                    ProblemComplementsDAO.deleteProblemNonWicaClaim(id);
                } else if (complement.equals("wica")) {
                    ProblemComplementsDAO.deleteAllProblemWicas();
                } else if (complement.equals("hospital")) {
                    ProblemComplementsDAO.deleteProblemHospital(id);
                } else if (complement.equals("mc")) {
                    ProblemComplementsDAO.deleteProblemMCStatus(id);
                } else if (complement.equals("r2r")) {
                    ProblemComplementsDAO.deleteProblemR2R(id);
                } else if (complement.equals("othercase")) {
                    ProblemComplementsDAO.deleteProblemOtherProblem(id);
                } else if (complement.equals("policareport")) {
                    ProblemComplementsDAO.deleteProblemPoliceReport(id);
                } else if (complement.equals("othercomplaint")) {
                    ProblemComplementsDAO.deleteProblemOtherComplaint(id);
                } else if (complement.equals("ncmilestone")) {
                    ProblemComplementsDAO.deleteProblemCaseMilestoneNC(id);
                } else if (complement.equals("cmilestone")) {
                    ProblemComplementsDAO.deleteProblemCaseMilestoneCR(id);
                } else if (complement.equals("ttr")) {
                    ProblemComplementsDAO.deleteProblemTTR(id);
                }
                response.sendRedirect("viewWorker.jsp?worker=" + workerFinNum + "&selectedProb=" + problemKey);
            } else if (name.equals("benefit")) {
                int problemKey = Integer.parseInt(request.getParameter("probKey"));
                BenefitDAO.deleteBenefit(id);
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
