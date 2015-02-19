/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.controller;

import camans.entity.*;
import camans.dao.*;
import java.io.*;
import java.text.*;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItemIterator;
import org.apache.commons.fileupload.FileItemStream;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author soemyatmyat
 */
@WebServlet(name = "processCreateNewCase", urlPatterns = {"/createNewCase.do"})
public class processCreateNewCase extends HttpServlet {

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

            boolean isMultiPart = ServletFileUpload.isMultipartContent(request);

            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
            java.util.Date date = new java.util.Date();
            //get FIN & job Key

            String finNumber = request.getParameter("workerFinNum");
            String jobKeyStr = request.getParameter("jobKey");

            //==========================================//
            //     Worker Info Data Collection
            //==========================================//
            String registeredDateStr = request.getParameter("registeredDate");
            String createdBy = request.getParameter("createdBy");
            String createdFor = request.getParameter("createdFor");
            java.sql.Date registeredDate = null;
            String workerName = request.getParameter("workerName");
            String finNum = request.getParameter("finNum");
            String gender = request.getParameter("gender");
            String nationality = request.getParameter("nationality");
            String nationalityMore = request.getParameter("nationalityMore");
            String dobStr = request.getParameter("dob");
            java.sql.Date dob = null;
            String photoPath = null;
            String photoName = null;
            Worker worker = null;
            //String passCurrent = null;
            //String passMore = null;
            //String passNumber = null;
            //String passIssueDate = null;

            //==========================================//
            //     Job Info Data Collection
            //==========================================//
            String employerName = request.getParameter("employerName");
            String workpassType = request.getParameter("workpassType");
            String workpassMore = request.getParameter("workpassMore");
            String jobSector = request.getParameter("jobSector");
            String jobSectorMore = request.getParameter("jobSectorMore");
            String occupation = request.getParameter("occupation");
            String jobStartDateStr = request.getParameter("jobStartDate");
            String jobEndDateStr = request.getParameter("jobEndDate");
            String tjs = request.getParameter("tjs");
            String jobRemark = request.getParameter("jobRemark");
            Job job = null;

            //==========================================//
            //     Problem Info Data Collection
            //==========================================//
            String problemRegDateStr = request.getParameter("problemRegDate");
            java.sql.Date problemRegDate = null;
            String problemName = request.getParameter("problem");
            String problemMore = request.getParameter("problemMore");
            String problemRemark = request.getParameter("problemRemark");
            // to confirm these 
            String injuryDate = request.getParameter("injuryDate");
            String injuryBodyPart = request.getParameter("injuryBodyPart");
            String currentHosptial = request.getParameter("currentHosptial");
            String hospitalMore = request.getParameter("hospitalMore");
            String lawfirmName = request.getParameter("lawfirmName");
            // end of to confirm these
            Problem problem = null;

            //=======================================//
            //   Server Side Validation Parameters
            //=======================================//
            boolean pass = true; //Assume validaiton pass first
            String err = null; //to store error msg
            String success = null;//to store success msg

            //check that we have a file upload request
            if (isMultiPart) {
                //==========================================//
                //          Prepare for File Upload
                //==========================================//
                // Create a factory for disk-based file items
                DiskFileItemFactory diskFactory = new DiskFileItemFactory();
                // File Upload Handler
                ServletFileUpload uploader = new ServletFileUpload(diskFactory);
                // Put all the fields request into iter
                FileItemIterator iter = uploader.getItemIterator(request);
                //==========================================//
                //          Data Collection
                //==========================================//

                while (iter.hasNext()) {
                    FileItemStream item = iter.next();
                    if (item.isFormField()) {
                        String fieldName = item.getFieldName();
                        InputStream inStream = item.openStream();
                        byte[] buffer = new byte[inStream.available()];
                        inStream.read(buffer);
                        String value = new String(buffer);
                        if ("registeredDate".equalsIgnoreCase(fieldName)) {
                            registeredDateStr = value;
                        } else if ("createdBy".equalsIgnoreCase(fieldName)) {
                            createdBy = value;
                        } else if ("createdFor".equalsIgnoreCase(fieldName)) {
                            createdFor = value;
                        } else if ("workerName".equalsIgnoreCase(fieldName)) {
                            workerName = value;
                        } else if ("finNum".equalsIgnoreCase(fieldName)) {
                            finNum = value;
                        } else if ("gender".equalsIgnoreCase(fieldName)) {
                            gender = value;
                        } else if ("nationality".equalsIgnoreCase(fieldName)) {
                            nationality = value;
                        } else if ("nationalityMore".equalsIgnoreCase(fieldName)) {
                            nationalityMore = value;
                        } else if ("dob".equalsIgnoreCase(fieldName)) {
                            dobStr = value;
                        } else if ("employerName".equalsIgnoreCase(fieldName)) {
                            employerName = value;
                        } else if ("workpassType".equalsIgnoreCase(fieldName)) {
                            workpassType = value;
                        } else if ("workpassMore".equalsIgnoreCase(fieldName)) {
                            workpassMore = value;
                        } else if ("jobSector".equalsIgnoreCase(fieldName)) {
                            jobSector = value;
                        } else if ("jobSectorMore".equalsIgnoreCase(fieldName)) {
                            jobSectorMore = value;
                        } else if ("occupation".equalsIgnoreCase(fieldName)) {
                            occupation = value;
                        } else if ("jobStartDate".equalsIgnoreCase(fieldName)) {
                            jobStartDateStr = value;
                        } else if ("jobEndDate".equalsIgnoreCase(fieldName)) {
                            jobEndDateStr = value;
                        } else if ("tjs".equalsIgnoreCase(fieldName)) {
                            tjs = value;
                        } else if ("jobRemark".equalsIgnoreCase(fieldName)) {
                            jobRemark = value;
                        } else if ("problemRegDate".equalsIgnoreCase(fieldName)) {
                            problemRegDateStr = value;
                        } else if ("problem".equalsIgnoreCase(fieldName)) {
                            problemName = value;
                        } else if ("problemMore".equalsIgnoreCase(fieldName)) {
                            problemMore = value;
                        } else if ("problemRemark".equalsIgnoreCase(fieldName)) {
                            problemRemark = value;
                        }
                    } else { //image upload
                        if (!item.getName().equals("")) { //only if there is file
                            String extension = item.getName().substring(item.getName().lastIndexOf(".") + 1);

                            if (extension.equalsIgnoreCase("jpeg") || extension.equalsIgnoreCase("jpg")
                                    || extension.equalsIgnoreCase("png") || extension.equalsIgnoreCase("bmp")) {

                                //retrieve filePath of the app build folder
                                String filePath = getServletContext().getRealPath("/");
                                //to append in image file name
                                String uniqueID = UUID.randomUUID().toString();
                                FileOutputStream outStream = null;
                                InputStream inStream = null;
                                try {
                                    File file = new File(filePath + File.separator + "workers");
                                    if (!file.exists()) {
                                        file.mkdir();
                                    } //workers file
                                    file = new File(filePath + File.separator + "workers" + File.separator + finNum);
                                    //create a image fie directory with workerFinNumber
                                    if (!file.exists()) {
                                        file.mkdir();
                                    } //workers/workerFinNumber files
                                    //set the file Name
                                    String fileName = uniqueID + "-xx-" + item.getName();
                                    file = new File(file.getAbsolutePath() + File.separator + fileName);
                                    outStream = new FileOutputStream(file);
                                    inStream = item.openStream();
                                    int bytesRead = 0;
                                    byte[] buffer = new byte[1024];
                                    while ((bytesRead = inStream.read(buffer)) != -1) {
                                        outStream.write(buffer, 0, bytesRead);
                                    }
                                    //set the photoPath for database update
                                    photoPath = "workers/" + finNum + "/" + fileName;
                                    photoName = item.getName();
                                } catch (Exception e) {
                                    out.println("Error:" + e);
                                } finally {
                                    if (outStream != null) {
                                        outStream.flush();
                                        outStream.close();
                                    }
                                    if (inStream != null) {
                                        inStream.close();
                                    }
                                }
                            } else { //invalid image file
                                err = "Invalid Image File. Only '.jpeg', '.jpg', "
                                        + "'.png', '.bmp' formats are allowed.";
                                pass = false;
                            }
                        }//check if there is file    
                    } //image upload
                } //while iter.hasNext
            } //isMultipart    

            //==========================================//
            //     Server side validation
            //==========================================//
            if (finNum != null) {
                if (!createdFor.equals("") && createdFor.length() > 20) {
                    pass = false;
                    err += "Created For cannot be longer than 20 characters, ";
                }
                if (workerName == null || workerName.length() > 50) {
                    pass = false;
                    err += "Worker Name cannot be longer than 50 characters, ";
                }
                if (finNum.matches("^[A-Z][0-9]{7}[A-Z]") || finNum.matches("^GEN[0-9]{6}")) {
                } else {
                    pass = false;
                    err += "Invalid Fin Number,";
                }
                try {
                    java.util.Date tmp = sdf.parse(registeredDateStr);
                    registeredDate = new java.sql.Date(tmp.getTime());

                } catch (ParseException ex) {
                    //out.println(ex);
                    pass = false;
                    err += "Invalid Registered Date Format";
                }

                try {
                    java.util.Date tmp = sdf.parse(problemRegDateStr);
                    problemRegDate = new java.sql.Date(tmp.getTime());

                } catch (ParseException ex) {
                    //out.println(ex);
                    pass = false;
                    err += "Invalid Problem Registered Date Format";
                }
                if (!dobStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(dobStr);
                        dob = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        //out.println(ex);
                        pass = false;
                        err += "Invalid Date of Birth Format,";
                    }
                }
            }
            if (jobKeyStr == null) {
                if (employerName == null || employerName.equals("") || employerName.length() > 50) {
                    pass = false;
                    err += "Invalid Employer Name,";
                }
                if (occupation != null && occupation.length() > 50) {
                    pass = false;
                    err += "Invalid occupation Format,";
                }
                if (jobStartDateStr != null && jobStartDateStr.length() > 50) {
                    pass = false;
                    err += "Job Start Date cannot be more than 50 characters, ";
                }
                if (jobEndDateStr != null && jobEndDateStr.length() > 50) {
                    pass = false;
                    err += "Job End Date cannot be more than 50 characters, ";
                }
                if (jobRemark != null && jobRemark.length() > 200) {
                    pass = false;
                    err += "Job Remark cannot be more than 200 characters, ";
                }
            }
            if (problemMore != null && problemMore.length() > 50) {
                pass = false;
                err += "Explain if above is other cannot be more than 50 charcters, ";
            }

            if (problemRemark != null && problemRemark.length() > 200) {
                pass = false;
                err += "Problem Remark cannot be more than 200 characters, ";
            }
            //==========================================//
            //     End of Server side validation
            //==========================================//

            //===============================================//
            //      Server Side Valdiation: Errors & Success
            //===============================================//
            //validation pass
            if (pass) {
                //all fields are correct & parsed to date            
                if (finNumber != null) {
                    finNum = finNumber;
                    registeredDate = new java.sql.Date(date.getTime());
                    worker = WorkerDAO.retrieveWorkerbyFinNumber(finNumber);
                } else {
                    //create new Worker Object and add to db
                    worker = new Worker(finNum, workerName, registeredDate, createdBy, createdFor,
                            gender, nationality, nationalityMore, dob, photoPath);
                    WorkerDAO.addWorker(worker);
                    if (photoPath != null) {
                        //update the attachment database
                        User _user = (User) request.getSession().getAttribute("userLogin");
                        WorkerAttachment workerAttachment =
                                new WorkerAttachment(finNum, photoName, photoPath, _user.getUsername());
                        WorkerComplementsDAO.addAttachmentDetails(workerAttachment);
                    }
                }

                int jobKey = -1;
                if (jobKeyStr == null) {
                    //create new Job Object and add to db
                    jobKey = JobDAO.retrieveMaxJobId() + 1;
                    job = new Job(finNum, jobKey, employerName, workpassType, workpassMore, jobSector,
                            jobSectorMore, occupation, jobStartDateStr, jobEndDateStr, tjs, jobRemark);
                    //jobKey = job.getJobKey();
                    JobDAO.addJob(worker, job);
                } else {
                    jobKey = Integer.parseInt(jobKeyStr);
                    worker = WorkerDAO.retrieveWorkerbyFinNumber(finNumber);
                    job = JobDAO.retrieveJobByJobId(jobKey);
                }

                problem = new Problem(finNum, jobKey, registeredDate, problemName,
                        problemMore, problemRemark, null, null, null, null);


                ProblemDAO.addProblem(worker, job, problem);

                //===============================================//
                //     Audit Log
                //===============================================//
                User _user = (User) request.getSession().getAttribute("userLogin");
                String auditChange = job.toString() + "," + problem.toString();
                UserAuditLog userAuditLog = new UserAuditLog(_user.getUsername(), finNum,
                        finNum, "Added", "New Case: " + auditChange);

                UserAuditLogDAO.addUserAuditLog(userAuditLog);

                //===============================================//
                //     End of Audit Log
                //===============================================//

            } else { //validation fail
                request.getSession().setAttribute("errorMsg", err);
                response.sendRedirect("createCase.jsp");
            }

            if (finNumber == null) {
                //Redirect Back to CreateNewCase Successful Page
                success = "success";
                

                request.getSession().setAttribute("worker", worker);
                request.getSession().setAttribute("status", success);
                
                String successMsg = "Worker " + worker.getName() + "(" + worker.getFinNumber() + ") has been successfully created.";
                request.getSession().setAttribute("successWrkCompMsg", successMsg);
                response.sendRedirect("viewWorker.jsp?worker=" + worker.getFinNumber());
            } else {
                //request.getSession().setAttribute("worker", worker);
                response.sendRedirect("viewWorker.jsp?worker=" + finNumber);
            }
        } catch (Exception e) {
            out.println(e);
            //do not proceed & show error page

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
