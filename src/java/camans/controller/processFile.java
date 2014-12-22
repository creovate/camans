/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.controller;

import camans.dao.WorkerComplementsDAO;
import camans.entity.User;
import camans.entity.WorkerAttachment;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItemIterator;
import org.apache.commons.fileupload.FileItemStream;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author pyaephyo
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
        PrintWriter out = response.getWriter();
        
        try {
            
            //==========================================//
            //          Success & Error Display
            //==========================================//
            String success = null;
            String error = null;
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
            String workerFinNum = null;
            String fileOrign = null;
            while(iter.hasNext()) {
                FileItemStream item = iter.next();
                if (item.isFormField()) {
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
                        //to append in image file name
                        String uniqueID = UUID.randomUUID().toString();
                        try {
                            File file = new File (filePath + File.separator + "workers");
                            if (!file.exists()) {file.mkdir();}
                            file = new File (filePath + File.separator + "workers" + File.separator + workerFinNum);
                            //create a image fie directory with username
                            if (!file.exists()) {file.mkdir();}
                            //set the file Name
                            fileOrign = item.getName();
                            String fileName = uniqueID + "-xx-" + item.getName();
                            file = new File(file.getAbsolutePath() + File.separator + fileName);
                            FileOutputStream fos = new FileOutputStream(file);
                            InputStream is = item.openStream();
                            int x = 0;
                            byte[] b  = new byte[1024];
                            while((x=is.read(b))!= -1){
                                fos.write(b,0,x);
                            }
                            fos.flush();
                            fos.close();
                            String fileDir = "workers/" + workerFinNum + "/" + fileName;
                            User _user = (User) request.getSession().getAttribute("userLogin");
                            WorkerAttachment workerAttachment = new WorkerAttachment(workerFinNum,item.getName(),fileDir,_user.getUsername());
                            WorkerComplementsDAO.addAttachmentDetails(workerAttachment);
                        } catch (Exception e) {
                            out.println("Error:" + e);
                        }
                    } else {
                        error = "No File Selected";
                        request.getSession().setAttribute("errAttachMsg", error);
                    }
                }   
            }
            success = fileOrign + " has been successfully uploaded!";
            request.getSession().setAttribute("successAttachMsg", success);
            response.sendRedirect("viewWorker.jsp?worker=" + workerFinNum);
        } catch (Exception e) {
            //do not process & show error page
            out.println("error:" + e);    
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
