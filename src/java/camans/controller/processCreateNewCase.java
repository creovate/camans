/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.controller;

import camans.entity.*;
import camans.dao.*;
import java.io.*;
import java.net.URL;
import java.sql.Date;
import java.text.*;
import java.util.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author soemyatmyat
 */
@WebServlet(name = "processCreateNewCase", urlPatterns = {"/createNewCase.do"})
public class processCreateNewCase extends HttpServlet {

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
                     
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
            java.sql.Date sqlRegisteredDate = null;
            java.sql.Date sqlDob = null;
            java.util.Date date = new java.util.Date();
            //get FIN & job Key
            
            String finNumber = request.getParameter("workerFinNum");
            String jobKeyStr = request.getParameter("jobKey");
            
            //worker variables
            String registeredDateStr = null;
            String createdBy = null;
            String createdFor = null;
            java.sql.Date registeredDate = null;
            String workerName = null;
            String finNum = null;
            String gender = null;
            String nationality = null;
            String nationalityMore = null;
            String dobStr = null;
            java.sql.Date dob = null;
            String passCurrent = null;
            String passMore = null;
            String passNumber = null;
            String passIssueDate = null;
            
            //job variables
            String employerName = null;
            String workpassType = null;;
            String workpassMore = null;
            String jobSector = null;
            String jobSectorMore = null;
            String occupation = null;
            String jobStartDateStr = null;
            String jobEndDateStr = null;
            String tjs = null;
            String jobRemark = null;
            
            if(finNumber == null){
                User userLogin = (User) request.getSession().getAttribute("userLogin");
                registeredDateStr = request.getParameter("registeredDate");
                createdBy = request.getParameter("createdBy");
                createdFor = request.getParameter("createdFor");


                try {
                    java.util.Date tmp = sdf.parse(registeredDateStr);
                    registeredDate = new java.sql.Date(tmp.getTime());
                } catch (ParseException ex) {
                    out.println(ex);
                }  


                //get all the information for new worker
                workerName = request.getParameter("workerName");
                finNum = request.getParameter("finNum");
                gender = request.getParameter("gender");
                nationality = request.getParameter("nationality");
                nationalityMore = request.getParameter("nationalityMore");
                dobStr = request.getParameter("dob");
                
                if (!dobStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(dobStr);
                        dob = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }
                //this should be in the user complements, but don't hv db table
                passCurrent = request.getParameter("passCurrent");
                passMore = request.getParameter("passMore");
                passNumber = request.getParameter("passNumber");
                passIssueDate = request.getParameter("passIssueDate");
            }
            if(jobKeyStr == null){

                //get all the information for new job
                employerName = request.getParameter("employerName");
                workpassType = request.getParameter("workpassType");
                workpassMore = request.getParameter("workpassMore");
                jobSector = request.getParameter("jobSector");
                jobSectorMore = request.getParameter("jobSectorMore");
                occupation = request.getParameter("occupation");
                jobStartDateStr = request.getParameter("jobStartDate");
                jobEndDateStr = request.getParameter("jobEndDate");
                tjs = request.getParameter("tjs");
                jobRemark = request.getParameter("jobRemark");
            }
                
            //get all the information for new problem
            String problemName = request.getParameter("problem");
            String problemMore = request.getParameter("problemMore");
            String problemRemark = request.getParameter("problemRemark");
            String injuryDate = request.getParameter("injuryDate");
            String injuryBodyPart = request.getParameter("injuryBodyPart");
            String currentHosptial = request.getParameter("currentHosptial");
            String hospitalMore = request.getParameter("hospitalMore");
            String lawfirmName = request.getParameter("lawfirmName");


            //all fields are correct & parsed to date
            Worker worker = null;
            
            if(finNumber != null){
                finNum = finNumber;
                registeredDate = new java.sql.Date(date.getTime());
                worker = WorkerDAO.retrieveWorkerbyFinNumber(finNumber);
            }else{
            //create new Worker Object and add to db
            worker = new Worker(finNum, workerName,registeredDate, createdBy, createdFor,
                    gender, nationality, nationalityMore, dob);
            out.println(worker);
            }
            //WorkerDAO.addWorker(worker);
            int jobKey = -1;
            Job job = null;
            if(jobKeyStr == null){
            //create new Job Object and add to db
             job = new Job(finNum, employerName, workpassType, workpassMore, jobSector, 
                    jobSectorMore, occupation, jobStartDateStr, jobEndDateStr, tjs, jobRemark);
            jobKey = job.getJobKey();
            out.println(job);
            }else{
                jobKey = Integer.parseInt(jobKeyStr);
                worker = WorkerDAO.retrieveWorkerbyFinNumber(finNumber);
                job = JobDAO.retrieveJobByJobId(jobKey);
            }
            Problem problem = new Problem(finNum, jobKey, registeredDate, problemName,
                    problemMore, problemRemark);
            out.println(problem);
            
            if(finNumber == null){
            WorkerDAO.addWorker(worker);
            }
            
            if(jobKeyStr == null){
            JobDAO.addJob(worker, job);
            }
            ProblemDAO.addProblem(worker, job, problem);

            //Upload face Picture to the server
            
            if(finNumber == null){
            //Redirect Back to CreateNewCase Successful Page
            String status = "success";
            request.getSession().setAttribute("worker", worker);
            request.getSession().setAttribute("status",status);
            //RequestDispatcher rd = request.getRequestDispatcher("createCase.jsp");
            //rd.forward(request, response);

           response.sendRedirect("createCase.jsp");
            }else{
                //request.getSession().setAttribute("worker", worker);
                response.sendRedirect("viewWorker.jsp?worker="+finNumber);
            }
        }catch(Exception e){
            out.println(e);

            //RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
            //rd.forward(request, response);

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
