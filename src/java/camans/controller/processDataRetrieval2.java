/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.controller;

import camans.dao.DropdownDAO;
import camans.dao.ProblemDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author soemyatmyat
 */
@WebServlet(name = "processDataRetrieval2", urlPatterns = {"/dataRetrieval2.do"})
public class processDataRetrieval2 extends HttpServlet {

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
        //response.setContentType("text/html;charset=UTF-8");
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        try {
            int minYear = ProblemDAO.getMinYear();
            int maxYear = ProblemDAO.getMaxYear();
            
            ArrayList<String> nationalityList = DropdownDAO.retrieveAllDropdownListOfNationalities();
            ArrayList<String> jobSectorList = DropdownDAO.retrieveAllDropdownListOfJobSector();
            
            JSONObject returnJsonObj = new JSONObject();
            for (int year = maxYear; year > minYear; year--) {
                JSONArray jsonArr = new JSONArray();
                for (String nationality: nationalityList) {
                    int total = 0;
                    JSONObject jsonObj = new JSONObject();
                    jsonObj.put("Nationality", nationality);
                    for (String jobSector: jobSectorList) {
                        int count = ProblemDAO.
                                retrieveProblemCountByNationalityAndYearAndJobSector(nationality, year, jobSector);
                        total = total + count;
                        jsonObj.put(jobSector, count);
                    }
                    jsonObj.put("Total", total);
                    jsonArr.add(jsonObj);
                }
                returnJsonObj.put(year, jsonArr);
            }
            //returnJsonObject.put("year", cJsonArray);
            out.println(returnJsonObj.toString());
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
