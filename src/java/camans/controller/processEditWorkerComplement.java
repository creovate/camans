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
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author soemyatmyat
 */
@WebServlet(name = "processEditWorkerComplement", urlPatterns = {"/editWorkerComplement.do"})
public class processEditWorkerComplement extends HttpServlet {

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
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
            User _user = (User) request.getSession().getAttribute("userLogin");
            String auditChange = "";
            
            
            if (complementName.equals("WorkerNickname")) {
                //get all the parameters for Nickname
                String nickName = request.getParameter("nickName");
                
                int id = Integer.parseInt(request.getParameter("Id"));
                WorkerNickname workerNickname = new WorkerNickname(workerFinNum,id, nickName);
                //update in the Database
                WorkerComplementsDAO.updateNickname(workerNickname); 

                //log the audit
                auditChange = workerNickname.toString2();
                
            } else if (complementName.equals("WorkerPassportDetails")) {

                //get all the parameters for passport
                String passportCountry = request.getParameter("passportCountry");
                String passportNum = request.getParameter("passportNum");
                String passportIssueDateStr = request.getParameter("passportIssueDate");
                String passportExpiryDateStr = request.getParameter("passportExpiryDate");
                java.sql.Date passportIssueDate = null;
                if (!passportIssueDateStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(passportIssueDateStr);
                        passportIssueDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }
                java.sql.Date passportExpiryDate = null;
                if (!passportIssueDateStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(passportExpiryDateStr);
                        passportExpiryDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }


                int id = Integer.parseInt(request.getParameter("Id"));
                                                //create passport object
                WorkerPassportDetails workerPassportDetails = new WorkerPassportDetails(workerFinNum,
                        id, passportCountry, passportNum, passportIssueDate, passportExpiryDate);
                //update in the Database
                WorkerComplementsDAO.updatePassportDetails(workerPassportDetails);
    
                //log the audit
                auditChange = workerPassportDetails.toString2();
                
            } else if (complementName.equals("WorkerHomeCountryPhNum")) {
                
                //get all the parameters for HomeCountry
                String phNum = request.getParameter("phNum");
                String phOwner = request.getParameter("phOwner");
                String obseleteDateStr = request.getParameter("obseleteDate");
                
                java.sql.Date obseleteDate = null;
                if (!obseleteDateStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(obseleteDateStr);
                        obseleteDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }

                int id = Integer.parseInt(request.getParameter("Id"));
                WorkerHomeCountryPhNum obj = new WorkerHomeCountryPhNum(workerFinNum, id, 
                        phNum, phOwner, obseleteDate);
                //update in the Database
                WorkerComplementsDAO.updateWorkerHomeCountryPhNum(obj);

                //log the audit
                auditChange = obj.toString2();
            } else if (complementName.equals("WorkerSgPhNum")) {
                //get all the parameters for HomeCountry
                String phNum = request.getParameter("phNum");
                String obseleteDateStr = request.getParameter("obseleteDate");
                java.sql.Date obseleteDate = null;
                if (!obseleteDateStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(obseleteDateStr);
                        obseleteDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }
                
                
                int id = Integer.parseInt(request.getParameter("Id"));
                WorkerSgPhNum obj = new WorkerSgPhNum(workerFinNum, id, phNum,obseleteDate);
                //update in the Database
                WorkerComplementsDAO.updateWorkerSgPhNum(obj);

                //log the audit
                auditChange = obj.toString2();
     
            } else if (complementName.equals("WorkerSgAddress")) {
                 //get all the parameters for HomeCountry
                String address = request.getParameter("address");
                String obseleteDateStr = request.getParameter("obseleteDate");
                
                java.sql.Date obseleteDate = null;
                if (!obseleteDateStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(obseleteDateStr);
                        obseleteDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }
                                
                

                int id = Integer.parseInt(request.getParameter("Id"));
                WorkerSgAddress obj = new WorkerSgAddress(workerFinNum, id, address,obseleteDate);
                //update in the Database
                WorkerComplementsDAO.updateWorkerSgAddress(obj);
 
                //log the audit
                auditChange = obj.toString2();
             
            } else if (complementName.equals("WorkerHomeCountryAddress")) {
                  //get all the parameters for HomeCountry
                String address = request.getParameter("address");
                String obseleteDateStr = request.getParameter("obseleteDate");
                
                java.sql.Date obseleteDate = null;
                if (!obseleteDateStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(obseleteDateStr);
                        obseleteDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }
  
  
                int id = Integer.parseInt(request.getParameter("Id"));
                WorkerHomeCountryAddress obj = new WorkerHomeCountryAddress(workerFinNum, 
                                id, address,obseleteDate);
                //update in the Database
                WorkerComplementsDAO.updateWorkerHomeCountryAddress(obj);
               
                //log the audit
                auditChange = obj.toString2();
                
            } else if (complementName.equals("WorkerDigitalContact")) {
                
                //get all the parameters for Nickname
                String digitalContactType = request.getParameter("digitalContactType");
                String digitalMore = request.getParameter("digitalMore");
                String digitalDetails = request.getParameter("digitalDetails");
                String digitalOwner = request.getParameter("digitalOwner");
                String remark = request.getParameter("remark");
                String obseleteDateStr = request.getParameter("obseleteDate");
                
                java.sql.Date obseleteDate = null;
                if (!obseleteDateStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(obseleteDateStr);
                        obseleteDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }
                

               
                int id = Integer.parseInt(request.getParameter("Id"));
                WorkerDigitalContact obj = new WorkerDigitalContact(workerFinNum,
                                id, digitalContactType,
                                digitalMore, digitalDetails,digitalOwner, remark, obseleteDate);      

                //update in the Database
                WorkerComplementsDAO.updateWorkerDigitalContact(obj);
 
                //log the audit
                auditChange = obj.toString2();
                
            } else if (complementName.equals("WorkerNextOfKin")) {
 
                //get all the parameters for next of kin
                String name = request.getParameter("name");
                String relation = request.getParameter("relation");
                String phNum = request.getParameter("nokphNum");
                String digitalContact = request.getParameter("digitalContact");
                String docReference = request.getParameter("docReference");
                String address = request.getParameter("nokaddress");
                String proofDoc = request.getParameter("proofDoc");
                String remark = request.getParameter("remark");
                String obseleteDateStr = request.getParameter("obseleteDate");
                
                java.sql.Date obseleteDate = null;
                if (!obseleteDateStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(obseleteDateStr);
                        obseleteDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }
                

                int id = Integer.parseInt(request.getParameter("Id"));
                //create object
                WorkerNextOfKin obj = new WorkerNextOfKin(workerFinNum, id, name,
                        relation, docReference ,phNum, digitalContact, address, 
                        proofDoc, remark, obseleteDate);
                WorkerComplementsDAO.updateWorkerNextOfKin(obj);

                //log the audit
                auditChange = obj.toString2();
                
            } else if (complementName.equals("WorkerFamilyMember")) {
                
                //get all the parameters for next of kin
                String name = request.getParameter("name");
                String relation = request.getParameter("relation");
                String address = request.getParameter("familyaddress");
                String phNum = request.getParameter("familyphNum");
                String digitalContact = request.getParameter("digitalContact");
                String remark = request.getParameter("remark");
                String obseleteDateStr = request.getParameter("obseleteDate");
                
                java.sql.Date obseleteDate = null;
                if (!obseleteDateStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(obseleteDateStr);
                        obseleteDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }

                
                int id = Integer.parseInt(request.getParameter("Id"));
                WorkerFamilyMember obj = new WorkerFamilyMember(workerFinNum, id, name,
                        relation, address,phNum, digitalContact, remark, obseleteDate);                    
                //update in the Database
                WorkerComplementsDAO.updateWorkerFamilyMember(obj);

                //log the audit
                auditChange = obj.toString2();
            } else if (complementName.equals("WorkerFriend")) {
                
                //get all the parameters for next of kin
                String name = request.getParameter("name");
                String relation = request.getParameter("relation");
                String phNum = request.getParameter("friendPhNum");
                String remark = request.getParameter("remark");
                String obseleteDateStr = request.getParameter("obseleteDate");
                
                java.sql.Date obseleteDate = null;
                if (!obseleteDateStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(obseleteDateStr);
                        obseleteDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }
                
                int id = Integer.parseInt(request.getParameter("Id"));
                WorkerFriend obj = new WorkerFriend(workerFinNum, id, name,
                        phNum, relation, remark, obseleteDate);
                WorkerComplementsDAO.updateWorkerFriend(obj);

                //log the audit
                auditChange = obj.toString2();
            } else if (complementName.equals("WorkerLanguage")) {

                //get all the parameters for next of kin
                String mainLanguage = request.getParameter("mainLanguage");
                String languageMore = request.getParameter("languageMore");
                String englishStandard = request.getParameter("englishStandard");
                String remark = request.getParameter("remark");
                


                int id = Integer.parseInt(request.getParameter("Id"));
                WorkerLanguage obj = new WorkerLanguage(workerFinNum,id, mainLanguage,
                        languageMore, englishStandard, remark);
                WorkerComplementsDAO.updateWorkerLanguage(obj);

                //log the audit
                auditChange = obj.toString2();         
                
            } else if (complementName.equals("WorkerBankAcct")) {
                //get all the parameters for next of kin
                String bankAcctName = request.getParameter("bankAcctName");
                String bankAcctNum = request.getParameter("bankAcctNum");
                String bankName = request.getParameter("bankName");
                String bankBranch = request.getParameter("bankBranch");
                String bankBranchAddress = request.getParameter("bankBranchAddress");
                String bankBranchCode = request.getParameter("bankBranchCode");
                String bankSwift = request.getParameter("bankSwift"); 
                String remark = request.getParameter("remark");
                String obseleteDateStr = request.getParameter("obseleteDate");
                
                java.sql.Date obseleteDate = null;
                if (!obseleteDateStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(obseleteDateStr);
                        obseleteDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }                
                

                int id = Integer.parseInt(request.getParameter("Id"));
                //create object
                WorkerBankAcct obj = new WorkerBankAcct(workerFinNum, id, bankAcctName,
                        bankAcctNum, bankName,bankBranch, bankBranchAddress,
                        bankBranchCode,bankSwift , remark,obseleteDate);                    
                WorkerComplementsDAO.updateWorkerBankAccountDetails(obj);
                
                //log the audit
                auditChange = obj.toString2();

            }
            
            //log to audit  
            UserAuditLog userAuditLog = new UserAuditLog(_user.getUsername(), workerFinNum, 
                    workerFinNum, "Modified", "Worker Complement: " + auditChange);
            
            UserAuditLogDAO.addUserAuditLog(userAuditLog);
            response.sendRedirect("viewWorker.jsp?worker=" + workerFinNum);
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
