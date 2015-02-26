/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.controller;

import camans.dao.JobDAO;
import camans.dao.ProblemDAO;
import camans.dao.UserAuditLogDAO;
import camans.dao.WorkerDAO;
import camans.entity.Job;
import camans.entity.Problem;
import camans.entity.User;
import camans.entity.UserAuditLog;
import camans.entity.Worker;
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
 * @author Nyein Su
 */
public class processEditStubs extends HttpServlet {

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
        boolean success = false;
        try {
            String complement = request.getParameter("stub");
            String workerFinNum = request.getParameter("workerFin");
            String jobKeyStr = request.getParameter("jobKey");
            String probKeyStr = request.getParameter("probKey");
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
            User userLogin = (User) request.getSession().getAttribute("userLogin");
            
            if(complement.equals("worker")){
                String registeredDateStr = request.getParameter("date");
                String hiddenFin = request.getParameter("hiddenFin");
                String createdBy = request.getParameter("createdBy");
                String createdFor = request.getParameter("createdFor");
                
                java.sql.Date registeredDate = null;
                if(!hiddenFin.equals(workerFinNum)){
                    //admin has edited the fin number
                    
                }else{
                    
                }
                try {
                    java.util.Date tmp = sdf.parse(registeredDateStr);
                    registeredDate = new java.sql.Date(tmp.getTime());
                } catch (ParseException ex) {
                    out.println(ex);
                }  

                //get all the information for new worker
                String workerName = request.getParameter("wkerName");
                String gender = request.getParameter("gender");
                String nationality = request.getParameter("nationality");
                String nationalityMore = request.getParameter("nationalityMore");
                String dobStr = request.getParameter("dob");
                
                java.sql.Date dob = null;
                
                if (!dobStr.equals("") || !dobStr.equals("null")) {
                    try {
                        java.util.Date tmp = sdf.parse(dobStr);
                        dob = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }
                
                Worker worker = new Worker(workerFinNum, workerName, registeredDate, createdBy, 
                        createdFor, gender, nationality, nationalityMore, dob, null);
                
                WorkerDAO.updateWorkerProfile(worker);
                
                //audit log
                String auditChange = worker.toString();
                UserAuditLog userAuditLog = new UserAuditLog(userLogin.getUsername(), workerFinNum, 
                        workerFinNum, "Modified", "Worker: " + auditChange);

                UserAuditLogDAO.addUserAuditLog(userAuditLog); 
                //end of audit log
                
            }else if(complement.equals("job")){
                int jobKey = Integer.parseInt(jobKeyStr);
                //this should be in the user complements, but don't hv db table
                String passCurrent = request.getParameter("passCurrent");
                String passMore = request.getParameter("passMore");
                String passNumber = request.getParameter("passNumber");
                String passIssueDate = request.getParameter("passIssueDate");
                
                String employerName = request.getParameter("empName");
                String workpassType = request.getParameter("wpType");
                String workpassMore = request.getParameter("wpMore");
                String jobSector = request.getParameter("jobSector");
                String jobSectorMore = request.getParameter("jobSectorMore");
                String occupation = request.getParameter("occupation");
                String jobStartDateStr = request.getParameter("jobStartDate");
                String jobEndDateStr = request.getParameter("jobEndDate");
                String tjs = request.getParameter("isTjs");
                String jobRemark = request.getParameter("jobRemark");
                
                Job job = new Job(workerFinNum, jobKey, employerName, workpassType, workpassMore, 
                        jobSector, jobSectorMore, occupation, jobStartDateStr, jobEndDateStr,
                        tjs, jobRemark);
                JobDAO.updateJob(job);
                
                //audit log
                String auditChange = job.toString2();
                UserAuditLog userAuditLog = new UserAuditLog(userLogin.getUsername(), job.getJobKey()+"", 
                        workerFinNum, "Modified", "Job: " + auditChange);

                UserAuditLogDAO.addUserAuditLog(userAuditLog); 
                //end of audit log
                
            }else if(complement.equals("problem")){
                java.util.Date date = new java.util.Date();
                String registeredDateStr = request.getParameter("problemRegDate");
                java.sql.Date registeredDate = null;
                try {
                    java.util.Date tmp = sdf.parse(registeredDateStr);
                    registeredDate = new java.sql.Date(tmp.getTime());
                } catch (ParseException ex) {
                    out.println(ex);
                } 
                String problemName = request.getParameter("problem");
                String problemMore = request.getParameter("problemMore");
                String problemRemark = request.getParameter("problemRemark");
                String injuryDate = request.getParameter("injuryDate");
                String injuryBodyPart = request.getParameter("injuryBodyPart");
                String currentHosptial = request.getParameter("currentHosptial");
                String hospitalMore = request.getParameter("hospitalMore");
                String lawfirmName = request.getParameter("lawfirmName");
                
                int jobKey = Integer.parseInt(jobKeyStr);
                int probKey = Integer.parseInt(probKeyStr);
                
                Problem problem = new Problem(workerFinNum, jobKey, probKey, registeredDate, 
                        problemName, problemMore, problemRemark);
                
                ProblemDAO.updateProblem(problem);
                
                //audit log
                String auditChange = problem.toString2();
                UserAuditLog userAuditLog = new UserAuditLog(userLogin.getUsername(), problem.getProbKey()+"", 
                        workerFinNum, "Modified", "Problem: " + auditChange);

                UserAuditLogDAO.addUserAuditLog(userAuditLog); 
                //end of audit log
            }
            response.sendRedirect("viewWorker.jsp?worker="+workerFinNum);
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
