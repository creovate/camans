/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.controller;

import camans.dao.ConnectionManager;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
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
        try {
            /* TODO output your page here. You may use following sample code. */
            String reportType = request.getParameter("reportType");
            String reportYearStr = request.getParameter("year");

            ServletOutputStream servletOutputStream = response.getOutputStream();
            HashMap map = new HashMap();
            
            Connection conn = ConnectionManager.getConnection();
            if (reportYearStr != null && reportYearStr.length() > 0) {
                int reportYear = Integer.parseInt(reportYearStr);
                map.put("year", reportYear);
            }


            String filePath = null;
            byte[] bytes = null;
            
            if (reportType.equals("Case Summary")) {
                //get the file path
                filePath = getServletContext().getRealPath("/reports/CaseSummaryReport.jasper");

                //generate report
                bytes = JasperRunManager.runReportToPdf(filePath, map,conn);


            } else {
                //get the file path
                filePath = getServletContext().getRealPath("/reports/BenefitSummaryReport.jasper");
                
                //generate report
                bytes = JasperRunManager.runReportToPdf(filePath, map, conn);
                
            }
         
            response.setContentType("application/pdf");
            response.setContentLength(bytes.length);
            servletOutputStream.write(bytes, 0, bytes.length);
            servletOutputStream.flush();
            servletOutputStream.close();
           
        } catch (JRException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
           //out.close();
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
