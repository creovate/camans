/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.controller;

import camans.dao.WorkerDAO;
import camans.entity.Worker;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author soemyatmyat
 */
public class processSearchWorker extends HttpServlet {

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
            //checking whether the request comes from associate form
            String isAssociate = request.getParameter("associate");
            if (isAssociate != null) {
                String fin = request.getParameter("fin");
                String sql = "";
                if (!fin.equals("")) {
                    sql = "SELECT FIN_number FROM tbl_worker WHERE FIN_number = '" + fin + "'";
                }
                ArrayList<Worker> searchWorkers = WorkerDAO.retrieveWorkersBySearchFilter(sql);
                request.getSession().setAttribute("searchWorkers", searchWorkers);
                request.getSession().setAttribute("fin", fin);
                response.sendRedirect("associate/issueBenefit.jsp");
            } else {
                SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
                String fin = request.getParameter("fin");
                String workerName = request.getParameter("name");
                String gender = request.getParameter("gender");
                String nationality = request.getParameter("nationality");
                String sgPhone = request.getParameter("sgPhone");
                String homeCountryPh = request.getParameter("homeCountryPhone");
                String employer = request.getParameter("employer");
                String occupation = request.getParameter("occupation");
                String workPassType = request.getParameter("workPassType");
                String problemType = request.getParameter("problemType");
                String aggravatingIssue = request.getParameter("aggravatingIssue");
                String hospital = request.getParameter("hospital");
                String registeredStartDateStr = request.getParameter("startDate");
                String registeredEndDateStr = request.getParameter("endDate");
                String leadCaseWorker = request.getParameter("leadCaseWorker");
                String auxiliaryCaseWorker = request.getParameter("auxiliaryCaseWorker");

                /*
                 out.println("Fin" + fin);
                 out.println("workerName" + workerName);
                 out.println("gender" + gender);
                 out.println("nationality" + nationality);
                 out.println("sgPhone" + sgPhone);
                 out.println("homeCountryPh" + homeCountryPh);
                 out.println("employer" + employer);
                 out.println("occupation: " + occupation);
                 out.println("workPassType: " + workPassType);
                 out.println("problemType: " + problemType);
                 out.println("aggravatingIssue: " + aggravatingIssue);
                 out.println("hospital: " + hospital);
                 out.println("registered Start Date: " + registeredStartDate);
                 out.println("registered End Date: " + registeredEndDate);
                 out.println("Lead Case Worker: " + leadCaseWorker);
                 out.println("Auxiliary Case Worker: " + auxiliaryCaseWorker);*/
                String sql = "";

                if (fin.equals("")) {
                    fin = "%";
                } else {
                    fin = "%" + fin + "%";
                }

                if (workerName != null && workerName.equals("")) {
                    workerName = "%";
                } else {
                    workerName = "%" + workerName + "%";
                }

                if (gender != null && gender.equals("")) {
                    gender = "%";
                }

                if (nationality != null && nationality.equals("")) {
                    nationality = "%";
                }


                sql += "SELECT distinct tbl_worker.FIN_number FROM tbl_worker where FIN_number like '" + fin
                        + "' AND Name_of_worker like '" + workerName + "' AND Gender like '" + gender
                        + "' AND Nationality like '" + nationality + "'";
                if (registeredStartDateStr != null && registeredEndDateStr != null) {
                    if (!registeredStartDateStr.equals("") && !(registeredEndDateStr.equals(""))) {
                        java.util.Date startDate = null;
                        java.util.Date endDate = null;
                        try {
                            java.util.Date tmp = sdf.parse(registeredStartDateStr);
                            startDate = new java.sql.Date(tmp.getTime());
                            tmp = sdf.parse(registeredEndDateStr);
                            endDate = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                        }
                        sql += " AND Worker_registration_date between '" + startDate + "' and '"
                                + endDate + "'";
                    } else if (!registeredStartDateStr.equals("")) {
                        java.util.Date startDate = null;
                        try {
                            java.util.Date tmp = sdf.parse(registeredStartDateStr);
                            startDate = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                        }
                        sql += " AND Worker_registration_date >= '" + startDate + "'";
                    } else if (!registeredEndDateStr.equals("")) {
                        java.util.Date endDate = null;
                        try {
                            java.util.Date tmp = sdf.parse(registeredEndDateStr);
                            endDate = new java.sql.Date(tmp.getTime());
                        } catch (ParseException ex) {
                        }
                        sql += " AND Worker_registration_date <= '" + endDate + "'";
                    }
                }


                if (sgPhone != null && !sgPhone.equals("")) {
                    sgPhone = "%" + sgPhone + "%";
                    sql += " AND tbl_worker.FIN_number in (SELECT distinct Worker_FIN_number "
                            + "From tbl_sg_phone_number where Sg_phone_num like '" + sgPhone + "')";
                }

                if (homeCountryPh != null && !homeCountryPh.equals("")) {
                    homeCountryPh = "%" + homeCountryPh + "%";
                    sql += " AND tbl_worker.FIN_number in (SELECT distinct Worker_FIN_number "
                            + "From tbl_home_country_phone_number where Home_country_telephone_number like '"
                            + homeCountryPh + "')";
                }

                if (employer != null && employer.equals("")) {
                    employer = "%";
                } else {
                    employer = "%" + employer + "%";
                }

                if (occupation != null && occupation.equals("")) {
                    occupation = "%";
                } else {
                    occupation = "%" + occupation + "%";
                }

                if (workPassType != null && workPassType.equals("")) {
                    workPassType = "%";
                }

                sql += " AND tbl_worker.FIN_number in (SELECT distinct Worker_FIN_number "
                        + "From tbl_job where Employer_name like '" + employer + "' AND Occupation like '"
                        + occupation + "' AND Workpass_Type like '" + workPassType + "')";

                if (problemType != null && !problemType.equals("")) {
                    sql += " AND tbl_worker.FIN_number in (SELECT distinct Worker_FIN_number "
                            + "From tbl_problem where Chief_problem = '" + problemType + "')";
                }

                if (aggravatingIssue != null && !aggravatingIssue.equals("")) {
                    sql += " AND tbl_worker.FIN_number in (SELECT distinct Worker_FIN_number "
                            + "From tbl_aggravating_issue where Aggra_issue = '" + aggravatingIssue + "')";
                }

                if (hospital != null && !hospital.equals("")) {
                    sql += " AND tbl_worker.FIN_number in (SELECT distinct Worker_FIN_number "
                            + "From tbl_hospital where Hosp_name = '" + hospital + "')";
                }

                if (leadCaseWorker != null && !leadCaseWorker.equals("")) {
                    leadCaseWorker = "%" + leadCaseWorker + "%";
                    sql += " AND tbl_worker.FIN_number in (SELECT distinct Worker_FIN_number "
                            + "From tbl_lead_case_worker where Lead_case_worker like '" + leadCaseWorker + "')";
                }

                if (auxiliaryCaseWorker != null && !auxiliaryCaseWorker.equals("")) {
                    auxiliaryCaseWorker = "%" + auxiliaryCaseWorker + "%";
                    sql += " AND tbl_worker.FIN_number in (SELECT distinct Worker_FIN_number "
                            + "From tbl_auxillarycaseworker where Aux_name like '" + auxiliaryCaseWorker + "')";
                }

                //out.println(sql);
                ArrayList<Worker> searchWorkers = WorkerDAO.retrieveWorkersBySearchFilter(sql);
                request.getSession().setAttribute("searchWorkers", searchWorkers);
                request.getSession().setAttribute("fin", request.getParameter("fin"));
                request.getSession().setAttribute("workerIn", request.getParameter("name"));
                request.getSession().setAttribute("gender", request.getParameter("gender"));
                request.getSession().setAttribute("nationality", request.getParameter("nationality"));
                request.getSession().setAttribute("sgPhone", request.getParameter("sgPhone"));
                request.getSession().setAttribute("homeCountryPh", request.getParameter("homeCountryPhone"));
                request.getSession().setAttribute("employer", request.getParameter("employer"));
                request.getSession().setAttribute("occupation", request.getParameter("occupation"));
                request.getSession().setAttribute("workPass", request.getParameter("workPassType"));
                request.getSession().setAttribute("problemType", request.getParameter("problemType"));
                request.getSession().setAttribute("aggravatingIssue", request.getParameter("aggravatingIssue"));
                request.getSession().setAttribute("hospital", request.getParameter("hospital"));
                request.getSession().setAttribute("start", request.getParameter("startDate"));
                request.getSession().setAttribute("end", request.getParameter("endDate"));
                request.getSession().setAttribute("leadCase", request.getParameter("leadCaseWorker"));
                request.getSession().setAttribute("auxCase", request.getParameter("auxiliaryCaseWorker"));


                response.sendRedirect("home.jsp");
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
