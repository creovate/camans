/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.controller;

import camans.dao.UserAuditLogDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author soemyatmyat
 */
@WebServlet(name = "processSearchAuditLog", urlPatterns = {"/searchAuditLog.do"})
public class processSearchAuditLog extends HttpServlet {

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
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");
            java.util.Date startDate = null;
            java.util.Date endDate= null;
            String errorMsg = "";
            try {
                java.util.Date tmp = sdf.parse(startDateStr);
                startDate = new java.sql.Date(tmp.getTime());
                tmp = sdf.parse(endDateStr);
                endDate = new java.sql.Date(tmp.getTime());
            } catch (ParseException ex) {
                errorMsg += "Invalid Date Format!";
                request.getSession().setAttribute("errMsg", errorMsg);
                response.sendRedirect("auditLog.jsp");
            }
            
            
            ArrayList<Integer> queryResult = UserAuditLogDAO.retrieveUserAduitLogIdsBySearch
                    (startDate, endDate);
            request.getSession().setAttribute("queryResult", queryResult);
            request.getSession().setAttribute("startDate", startDateStr);
            request.getSession().setAttribute("endDate", endDateStr);
            response.sendRedirect("auditLog.jsp");
            
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
