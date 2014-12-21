/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.controller;

import camans.dao.*;
import camans.entity.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Nyein Su
 */
public class processAssignCase extends HttpServlet {

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
            String userLogin = request.getParameter("userLogin");
            String probKeyStr = request.getParameter("probKey");
            int probKey = Integer.parseInt(probKeyStr);
            Problem problem = ProblemDAO.retrieveProblemByProblemId(probKey);
            int jobKey = problem.getJobKey();
            String workerFin = problem.getWorkerFinNum();
            java.util.Date tempDate = new java.util.Date();
            java.sql.Date leadStart = new java.sql.Date(tempDate.getTime());
            
            User user = UserDAO.retrieveUserByNRIC(userLogin);
            Problem prob = ProblemDAO.retrieveProblemByProblemId(probKey);
            ProblemLeadCaseWorker leadCaseWorker = new ProblemLeadCaseWorker(workerFin, jobKey, probKey, userLogin, leadStart, null);
            
            ProblemComplementsDAO.addProblemLeadCaseWorker(leadCaseWorker);
            request.getSession().setAttribute("userLogin", user);
            response.sendRedirect("caseReferral.jsp?worker=" + workerFin + "&selectedProb=" + probKey);
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
