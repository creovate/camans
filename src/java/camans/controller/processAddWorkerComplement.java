/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.controller;

import camans.dao.WorkerComplementsDAO;
import camans.entity.WorkerBankAcct;
import camans.entity.WorkerDigitalContact;
import camans.entity.WorkerFamilyMember;
import camans.entity.WorkerFriend;
import camans.entity.WorkerHomeCountryAddress;
import camans.entity.WorkerHomeCountryPhNum;
import camans.entity.WorkerLanguage;
import camans.entity.WorkerNextOfKin;
import camans.entity.WorkerNickname;
import camans.entity.WorkerPassportDetails;
import camans.entity.WorkerSgAddress;
import camans.entity.WorkerSgPhNum;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class processAddWorkerComplement extends HttpServlet {

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
            throws ServletException, IOException, ParseException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {

            String complementName = request.getParameter("complementName");
            String workerFinNum = request.getParameter("workerFinNum");
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
            //SimpleDateFormat sdf = new SimpleDateFormat("mm/dd/yyyy");
            //=======================================//
            //          Nick Name 
            //=======================================//            
            if (complementName.equals("WorkerNickname")) {
                //get all the parameters for Nickname
                String nickName = request.getParameter("nNickName");

                //create nickname object
                WorkerNickname workerNickname = new WorkerNickname(workerFinNum, nickName);
                //addInto Database
                WorkerComplementsDAO.addNickname(workerNickname);
                
            //=======================================//
            //          Passport Details  
            //=======================================// 
            } else if (complementName.equals("WorkerPassportDetails")) {

                //get all the parameters for passport
                String passportCountry = request.getParameter("nPassportCountry");
                String passportNum = request.getParameter("nPassportNum");
                String passportIssueDateStr = request.getParameter("nPassportIssueDate");
                String passportExpiryDateStr = request.getParameter("nPassportExpiryDate");
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



                //create passport object
                WorkerPassportDetails workerPassportDetails = new WorkerPassportDetails(workerFinNum,
                        passportNum, passportCountry, passportIssueDate, passportExpiryDate);
                //addInto Database
                WorkerComplementsDAO.addWorkerPassportDetails(workerPassportDetails);
                
            //=======================================//
            //          Home Country Phone Number  
            //=======================================//
            } else if (complementName.equals("WorkerHomeCountryPhNum")) {

                //get all the parameters for HomeCountry
                String phNum = request.getParameter("nPhNum");
                String phOwner = request.getParameter("nPhOwner");
                String obseleteDateStr = request.getParameter("nObseleteDate");

                java.sql.Date obseleteDate = null;
                if (!obseleteDateStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(obseleteDateStr);
                        obseleteDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }


                //create object
                WorkerHomeCountryPhNum obj = new WorkerHomeCountryPhNum(workerFinNum,
                        phNum, phOwner, obseleteDate);
                //add into db
                WorkerComplementsDAO.addWorkerHomeCountryPhNum(obj);

            //=======================================//
            //          Singapore Phone Number  
            //=======================================//
            } else if (complementName.equals("WorkerSgPhNum")) {
                //get all the parameters for HomeCountry
                String phNum = request.getParameter("nPhNum");
                String obseleteDateStr = request.getParameter("nObseleteDate");
                java.sql.Date obseleteDate = null;
                if (!obseleteDateStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(obseleteDateStr);
                        obseleteDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }



                WorkerSgPhNum obj = new WorkerSgPhNum(workerFinNum, phNum, obseleteDate);
                //add into db
                WorkerComplementsDAO.addWorkerSgPhNum(obj);

            //=======================================//
            //          Singapore Address  
            //=======================================//
            } else if (complementName.equals("WorkerSgAddress")) {
                //get all the parameters for HomeCountry
                String address = request.getParameter("nAddress");
                String obseleteDateStr = request.getParameter("nObseleteDate");

                java.sql.Date obseleteDate = null;
                if (!obseleteDateStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(obseleteDateStr);
                        obseleteDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }



                //add into db//create object
                WorkerSgAddress obj = new WorkerSgAddress(workerFinNum, address, obseleteDate);
                WorkerComplementsDAO.addWorkerSgAddress(obj);

            //=======================================//
            //          Home Country Address   
            //=======================================//
            } else if (complementName.equals("WorkerHomeCountryAddress")) {
                //get all the parameters for HomeCountry
                String address = request.getParameter("nAddress");
                String obseleteDateStr = request.getParameter("nObseleteDate");

                java.sql.Date obseleteDate = null;
                if (!obseleteDateStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(obseleteDateStr);
                        obseleteDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }

                //add into db
                WorkerHomeCountryAddress obj = new WorkerHomeCountryAddress(workerFinNum, address, obseleteDate);
                WorkerComplementsDAO.addWorkerHomeCountryAddress(obj);

            //=======================================//
            //          Digital Contacts  
            //=======================================//
            } else if (complementName.equals("WorkerDigitalContact")) {

                //get all the parameters for Nickname
                String digitalContactType = request.getParameter("nDigitalContactType");
                String digitalMore = request.getParameter("nDigitalMore");
                String digitalDetails = request.getParameter("nDigitalDetails");
                String digitalOwner = request.getParameter("nDigitalOwner");
                String remark = request.getParameter("nRemark");
                String obseleteDateStr = request.getParameter("nObseleteDate");

                java.sql.Date obseleteDate = null;
                if (!obseleteDateStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(obseleteDateStr);
                        obseleteDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }


                //create object
                WorkerDigitalContact obj = new WorkerDigitalContact(workerFinNum, digitalContactType,
                        digitalMore, digitalDetails, digitalOwner, remark, obseleteDate);

                //add into db
                WorkerComplementsDAO.addWorkerDigitalContact(obj);

            //=======================================//
            //          Next of Kin  
            //=======================================//
            } else if (complementName.equals("WorkerNextOfKin")) {

                //get all the parameters for next of kin
                String name = request.getParameter("nName");
                String relation = request.getParameter("nRelation");
                String phNum = request.getParameter("nPhNum");
                String digitalContact = request.getParameter("nDigitalContact");
                String docReference = request.getParameter("nDocReference");
                String address = request.getParameter("nAddress");
                String proofDoc = request.getParameter("nProofDoc");
                String remark = request.getParameter("nRemark");
                String obseleteDateStr = request.getParameter("nObseleteDate");

                java.sql.Date obseleteDate = null;
                if (!obseleteDateStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(obseleteDateStr);
                        obseleteDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }



                //create object
                WorkerNextOfKin obj = new WorkerNextOfKin(workerFinNum, name,
                        relation, docReference, phNum, digitalContact, address,
                        proofDoc, remark, obseleteDate);
                WorkerComplementsDAO.addWorkerNextOfKin(obj);

            //=======================================//
            //          Family Members   
            //=======================================//                
            } else if (complementName.equals("WorkerFamilyMember")) {

                //get all the parameters for next of kin
                String name = request.getParameter("nName");
                String relation = request.getParameter("nRelation");
                String address = request.getParameter("nAddress");
                String phNum = request.getParameter("nPhNum");
                String digitalContact = request.getParameter("nDigitalContact");
                String remark = request.getParameter("nRemark");
                String obseleteDateStr = request.getParameter("nObseleteDate");

                java.sql.Date obseleteDate = null;
                if (!obseleteDateStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(obseleteDateStr);
                        obseleteDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }


                //add into db                //create object
                WorkerFamilyMember obj = new WorkerFamilyMember(workerFinNum, name,
                        relation, address, phNum, digitalContact, remark, obseleteDate);
                WorkerComplementsDAO.addWorkerFamilyMember(obj);

            //=======================================//
            //          Friends In Singapore 
            //=======================================//               
            } else if (complementName.equals("WorkerFriend")) {

                //get all the parameters for next of kin
                String name = request.getParameter("nName");
                String relation = request.getParameter("nRelation");
                String phNum = request.getParameter("nPhNum");
                String remark = request.getParameter("nRemark");
                String obseleteDateStr = request.getParameter("nObseleteDate");

                java.sql.Date obseleteDate = null;
                if (!obseleteDateStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(obseleteDateStr);
                        obseleteDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }


                //add into db                //create object
                WorkerFriend obj = new WorkerFriend(workerFinNum, name,
                        phNum, relation, remark, obseleteDate);
                WorkerComplementsDAO.addWorkerFriend(obj);

            //=======================================//
            //          Language 
            //=======================================//
            } else if (complementName.equals("WorkerLanguage")) {

                //get all the parameters for next of kin
                String mainLanguage = request.getParameter("nMainLanguage");
                String languageMore = request.getParameter("nLanguageMore");
                String englishStandard = request.getParameter("nEnglishStandard");
                String remark = request.getParameter("nRemark");


                //add into db                //create object
                WorkerLanguage obj = new WorkerLanguage(workerFinNum, mainLanguage,
                        languageMore, englishStandard, remark);
                WorkerComplementsDAO.addWorkerLanguage(obj);

            //=======================================//
            //          Bank Account Details  
            //=======================================//
            } else if (complementName.equals("WorkerBankAcct")) {
                //get all the parameters for next of kin
                String bankAcctName = request.getParameter("nBankAcctName");
                String bankAcctNum = request.getParameter("nBankAcctNum");
                String bankName = request.getParameter("nBankName");
                String bankBranch = request.getParameter("nBankBranch");
                String bankBranchAddress = request.getParameter("nBankBranchAddress");
                String bankBranchCode = request.getParameter("nBankBranchCode");
                String bankSwift = request.getParameter("nBankSwift");
                String remark = request.getParameter("nRemark");
                String obseleteDateStr = request.getParameter("nObseleteDate");

                java.sql.Date obseleteDate = null;
                if (!obseleteDateStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(obseleteDateStr);
                        obseleteDate = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }


                //create object
                WorkerBankAcct obj = new WorkerBankAcct(workerFinNum, bankAcctName,
                        bankAcctNum, bankName, bankBranch, bankBranchAddress,
                        bankBranchCode, bankSwift, remark, obseleteDate);
                WorkerComplementsDAO.addWorkerBankAccountDetails(obj);



            }
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
        try {
            processRequest(request, response);
        } catch (ParseException ex) {
            Logger.getLogger(processAddWorkerComplement.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (ParseException ex) {
            Logger.getLogger(processAddWorkerComplement.class.getName()).log(Level.SEVERE, null, ex);
        }
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
