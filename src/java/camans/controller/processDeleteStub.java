/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.controller;

import camans.dao.JobDAO;
import camans.dao.ProblemDAO;
import camans.dao.WorkerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Nyein Su
 */
public class processDeleteStub extends HttpServlet {

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
            String workerFin = request.getParameter("workerFinNum");
            String jobKeyStr = request.getParameter("jobKey");
            String probKeyStr = request.getParameter("probKey");
            int jobKey = -1;
            int probKey = -1;
            String stub = request.getParameter("stub");
            String url = "home.jsp";
            if(stub.equals("worker")){
                //delete whole case
                WorkerDAO.deleteWorker(workerFin);
                
            }else if (stub.equals("job")){
                
                if(jobKeyStr != null && !jobKeyStr.equals("")){
                    jobKey = Integer.parseInt(jobKeyStr);
                }
                //delete job
                JobDAO.deleteJob(jobKey);
                ArrayList<Integer> jobList =  JobDAO.retrieveJobIdsOfWorker(WorkerDAO.retrieveWorkerbyFinNumber(workerFin));
                if(jobList.size() > 0){
                    url = "viewWorker.jsp?worker="+ workerFin;
                }
            }else if(stub.equals("problem")){
                
                if(probKeyStr != null && !probKeyStr.equals("")){
                    probKey = Integer.parseInt(probKeyStr);
                }
                //delete problem
                ProblemDAO.deleteProblem(probKey);
                ArrayList<Integer> probList = ProblemDAO.retrieveProblemsIdsOfWorkerAndJob(WorkerDAO.retrieveWorkerbyFinNumber(workerFin), JobDAO.retrieveJobByJobId(jobKey));
                
                if(probList.size() > 0){
                    url = "viewWorker.jsp?worker=" + workerFin;
                }
            }
            
            response.sendRedirect("viewWorker.jsp?worker" + workerFin);
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
