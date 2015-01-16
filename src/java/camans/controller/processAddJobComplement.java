/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.controller;

import camans.dao.*;
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
 * @author Nyein Su
 */
public class processAddJobComplement extends HttpServlet {

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
            
            User _user = (User) request.getSession().getAttribute("userLogin");
            String auditChange = "";

            /*Job Pass Details*/
            if (complementName.equals("JobPassDetails")) {

                //get all the parameters for passport
                String passType = request.getParameter("npasstype");
                String passTypeMore = request.getParameter("npasstypeMore");
                String passNum = request.getParameter("npassno");
                String issuer = request.getParameter("nissuer");
                String apDateStr = request.getParameter("napdate");
                String isDateStr = request.getParameter("nisdate");
                String exDateStr = request.getParameter(("nexdate"));
                String remark = request.getParameter("nremark");
                String obsoleteDateStr = request.getParameter("nobsoleteDate");

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

                //create new pass details
                JobPassDetails pass = new JobPassDetails(workerFinNum, jobKey, passType, 
                        passTypeMore, passNum, apDate, isDate, exDate, issuer, remark, obDate);

                //add into db
                JobComplementsDAO.addJobPassDetails(pass);
 
                //log the audit
                auditChange = pass.toString2();
                
             /* Employer Details */   
            } else if (complementName.equals("EmployerDetails")) {
                //get all the parameters
                String name = request.getParameter("nname");
                String person = request.getParameter("nperson");
                String employerId = request.getParameter("nempid");
                String contract = request.getParameter("ncontact");
                String remark = request.getParameter("nremark");
                String address = request.getParameter("naddress");

                JobEmployer employer = new JobEmployer(workerFinNum, jobKey, name, employerId, address, contract, person, remark);

                //add into db
                JobComplementsDAO.addJobEmployer(employer);
                //log the audit
                auditChange = employer.toString2();
                
            /* Contract Details */    
            } else if (complementName.equals("ContractDetails")) {
                //get all the parameters
                String shortName = request.getParameter("nname");
                String contractDateStr = request.getParameter("ncontdate");
                String contractWhere = request.getParameter("nlocation");
                String contractOpName = request.getParameter("nopname");
                String opRelation = request.getParameter("noprelation");
                String language = request.getParameter("nlanguage");
                String occupation = request.getParameter("noccupation");
                String salary = request.getParameter("nsalary");
                String allowance = request.getParameter("nallowance");
                String deduction = request.getParameter("ndeduction");
                String duress = request.getParameter("nduress");
                String duration = request.getParameter("nduration");
                String remark = request.getParameter("nremark");

                java.sql.Date contractDate = null;
                if (!contractDateStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(contractDateStr);
                        contractDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }

                //create new compelment new JobEmployer( workerFinNum, nt jobKey,  employerOfficialName, String employerID,  employerAddress,  employerContacts,  employerPersons,  employerRemarks
                JobEmploymentContract contract = new JobEmploymentContract(workerFinNum, jobKey, 
                        shortName, contractDate, contractWhere, language, contractOpName, 
                        opRelation, occupation, salary, allowance, deduction, duration, 
                        duress, remark);

                //add into db
                JobComplementsDAO.addJobEmploymentContract(contract);
                //log the audit
                auditChange = contract.toString2();

             
            /*Intermediary Agent */
            } else if (complementName.equals("Agent")) {
                //get all the parameters
                String agentCompany = request.getParameter("ncompany");
                String agentPersonName = request.getParameter("nagperson");
                String agentLocation = request.getParameter("naglocation");
                String agentlocationMore = request.getParameter("naglocationMore");
                String agentAddress = request.getParameter("naddress");
                String agentContact = request.getParameter("ncontact");
                String agentAmtPaidStr = request.getParameter("namtpaid");
                String agentAmtOwedStr = request.getParameter("namtowed");
                String agentFeeShared = request.getParameter("nfeeshared");
                String agentFeeTraining = request.getParameter("nfeetraining");
                String agentFeeAirfare = request.getParameter("nfeeairfare");
                String agentFeeWhere = request.getParameter("nfeewhere");
                String agentFeeWhen = request.getParameter("nfeewhen");
                String agentFeeRepay = request.getParameter("nfeerepay");
                String agentEmployer = request.getParameter("nemp");
                String agentRemarks = request.getParameter("nagremark");

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
                JobIntermediaryAgent agent = new JobIntermediaryAgent(workerFinNum, jobKey, agentCompany, agentPersonName, agentLocation, agentlocationMore, agentAddress, agentContact, agentAmtPaid, agentAmtOwed, agentFeeShared, agentFeeTraining, agentFeeAirfare, agentFeeWhere, agentFeeWhen, agentFeeRepay, agentEmployer, agentRemarks);
                //add into db
                JobComplementsDAO.addJobIntermediaryAgent(agent);
                //log the audit
                auditChange = agent.toString2();
                
            /*Verbal Assurance of Previous Job */    
            } else if (complementName.equals("VerbalAssurance")) {
                //get all the parameters

                String verbalName = request.getParameter("nname");
                String VerbalRelationship = request.getParameter("nrelation");
                String when = request.getParameter("nvaWhen");
                String where = request.getParameter("nvaWhere");
                String content = request.getParameter("nvaContent");


                //create new compelment new JobEmployer( workerFinNum, nt jobKey,  employerOfficialName, String employerID,  employerAddress,  employerContacts,  employerPersons,  employerRemarks
                JobVerbalAssurance assurance = new JobVerbalAssurance(workerFinNum, jobKey, verbalName, VerbalRelationship, when, where, content);
                //add into db
                JobComplementsDAO.addJobVerbalAssurance(assurance);
                //log the audit
                auditChange = assurance.toString2();
                
            /*Work Place Details*/    
            } else if (complementName.equals("WorkPlace")) {
                //get all the parameters of workplace
                String workplaceType = request.getParameter("nwpType");
                String workplaceTypeMore = request.getParameter("nwpTypeMore");
                String workplaceWhose = request.getParameter("nwhose");
                String workplacePerson = request.getParameter("npersonDetails");
                String workplaceRelationship = request.getParameter("nrelation");
                String workplaceDirect = request.getParameter("ndirect");
                String workplaceDirectMore = request.getParameter("ndirectMore");
                String workplaceStart = request.getParameter("nstart");
                String workplaceEnd = request.getParameter("nend");
                String workplaceCondition = request.getParameter("ncondition");
                String workplaceSafety = request.getParameter("nsafety");
                String workplaceRemark = request.getParameter("nremark");

                //Create new workplace  , int , String workplaceType, String workplaceTypeMore, String workplaceWhose, String workpladePersons, String workplaceEmployerRelationship, String workplaceDirect, String workplaceDirectMore, String workplaceStart, String workplaceEnd, String workplaceCondition, String workplaceSafety, String workplaceRemarks)
                JobWorkplace jobWorkplace = new JobWorkplace(workerFinNum, jobKey, workplaceType, workplaceTypeMore, workplaceWhose, workplacePerson, workplaceRelationship, workplaceDirect, workplaceDirectMore, workplaceStart, workplaceEnd, workplaceCondition, workplaceSafety, workplaceRemark);
                //add to db
                JobComplementsDAO.addJobWorkplace(jobWorkplace);
                //log the audit
                auditChange = jobWorkplace.toString2();
                
            /*Work History */    
            } else if (complementName.equals("WorkHistory")) {
                //get parameters of workHistory
                String workHistHow = request.getParameter("nhow");
                String workHistHowMore = request.getParameter("nhowMore");
                String strHistDate = request.getParameter("narrivalDate");
                String workHistFirst = request.getParameter("nisFirstJob");
                String workHistYearArrive = request.getParameter("narrivalYear");
                String workHistPreviousJob = request.getParameter("nprevJob");
                String workHistPreviousProb = request.getParameter("nprevProb");
                String workHistRemark = request.getParameter("nremark");
                out.println(strHistDate);
                java.sql.Date histDate = null;
                if (!strHistDate.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(strHistDate);
                        histDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }
                //create new JobWorkHistory
                JobWorkHistory hist = new JobWorkHistory(workerFinNum, jobKey, workHistHow, workHistHowMore, 
                        histDate, workHistFirst, workHistYearArrive, workHistPreviousJob, workHistPreviousProb, 
                        workHistRemark);
                JobComplementsDAO.addJobWorkHistory(hist);
                //log the audit
                auditChange = hist.toString2();
                
            /*Accommodation During Work */            
            } else if (complementName.equals("Accommodation")) {

                //get parameters for Accomodation
                String accProvided = request.getParameter("nisProvided");
                String accProvidedMore = request.getParameter("nisProvidedMore");
                String accType = request.getParameter("ntype");
                String accTypeMore = request.getParameter("ntypeMore");
                String accLocation = request.getParameter("nlocation");
                String accCondition = request.getParameter("ncondition");
                String accChargedStr = request.getParameter("naccCharged");
                String accPaidStr = request.getParameter("naccPaid");
                String accMeal = request.getParameter("nmeal");
                String accStart = request.getParameter("nfrom");
                String accEnd = request.getParameter("nto");
                String accRemark = request.getParameter("nremark");
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

                //create new JobAccomodation
                JobAccomodation accomodation = new JobAccomodation(workerFinNum, jobKey, accProvided,
                        accProvidedMore, accType, accTypeMore, accLocation, accCondition, accCharged, 
                        accPaid, accMeal, accStart, accEnd, accRemark);

                //add to db
                JobComplementsDAO.addJobAccomodation(accomodation);
                //log the audit
                auditChange = accomodation.toString2();
              
            /*IPA Details */    
            } else if (complementName.equals("IPA")) {
                //get parameters from IPA
                String ipaPassType = request.getParameter("nworkpassType");
                String ipaPassTypeMore = request.getParameter("nworkpassTypeMore");
                String ipaDateStr = request.getParameter("nappDate");
                String ipaEmpName = request.getParameter("nempName");
                String ipaAgentName = request.getParameter("nagentName");
                String ipaIndustry = request.getParameter("nindustry");
                String ipaOccupation = request.getParameter("nipaoccupation");
                String ipaPeriods = request.getParameter("nperiods");
                String ipaBasicSalaryStr = request.getParameter("nbasicSalary");
                String ipaTotalAllowanceStr = request.getParameter("ntotalAllowance");
                String ipaTotalAllowanceDetails = request.getParameter("nallowanceDetails");
                String ipaDeductionStr = request.getParameter("ntotalDeduction");
                String ipaDeductionDetails = request.getParameter("ndeductionDetails");
                String ipaHousingProvided = request.getParameter("nisHousingProvided");
                String ipaRemark = request.getParameter("nremark");

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
                //create new JobIPADetails workerFinNum, int jobKey, String ip, String ipaAgentName, String industry, String occuupation, String periodYears, double basicSalary, double ipaAllowances, String ipaAllowancesDetails, double ipaDeduction, String ipaDeductionDetails, String housingProvided, String ipaRemarks
                JobIPADetails ipa = new JobIPADetails(workerFinNum, jobKey, ipaPassType, 
                        ipaPassTypeMore, ipaDate, ipaEmpName, ipaAgentName, ipaIndustry, 
                        ipaOccupation, ipaPeriods, ipaBasicSalary, ipaTotalAllowance, 
                        ipaTotalAllowanceDetails, ipaDeduction, ipaDeductionDetails, 
                        ipaHousingProvided, ipaRemark);
                 //add to db
                JobComplementsDAO.addJobIPADetails(ipa);
                //log the audit
                auditChange = ipa.toString2();
            }
            
            //log to audit
            UserAuditLog userAuditLog = new UserAuditLog(_user.getUsername(), jobKey + "", 
                    workerFinNum, "Added", "Job Complement: " + auditChange);

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
