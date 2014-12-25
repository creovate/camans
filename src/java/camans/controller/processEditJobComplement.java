/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.controller;

import camans.dao.JobComplementsDAO;
import camans.dao.UserAuditLogDAO;
import camans.entity.*;
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
public class processEditJobComplement extends HttpServlet {

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
            String complementName = request.getParameter("complementName");
            String workerFinNum = request.getParameter("workerFinNum");
            int jobKey = Integer.parseInt(request.getParameter("jobkey"));
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
            //SimpleDateFormat sdf = new SimpleDateFormat("mm/dd/yyyy");
  
            User _user = (User) request.getSession().getAttribute("userLogin");
            String auditChange = "";
            
            if (complementName.equals("JobPassDetails")) {
                //get all the parameters for passport
                String passType = request.getParameter("passtype");
                String passTypeMore = request.getParameter("passtypeMore");
                String passNum = request.getParameter("passno");
                String issuer = request.getParameter("issuer");
                String apDateStr = request.getParameter("apdate");
                String isDateStr = request.getParameter("isdate");
                String exDateStr = request.getParameter(("exdate"));
                String remark = request.getParameter("remark");
                String obsoleteDateStr = request.getParameter("obsoleteDate");

                java.sql.Date apDate = null;
                if (!apDateStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(apDateStr);
                        apDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }

                java.sql.Date isDate = null;
                if (!isDateStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(isDateStr);
                        isDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }

                java.sql.Date exDate = null;
                if (!exDateStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(exDateStr);
                        exDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }

                java.sql.Date obDate = null;
                if (!obsoleteDateStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(obsoleteDateStr);
                        obDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }
                
                int id = Integer.parseInt(request.getParameter("Id"));

                //create new pass details
                JobPassDetails pass = new JobPassDetails(id, workerFinNum, jobKey, passType, 
                        passTypeMore, passNum, apDate, isDate, exDate, issuer, remark, obDate);

                //update to db
                JobComplementsDAO.updateJobPassDetails(pass);
                //log the audit
                auditChange = pass.toString2();
                
                
            } else if (complementName.equals("EmployerDetails")) {

                //get all the parameters
                String name = request.getParameter("name");
                String person = request.getParameter("person");
                String employerId = request.getParameter("empid");
                String contract = request.getParameter("contact");
                String remark = request.getParameter("remark");
                String address = request.getParameter("address");

                int id = Integer.parseInt(request.getParameter("Id"));
                
                JobEmployer employer = new JobEmployer(id, workerFinNum, jobKey, name, 
                        employerId, address, contract, person, remark);

                //add into db
                JobComplementsDAO.updateJobEmployer(employer);
                //log the audit
                auditChange = employer.toString2();


            } else if (complementName.equals("ContractDetails")) {
                //get all the parameters
                String shortName = request.getParameter("name");
                String contractDateStr = request.getParameter("contdate");
                String contractWhere = request.getParameter("location");
                String contractOpName = request.getParameter("opname");
                String opRelation = request.getParameter("oprelation");
                String language = request.getParameter("language");
                String occupation = request.getParameter("occupation");
                String salary = request.getParameter("salary");
                String allowance = request.getParameter("allowance");
                String deduction = request.getParameter("deduction");
                String duress = request.getParameter("duress");
                String duration = request.getParameter("duration");
                String remark = request.getParameter("remark");

                java.sql.Date contractDate = null;
                if (!contractDateStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(contractDateStr);
                        contractDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }

                int id = Integer.parseInt(request.getParameter("Id"));
                JobEmploymentContract contract = new JobEmploymentContract(id, workerFinNum, 
                        jobKey, shortName, 
                        contractDate, contractWhere, language, contractOpName, 
                        opRelation, occupation, salary, allowance, deduction, 
                        duration, duress, remark);

                //update in the db
                JobComplementsDAO.updateJobEmploymentContract(contract);
                //log the audit
                auditChange = contract.toString2();

            } else if (complementName.equals("Agent")) {

                //get all the parameters
                String agentCompany = request.getParameter("company");
                String agentPersonName = request.getParameter("agperson");
                String agentLocation = request.getParameter("aglocation");
                String agentlocationMore = request.getParameter("aglocationMore");
                String agentAddress = request.getParameter("address");
                String agentContact = request.getParameter("contract");
                String agentAmtPaidStr = request.getParameter("amtpaid");
                String agentAmtOwedStr = request.getParameter("amtowed");
                String agentFeeShared = request.getParameter("feeshared");
                String agentFeeTraining = request.getParameter("feetraining");
                String agentFeeAirfare = request.getParameter("feeairfare");
                String agentFeeWhere = request.getParameter("feewhere");
                String agentFeeWhen = request.getParameter("feewhen");
                String agentFeeRepay = request.getParameter("feerepay");
                String agentEmployer = request.getParameter("emp");
                String agentRemarks = request.getParameter("agremark");

                Double agentAmtPaid = 0.0;
                if (!agentAmtPaidStr.equals("")) {
                    try {
                        agentAmtPaid = Double.parseDouble(agentAmtPaidStr);
                    } catch (Exception ex) {
                        out.println(ex);
                    }
                }
                Double agentAmtOwed = 0.0;
                if (!agentAmtPaidStr.equals("")) {
                    try {
                        agentAmtOwed = Double.parseDouble(agentAmtOwedStr);
                    } catch (Exception ex) {
                        out.println(ex);
                    }
                } 

                int id = Integer.parseInt(request.getParameter("Id"));

                JobIntermediaryAgent agent = new JobIntermediaryAgent(id, workerFinNum, jobKey, 
                        agentCompany, agentPersonName, agentLocation, agentlocationMore, 
                        agentAddress, agentContact, agentAmtPaid, agentAmtOwed, agentFeeShared, 
                        agentFeeTraining, agentFeeAirfare, agentFeeWhere, agentFeeWhen, agentFeeRepay, agentEmployer, agentRemarks);
                //add into db
                JobComplementsDAO.updateJobIntermediaryAgent(agent);
                //log the audit
                auditChange = agent.toString2();
                
            } else if (complementName.equals("VerbalAssurance")) {
                //get all the parameters
                String verbalName = request.getParameter("name");
                String VerbalRelationship = request.getParameter("relation");
                String when = request.getParameter("vaWhen");
                String where = request.getParameter("vaWhere");
                String content = request.getParameter("vaContent");

                int id = Integer.parseInt(request.getParameter("Id"));
                
                JobVerbalAssurance assurance = new JobVerbalAssurance(id, workerFinNum, jobKey, 
                        verbalName, VerbalRelationship, when, where, content);
                //add into db
                JobComplementsDAO.updateJobVerbalAssurance(assurance);

                //log the audit
                auditChange = assurance.toString2();
                
            } else if (complementName.equals("WorkPlace")) {
                //get all the parameters of workplace
                String workplaceType = request.getParameter("wpType");
                String workplaceTypeMore = request.getParameter("wpTypeMore");
                String workplaceWhose = request.getParameter("whose");
                String workplacePerson = request.getParameter("personDetails");
                String workplaceRelationship = request.getParameter("relation");
                String workplaceDirect = request.getParameter("direct");
                String workplaceDirectMore = request.getParameter("directMore");
                String workplaceStart = request.getParameter("start");
                String workplaceEnd = request.getParameter("end");
                String workplaceCondition = request.getParameter("condition");
                String workplaceSafety = request.getParameter("safety");
                String workplaceRemark = request.getParameter("remark");

                int id = Integer.parseInt(request.getParameter("Id"));
                JobWorkplace jobWorkplace = new JobWorkplace(id, workerFinNum, jobKey, workplaceType, 
                        workplaceTypeMore, workplaceWhose, workplacePerson, 
                        workplaceRelationship, workplaceDirect, workplaceDirectMore, 
                        workplaceStart, workplaceEnd, workplaceCondition, workplaceSafety, workplaceRemark);
                //add to db
                JobComplementsDAO.updateJobWorkplace(jobWorkplace);
                //log the audit
                auditChange = jobWorkplace.toString2();

            } else if (complementName.equals("WorkHistory")) {

                //get parameters of workHistory

                String workHistHow = request.getParameter("how");
                String workHistHowMore = request.getParameter("howMore");
                String strHistDate = request.getParameter("arrivalDate");
                String workHistFirst = request.getParameter("isFirstJob");
                String workHistYearArrive = request.getParameter("arrivalYear");
                String workHistPreviousJob = request.getParameter("prevJob");
                String workHistPreviousProb = request.getParameter("prevProb");
                String workHistRemark = request.getParameter("remark");

                java.sql.Date histDate = null;
                if (!strHistDate.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(strHistDate);
                        histDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }

                int id = Integer.parseInt(request.getParameter("Id"));
                //create new JobWorkHistory
                JobWorkHistory hist = new JobWorkHistory(id, workerFinNum, jobKey, workHistHow, 
                        workHistHowMore, histDate, workHistFirst, workHistYearArrive, 
                        workHistPreviousJob, workHistPreviousProb, workHistRemark);


                // update to db
                JobComplementsDAO.updateJobWorkHistory(hist);
                //log the audit
                auditChange = hist.toString2();
                
            } else if (complementName.equals("Accommodation")) {
                //get parameters for Accomodation

                String accProvided = request.getParameter("isProvided");
                String accProvidedMore = request.getParameter("isProvidedMore");
                String accType = request.getParameter("type");
                String accTypeMore = request.getParameter("typeMore");
                String accLocation = request.getParameter("location");
                String accCondition = request.getParameter("condition");
                String accChargedStr = request.getParameter("accCharged");
                String accPaidStr = request.getParameter("accPaid");
                String accMeal = request.getParameter("meal");
                String accStart = request.getParameter("from");
                String accEnd = request.getParameter("to");
                String accRemark = request.getParameter("remark");

                double accCharged = 0.0;
                if (!accChargedStr.equals("")) {
                    try {
                        accCharged = Double.parseDouble(accChargedStr);
                    } catch (Exception ex) {
                        out.println(ex);
                    }
                }   
                double accPaid = 0.0;
                if (!accPaidStr.equals("")) {
                    try {
                        accPaid = Double.parseDouble(accPaidStr);
                    } catch (Exception ex) {
                        out.println(ex);
                    }
                }   

                int id = Integer.parseInt(request.getParameter("Id"));
                //create new JobAccomodation
                JobAccomodation accomodation = new JobAccomodation(id, workerFinNum, jobKey, 
                        accProvided, accProvidedMore, accType, accTypeMore, accLocation, 
                        accCondition, accCharged, accPaid, accMeal, accStart, accEnd, accRemark);
                //add to db
                JobComplementsDAO.updateJobAccomodation(accomodation);  
                //log the audit
                auditChange = accomodation.toString2();
            } else if (complementName.equals("IPA")) {

                //get parameters from IPA
                String ipaPassType = request.getParameter("workpassType");
                String ipaPassTypeMore = request.getParameter("workpassTypeMore");
                String ipaDateStr = request.getParameter("appDate");
                String ipaEmpName = request.getParameter("empName");
                String ipaAgentName = request.getParameter("agentName");
                String ipaIndustry = request.getParameter("industry");
                String ipaOccupation = request.getParameter("ipaoccupation");
                String ipaPeriods = request.getParameter("periods");
                String ipaBasicSalaryStr = request.getParameter("basicSalary");
                String ipaTotalAllowanceStr = request.getParameter("totalAllowance");
                String ipaTotalAllowanceDetails = request.getParameter("nallowanceDetails");
                String ipaDeductionStr = request.getParameter("deduction");
                String ipaDeductionDetails = request.getParameter("deductionDetails");
                String ipaHousingProvided = request.getParameter("isHousingProvided");
                String ipaRemark = request.getParameter("remark");

                double ipaBasicSalary = 0.0;
                if (!ipaBasicSalaryStr.equals("")) {
                    try {
                        ipaBasicSalary = Double.parseDouble(ipaBasicSalaryStr);
                    } catch (Exception ex) {
                        out.println(ex);
                    }
                }
                
                double ipaTotalAllowance = 0.0;
                if (!ipaTotalAllowanceStr.equals("")) {
                    try {
                        ipaTotalAllowance = Double.parseDouble(ipaTotalAllowanceStr);
                    } catch (Exception ex) {
                        out.println(ex);
                    }
                }
                
                double ipaDeduction = 0.0;
                if (!ipaDeductionStr.equals("")) {
                    try {
                        ipaDeduction = Double.parseDouble(ipaDeductionStr);
                    } catch (Exception ex) {
                        out.println(ex);
                    }
                }                
                
                java.sql.Date ipaDate = null;
                if (!ipaDateStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(ipaDateStr);
                        ipaDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }
                int id = Integer.parseInt(request.getParameter("Id"));
                JobIPADetails ipa = new JobIPADetails(id, workerFinNum, jobKey, ipaPassType, 
                        ipaPassTypeMore, ipaDate, ipaEmpName, ipaAgentName, ipaIndustry, 
                        ipaOccupation, ipaPeriods, ipaBasicSalary, ipaTotalAllowance, 
                        ipaTotalAllowanceDetails, ipaDeduction, ipaDeductionDetails, 
                        ipaHousingProvided, ipaRemark);
                JobComplementsDAO.updateJobIPADetails(ipa);
                //log the audit
                auditChange = ipa.toString2();
            }
            
            //log to audit
            UserAuditLog userAuditLog = new UserAuditLog(_user.getUsername(), jobKey + "", 
                    workerFinNum, "Modified", "Job Complement: " + auditChange);

            UserAuditLogDAO.addUserAuditLog(userAuditLog); 
            response.sendRedirect("viewWorker.jsp?worker=" + workerFinNum + "&selectedJob=" + jobKey);
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
