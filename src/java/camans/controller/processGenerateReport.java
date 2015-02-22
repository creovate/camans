/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.controller;

import camans.dao.ConnectionManager;
import camans.dao.ReportDAO;
import camans.entity.JasperDataSourceBuilder;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.data.JRBeanArrayDataSource;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.data.JRMapArrayDataSource;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.export.JRCsvExporter;
import net.sf.jasperreports.engine.export.ooxml.JRXlsxExporter;
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
            String reportStartStr = request.getParameter("start");
            String reportEndStr = request.getParameter("end");

            ServletOutputStream servletOutputStream = response.getOutputStream();
            HashMap map = new HashMap();

            java.util.Date start = null;
            java.util.Date end = null;

            Connection conn = ConnectionManager.getConnection();
            if (reportStartStr != null && reportStartStr.length() > 0 && reportEndStr != null && reportEndStr.length() > 0) {
                try {

                    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
                    SimpleDateFormat sdfNew = new SimpleDateFormat("MM/dd/yyyy");

                    start = sdf.parse(reportStartStr);
                    end = sdf.parse(reportEndStr);

                    String startNF = sdfNew.format(start);
                    String endNF = sdfNew.format(end);

                    start = sdfNew.parse(startNF);
                    end = sdfNew.parse(endNF);

                    map.put("start", start);
                    map.put("end", end);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }


            String filePath = null;
            ByteArrayOutputStream os = new ByteArrayOutputStream();
            if (reportType.equals("Case Summary")) {
                //get the file path
                filePath = getServletContext().getRealPath("/reports/CaseSummaryReport.jasper");

                //generate report

                JasperPrint print = JasperFillManager.fillReport(filePath, map);

//                JasperViewer.viewReport(print);

//                JRCsvExporter exporter = new JRCsvExporter();
//                exporter.setExporterInput(null);
//                exporter.setParameter(JRExporterParameter.JASPER_PRINT, print);
//                
//                exporter.setParameter(JRExporterParameter.OUTPUT_STRING_BUFFER, buffer);
//                exporter.exportReport();

                JRXlsxExporter exporter = new JRXlsxExporter();
                exporter.setParameter(JRExporterParameter.JASPER_PRINT, print);

                exporter.setParameter(JRExporterParameter.OUTPUT_STREAM, os);
                exporter.exportReport();

                response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
                response.setHeader("Content-Disposition", "attachment;filename=CaseSummaryReport.xlsx");


            } else if (reportType.equals("Benefit Summary")) {
                //get the file path
                filePath = getServletContext().getRealPath("/reports/BenefitSummaryReport.jasper");

                //generate report
                JasperPrint print = JasperFillManager.fillReport(filePath, map);

                JRXlsxExporter exporter = new JRXlsxExporter();
                exporter.setParameter(JRExporterParameter.JASPER_PRINT, print);

                exporter.setParameter(JRExporterParameter.OUTPUT_STREAM, os);
                exporter.exportReport();

                response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
                response.setHeader("Content-Disposition", "attachment;filename=BenefitSummaryReport.xlsx");

            } 

            response.getOutputStream().write(os.toByteArray());
            response.flushBuffer();
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
