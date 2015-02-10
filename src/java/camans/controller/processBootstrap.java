/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.controller;

import au.com.bytecode.opencsv.CSVWriter;
import camans.dao.*;
import camans.entity.*;
import camans.utility.DataValidator;
import java.io.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import java.util.zip.ZipOutputStream;
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
            
            /* BOOTSTRAP DELETION
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
                //benefit
                BenefitDAO.deleteAll();
                //user & audit log 
                //UserDAO.deleteAllUsers();
                //UserAuditLogDAO.deleteAll();
                //add superadmin
                String encryptedPwd = "";
                try {
                    encryptedPwd = PasswordHash.createHash("superadmin");
                } catch (Exception ex) {
                    //do not process & show error page 
                }  
                //User user = new User("dummy", "Super Admin", "dummy", "superadmin", encryptedPwd, 
                //        "dummy@email.com", "", "Male", "Administrator", null, "Active");
                //UserDAO.addUser(user);
            } catch (Exception ex) {
                //log this error
                out.println("Bootstrap Failed - Unable to delete existing data from database: " 
                        + ex.getMessage());
                return;
            }*/
            
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
                request.getSession().setAttribute("error", "Bootstrap Failed - Please choose a file.");
                response.sendRedirect("importexport.jsp");
                return;
            }
            // If it is not a zip file, redirect back & stop further processing
            String[] split = fileName.split("\\.");
            String ext = split[split.length - 1];
            if (!ext.equalsIgnoreCase("zip")) {
                request.getSession().setAttribute("error", "Bootstrap Failed - Please choose only files with zip extension.");
                response.sendRedirect("importexport.jsp");
                return;
            }
            
            //folder name
            String folderName = "dataIn";
            //retrieve filePath of the app build folder
            String filePath = getServletContext().getRealPath("/");
            // Creating folder to store the zip file
            File file = new File(filePath + File.separator + folderName);
            if (!file.exists()) {file.mkdir();} //data file
            // delete the files inside the directory
            FileUtils.cleanDirectory(file);
            filePath = file.getAbsolutePath() + File.separator;
            File uploadFile = new File(filePath + fileName);
            // Write uploaded file to disk
            fItem.write(uploadFile);
            
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
            
            //folder to store the err data
            String folderErrName = "dataErr";
            //retrieve filePath of the app build folder
            String fileErrPath = getServletContext().getRealPath("/");
            // Creating folder to store the zip file
            File fileErr = new File(fileErrPath + File.separator + folderErrName);
            if (!fileErr.exists()) {fileErr.mkdir();} //data Error file
            // delete the files inside the directory
            FileUtils.cleanDirectory(fileErr);    
            
            //worker, job, problem
            String workerFile = filePath + "worker.csv";
            String workerErrFile = fileErr.getAbsolutePath() + File.separator + "workerErr.csv";
            String jobFile = filePath + "job.csv";
            String jobErrFile = fileErr.getAbsolutePath() + File.separator + "jobErr.csv";
            String problemFile = filePath + "problem.csv";
            String problemErrFile = fileErr.getAbsolutePath() + File.separator + "problemErr.csv";
            
            ArrayList<String> fileList = new ArrayList<String>();
            File[] filelistnames = file.listFiles();
            for (int i = 0; i < filelistnames.length; i++) {
                String tmpname = filelistnames[i].getName();
                if (tmpname.endsWith(".csv") && !tmpname.equals("worker.csv") && !tmpname.equals("job.csv")
                        && !tmpname.equals("problem.csv")) {
                    fileList.add(tmpname);
                }    
            }
            
            HashMap<String, Integer> successList = new HashMap<String, Integer>();
            HashMap<String, Integer> errCountList = new HashMap<String, Integer> ();
            try {
                //tmp = WorkerDAO.validateAndAddWorker(workerFile, workerErrFile);
                String errCountMsg = WorkerDAO.validateAndAddWorker(workerFile, workerErrFile);
                if (errCountMsg != null) {
                    String errFileName = errCountMsg.substring(0, errCountMsg.indexOf(":"));
                    int errCount = Integer.parseInt(errCountMsg.substring(errCountMsg.indexOf(":")+1));
                    if (errCount != 0) {
                        errCountList.put(errFileName, errCount);
                    }
                }
                
                errCountMsg = JobDAO.validateAndAddJob(jobFile, jobErrFile);
                if (errCountMsg != null) {
                    String errFileName = errCountMsg.substring(0, errCountMsg.indexOf(":"));
                    int errCount = Integer.parseInt(errCountMsg.substring(errCountMsg.indexOf(":")+1));
                    if (errCount != 0) {
                        errCountList.put(errFileName, errCount);
                    }
                }
                
                errCountMsg = ProblemDAO.validateAndAddProblem(problemFile, problemErrFile);
                if (errCountMsg != null) {
                    String errFileName = errCountMsg.substring(0, errCountMsg.indexOf(":"));
                    int errCount = Integer.parseInt(errCountMsg.substring(errCountMsg.indexOf(":")+1));
                    if (errCount != 0) {
                        errCountList.put(errFileName, errCount);
                    }
                }

                if (ProblemDAO.problemList != null && !ProblemDAO.problemList.isEmpty()) {
                    int probCount = 0;
                    int jobCount = 0;
                    int workerCount = 0;
                    //iterate through problems by fin number 
                    for (String finNum: ProblemDAO.problemList.keySet()) {
                        ArrayList<Problem> probTmpList = ProblemDAO.problemList.get(finNum);
                        //loop through each problem
                        for (Problem problem: probTmpList) {
                            //check any job exist for this problem in db
                            Job job = JobDAO.retrieveJobByJobId(problem.getJobKey());
                            if (job == null) { //does not exist in db
                                if (JobDAO.jobList != null && !JobDAO.jobList.isEmpty()) {
                                    ArrayList<Job> jobList = JobDAO.jobList.get(finNum);
                                    if (jobList != null && !jobList.isEmpty()) {
                                        for (Job tmpJob: jobList) { //check in jobList
                                            if (tmpJob.getJobKey() == problem.getJobKey() &&
                                                    tmpJob.getWorkerFinNum().equals(finNum)) {//exist in the list
                                                //check whether worker exist for this job in db
                                                Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                                                if (worker == null) { //does not exist in db
                                                    //check in list
                                                    if (WorkerDAO.workerList != null && !WorkerDAO.workerList.isEmpty()) {
                                                        worker = WorkerDAO.workerList.get(finNum);
                                                        if (worker != null) { //worker exist in list
                                                            WorkerDAO.addWorker(worker);
                                                            workerCount++;
                                                            JobDAO.addJob(worker, tmpJob);
                                                            jobCount++;
                                                            ProblemDAO.addProblemData(worker, tmpJob, problem);
                                                            probCount++;
                                                        } else { //worker does not exit in list either
                                                           
                                                            int errCount = 0;
                                                            if (errCountList.containsKey("problem.csv")) {
                                                                errCount = errCountList.get("problem.csv");
                                                            }
                                                            
                                                            errCount++;
                                                            CSVWriter csvWriter = null;
                                                            csvWriter = new CSVWriter(new FileWriter(problemErrFile, true));
                                                            String str = finNum + "," + problem.getJobKey() + "," + 
                                                                    problem.getProbKey() + "," + problem.getProblemRegisteredDate() +
                                                                    "," + problem.getProblem() + "," + problem.getProblemMore() +
                                                                    "," + problem.getProblemRemark() + "," + "invalid FinNumber";
                                                            String[] record = str.split(",");
                                                            csvWriter.writeNext(record);
                                                            csvWriter.close();
                                                            errCountList.put("problem.csv", errCount);
                                                            
                                                            errCount = 0;
                                                            if (errCountList.containsKey("job.csv")) {
                                                                errCount = errCountList.get("job.csv");
                                                            }
                                                            errCount++;
                                                            csvWriter = null;
                                                            csvWriter = new CSVWriter(new FileWriter(jobErrFile, true));
                                                            str = finNum + "," + tmpJob.getJobKey() + "," + tmpJob.getEmployerName() +
                                                                    "," + tmpJob.getWorkPassType() + "," + tmpJob.getWorkPassMore() +
                                                                    "," + tmpJob.getJobSector() + "," + tmpJob.getJobSectorMore() +
                                                                    "," + tmpJob.getOccupation() + "," + tmpJob.getJobStartDate() +
                                                                    "," + tmpJob.getJobEndDate() + "," + tmpJob.getJobTJS() +
                                                                    "," + tmpJob.getJobRemark() + "," + "invalid FinNumber";
                                                            String[] record2 = str.split(",");
                                                            csvWriter.writeNext(record2);
                                                            csvWriter.close();
                                                            errCountList.put("job.csv", errCount);
                                                                    
                                                        }
                                                    } else { //no worker list
                                                        int errCount = 0;
                                                        if (errCountList.containsKey("problem.csv")) {
                                                            errCount = errCountList.get("problem.csv");
                                                        }
                                                        errCount++;
                                                        CSVWriter csvWriter = null;
                                                        csvWriter = new CSVWriter(new FileWriter(problemErrFile, true));
                                                        String str = finNum + "," + problem.getJobKey() + "," + 
                                                                problem.getProbKey() + "," + problem.getProblemRegisteredDate() +
                                                                "," + problem.getProblem() + "," + problem.getProblemMore() +
                                                                "," + problem.getProblemRemark() + "," + "invalid FinNumber";
                                                        String[] record = str.split(",");
                                                        csvWriter.writeNext(record);
                                                        csvWriter.close();
                                                        errCountList.put("problem.csv", errCount);

                                                        errCount = 0;
                                                        if (errCountList.containsKey("job.csv")) {
                                                            errCount = errCountList.get("job.csv");
                                                        }
                                                        errCount++;
                                                        csvWriter = null;
                                                        csvWriter = new CSVWriter(new FileWriter(jobErrFile, true));
                                                        str = finNum + "," + tmpJob.getJobKey() + "," + tmpJob.getEmployerName() +
                                                                "," + tmpJob.getWorkPassType() + "," + tmpJob.getWorkPassMore() +
                                                                "," + tmpJob.getJobSector() + "," + tmpJob.getJobSectorMore() +
                                                                "," + tmpJob.getOccupation() + "," + tmpJob.getJobStartDate() +
                                                                "," + tmpJob.getJobEndDate() + "," + tmpJob.getJobTJS() +
                                                                "," + tmpJob.getJobRemark() + "," + "invalid FinNumber";
                                                        String[] record2 = str.split(",");
                                                        csvWriter.writeNext(record2);
                                                        csvWriter.close();
                                                        errCountList.put("job.csv", errCount);
                                                    }     
                                                } else { //worker already exist in db
                                                    JobDAO.addJob(worker, tmpJob);
                                                    jobCount++;
                                                    ProblemDAO.addProblemData(worker, tmpJob, problem); 
                                                    probCount++;
                                                }
                                                break; //get out of loop
                                            } else { //does not exist in job list
                                               
                                                int errCount = 0;
                                                if (errCountList.containsKey("problem.csv")) {
                                                    errCount = errCountList.get("problem.csv");
                                                }
                                                errCount++;
                                                CSVWriter csvWriter = null;
                                                csvWriter = new CSVWriter(new FileWriter(problemErrFile, true));
                                                String str = finNum + "," + problem.getJobKey() + "," + 
                                                        problem.getProbKey() + "," + problem.getProblemRegisteredDate() +
                                                        "," + problem.getProblem() + "," + problem.getProblemMore() +
                                                        "," + problem.getProblemRemark() + "," + "invalid job key";
                                                String[] record = str.split(",");
                                                csvWriter.writeNext(record);
                                                csvWriter.close();
                                                errCountList.put("problem.csv", errCount);
                                            }
                                        }
                                    } else { //does not exist in job list
                                       int errCount = 0;
                                        if (errCountList.containsKey("problem.csv")) {
                                            errCount = errCountList.get("problem.csv");
                                        }
                                        errCount++;
                                        CSVWriter csvWriter = null;
                                        csvWriter = new CSVWriter(new FileWriter(problemErrFile, true));
                                        String str = finNum + "," + problem.getJobKey() + "," + 
                                                problem.getProbKey() + "," + problem.getProblemRegisteredDate() +
                                                "," + problem.getProblem() + "," + problem.getProblemMore() +
                                                "," + problem.getProblemRemark() + "," + "no job record, ";
                                        String[] record = str.split(",");
                                        csvWriter.writeNext(record);
                                        csvWriter.close();
                                        errCountList.put("problem.csv", errCount);
                                    } 
                                } else {
                                    int errCount = 0;
                                    if (errCountList.containsKey("problem.csv")) {
                                        errCount = errCountList.get("problem.csv");
                                    }
                                    errCount++;
                                    CSVWriter csvWriter = null;
                                    csvWriter = new CSVWriter(new FileWriter(problemErrFile, true));
                                    String str = finNum + "," + problem.getJobKey() + "," + 
                                            problem.getProbKey() + "," + problem.getProblemRegisteredDate() +
                                            "," + problem.getProblem() + "," + problem.getProblemMore() +
                                            "," + problem.getProblemRemark() + "," + "no job record, ";
                                    String[] record = str.split(",");
                                    csvWriter.writeNext(record);
                                    csvWriter.close();
                                    errCountList.put("problem.csv", errCount);
                                }
                            } else { //job already exist in db
                                if (job.getWorkerFinNum().equals(finNum)) {
                                    Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                                    ProblemDAO.addProblemData(worker, job, problem);
                                    probCount++;
                                } else { //job fin number & problem fin num not the same
                                    int errCount = 0;
                                    if (errCountList.containsKey("problem.csv")) {
                                        errCount = errCountList.get("problem.csv");
                                    }
                                    errCount++;
                                    CSVWriter csvWriter = null;
                                    csvWriter = new CSVWriter(new FileWriter(problemErrFile, true));
                                    String str = finNum + "," + problem.getJobKey() + "," + 
                                            problem.getProbKey() + "," + problem.getProblemRegisteredDate() +
                                            "," + problem.getProblem() + "," + problem.getProblemMore() +
                                            "," + problem.getProblemRemark() + "," + "invalid fin number, ";
                                    String[] record = str.split(",");
                                    csvWriter.writeNext(record);
                                    csvWriter.close();
                                    errCountList.put("problem.csv", errCount);
                                }
                            } 

                        } //for each problem 
                    }//loop through problem list
                    successList.put("worker.csv", workerCount);
                    successList.put("job.csv", jobCount);
                    successList.put("problem.csv", probCount);
                    
                } else { //problem.csv? 
                    if (JobDAO.jobList != null && !JobDAO.jobList.isEmpty()) {  
                        Iterator iter = JobDAO.jobList.keySet().iterator();
                        while (iter.hasNext()) {
                            String fin = (String) iter.next();
                            ArrayList<Job> jobList = JobDAO.jobList.get(fin);
                            for (Job tmpJob: jobList) {
                                int errCount = 0;
                                if (errCountList.containsKey("job.csv")) {
                                    errCount = errCountList.get("job.csv");
                                }
                                errCount++;
                                CSVWriter csvWriter = null;
                                csvWriter = new CSVWriter(new FileWriter(jobErrFile, true));
                                String str = tmpJob.getWorkerFinNum() + "," + tmpJob.getJobKey() + "," + tmpJob.getEmployerName() +
                                        "," + tmpJob.getWorkPassType() + "," + tmpJob.getWorkPassMore() +
                                        "," + tmpJob.getJobSector() + "," + tmpJob.getJobSectorMore() +
                                        "," + tmpJob.getOccupation() + "," + tmpJob.getJobStartDate() +
                                        "," + tmpJob.getJobEndDate() + "," + tmpJob.getJobTJS() +
                                        "," + tmpJob.getJobRemark() + "," + "no problem.csv file for new jobs";
                                String[] record2 = str.split(",");
                                csvWriter.writeNext(record2);
                                csvWriter.close();
                                errCountList.put("job.csv", errCount);
                            }
                        }
                    } else {
                        if (WorkerDAO.workerList != null && !WorkerDAO.workerList.isEmpty()) {
                             for(String finNum: WorkerDAO.workerList.keySet()) {   
                                Worker worker = WorkerDAO.workerList.get(finNum);
                                int errCount = 0;
                                if (errCountList.containsKey("worker.csv")) {
                                    errCount = errCountList.get("worker.csv");
                                }
                                errCount++;
                                CSVWriter csvWriter = null;
                                csvWriter = new CSVWriter(new FileWriter(workerErrFile, true));
                                String str = finNum + "," + worker.getName() + "," + worker.getRegistrationDate() + 
                                        "," + worker.getCreatedBy() + "," + worker.getCreatedFor() + "," +
                                        worker.getGender() + "," + worker.getNationality() + "," +
                                        worker.getNationalityMore() + "," + worker.getDateOfBirth() + "," +
                                        "no job.csv file for new workers";
                                String[] record = str.split(",");
                                csvWriter.writeNext(record);
                                csvWriter.close();
                                errCountList.put("worker.csv", errCount);
                                
                            }
                        }
                    }
                }
                for (String finNum: WorkerDAO.workerList.keySet()) {
                    Worker worker = WorkerDAO.workerList.get(finNum);
                    if (WorkerDAO.retrieveWorkerbyFinNumber(worker.getFinNumber()) == null) {
                       int errCount = 0;
                        if (errCountList.containsKey("worker.csv")) {
                            errCount = errCountList.get("worker.csv");
                        } 
                        errCount++;
                        CSVWriter csvWriter = null;
                        csvWriter = new CSVWriter(new FileWriter(workerErrFile, true));
                        String str = finNum + "," + worker.getName() + "," + worker.getRegistrationDate() + 
                                "," + worker.getCreatedBy() + "," + worker.getCreatedFor() + "," +
                                worker.getGender() + "," + worker.getNationality() + "," +
                                worker.getNationalityMore() + "," + worker.getDateOfBirth() + "," +
                                "no job or problem record";
                        String[] record = str.split(",");
                        csvWriter.writeNext(record);
                        csvWriter.close();
                        errCountList.put("worker.csv", errCount);
                    }
                    
                }
                
                //clear static data
                WorkerDAO.workerList.clear();
                JobDAO.jobList.clear();
                ProblemDAO.problemList.clear();
                
                for (String inputFileName: fileList) {
                    String inputFile = filePath + inputFileName;
                    String errFile = fileErr.getAbsolutePath() + File.separator + inputFileName.substring(0,inputFileName.indexOf(".")) + "Err.csv";
                    String msg = DataValidator.validateData(inputFile, errFile);
                    if (!msg.equals("")) {
                        String filename = msg.substring(0,msg.indexOf(":"));
                        int succCount = Integer.parseInt(msg.substring(msg.indexOf(":")+1, msg.indexOf(",")));
                        int errCount = Integer.parseInt(msg.substring(msg.indexOf(",")+1));
                        successList.put(filename, succCount);
                        if (errCount != 0) {
                            errCountList.put(filename, errCount);
                        }
                    }
                }
                
                request.getSession().setAttribute("bootstrapResult", errCountList);
                request.getSession().setAttribute("successList", successList);
                
                //zip all the err csv files
                if (fileErr.exists()) {
                    String zipFileName = "errData.zip";
                    File[] errFileNames = fileErr.listFiles();
                    //Output stream to create a zip file
                    FileOutputStream fileOutStream = new FileOutputStream(fileErr.getAbsolutePath() + 
                            File.separator + zipFileName);
                    // Zip Output stream to write the files inside the zip file
                    ZipOutputStream zos = new ZipOutputStream(fileOutStream);
                    for (File errFileName: errFileNames) {
                        // for ZipEntry we need to keep only relative file path
                        String absolutePath = errFileName.getAbsolutePath();
                        // ZipEntry to prepare to store the file
                        ze = new ZipEntry(absolutePath.substring(filePath.length()+1));
                        // Add the file to zip file
                        zos.putNextEntry(ze);
                        // InputStream to read the csv file
                        fileInStream = new FileInputStream(errFileName.getAbsolutePath());
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
                
                response.sendRedirect("importexport.jsp");
            } catch (IOException ex) {
                out.println("Bootstrap Failed - File IO exception occured: " + ex.getMessage());
                return;
            } catch (Exception ex) {
                out.println("Bootstrap Failed - Validation exception occured: " + ex);
                return;
            }
            
            
                        
            
        } catch (Exception ex) {
            out.println(ex);
        } finally {            
            
            //response.sendRedirect("admin.jsp");
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
