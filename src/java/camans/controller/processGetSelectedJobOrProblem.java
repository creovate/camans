/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Nyein Su
 */
public class processGetSelectedJobOrProblem extends HttpServlet {

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
            String workerFin = request.getParameter("workerFin");
            String selectedType = request.getParameter("selectedType");
            String associate = request.getParameter("associate");
            if (selectedType.equals("job")) {
                
                String jobId = request.getParameter("selectedJob");
                
                request.getSession().setAttribute("worker", workerFin);
                
                request.getSession().setAttribute("selectedJob", jobId);
                if (associate != null) {
                    response.sendRedirect("associate/issueBenefit.jsp");
                } else {
                    request.getSession().setAttribute("tabIndicator", "job");
                    response.sendRedirect("viewWorker.jsp");
                }
                //response.sendRedirect("viewWorker.jsp");

            } else if (selectedType.equals("problem")) {
                String jobKeyStr = request.getParameter("jobKey");
                String problemId = request.getParameter("selectedProblem");
                
                
                request.getSession().setAttribute("worker", workerFin);
                request.getSession().setAttribute("selectedProb", problemId);
                
                if (associate != null) {
                    response.sendRedirect("associate/issueBenefit.jsp");
                } else {
                    request.getSession().setAttribute("tabIndicator", "problem");
                    response.sendRedirect("viewWorker.jsp");
                }
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
