/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.controller;

import camans.dao.ConnectionManager;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;
import net.sf.jasperreports.view.JasperViewer;

/**
 *
 * @author Nyein Su
 */
public class processGenerateReport extends HttpServlet {

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
            String reportType = request.getParameter("reportType");
            String reportYearStr = request.getParameter("year");
            
            
            HashMap map = new HashMap();
            JasperPrint jasperPrint = null;
            String printFileName = null;
            Connection conn = ConnectionManager.getConnection();
            if(reportYearStr != null && reportYearStr.length() > 0){
            int reportYear = Integer.parseInt(reportYearStr);
            map.put("year", reportYear);
            }
            



            if (reportType.equals("Case Summary")) {
                //call method with parameter year
                //JasperCompileManager.compileReportToFile("reports/CaseSummaryReport.jrxml");
                JasperReport jasperReport = JasperCompileManager.compileReport("C:\\Users\\Nyein Su\\Desktop\\app\\camans\\reports\\CaseSummaryReport.jrxml");
                jasperPrint = JasperFillManager.fillReport(jasperReport, map, conn);
                
            } else {
                //call method with parameter year
                //JasperDesign jd  = JRXmlLoader.load("C:\\Users\\Nyein Su\\Desktop\\app\\camans\\reports\\BenefitSummaryReport.jasper");
                //JasperDesign jd  = JRXmlLoader.load("reports/BenefitSummaryReport.jasper");
                jasperPrint = JasperFillManager.fillReport("C:\\Users\\Nyein Su\\Desktop\\app\\camans\\reports\\BenefitSummaryReport.jasper", map, conn);
            }
            JasperViewer jasperViewer = new JasperViewer(jasperPrint);
            jasperViewer.setVisible(true);
            //JasperExportManager.exportReportToPdfFile(jasperPrint,"C://sample_report.pdf");
            //request.getSession().setAttribute("userLogin", user);
            response.sendRedirect("home.jsp");
        } catch (JRException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
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
