/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.controller;

import camans.dao.BenefitDAO;
import camans.dao.ProblemComplementsDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Nyein Su
 */
public class processBenefitRetrieve extends HttpServlet {

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
            /* TODO output your page here. You may use following sample code. */
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");
            String category = request.getParameter("category");
            ArrayList<Integer> benefitIds = new ArrayList<Integer>();
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
            if (startDateStr != null && endDateStr != null && !startDateStr.equals("") && !endDateStr.equals("")) {
                java.util.Date startDate = sdf.parse(startDateStr);
                java.util.Date endDate = sdf.parse(endDateStr);
                if (category.equals("r2r")) {
                    benefitIds = ProblemComplementsDAO.retrieveProblemR2rIdsBetDates(startDate, endDate);
                    request.getSession().setAttribute("startDate", startDateStr);
                    request.getSession().setAttribute("endDate", endDateStr);
                    request.getSession().setAttribute("r2rIds", benefitIds);
                    request.getSession().setAttribute("category", "r2r");
                    request.getSession().setAttribute("action", "review");

                    response.sendRedirect("associate/benefection.jsp");
                } else {

                    benefitIds = BenefitDAO.retrieveBenefitsIdsOfCategory(category, startDate, endDate);
                    request.getSession().setAttribute("startDate", startDateStr);
                    request.getSession().setAttribute("endDate", endDateStr);
                    request.getSession().setAttribute("benefitIds", benefitIds);
                    request.getSession().setAttribute("category", category);
                    request.getSession().setAttribute("action", "viewHistory");

                    response.sendRedirect("associate/benefection.jsp");
                }
            }
        } catch (ParseException ex) {
            Logger.getLogger(processBenefitRetrieve.class.getName()).log(Level.SEVERE, null, ex);
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
