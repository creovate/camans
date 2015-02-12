/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.controller;

import camans.dao.DropdownDAO;
import camans.entity.Dropdown;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author soemyatmyat
 */
@WebServlet(name = "processDropdown", urlPatterns = {"/dropdownProcess.do"})
public class processDropdown extends HttpServlet {

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
            String action = request.getParameter("action");
            String success = null;
            String error = null;
            
            //===============================================//
            //      Adding new Item Field
            //===============================================//
            if (action != null && action.equals("add")) {
                String itemName = request.getParameter("nItemName");
                String type = request.getParameter("nItemType");
                int rank = Integer.parseInt(request.getParameter("nRank"));
                
                Dropdown dropdownItem = null;
                if (type.startsWith("Bene_type")) {
                    String remark = type.substring(type.lastIndexOf("_")+1);
                    if (remark.equals("medical")) {
                        remark = "Medical & Karunya";
                    }
                    dropdownItem = new Dropdown("Bene_type", itemName, remark, rank);   
                } else {
                    dropdownItem = new Dropdown(type, itemName, null, rank);    
                }
                DropdownDAO.addDropdownItem(dropdownItem);
                success = "Item: " + itemName + " has been added!";
                request.getSession().setAttribute("successMsg", success);
                response.sendRedirect("dropdownSetting.jsp?name=" + type);
                
            //===============================================//
            //      Deleting Selected Items
            //===============================================//    
            } else if (action != null && action.equals("delete")) {
                String type = request.getParameter("name");
                String deleteArray[] = request.getParameterValues("select");
                if (deleteArray != null) {
                    success = "";
                    for (int i = 0; i < deleteArray.length; i++) {
                        int id = Integer.parseInt(deleteArray[i]);
                        Dropdown dropdownItem = DropdownDAO.retrieveDropdownItemById(id);
                        DropdownDAO.deleteDropdownItem(dropdownItem);
                        success += dropdownItem.getName() + ", ";
                    }
                    success = "Item: " + success + " has been deleted!";
                    request.getSession().setAttribute("successMsg", success);
                    response.sendRedirect("dropdownSetting.jsp?name=" + type);
                } else {
                    error = "No item has been selected!";
                    request.getSession().setAttribute("errMsg", error);
                    response.sendRedirect("dropdownSetting.jsp?name=" + type);
                }
                
            //===============================================//
            //                  Items Ordering
            //===============================================//    
            } else {
                String str = request.getParameter("items");
                String[] strArr = str.split(",");
                for (int i = 0; i < strArr.length; i++){
                    String tmp = strArr[i];
                    int id = Integer.parseInt(tmp.substring(tmp.indexOf("=")+1));
                    Dropdown dropdownItem = DropdownDAO.retrieveDropdownItemById(id);
                    dropdownItem.setDisplayRank(i+1);
                    DropdownDAO.updateDropdownItem(dropdownItem);
                }
            }
            
        } catch (Exception e) {
            //do not proceed & show the error page
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
