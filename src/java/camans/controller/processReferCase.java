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
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Nyein Su
 */
public class processReferCase extends HttpServlet {

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
            String workerFinNum = request.getParameter("workerFin");
            String jobKeyStr = request.getParameter("jobkey");
            String probKeyStr = request.getParameter("probkey");
            String referredBy = request.getParameter("referredBy");
            String referredDateStr = request.getParameter("refDate");

            String referredDescription = request.getParameter("refDesc");
            int jobKey = 0;
            int probKey = 0;
            try {
                jobKey = Integer.parseInt(jobKeyStr);
                probKey = Integer.parseInt(probKeyStr);
            } catch (Exception e) {
                out.println(e);
            }
            java.sql.Date refDate = null;
            //if (!referredDateStr.equals("")) {
                //try {
                    //java.util.Date tmp = sdf.parse(referredDateStr);
                    java.util.Date tmp = new java.util.Date();
                    refDate = new java.sql.Date(tmp.getTime());
                //} catch (ParseException ex) {
                 //   out.println(ex);
               // }
            //}


            Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(workerFinNum);
            Job job = null;
            Problem problem = null;
            if (jobKey > 0 && probKey > 0) {
                job = JobDAO.retrieveJobByJobId(jobKey);
                problem = ProblemDAO.retrieveProblemByProblemId(probKey);

                CaseManagementDAO.referCase(workerFinNum, jobKey, probKey, refDate, referredBy, referredDescription);

            }

            response.sendRedirect("viewWorker.jsp?worker=" + workerFinNum + "&selectedProb=" + probKey);

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
