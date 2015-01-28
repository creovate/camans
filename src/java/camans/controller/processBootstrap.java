/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.controller;

import camans.dao.*;
import camans.entity.*;
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
                request.getSession().setAttribute("error", "Bootstrap Failed - Please choose a file.");
                response.sendRedirect("admin.jsp");
                return;
            }
            // If it is not a zip file, redirect back & stop further processing
            String[] split = fileName.split("\\.");
            String ext = split[split.length - 1];
            if (!ext.equalsIgnoreCase("zip")) {
                request.getSession().setAttribute("error", "Bootstrap Failed - Please choose only files with zip extension.");
                response.sendRedirect("admin.jsp");
                return;
            }
            
            //retrieve filePath of the app build folder
            String filePath = getServletContext().getRealPath("/");
            // Creating folder to store the zip file
            File file = new File(filePath + File.separator + "data");
            if (!file.exists()) {file.mkdir();} //data file
            // delete the files inside the directory
            FileUtils.cleanDirectory(file);
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
            
            
            //worker, job, problem
            String workerFile = filePath + "worker.csv";
            String jobFile = filePath + "job.csv";
            String problemFile = filePath + "problem.csv";
            //worker complements
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
            //job complements
            String jobPassDetailsFile = filePath + "passdetails.csv";
            String jobIPADetailsFile = filePath + "ipa.csv";
            String jobVerbalAssuranceFile = filePath + "verbalassurance.csv";
            String jobEmploymentContractFile = filePath + "employmentcontract.csv";
            String jobIntermediaryAgentFile = filePath + "intermediaryagent.csv";
            String jobEmployerFile = filePath + "employer.csv";
            String jobWorkplaceFile = filePath + "workplace.csv";
            String jobWorkHistoryFile = filePath + "workhistory.csv";
            String jobAccomodationFile = filePath + "accomodation.csv";
            //problem complements
            String probAggravatingIssueFile = filePath + "aggravatingissue.csv";
            String probLeadCaseWorkerFile = filePath + "leadcaseworker.csv";
            String probAuxiliaryCaseWorkerFile = filePath + "auxiliaryworker.csv";
            String probSalaryRelatedHistoryFile = filePath + "salaryrelatedhistory.csv";
            String probInjuryFile = filePath + "injury.csv";
            String probIllnessFile = filePath + "illness.csv";
            String probOtherProblemFile = filePath + "otherproblems.csv";
            String probSalaryClaimFile = filePath + "salaryclaim.csv";
            String probWicaFile = filePath + "wica.csv";
            String probWicClaimFile = filePath + "wicaclaim.csv";
            String probNonWicaFile = filePath + "nonwicaclaim.csv";
            String probPoliceReportFile = filePath + "policereport.csv";
            String probOtherComplaintFile = filePath + "othercomplaints.csv";
            String probCaseDiscussionFile = filePath + "casediscussion.csv";
            String probHospitalFile = filePath + "hospital.csv";
            String probMCStatusFile = filePath + "mcstatus.csv";
            String probR2RFile = filePath + "r2r.csv";
            String probLawyerFile = filePath + "lawyer.csv";
            String probCaseMileStoneNC = filePath + "casemilestonenc.csv";
            String probCaseMileStoneCR = filePath + "casemilestonecr.csv";
            String probTTRFile = filePath + "ttr.csv";
            
            HashMap<String, ArrayList<String>> errList = new HashMap<String, ArrayList<String>>();
            HashMap<String, Integer> successList = new HashMap<String, Integer>();
            
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
                                                            ProblemDAO.addProblem(worker, tmpJob, problem);
                                                            probCount++;
                                                        } else { //worker does not exit in list either
                                                            ArrayList<String> tmpList = errList.get("problem.csv");
                                                            if (tmpList == null) {
                                                                tmpList = new ArrayList<String>();
                                                            }
                                                            tmpList.add(finNum + ":" + " invaild FinNumber,");
                                                            errList.put("problem.csv", tmpList);
                                                            tmpList = errList.get("job.csv");
                                                            if (tmpList == null) {
                                                                tmpList = new ArrayList<String>();
                                                            }
                                                            tmpList.add(finNum + ":" + " invaild FinNumber,");
                                                            errList.put("job.csv", tmpList);
                                                        }
                                                    } else {
                                                        ArrayList<String> tmpList = errList.get("problem.csv");
                                                        if (tmpList == null) {
                                                            tmpList = new ArrayList<String>();
                                                        }
                                                        tmpList.add(finNum + ":" + " invaild FinNumber,");
                                                        errList.put("problem.csv", tmpList);
                                                        tmpList = errList.get("job.csv");
                                                        if (tmpList == null) {
                                                            tmpList = new ArrayList<String>();
                                                        }
                                                        tmpList.add(finNum + ":" + " invaild FinNumber,");
                                                        errList.put("job.csv", tmpList);
                                                    }     
                                                } else { //worker already exist in db
                                                    JobDAO.addJob(worker, tmpJob);
                                                    jobCount++;
                                                    ProblemDAO.addProblem(worker, tmpJob, problem); 
                                                    probCount++;
                                                }
                                                break; //get out of loop
                                            } else { //does not exist in job list
                                               ArrayList<String> tmpList = errList.get("problem.csv");
                                                if (tmpList == null) {
                                                    tmpList = new ArrayList<String>();
                                                }
                                                tmpList.add(finNum + ":" + " invalid job key or finNumber,");
                                                errList.put("problem.csv", tmpList);  
                                            }
                                        }
                                    } else { //does not exist in job list
                                       ArrayList<String> tmpList = errList.get("problem.csv");
                                        if (tmpList == null) {
                                            tmpList = new ArrayList<String>();
                                        }
                                        tmpList.add(finNum + ":" + " no job record,");
                                        errList.put("problem.csv", tmpList); 
                                    } 
                                } else {
                                    ArrayList<String> tmpList = errList.get("problem.csv");
                                    if (tmpList == null) {
                                        tmpList = new ArrayList<String>();
                                    }
                                    tmpList.add(finNum + ":" + " no job record, ");
                                    errList.put("problem.csv", tmpList);
                                }
                            } else { //job already exist in db
                                if (job.getWorkerFinNum().equals(finNum)) {
                                    Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(finNum);
                                    ProblemDAO.addProblem(worker, job, problem);
                                    probCount++;
                                } else { //job fin number & problem fin num not the same
                                    ArrayList<String> tmpList = errList.get("problem.csv");
                                    if (tmpList == null) {
                                        tmpList = new ArrayList<String>();
                                    }
                                    tmpList.add(finNum + ":" + " invalid FinNumber,");
                                    errList.put("problem.csv", tmpList);
                                }
                            } 

                        } //for each problem 
                    }//loop through problem list
                    successList.put("worker.csv", workerCount);
                    successList.put("job.csv", jobCount);
                    successList.put("problem.csv", probCount);
                    
                } else { //problem.csv? 
                    if (JobDAO.jobList != null && !JobDAO.jobList.isEmpty()) {
                        ArrayList<String> tmpList = errList.get("job.csv");
                        if (tmpList == null) {
                            tmpList = new ArrayList<String>();
                        }
                        tmpList.add("job.csv" + ":" + " no problem.csv file for new jobs,");
                        errList.put("job.csv", tmpList);
                    } else {
                        if (WorkerDAO.workerList != null && !WorkerDAO.workerList.isEmpty()) {
                            ArrayList<String> tmpList = errList.get("worker.csv");
                            if (tmpList == null) {
                                tmpList = new ArrayList<String>();
                            }
                            tmpList.add("worker.csv" + ":" + " no job.csv file for new workers,");
                            errList.put("worker.csv", tmpList);  
                        }
                    }
                }
                for (String finNum: WorkerDAO.workerList.keySet()) {
                    ArrayList<String> tmpList = errList.get("worker.csv");
                    if (tmpList == null) {
                        tmpList = new ArrayList<String>();
                    }
                    Worker worker = WorkerDAO.workerList.get(finNum);
                    if (WorkerDAO.retrieveWorkerbyFinNumber(worker.getFinNumber()) == null) {
                        tmpList.add(finNum + ":" + " no job or problem record,");
                        errList.put("worker.csv", tmpList);
                    }
                    
                }
                
                //clear static data
                WorkerDAO.workerList.clear();
                JobDAO.jobList.clear();
                ProblemDAO.problemList.clear();
                
                
                
                tmp = WorkerComplementsDAO.validateAndAddNickname(workerNickNamesFile);
                if (!tmp.isEmpty()) {
                    String str = tmp.get(tmp.size()-1);
                    successList.put(str.substring(0, str.indexOf(":")), Integer.parseInt(str.substring(str.indexOf(":")+1)));
                    tmp.remove(str);
                    if (!tmp.isEmpty()) {
                        errList.put("nickname.csv", tmp);
                    }
                }
                
                tmp = WorkerComplementsDAO.validateAndAddPassportDetails(workerPassportsFile);
                if (!tmp.isEmpty()) {
                    String str = tmp.get(tmp.size()-1);
                    successList.put(str.substring(0, str.indexOf(":")), Integer.parseInt(str.substring(str.indexOf(":")+1)));
                    tmp.remove(str);
                    if (!tmp.isEmpty()) {
                        errList.put("passport.csv", tmp);
                    }    
                }
                
                tmp = WorkerComplementsDAO.validateAndAddHomeCountryPhoneNum(workerHomeCountryPhFile);
                if (!tmp.isEmpty()) {
                    String str = tmp.get(tmp.size()-1);
                    successList.put(str.substring(0, str.indexOf(":")), Integer.parseInt(str.substring(str.indexOf(":")+1)));
                    tmp.remove(str);
                    if (!tmp.isEmpty()) {
                        errList.put("homecountryph.csv", tmp);
                    }
                }
                
                tmp = WorkerComplementsDAO.validateAndAddSgPhoneNum(workerSgPhFile);
                if (!tmp.isEmpty()) {
                    String str = tmp.get(tmp.size()-1);
                    successList.put(str.substring(0, str.indexOf(":")), Integer.parseInt(str.substring(str.indexOf(":")+1)));
                    tmp.remove(str);
                    if (!tmp.isEmpty()) {
                        errList.put("sgph.csv", tmp);
                    }
                }
                
                tmp = WorkerComplementsDAO.validateAndAddHomeCountryAddress(workerHomeCountryAddressFile );
                if (!tmp.isEmpty()) {
                    String str = tmp.get(tmp.size()-1);
                    successList.put(str.substring(0, str.indexOf(":")), Integer.parseInt(str.substring(str.indexOf(":")+1)));
                    tmp.remove(str);
                    if (!tmp.isEmpty()) {
                        errList.put("homecountryaddress.csv", tmp);
                    }
                }
                
                tmp = WorkerComplementsDAO.validateAndAddSgAddress(workerSgAddressFile );
                if (!tmp.isEmpty()) {
                    String str = tmp.get(tmp.size()-1);
                    successList.put(str.substring(0, str.indexOf(":")), Integer.parseInt(str.substring(str.indexOf(":")+1)));
                    tmp.remove(str);
                    if (!tmp.isEmpty()){
                        errList.put("sgaddress.csv", tmp);
                    }
                }
                
                tmp = WorkerComplementsDAO.validateAndAddWorkerDigitalContact(workerDigitalContactFile);
                if (!tmp.isEmpty()) {
                    String str = tmp.get(tmp.size()-1);
                    successList.put(str.substring(0, str.indexOf(":")), Integer.parseInt(str.substring(str.indexOf(":")+1)));
                    tmp.remove(str);
                    if (!tmp.isEmpty()) {
                        errList.put("digitalcontact.csv", tmp);
                    }
                }
                
                tmp = WorkerComplementsDAO.validateAndAddWorkerNextOfKin(workerNextKinFile);
                if (!tmp.isEmpty()) {
                    String str = tmp.get(tmp.size()-1);
                    successList.put(str.substring(0, str.indexOf(":")), Integer.parseInt(str.substring(str.indexOf(":")+1)));
                    tmp.remove(str);
                    if (!tmp.isEmpty()) {
                        errList.put("nextofkin.csv", tmp);
                    }
                }
                
                tmp = WorkerComplementsDAO.validateAndAddWorkerFamilyMember(workerFamilyMemberFile);
                if (!tmp.isEmpty()) {
                    String str = tmp.get(tmp.size()-1);
                    successList.put(str.substring(0, str.indexOf(":")), Integer.parseInt(str.substring(str.indexOf(":")+1)));
                    tmp.remove(str);
                    if (!tmp.isEmpty()) {
                        errList.put("familymember.csv", tmp);
                    }
                }
                
                tmp = WorkerComplementsDAO.validateAndAddWorkerFriend(workerFriendFile);
                if (!tmp.isEmpty()) {
                    String str = tmp.get(tmp.size()-1);
                    successList.put(str.substring(0, str.indexOf(":")), Integer.parseInt(str.substring(str.indexOf(":")+1)));
                    tmp.remove(str);
                    if (!tmp.isEmpty()) {
                        errList.put("friend.csv", tmp);
                    }
                }
                
                tmp = WorkerComplementsDAO.validateAndAddWorkerLanguage(workerLanguageFile);
                if (!tmp.isEmpty()) {
                    String str = tmp.get(tmp.size()-1);
                    successList.put(str.substring(0, str.indexOf(":")), Integer.parseInt(str.substring(str.indexOf(":")+1)));
                    tmp.remove(str);
                    if (!tmp.isEmpty()) {
                        errList.put("language.csv", tmp);
                    }
                }
                
                tmp = WorkerComplementsDAO.validateAndAddWorkerBankAccountDetails(workerBankAcctFile);
                if (!tmp.isEmpty()) {
                    String str = tmp.get(tmp.size()-1);
                    successList.put(str.substring(0, str.indexOf(":")), Integer.parseInt(str.substring(str.indexOf(":")+1)));
                    tmp.remove(str);
                    if (!tmp.isEmpty()) {
                        errList.put("bankacct.csv", tmp);
                    }
                }
                //job complements
                tmp = JobComplementsDAO.validateAndAddJobPassDetails(jobPassDetailsFile);
                if (!tmp.isEmpty()) {
                    String str = tmp.get(tmp.size()-1);
                    successList.put(str.substring(0, str.indexOf(":")), Integer.parseInt(str.substring(str.indexOf(":")+1)));
                    tmp.remove(str);
                    if (!tmp.isEmpty()) {
                        errList.put("passdetails.csv", tmp);
                    }
                }
                
                tmp = JobComplementsDAO.validateAndAddJobIPADetails(jobIPADetailsFile);
                if (!tmp.isEmpty()) {
                    String str = tmp.get(tmp.size()-1);
                    successList.put(str.substring(0, str.indexOf(":")), Integer.parseInt(str.substring(str.indexOf(":")+1)));
                    tmp.remove(str);
                    if (!tmp.isEmpty()) {
                        errList.put("ipa.csv", tmp);
                    }
                }
                
                tmp = JobComplementsDAO.validateAndAddJobVerbalAssurance(jobVerbalAssuranceFile);
                if (!tmp.isEmpty()) {
                    String str = tmp.get(tmp.size()-1);
                    successList.put(str.substring(0, str.indexOf(":")), Integer.parseInt(str.substring(str.indexOf(":")+1)));
                    tmp.remove(str);
                    if (!tmp.isEmpty()) {
                        errList.put("verbalassurance.csv", tmp);
                    }
                }
                
                tmp = JobComplementsDAO.validateAndAddJobEmploymentContract(jobEmploymentContractFile);
                if (!tmp.isEmpty()) {
                    String str = tmp.get(tmp.size()-1);
                    successList.put(str.substring(0, str.indexOf(":")), Integer.parseInt(str.substring(str.indexOf(":")+1)));
                    tmp.remove(str);
                    if (!tmp.isEmpty()) {
                        errList.put("employmentcontract.csv", tmp);
                    }
                }
                
                tmp = JobComplementsDAO.validateAndAddJobIntermediaryAgent(jobIntermediaryAgentFile);
                if (!tmp.isEmpty()) {
                    String str = tmp.get(tmp.size()-1);
                    successList.put(str.substring(0, str.indexOf(":")), Integer.parseInt(str.substring(str.indexOf(":")+1)));
                    tmp.remove(str);
                    if (!tmp.isEmpty()) {
                        errList.put("intermediaryagent.csv", tmp);
                    }
                }
                
                tmp = JobComplementsDAO.validateAndAddJobEmployer(jobEmployerFile);
                if (!tmp.isEmpty()) {
                    String str = tmp.get(tmp.size()-1);
                    successList.put(str.substring(0, str.indexOf(":")), Integer.parseInt(str.substring(str.indexOf(":")+1)));
                    tmp.remove(str);
                    if (!tmp.isEmpty()) {
                        errList.put("employer.csv", tmp);
                    }
                }
                
                tmp = JobComplementsDAO.validateAndAddJobWorkplace(jobWorkplaceFile);
                if (!tmp.isEmpty()) {
                    String str = tmp.get(tmp.size()-1);
                    successList.put(str.substring(0, str.indexOf(":")), Integer.parseInt(str.substring(str.indexOf(":")+1)));
                    tmp.remove(str);
                    if (!tmp.isEmpty()) {
                        errList.put("workplace.csv", tmp);
                    }
                }
                
                tmp = JobComplementsDAO.validateAndAddJobWorkHistory(jobWorkHistoryFile);
                if (!tmp.isEmpty()) {
                    String str = tmp.get(tmp.size()-1);
                    successList.put(str.substring(0, str.indexOf(":")), Integer.parseInt(str.substring(str.indexOf(":")+1)));
                    tmp.remove(str);
                    if (!tmp.isEmpty()) {
                        errList.put("workhistory.csv", tmp);
                    }
                }
                
                tmp = JobComplementsDAO.validateAndAddJobAccomodation(jobAccomodationFile);
                if (!tmp.isEmpty()) {
                    String str = tmp.get(tmp.size()-1);
                    successList.put(str.substring(0, str.indexOf(":")), Integer.parseInt(str.substring(str.indexOf(":")+1)));
                    tmp.remove(str);
                    if (!tmp.isEmpty()) {
                        errList.put("accomodation.csv", tmp);
                    }
                }
                //problem complements
            
                tmp = ProblemComplementsDAO.validateAndAddProblemAggravatingIsssue(probAggravatingIssueFile);
                if (!tmp.isEmpty()) {
                    String str = tmp.get(tmp.size()-1);
                    successList.put(str.substring(0, str.indexOf(":")), Integer.parseInt(str.substring(str.indexOf(":")+1)));
                    tmp.remove(str);
                    if (!tmp.isEmpty()) {
                        errList.put("aggravatingissue.csv", tmp);
                    }
                }
                tmp = ProblemComplementsDAO.validateAndAddLeadCaseWorker(probLeadCaseWorkerFile);
                if (!tmp.isEmpty()) {
                    String str = tmp.get(tmp.size()-1);
                    successList.put(str.substring(0, str.indexOf(":")), Integer.parseInt(str.substring(str.indexOf(":")+1)));
                    tmp.remove(str);
                    if (!tmp.isEmpty()) {
                        errList.put("leadcaseworker.csv", tmp);
                    }
                }
                tmp = ProblemComplementsDAO.validateAndAddAuxiliaryCaseWorker(probAuxiliaryCaseWorkerFile);
                if (!tmp.isEmpty()) {
                    String str = tmp.get(tmp.size()-1);
                    successList.put(str.substring(0, str.indexOf(":")), Integer.parseInt(str.substring(str.indexOf(":")+1)));
                    tmp.remove(str);
                    if (!tmp.isEmpty()) {
                        errList.put("auxiliaryworker.csv", tmp);
                    }
                }
                tmp = ProblemComplementsDAO.validateAndAddProblemSalaryRelatedHistory(probSalaryRelatedHistoryFile);
                if (!tmp.isEmpty()) {
                    String str = tmp.get(tmp.size()-1);
                    successList.put(str.substring(0, str.indexOf(":")), Integer.parseInt(str.substring(str.indexOf(":")+1)));
                    tmp.remove(str);
                    if (!tmp.isEmpty()) {
                        errList.put("salaryrelatedhistory.csv", tmp);
                    }
                }
                tmp = ProblemComplementsDAO.validateAndAddProblemInjury(probInjuryFile);
                if (!tmp.isEmpty()) {
                    String str = tmp.get(tmp.size()-1);
                    successList.put(str.substring(0, str.indexOf(":")), Integer.parseInt(str.substring(str.indexOf(":")+1)));
                    tmp.remove(str);
                    if (!tmp.isEmpty()) {
                        errList.put("injury.csv", tmp);
                    }
                }
                tmp = ProblemComplementsDAO.validateAndAddProblemIllness(probIllnessFile);
                if (!tmp.isEmpty()) {
                    String str = tmp.get(tmp.size()-1);
                    successList.put(str.substring(0, str.indexOf(":")), Integer.parseInt(str.substring(str.indexOf(":")+1)));
                    tmp.remove(str);
                    if (!tmp.isEmpty()) {
                        errList.put("illness.csv", tmp);
                    }
                }
                tmp = ProblemComplementsDAO.validateAndAddProblemOtherProblems(probOtherProblemFile);
                if (!tmp.isEmpty()) {
                    String str = tmp.get(tmp.size()-1);
                    successList.put(str.substring(0, str.indexOf(":")), Integer.parseInt(str.substring(str.indexOf(":")+1)));
                    tmp.remove(str);
                    if (!tmp.isEmpty()) {
                        errList.put("otherproblems.csv", tmp);
                    }
                }
                tmp = ProblemComplementsDAO.validateAndAddProblemSalaryClaim(probSalaryClaimFile);
                if (!tmp.isEmpty()) {
                    String str = tmp.get(tmp.size()-1);
                    successList.put(str.substring(0, str.indexOf(":")), Integer.parseInt(str.substring(str.indexOf(":")+1)));
                    tmp.remove(str);
                    if (!tmp.isEmpty()) {
                        errList.put("salaryclaim.csv", tmp);
                    }
                }
                tmp = ProblemComplementsDAO.validateAndAddProblemWica(probWicaFile);
                if (!tmp.isEmpty()) {
                    String str = tmp.get(tmp.size()-1);
                    successList.put(str.substring(0, str.indexOf(":")), Integer.parseInt(str.substring(str.indexOf(":")+1)));
                    tmp.remove(str);
                    if (!tmp.isEmpty()) {
                        errList.put("wica.csv", tmp);
                    }
                }
                tmp = ProblemComplementsDAO.validateAndAddProblemWicaClaim(probWicClaimFile);
                if (!tmp.isEmpty()) {
                    String str = tmp.get(tmp.size()-1);
                    successList.put(str.substring(0, str.indexOf(":")), Integer.parseInt(str.substring(str.indexOf(":")+1)));
                    tmp.remove(str);
                    if (!tmp.isEmpty()) {
                        errList.put("wicaclaim.csv", tmp);
                    }
                }
                tmp = ProblemComplementsDAO.validateAndAddProblemNonWicaClaim(probNonWicaFile);
                if (!tmp.isEmpty()) {
                    String str = tmp.get(tmp.size()-1);
                    successList.put(str.substring(0, str.indexOf(":")), Integer.parseInt(str.substring(str.indexOf(":")+1)));
                    tmp.remove(str);
                    if (!tmp.isEmpty()) {
                        errList.put("nonwicaclaim.csv", tmp);
                    }
                }
                tmp = ProblemComplementsDAO.validateAndAddProblemPoliceReport(probPoliceReportFile);
                if (!tmp.isEmpty()) {
                    String str = tmp.get(tmp.size()-1);
                    successList.put(str.substring(0, str.indexOf(":")), Integer.parseInt(str.substring(str.indexOf(":")+1)));
                    tmp.remove(str);
                    if (!tmp.isEmpty()) {
                        errList.put("policereport.csv", tmp);
                    }
                }
                tmp = ProblemComplementsDAO.validateAndAddProblemOtherComplaints(probOtherComplaintFile);
                if (!tmp.isEmpty()) {
                    String str = tmp.get(tmp.size()-1);
                    successList.put(str.substring(0, str.indexOf(":")), Integer.parseInt(str.substring(str.indexOf(":")+1)));
                    tmp.remove(str);
                    if (!tmp.isEmpty()) {
                        errList.put("othercomplaints.csv", tmp);
                    }
                }
                tmp = ProblemComplementsDAO.validateAndAddProblemCaseDiscussions(probCaseDiscussionFile);
                if (!tmp.isEmpty()) {
                    String str = tmp.get(tmp.size()-1);
                    successList.put(str.substring(0, str.indexOf(":")), Integer.parseInt(str.substring(str.indexOf(":")+1)));
                    tmp.remove(str);
                    if (!tmp.isEmpty()) {
                        errList.put("casediscussion.csv", tmp);
                    }
                }
                tmp = ProblemComplementsDAO.validateAndAddProblemHospital(probHospitalFile);
                if (!tmp.isEmpty()) {
                    String str = tmp.get(tmp.size()-1);
                    successList.put(str.substring(0, str.indexOf(":")), Integer.parseInt(str.substring(str.indexOf(":")+1)));
                    tmp.remove(str);
                    if (!tmp.isEmpty()) {
                        errList.put("hospital.csv", tmp);
                    }
                }
                tmp = ProblemComplementsDAO.validateAndAddProblemMCStatus(probMCStatusFile);
                if (!tmp.isEmpty()) {
                    String str = tmp.get(tmp.size()-1);
                    successList.put(str.substring(0, str.indexOf(":")), Integer.parseInt(str.substring(str.indexOf(":")+1)));
                    tmp.remove(str);
                    if (!tmp.isEmpty()) {
                        errList.put("mcstatus.csv", tmp);
                    }
                }
                tmp = ProblemComplementsDAO.validateAndAddProblemR2R(probR2RFile);
                if (!tmp.isEmpty()) {
                    String str = tmp.get(tmp.size()-1);
                    successList.put(str.substring(0, str.indexOf(":")), Integer.parseInt(str.substring(str.indexOf(":")+1)));
                    tmp.remove(str);
                    if (!tmp.isEmpty()) {
                        errList.put("r2r.csv", tmp);
                    }
                }
                tmp = ProblemComplementsDAO.validateAndAddProblemLawyer(probLawyerFile);
                if (!tmp.isEmpty()) {
                    String str = tmp.get(tmp.size()-1);
                    successList.put(str.substring(0, str.indexOf(":")), Integer.parseInt(str.substring(str.indexOf(":")+1)));
                    tmp.remove(str);
                    if (!tmp.isEmpty()) {
                        errList.put("lawyer.csv", tmp);
                    }
                }
                tmp = ProblemComplementsDAO.validateAndAddProblemCaseMilestoneNC(probCaseMileStoneNC);
                if (!tmp.isEmpty()) {
                    String str = tmp.get(tmp.size()-1);
                    successList.put(str.substring(0, str.indexOf(":")), Integer.parseInt(str.substring(str.indexOf(":")+1)));
                    tmp.remove(str);
                    if (!tmp.isEmpty()) {
                        errList.put("casemilestonenc.csv", tmp);
                    }
                }
                tmp = ProblemComplementsDAO.validateAndAddProblemCaseMilestoneCR(probCaseMileStoneCR);
                if (!tmp.isEmpty()) {
                    String str = tmp.get(tmp.size()-1);
                    successList.put(str.substring(0, str.indexOf(":")), Integer.parseInt(str.substring(str.indexOf(":")+1)));
                    tmp.remove(str);
                    if (!tmp.isEmpty()) {
                        errList.put("casemilestonecr.csv", tmp);
                    }
                }
                tmp = ProblemComplementsDAO.validateAndAddProblemTTR(probTTRFile);
                if (!tmp.isEmpty()) {
                    String str = tmp.get(tmp.size()-1);
                    successList.put(str.substring(0, str.indexOf(":")), Integer.parseInt(str.substring(str.indexOf(":")+1)));
                    tmp.remove(str);
                    if (!tmp.isEmpty()) {
                        errList.put("ttr.csv", tmp);
                    }
                }
                
                request.getSession().setAttribute("bootstrapResult", errList);
                request.getSession().setAttribute("successList", successList);
                
                response.sendRedirect("importexport.jsp");
            } catch (IOException ex) {
                out.println("Bootstrap Failed - File IO exception occured: " + ex.getMessage());
                return;
            } catch (Exception ex) {
                out.println("Bootstrap Failed - Validation exception occured: " + ex);
                return;
            }
            
            
                        
            
        } catch (Exception ex) {
            
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
