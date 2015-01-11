/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.controller;

import camans.dao.*;
import camans.entity.PasswordHash;
import camans.entity.User;
import java.io.BufferedOutputStream;
import java.io.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.tomcat.util.http.fileupload.FileUtils;

/**
 *
 * @author soemyatmyat
 */
@WebServlet(name = "processBootstrap", urlPatterns = {"/processBootstrap"})
public class processBootstrap extends HttpServlet {

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
            
            try {
                //delete all existing data from database
                //worker & its 13 complements
                WorkerDAO.deleteAll();
                WorkerComplementsDAO.deleteAll();
                //job & its 9 complements
                JobDAO.deleteAll();
                JobComplementsDAO.deleteAll();
                //problem & its 23 complements
                ProblemDAO.deleteAll();
                ProblemComplementsDAO.deleteAll();
                //user & audit log 
                UserDAO.deleteAllUsers();
                UserAuditLogDAO.deleteAll();
                //add superadmin
                String encryptedPwd = "";
                try {
                    encryptedPwd = PasswordHash.createHash("superadmin");
                } catch (Exception ex) {
                    //do not process & show error page 
                }  
                User user = new User("dummy", "Super Admin", "dummy", "superadmin", encryptedPwd, 
                        "dummy@email.com", "", "Male", "Administrator", null, "Active");
                UserDAO.addUser(user);
            } catch (Exception ex) {
                //log this error
                out.println("Bootstrap Failed - Unable to delete existing data from database: " 
                        + ex.getMessage());
                return;
            }
            
            // Create a factory for disk-based file items
            DiskFileItemFactory diskFactory = new DiskFileItemFactory();
            // File Upload Handler
            ServletFileUpload uploader = new ServletFileUpload(diskFactory);
            // Parse the request to get file item.
            List fileItems = uploader.parseRequest(request);
            // Get file item - first in the list because it's only one zip file
            FileItem fItem = (FileItem) fileItems.get(0);
            // Get name of zip file
            String fileName = fItem.getName();
            // If no file is selected, redirect back & stop further processing
            if (fileName.equals("")) {
                response.sendRedirect("admin.jsp");
                return;
            }
            // If it is not a zip file, redirect back & stop further processing
            String[] split = fileName.split("\\.");
            String ext = split[split.length - 1];
            if (!ext.equalsIgnoreCase("zip")) {
                response.sendRedirect("admin.jsp" + fileName);
                return;
            }
            
            //retrieve filePath of the app build folder
            String filePath = getServletContext().getRealPath("/");
            // Creating folder to store the zip file
            File file = new File(filePath + File.separator + "data");
            // delete the files inside the directory
            FileUtils.cleanDirectory(file);
            if (!file.exists()) {file.mkdir();} //data file
            filePath = filePath + File.separator + "data" + File.separator;
            file = new File(filePath + fileName);
            // Write uploaded file to disk
            fItem.write(file);
            
            /* Extraction of zip content */
            // Input stream for the uploaded file
            FileInputStream fileInStream = new FileInputStream(filePath + fileName);
            // Zip input stream for reading the files inside zip folder
            ZipInputStream zis = new ZipInputStream(fileInStream);
            // ZipEntry to prepare to store the files
            ZipEntry ze;
            // Loop through and extract all csv files in zip archive
            while ((ze = zis.getNextEntry()) != null) {
                int size;
                byte[] buffer = new byte[2048];
                FileOutputStream fos = new FileOutputStream(filePath + ze.getName());
                BufferedOutputStream bos = new BufferedOutputStream(fos, buffer.length);
                while ((size = zis.read(buffer, 0, buffer.length)) != -1) {
                    bos.write(buffer, 0, size);
                }
                bos.flush();
                bos.close();
            }
            // Close the zipInputStream
            if (zis != null) {
                zis.close();
            }
            // Close the FileInputStream
            if (fileInStream != null) {
                fileInStream.close();
            }
            
            
            //
            String workerFile = filePath + "worker.csv";
            String jobFile = filePath + "job.csv";
            String problemFile = filePath + "problem.csv";
            
            String workerNickNamesFile = filePath + "nickname.csv";
            String workerPassportsFile = filePath + "passport.csv";
            String workerHomeCountryPhFile = filePath + "homecountryph.csv";
            String workerSgPhFile = filePath + "sgph.csv";
            String workerHomeCountryAddressFile = filePath + "homecountryaddress.csv";
            String workerSgAddressFile = filePath + "sgaddress.csv";
            String workerDigitalContactFile = filePath + "digitalcontact.csv";
            String workerNextKinFile = filePath + "nextofkin.csv";
            String workerFamilyMemberFile = filePath + "familymember.csv";
            String workerFriendFile = filePath + "friend.csv";
            String workerLanguageFile = filePath + "language.csv";
            String workerBankAcctFile = filePath + "bankacct.csv";
            
            HashMap<String, ArrayList<String>> errList = new HashMap<String, ArrayList<String>>();
            ArrayList<String> tmp = null;
            try {
                tmp = WorkerDAO.validateAndAddWorker(workerFile);
                if (!tmp.isEmpty()) {
                    errList.put("worker.csv", tmp);
                } 
                tmp = JobDAO.validateAndAddJob(jobFile);
                if (!tmp.isEmpty()) {
                    errList.put("job.csv", tmp);
                }    
                tmp = ProblemDAO.validateAndAddProblem(problemFile);
                if (!tmp.isEmpty()) {
                    errList.put("problem.csv", tmp);
                }
                
                tmp = WorkerComplementsDAO.validateAndAddNickname(workerNickNamesFile);
                if (!tmp.isEmpty()) {
                    errList.put("nickname.csv", tmp);
                }
                
                tmp = WorkerComplementsDAO.validateAndAddPassportDetails(workerPassportsFile);
                if (!tmp.isEmpty()) {
                    errList.put("passport.csv", tmp);
                }
                
                tmp = WorkerComplementsDAO.validateAndAddHomeCountryPhoneNum(workerHomeCountryPhFile);
                if (!tmp.isEmpty()) {
                    errList.put("homecountryph.csv", tmp);
                }
                
                tmp = WorkerComplementsDAO.validateAndAddSgPhoneNum(workerSgPhFile);
                if (!tmp.isEmpty()) {
                    errList.put("sgph.csv", tmp);
                }
                
                tmp = WorkerComplementsDAO.validateAndAddHomeCountryAddress(workerHomeCountryAddressFile );
                if (!tmp.isEmpty()) {
                    errList.put("homecountryaddress.csv", tmp);
                }
                
                tmp = WorkerComplementsDAO.validateAndAddSgAddress(workerSgAddressFile );
                if (!tmp.isEmpty()) {
                    errList.put("sgaddress.csv", tmp);
                }
                
                tmp = WorkerComplementsDAO.validateAndAddWorkerDigitalContact(workerDigitalContactFile);
                if (!tmp.isEmpty()) {
                    errList.put("digitalcontact.csv", tmp);
                }
                
                tmp = WorkerComplementsDAO.validateAndAddWorkerNextOfKin(workerNextKinFile);
                if (!tmp.isEmpty()) {
                    errList.put("nextofkin.csv", tmp);
                }
                
                tmp = WorkerComplementsDAO.validateAndAddWorkerFamilyMember(workerFamilyMemberFile);
                if (!tmp.isEmpty()) {
                    errList.put("familymember.csv", tmp);
                }
                
                tmp = WorkerComplementsDAO.validateAndAddWorkerFriend(workerFriendFile);
                if (!tmp.isEmpty()) {
                    errList.put("friend.csv", tmp);
                }
                
                tmp = WorkerComplementsDAO.validateAndAddWorkerLanguage(workerLanguageFile);
                if (!tmp.isEmpty()) {
                    errList.put("language.csv", tmp);
                }
                
                tmp = WorkerComplementsDAO.validateAndAddWorkerBankAccountDetails(workerBankAcctFile);
                if (!tmp.isEmpty()) {
                    errList.put("bankacct.csv", tmp);
                }
                
                
                
            } catch (IOException ex) {
                out.println("Bootstrap Failed - File IO exception occured: " + ex.getMessage());
                return;
            } catch (Exception ex) {
                out.println("Bootstrap Failed - Validation exception occured: " + ex);
                return;
            }
            
            
                        
            
        } catch (Exception ex) {
            
        } finally {            
            
            response.sendRedirect("admin.jsp");
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
