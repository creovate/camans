/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.controller;

import camans.dao.BenefitDAO;
import camans.dao.UserAuditLogDAO;
import camans.entity.Benefit;
import camans.entity.User;
import camans.entity.UserAuditLog;
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
 * @author soemyatmyat
 */
public class processAddBenefit extends HttpServlet {

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
            String action = request.getParameter("action");
            String workerFinNum = request.getParameter("workerFinNum");
            int jobKey = Integer.parseInt(request.getParameter("jobkey"));
            int problemKey = Integer.parseInt(request.getParameter("probKey"));
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
            
            //server side validation parameters
            boolean pass = true; //Assume validaiton pass first
            String err = null; //to store error msg
            String success = null;//to store success msg
            
            //audit paratmeters
            User _user = (User) request.getSession().getAttribute("userLogin");
            String auditChange = "";
            //===============================================//
            //     Add New Benefit
            //===============================================//
            if (action.equals("add")) {
                
                //Data Collection
                String beneDateStr = request.getParameter("nisDate");
                String beneGiver = request.getParameter("ngivenby");
                String beneType = request.getParameter("nbenetype");
                String beneTypeMore = request.getParameter("nbenetypeMore");
                String beneSerial = request.getParameter("nsernum");
                String benePurpose = request.getParameter("npurpose");
                String beneRem = request.getParameter("nremark");
                String beneValueStr = request.getParameter("nvalue");
                //End of Data Collection
                
                //Server side validation
                java.sql.Date beneDate = null;
                if (beneDateStr == null || beneDateStr.equals("")) {
                    pass = false;
                    err = "Benefit Issue Date cannot be empty.";
                } else {        
                    try {
                        java.util.Date tmp = sdf.parse(beneDateStr);
                        beneDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        //do not proceed & show error page
                        err = "Benefit Iusse Date format is not correct.";
                    }
                }
                
                if (beneType == null || beneType.equals("")) {
                    pass = false;
                    err += "Benefit Type cannot be empty.";
                }
                
                if (beneSerial != null && beneSerial.length() > 30) {
                    pass = false;
                    err += "Benefit Serial cannot be more than 30 characters.";
                }
                
                if (benePurpose != null && benePurpose.length() > 200) {
                    pass = false;
                    err += "Benefit Purpose cannot be more than 200 characerers.";
                }
                
                if (beneRem != null && beneRem.length() > 500) {
                    pass = false;
                    err += "Benefit Remark cannot be more than 500 characters.";
                }
                
                Double beneValue = 0.0;
                if (!beneValueStr.equals("")) {
                    try {
                        beneValue = Double.parseDouble(beneValueStr);
                    } catch (Exception ex) {
                        pass = false;
                        err += "Benefit Value must have maximum 2 decimal place.";
                        
                    }
                }
                
                if (pass) {
                    //create object
                    Benefit benefit = new Benefit(workerFinNum, jobKey, problemKey, beneDate, beneGiver,
                            beneType, beneTypeMore, beneSerial, benePurpose, beneRem, beneValue);
                    //add  to db  
                    BenefitDAO.addBenefit(benefit);

                    //log to audit
                    auditChange = benefit.toString2();
                    UserAuditLog userAuditLog = new UserAuditLog(_user.getUsername(), problemKey + "", 
                            workerFinNum, "Added", "Benefit: " + auditChange);

                    UserAuditLogDAO.addUserAuditLog(userAuditLog);
                    
                    //sucesss
                    //success = benefit.getBenefitType() + " has been created succesfully.";
                    //request.getSession().setAttribute("succBenefitMsg", success);
                } else {
                    //request.getSession().setAttribute("errBenefitMsg", err);
                }
            //===============================================//
            //     Edit Benefit
            //===============================================//    
            } else if (action.equals("edit")) {
                String beneDateStr = request.getParameter("isDate");
                String beneGiver = request.getParameter("givenby");
                String beneType = request.getParameter("benetype");
                String beneTypeMore = request.getParameter("benetypeMore");
                String beneSerial = request.getParameter("sernum");
                String benePurpose = request.getParameter("purpose");
                String beneRem = request.getParameter("remark");
                String beneValueStr = request.getParameter("value");
                int id = Integer.parseInt(request.getParameter("Id"));
                
                java.sql.Date beneDate = null;
                if (!beneDateStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(beneDateStr);
                        beneDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }
                
                Double beneValue = 0.0;
                if (!beneValueStr.equals("")) {
                    try {
                        beneValue = Double.parseDouble(beneValueStr);
                    } catch (Exception ex) {
                        out.println(ex);
                    }
                }
                //create object
                Benefit benefit = new Benefit(id, workerFinNum, jobKey, problemKey, beneDate, beneGiver,
                        beneType, beneTypeMore, beneSerial, benePurpose, beneRem, beneValue);
                //update to db
                out.println(benefit.toString());
                BenefitDAO.updateBenefit(benefit);
                
                //log to audit
                auditChange = benefit.toString2();
                UserAuditLog userAuditLog = new UserAuditLog(_user.getUsername(), problemKey + "", 
                        workerFinNum, "Added", "Benefit: " + auditChange);

                UserAuditLogDAO.addUserAuditLog(userAuditLog);  

            }
            
            
            response.sendRedirect("viewWorker.jsp?worker=" + workerFinNum + 
                    "&selectedBenefit=" + problemKey);

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
