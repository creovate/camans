/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.controller;

import camans.dao.UserAuditLogDAO;
import camans.dao.WorkerComplementsDAO;
import camans.dao.WorkerDAO;
import camans.entity.User;
import camans.entity.UserAuditLog;
import camans.entity.Worker;
import camans.entity.WorkerAttachment;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
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
public class processFile extends HttpServlet {

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
        //PrintWriter out = response.getWriter();//comment out because of fileOutputStream confusing
        
        try {
            
            boolean isMultiPart = ServletFileUpload.isMultipartContent(request);
            //==========================================//
            //          Data Collection
            //==========================================//
            String attachId = request.getParameter("attachId");
            String action = request.getParameter("action");
            String workerFinNum = request.getParameter("workerFin");
            String newFileName = request.getParameter("nFileName");
            User userLogin = (User) request.getSession().getAttribute("userLogin");
            String auditChange = "";
            
            //==========================================//
            //          Success & Error Display
            //==========================================//
            String success = null;
            String error = null;
            
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
                //          Process File Upload 
                //==========================================//
                workerFinNum = null;
                String fileOrign = null;
                while(iter.hasNext()) {
                    FileItemStream item = iter.next();
                    if (item.isFormField()) { //form items in isMultipart
                        String fieldName = item.getFieldName();
                        InputStream is = item.openStream();
                        byte[] b = new byte[is.available()];
                        is.read(b);
                        String value = new String(b);
                        if ("workerFin".equalsIgnoreCase(fieldName)) {
                            workerFinNum = value;
                        }
                    } else { //file upload

                        if (!item.getName().equals("")) {//only if there is file
                            //retrieve filePath of the app build folder
                            String filePath = getServletContext().getRealPath("/");
                            //to append in file name
                            String uniqueID = UUID.randomUUID().toString();
                            FileOutputStream outStream = null;
                            InputStream inStream = null;
                            try {
                                File file = new File (filePath + File.separator + "workers");
                                if (!file.exists()) {file.mkdir();} //workers file
                                file = new File (filePath + File.separator + "workers" + File.separator + workerFinNum);
                                //create a image fie directory with workerFinNumber
                                if (!file.exists()) {file.mkdir();} //workers/workerFinNumber files
                                //set the file Name
                                fileOrign = item.getName();
                                String fileName = uniqueID + "-xx-" + item.getName();
                                file = new File(file.getAbsolutePath() + File.separator + fileName);
                                //writing the file data
                                outStream = new FileOutputStream(file);
                                inStream = item.openStream();
                                int bytesRead = 0;
                                byte[] buffer  = new byte[1024];
                                while((bytesRead=inStream.read(buffer))!= -1){
                                    outStream.write(buffer,0,bytesRead);
                                }
                                
                                //update the database
                                String fileDir = "workers/" + workerFinNum + "/" + fileName;
                                User _user = (User) request.getSession().getAttribute("userLogin");
                                WorkerAttachment workerAttachment = new WorkerAttachment(workerFinNum,item.getName(),fileDir,_user.getUsername());
                                WorkerComplementsDAO.addAttachmentDetails(workerAttachment);
                                //log to audit
                                auditChange = workerAttachment.toString2();
                            } catch (Exception e) {
                                //think of how to display the error
                                //do not process and show error page
                                //log the errors to logs file
                            } finally {
                                if (outStream != null) {
                                    outStream.flush();
                                    outStream.close();
                                }
                                if (inStream != null) {
                                    inStream.close();
                                }
                            }
                        } else { //no file selected
                            error = "No File Selected";
                            request.getSession().setAttribute("errAttachMsg", error);
                        }
                    } //end of fileUpload   
                } //while
                if (fileOrign != null) {
                    success = fileOrign + " has been successfully uploaded!";
                }
                //log to audit
                UserAuditLog userAuditLog = new UserAuditLog(userLogin.getUsername(), workerFinNum + "", 
                        workerFinNum, "Added", "Attachment: " + auditChange);

                UserAuditLogDAO.addUserAuditLog(userAuditLog);  
                request.getSession().setAttribute("successAttachMsg", success);
                response.sendRedirect("viewWorker.jsp?worker=" + workerFinNum +"#attachment_complement");
                //==========================================//
                //          End of Process File Upload 
                //==========================================//
            } else { //this is not a file upload request
                //==========================================//
                //          Process File Delete
                //==========================================//
                if (action.equals("delete")) {
                    int id = Integer.parseInt(attachId);
                    WorkerAttachment workerAttachment = WorkerComplementsDAO.retrieveAttachmentDetailsById(id);
                    //retrieve filePath of the app build folder together with file dir
                    String filePath = getServletContext().getRealPath("/") + File.separator + workerAttachment.getFilePath();
                    File deleteFile = new File(filePath);
                    if (!deleteFile.exists()) {
                        error = "Selected File does not exist. Please check with admin.";
                        request.getSession().setAttribute("errAttachMsg", error);
                        response.sendRedirect("viewWorker.jsp?worker=" + workerFinNum +"#attachment_complement");
                    } else {
                        if (deleteFile.delete()) {     
                            //update database
                            success = workerAttachment.getDocumentName() + " has been successfully deleted!";
                            WorkerComplementsDAO.deleteWorkerAttachment(workerAttachment);
                            Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(workerFinNum);
                            //if the file to be deleted is profile picture
                            if (worker.getPhotoPath().equals(workerAttachment.getFilePath())) {
                                String photoPath = null;
                                worker.setPhotoPath(photoPath);
                                WorkerDAO.updateWorkerPhotoPath(worker);
                            } //end if 
                            request.getSession().setAttribute("successAttachMsg", success);
                            //log to audit
                            auditChange = workerAttachment.toString2();
                            UserAuditLog userAuditLog = new UserAuditLog(userLogin.getUsername(), workerFinNum + "", 
                            workerFinNum, "Deleted", "Attachment: " + auditChange);
                            UserAuditLogDAO.addUserAuditLog(userAuditLog);
                            
                            response.sendRedirect("viewWorker.jsp?worker=" + workerFinNum +"#attachment_complement");
                        } else { //file delete processing error
                            //do not proceed & show error page
                            //log the errors to logs file
                        }
                    }
                //==========================================//
                //          End of Process File Delete
                //==========================================//    
                } else if (action.equals("edit")) {
                //==========================================//
                //          Process File Rename
                //==========================================//      
                    int id = Integer.parseInt(attachId);
                    WorkerAttachment workerAttachment = WorkerComplementsDAO.retrieveAttachmentDetailsById(id);
                    
                    String fileDir = workerAttachment.getFilePath(); 
                    
                    Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(workerFinNum);
                    
                    //note to  change the profile pic directory if it's the same file
                    boolean change = false;
                    if (worker.getPhotoPath().equals(fileDir)) {
                        change = true;
                    } //end note
                    String oldFilePath = getServletContext().getRealPath("/") + File.separator + fileDir; 
                    File oldFile = new File(oldFilePath);
                    if (!oldFile.exists()) {
                        error = "Selected File does not exist. Please check with admin.";
                        request.getSession().setAttribute("errAttachMsg", error);
                        response.sendRedirect("viewWorker.jsp?worker=" + workerFinNum 
                                +"#attachment_complement");
                    } else {
                        String oldFileName = oldFile.getName();

                        newFileName = oldFileName.substring(0, oldFileName.indexOf("-xx-")) + "-xx-" 
                                + newFileName + oldFileName.substring(oldFileName.indexOf("."));
                        String newFilePath = oldFile.getParent() + File.separator + newFileName;
                        File newFile = new File(newFilePath);
                        if (oldFile.renameTo(newFile)) {
                            workerAttachment.setDocumentName(newFileName.substring(newFileName.lastIndexOf('-')+1));
                            workerAttachment.setFilePath("workers/" + workerFinNum + "/" + newFileName);
                            WorkerComplementsDAO.updateAttachmentDetails(workerAttachment);
                            success = oldFileName.substring(oldFileName.lastIndexOf('-')+1) + " has been successfully renamed to " + 
                                    workerAttachment.getDocumentName() + "!";
                            request.getSession().setAttribute("successAttachMsg", success);
                            
                            if (change) {
                                worker.setPhotoPath(workerAttachment.getFilePath());
                                WorkerDAO.updateWorkerPhotoPath(worker);
                            }
                            //log to audit
                            auditChange = workerAttachment.toString2();
                            UserAuditLog userAuditLog = new UserAuditLog(userLogin.getUsername(), workerFinNum + "", 
                            workerFinNum, "Modified", "Attachment: " + auditChange);

                            UserAuditLogDAO.addUserAuditLog(userAuditLog);
                            response.sendRedirect("viewWorker.jsp?worker=" + workerFinNum +"#attachment_complement");
                        } else { //file rename processing error
                            //do not proceed & show error page
                            //log the errors to logs file  
                        }

                    }
                    
                    
                //==========================================//
                //         End of Process File Rename
                //==========================================//  
                    
                } else if (action.equals("download")) {
                //==========================================//
                //          Process File Download
                //==========================================//   
                    int id = Integer.parseInt(attachId);
                    WorkerAttachment workerAttachment = WorkerComplementsDAO.retrieveAttachmentDetailsById(id);
                    
                    //retrieve filePath of the app build folder together with file dir
                    String filePath = getServletContext().getRealPath("/") + File.separator 
                            + workerAttachment.getFilePath();
                    File dlFile = new File(filePath);
                   //out.println(dlFile.toString());
                    
                    if (dlFile.exists()) {
                        //get MIME type of the file
                        String mimeType = getServletContext().getMimeType(dlFile.getAbsolutePath());
                        if (mimeType == null) {
                            // set to binary type if MIME mapping not found
                            mimeType = "application/octet-stream";
                        }

                        //modifies response
                        response.setContentType(mimeType);
                        response.setContentLength((int) dlFile.length());
 
                        // forces download
                        String headerKey = "Content-Disposition";
                        String headerValue = String.format("attachment; filename=\"%s\"", workerAttachment.getDocumentName());
                        response.setHeader(headerKey, headerValue);

                        FileInputStream inStream = null;
                        OutputStream outStream = null;
                        
                        try {
                            inStream = new FileInputStream(dlFile);
                            //obtains the response's output stream
                            outStream = response.getOutputStream();
                        
                            byte[] buffer = new byte[1024];   
                            int bytesRead = 0;

                            while ((bytesRead = inStream.read(buffer)) != -1) {
                                outStream.write(buffer, 0, bytesRead);
                            }
                            } catch (Exception e) {
                                //need to think of how to display the error
                                //do not process & show error page
                                outStream.write("error".getBytes());    
                            } finally {
                                outStream.flush();
                                inStream.close();
                                outStream.close();
                            }
                        
                    } else {
                        error = "Selected File does not exist. Please check with admin.";
                        request.getSession().setAttribute("errAttachMsg", error);
                        response.sendRedirect("viewWorker.jsp?worker=" + workerFinNum 
                                +"#attachment_complement");
                    }
                } else if (action.equals("profilepic")) {
                    //==========================================//
                    //          Set As Profile Picture
                    //==========================================// 
                    int id = Integer.parseInt(attachId);
                    WorkerAttachment workerAttachment = WorkerComplementsDAO.retrieveAttachmentDetailsById(id);
                    Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(workerFinNum);
                    worker.setPhotoPath(workerAttachment.getFilePath());
                    WorkerDAO.updateWorkerPhotoPath(worker);
                    success = workerAttachment.getDocumentName() + " has been set as profile picture.";
                    request.getSession().setAttribute("successAttachMsg", success);
                    response.sendRedirect("viewWorker.jsp?worker=" + workerFinNum 
                                +"#attachment_complement");
                }
            }
        } catch (Exception e) {
            //do not process & show error page
            //String tmp = "" + e;
            //out.println("error:" + e);    
            
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
