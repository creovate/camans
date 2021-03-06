/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.controller;

import camans.entity.*;
import camans.dao.*;

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

import org.json.simple.JSONObject;

/**
 *
 * @author soemyatmyat
 */
public class processUser extends HttpServlet {

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
        //response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        try {


            boolean isMultiPart = ServletFileUpload.isMultipartContent(request);

            String action = request.getParameter("action");
            String nric = request.getParameter("nNRIC");
            String fullName = "";
            String alias = "";
            String username = request.getParameter("nUsername");
            String pwd = request.getParameter("nPwd");
            String gender = "";
            String role = "";
            String email = "";
            String phNum = "";
            String photoPath = "";
            String page = request.getParameter("page");
            String oldPwd = request.getParameter("nOldPwd");
            
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

                while(iter.hasNext()) {
                    FileItemStream item = iter.next();
                    if (item.isFormField()) {
                        String fieldName = item.getFieldName();
                        InputStream is = item.openStream();
                        byte[] b = new byte[is.available()];
                        is.read(b);
                        String value = new String(b);
                        if ("action".equalsIgnoreCase(fieldName)) {
                            action = value;
                        } else if ("nNRIC".equalsIgnoreCase(fieldName)) {
                            nric = value;
                        } else if ("nFullName".equalsIgnoreCase(fieldName)) {
                            fullName = value;
                        } else if ("nAlias".equalsIgnoreCase(fieldName)) {
                            alias = value;
                        } else if ("nUsername".equalsIgnoreCase(fieldName)) {
                            username = value;
                        } else if ("nPwd".equalsIgnoreCase(fieldName)) {
                            pwd = value;
                        } else if ("nGender".equalsIgnoreCase(fieldName)) {
                            gender = value;
                        } else if ("nRole".equalsIgnoreCase(fieldName)) {
                            role = value;
                        } else if ("nEmail".equalsIgnoreCase(fieldName)) {
                           email = value;
                        }  else if ("nPhNum".equalsIgnoreCase(fieldName)) {
                           phNum = value;
                        }  else if ("nPhotoPath".equalsIgnoreCase(fieldName)) {
                           photoPath = value;
                        }  else if ("page".equalsIgnoreCase(fieldName)) {
                            page = value;
                        }  
                    } else { //image upload

                        if (!item.getName().equals("")) { //only if there is file
                            String extension = item.getName().substring(item.getName().lastIndexOf(".")+1);
                            
                            if (extension.equalsIgnoreCase("jpeg") || extension.equalsIgnoreCase("jpg") ||
                                    extension.equalsIgnoreCase("png")|| extension.equalsIgnoreCase("bmp")) {
                       
                                //retrieve filePath of the app build folder
                                String filePath = getServletContext().getRealPath("/");
                                //to append in image file name
                                String uniqueID = UUID.randomUUID().toString();
                                FileOutputStream outStream = null;
                                InputStream inStream = null;
                                try {
                                    File file = new File (filePath + File.separator + "img" + File.separator + username);
                                    //create a image fie directory with username
                                    if (!file.exists()) {file.mkdir();}
                                    //set the file Name
                                    String fileName = uniqueID + "-xx-" + item.getName();
                                    file = new File(file.getAbsolutePath() + File.separator + fileName);
                                    outStream = new FileOutputStream(file);
                                    inStream = item.openStream();
                                    int bytesRead = 0;
                                    byte[] buffer  = new byte[1024];
                                    while((bytesRead = inStream.read(buffer))!= -1){
                                        outStream.write(buffer,0,bytesRead);
                                    }
                                    //set the photoPath for database update
                                    photoPath = "img/" + username + "/" + fileName;
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
                        }    

                    } //image upload
                } //while iter.hasNext
            } //isMultiPart
            //==========================================//
            //          End of Data Collection
            //==========================================//

            //==========================================//
            //     Ajax NRIC, username & pwd validation
            //==========================================//
            if (action == null) {
                User user = null; //tmp user
                if (nric != null) { 
                    user = UserDAO.retrieveUserByNRIC(nric);
                } else {
                    user = UserDAO.retrieveUserByUsername(username);
                }
                JSONObject returnJsonObject = new JSONObject();
                
                if (oldPwd == null) {
                    if (user != null) {//user already exists
                        returnJsonObject.put("valid", "false");
                    } else {
                        returnJsonObject.put("valid", "true");
                    }
                } else { //oldPassword validation for change password
                    user = (User) request.getSession().getAttribute("userLogin");
                    returnJsonObject.put("valid", user.authenticate(oldPwd));
                }    
                //returnJsonObject.put("user", user);
                out.println(returnJsonObject);

            } else if (action != null && (action.equals("add") || action.equals("edit"))) {
                //either adding new user or editing
                //=======================================//
                //    Server Side Validation process
                //=======================================//

                //nric
                if (nric == null || nric.length() >9 || !nric.matches("^[A-Z][0-9]{7}[A-Z]$")) {
                    pass = false;
                    err += "Invalid NRIC Format,";
                }
                //Full Name
                if (fullName == null || fullName.length() >50) {
                    pass = false;
                    err += "Invalid fullName, ";
                }
                //Alias
                if (alias.length() > 50) {
                    pass = false;
                    err += "Invalid Alias";
                }
                //Username
                if (username == null || username.length()<6 || username.length()>20 || 
                        !username.matches("^[a-zA-Z0-9_]+$")) {
                    pass = false;
                    err += "Invalid username, ";
                } 

                //Email
                if (email == null || !email.matches("^[\\w-_\\.+]*[\\w-_\\.]\\@([\\w]+\\.)+[\\w]+[\\w]$")) {
                    pass = false;
                    err += "Invalid email format, ";
                }
                
                //Phone Number //regrex still needs

                //=======================================//
                //      Server Side Validation End
                //=======================================//

                //===============================================//
                //      Server Side Valdiation: Errors & Success
                //===============================================//
                //Validation Pass
                if (pass) {

                    User user = null;
                     //===============================================//
                     //      Adding New user
                     //===============================================//
                    if (action.equals("add")) {
                        //Encrypt password
                        
                        String encryptedPwd = "";
                        try {
                            encryptedPwd = PasswordHash.createHash(pwd);
                        } catch (Exception ex) {
                            //do not process & show error page 
                        }    
                        //brand-new User :P
                        user = new User(nric, fullName, alias, username, encryptedPwd, email, phNum, gender, 
                            role, photoPath, "Active");
                        /*user = new User(nric, fullName, alias, username, pwd, email, phNum, gender, 
                            role, photoPath, "Active");*/
                        UserDAO.addUser(user);
                        success = "User " + user.getUsername() + " has been successfully added!";

                      //===============================================//
                     //      Editing Existing User
                     //===============================================//
                    } else if (action.equals("edit")) {


                        user = UserDAO.retrieveUserByUsername(username);

                        user.setFullName(fullName);
                        user.setAlias(alias);
                        user.setGender(gender);
                        user.setRole(role);
                        user.setEmailAddress(email);
                        user.setPhoneNumber(phNum);
                        if (!photoPath.equals("")) { user.setPhotoPath(photoPath); }
                        UserDAO.updateUser(user);
                        
                        //only if user is modifying its own profile
                        if (((User) request.getSession().getAttribute("userLogin"))
                                .getUsername().equals(user.getUsername())) {
                            request.getSession().setAttribute("userLogin", user);
                        }
                        success = "User " + user.getUsername() + " has been successfully updated!";
                        
                    }

                    request.getSession().setAttribute("successMsg", success);

                //Validation Fails    
                } else {

                    request.getSession().setAttribute("errorMsg", err);
                }
                if (page != null) {
                    response.sendRedirect(page);
                } else {
                    response.sendRedirect("userManagement.jsp");
                }

            //=======================================//
            //      Inactivate/Activate User
            //=======================================//    
            } else if (action.equals("inactive") || action.equals("active")) {//need to change to inactivate!

                if (action.equals("inactive")) {
                    String inactivateUserName = request.getParameter("nUsername");

                    User user = UserDAO.retrieveUserByUsername(inactivateUserName);
                    user.setStatus("Inactive");
                    UserDAO.updateStatus(user);
                    //UserDAO.deleteUser(username);
                    success = "User " + username + " has been successfully inactivated!";
                } else {
                    String activateUserName = request.getParameter("nUsername");

                    User user = UserDAO.retrieveUserByUsername(activateUserName);
                    user.setStatus("Active");
                    UserDAO.updateStatus(user);
                    success = "User " + username + " has been successfully activated!";
                }
                    request.getSession().setAttribute("successMsg", success);
                    response.sendRedirect("userManagement.jsp");

            //=======================================//
            //      Reset/Change Password 
            //=======================================//       
            } else if (action.equals("resetPwd")) {//
                String resetUserName = request.getParameter("nUsername");

                //Encrypt password           
                String encryptedPwd = "";
                try {
                    encryptedPwd = PasswordHash.createHash(pwd);
                } catch (Exception ex) {
                    //do not process & show error page 
                }

                User user = UserDAO.retrieveUserByUsername(resetUserName);
                user.setPassword(encryptedPwd);
                //user.setPassword(pwd);
                UserDAO.updatePassword(user);
                User _user = (User) request.getSession().getAttribute("userLogin");
                //this applies only to userprofile
                if (user.getUsername().equals(_user.getUsername())) {
                    request.getSession().setAttribute("userLogin", user);
                }

                if (page !=null) {
                    success = resetUserName + "'s password has been change!";
                    request.getSession().setAttribute("successMsg", success);
                    response.sendRedirect(page);
                } else {
                    success = "User " + resetUserName + "'s password has been reset!";
                    request.getSession().setAttribute("successMsg", success);
                    response.sendRedirect("userManagement.jsp");
                }


            } 
      
        } catch (Exception e) {
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
