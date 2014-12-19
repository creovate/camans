/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.controller;

import camans.entity.*;
import camans.dao.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.JSONArray;
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
            //data collection//
            String action = request.getParameter("action");
            String nric = request.getParameter("nNRIC");
            String fullName = request.getParameter("nFullName");
            String alias = request.getParameter("nAlias");
            String username = request.getParameter("nUsername");
            String pwd = request.getParameter("nPwd");
            String gender = request.getParameter("nGender");
            String role = request.getParameter("nRole");
            String email = request.getParameter("nEmail");
            String phNum = request.getParameter("nPhNum");
            String photoPath = request.getParameter("nPhotoPath");
            String page = request.getParameter("page");
            //end of data collection//
            out.println(action);
            //==========================================//
            // Client Side NRIC and username validation
            //==========================================//
            if (action == null) {
                User user = null; //tmp user
                if (nric != null) { 
                    user = UserDAO.retrieveUserByNRIC(nric);
                } else {
                    user = UserDAO.retrieveUserByUsername(username);
                }
                JSONObject returnJsonObject = new JSONObject();
                if (user != null) {//user already exists
                    returnJsonObject.put("valid", "false");
                } else {
                    returnJsonObject.put("valid", "true");
                }
                out.println(returnJsonObject);
            } else if (action != null && (action.equals("add") || action.equals("edit"))) {
                //either adding new user or editing
                //=======================================//
                //        Server Side Validation
                //=======================================//
                boolean pass = true; //Assume validaiton pass first
                String err = ""; //to store error msg
                String success = "";//to store success msg
                //nric
                if (nric == null || nric.length() >9 || !nric.matches("^[A-Z][0-9]{7}[A-Z]")) {
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
                //      Server Side Valdiatin: Errors & Success
                //===============================================//
                //Validation Pass
                if (pass) {

                    User user = null;
                     //this is adding new user
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
                        UserDAO.addUser(user);
                        success = "User " + user.getUsername() + " has been successfully added!";
                        
                        // this is editing existing user
                    } else if (action.equals("edit")) {
                        
                        user = UserDAO.retrieveUserByUsername(username);
                        user.setFullName(fullName);
                        user.setAlias(alias);
                        user.setGender(gender);
                        user.setRole(role);
                        user.setEmailAddress(email);
                        user.setPhoneNumber(phNum);
                        user.setPhotoPath(photoPath);
                        UserDAO.updateUser(user);
                        success = "User " + user.getUsername() + " has been successfully updated!";
                        
                    }
                    
                    request.getSession().setAttribute("successMsg", success);

                //Validation Fails    
                } else {

                    request.getSession().setAttribute("errorMsg", err);
                }
            
            //=======================================//
            //      Inactivate User
            //=======================================//    
            } else if (action.equals("inactive") || action.equals("active")) {//need to change to inactivate!
                String success = "";
                
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
                //response.sendRedirect("userManagement.jsp");
                
            //=======================================//
            //      Reset Password 
            //=======================================//       
            } else if (action.equals("resetPwd")) {//
                String success = "";
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
                UserDAO.updatePassword(user);
                
                success = "User " + resetUserName + "'s password has been reset!";
                request.getSession().setAttribute("successMsg", success);
                //response.sendRedirect("userManagement.jsp");
            }
            
            if (page == null || page.equals("")) {
                response.sendRedirect("userManagement.jsp");
            } else {
                response.sendRedirect(page);
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
