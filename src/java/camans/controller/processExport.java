/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.controller;

import au.com.bytecode.opencsv.CSVWriter;
import camans.dao.WorkerDAO;
import camans.utility.DataExport;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.tomcat.util.http.fileupload.FileUtils;

/**
 *
 * @author soemyatmyat
 */
public class processExport extends HttpServlet {

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
        //PrintWriter out = response.getWriter();
        try {
            String selected[] = request.getParameterValues("select");
            
            if (selected != null) {
                
                //==========================================//
                //      Prepare all the necessary files
                //==========================================//
                //Zip file Name
                String zipFileName = "data.zip";
                //folder to store the out data
                String folderName = "dataOut";
                //retrieve filePath of the app build folder
                String filePath = getServletContext().getRealPath("/");
                // Creating folder to store the zip file
                File file = new File(filePath + File.separator + folderName);
                if (!file.exists()) {file.mkdir();} //data file
                // delete the files inside the directory
                FileUtils.cleanDirectory(file);
                // get the file Path
                filePath = file.getAbsolutePath() + File.separator;
                // preparing for force download
                response.setContentType("application/zip");
                response.setHeader("Content-Disposition", "attachment; fileName=" + zipFileName);
                
                
                
                //==========================================//
                //    Exporting data in db to csv file
                //==========================================//
                //loop through and export data to data folder
                for (int i = 0; i < selected.length; i++) {
                    String item = selected[i];
                    String fileName = filePath + item + ".csv";
                    DataExport.exportData(fileName);
                }
                
                //==========================================//
                //    Compressing csv files into zip file
                //==========================================//
                File[] files = file.listFiles();// get all the file lists

                // Zip Output stream to write the files to zip file (for download)
                ZipOutputStream zos = new ZipOutputStream(response.getOutputStream());
                // loop through all the files in directory file
                for (File csvfile: files) {
                    // for ZipEntry we need to keep only relative file path
                    String absolutePath = csvfile.getAbsolutePath();
                    // ZipEntry to prepare to store the file
                    ZipEntry ze = new ZipEntry(absolutePath.substring(filePath.length()));
                    // Add the file to zip file
                    zos.putNextEntry(ze);
                    // InputStream to read the csv file
                    FileInputStream fileInStream = new FileInputStream(csvfile.getAbsolutePath());
                    byte[] buffer = new byte[2048];
                    int size;
                    while ((size = fileInStream.read(buffer)) > 0) {
                        zos.write(buffer, 0, size);
                    }
                    zos.closeEntry();
                    fileInStream.close();
                }
                zos.finish();
                zos.close();

            }
            
        } catch (Exception ex) {
            //out.println(ex);
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
