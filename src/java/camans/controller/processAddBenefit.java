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
            String idStr = request.getParameter("Id");

            String isAssociate = request.getParameter("associate");

            //=======================================//
            //   Server Side Validation Parameters
            //=======================================//
            String errorMsg = ""; //to store error msg
            String success = "";//to store success msgf
            //audit paratmeters
            User _user = (User) request.getSession().getAttribute("userLogin");
            String auditChange = "";

            String beneDateStr = "";
            String beneGiver = "";
            String beneType = "";
            String beneTypeMore = "";
            String beneSerial = "";
            String benePurpose = "";
            String beneRem = "";
            String beneValueStr = "";
            Double beneValue = 0.0;
            java.sql.Date beneDate = null;
            //===============================================//
            //     Add/Edit  Benefit
            //===============================================//
            //Data Collection
            if (action.equals("add")) {
                beneDateStr = request.getParameter("nisDate");
                beneGiver = request.getParameter("ngivenby");
                beneType = request.getParameter("nbenetype");
                beneTypeMore = request.getParameter("nbenetypeMore");
                beneSerial = request.getParameter("nsernum");
                benePurpose = request.getParameter("npurpose");
                beneRem = request.getParameter("nremark");
                beneValueStr = request.getParameter("nvalue");
            } else {
                beneDateStr = request.getParameter("isDate");
                beneGiver = request.getParameter("givenby");
                beneType = request.getParameter("benetype");
                beneTypeMore = request.getParameter("benetypeMore");
                beneSerial = request.getParameter("sernum");
                benePurpose = request.getParameter("purpose");
                beneRem = request.getParameter("remark");
                beneValueStr = request.getParameter("value");
            }
            //End of Data Collection

            //Server side validation
            boolean pass = true; //Assume validaiton pass first
            if (beneDateStr == null || beneDateStr.equals("")) {
                pass = false;
                errorMsg = "Benefit Issue Date cannot be empty.";
            } else {
                try {
                    java.util.Date tmp = sdf.parse(beneDateStr);
                    beneDate = new java.sql.Date(tmp.getTime());
                } catch (ParseException ex) {
                    //do not proceed & show error page
                    errorMsg = "Benefit Issue Date format is not correct.";
                }
            }
            if (beneType == null || beneType.equals("")) {
                pass = false;
                errorMsg += "Benefit Type cannot be empty.";
            }

            if (beneGiver == null || beneGiver.equals("")) {
                pass = false;
                errorMsg += "Benefit Giver cannot be empty.";
            }

            if (pass) {

                if (beneGiver != null && beneGiver.length() > 20) {
                    errorMsg += "Benefit Giver must not exceed 20 characters.";
                }
                if (beneSerial != null && beneSerial.length() > 30) {
                    errorMsg += "Benefit Serial must not exceed 30 characters.";
                }

                if (benePurpose != null && benePurpose.length() > 200) {
                    errorMsg += "Benefit Purpose must not exceed 200 characerers.";
                }

                if (beneRem != null && beneRem.length() > 500) {
                    errorMsg += "Benefit Remark must not exceed 500 characters.";
                }

                if (!beneValueStr.equals("")) {
                    try {
                        beneValue = Double.parseDouble(beneValueStr);
                    } catch (Exception ex) {
                        pass = false;
                        errorMsg += "Benefit Value must have maximum 2 decimal place.";

                    }
                }
            }//pass

            if (errorMsg.equals("")) {
                if (idStr == null) {
                    //create object
                    Benefit benefit = new Benefit(workerFinNum, jobKey, problemKey, beneDate, beneGiver,
                            beneType, beneTypeMore, beneSerial, benePurpose, beneRem, beneValue);
                    //add  to db  
                    BenefitDAO.addBenefit(benefit);

                    //log to audit
                    auditChange = benefit.toString2();
                    auditChange = auditChange.replace("{", " [");
                    auditChange = auditChange.replace("}", "]");
                    UserAuditLog userAuditLog = new UserAuditLog(_user.getUsername(), problemKey + "",
                            workerFinNum, "Added", "Benefit: " + auditChange);

                    UserAuditLogDAO.addUserAuditLog(userAuditLog);

                    //sucesss
                    success = benefit.getBenefitType() + " has been created succesfully.";
                } else {
                    int id = Integer.parseInt(request.getParameter("Id"));
                    //create object
                    Benefit benefit = new Benefit(id, workerFinNum, jobKey, problemKey, beneDate, beneGiver,
                            beneType, beneTypeMore, beneSerial, benePurpose, beneRem, beneValue);
                    //update to db
                    out.println(benefit.toString());
                    BenefitDAO.updateBenefit(benefit);

                    //log to audit
                    auditChange = benefit.toString2();
                    auditChange = auditChange.replace("{", " [");
                    auditChange = auditChange.replace("}", "]");
                    UserAuditLog userAuditLog = new UserAuditLog(_user.getUsername(), problemKey + "",
                            workerFinNum, "Added", "Benefit: " + auditChange);

                    UserAuditLogDAO.addUserAuditLog(userAuditLog);
                    //sucesss
                    success = benefit.getBenefitType() + " has been updated succesfully.";
                }
            } // no error

            request.getSession().setAttribute("successBenefitMsg", success);
            request.getSession().setAttribute("errorBenefitMsg", errorMsg);
            request.getSession().setAttribute("tabIndicator", "benefit");
            request.getSession().setAttribute("worker", workerFinNum);
            request.getSession().setAttribute("selectedProb", problemKey + "");
            request.getSession().setAttribute("selectedBenefit", idStr);
            if (isAssociate != null) {
                    response.sendRedirect("associate/issueBenefit.jsp");
                } else {
                response.sendRedirect("viewWorker.jsp");
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
