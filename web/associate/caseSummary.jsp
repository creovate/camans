<%-- 
    Document   : caseSummary
    Created on : Mar 3, 2015, 9:36:23 PM
    Author     : Nyein Su
--%>

<%@page import="camans.dao.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="camans.entity.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
    java.util.Date today = new java.util.Date();

    User userLogin = (User) request.getSession().getAttribute("userLogin");

    String workerFin = request.getParameter("workerFin");
    String jobKeyStr = request.getParameter("selectedJob");
    int jobKey = Integer.parseInt(jobKeyStr);
    String probKeyStr = request.getParameter("selectedProb");
    int probKey = Integer.parseInt(probKeyStr);

    Worker selectedWorker = WorkerDAO.retrieveWorkerbyFinNumber(workerFin);
    Job selectedJob = JobDAO.retrieveJobByJobId(jobKey);
    Problem selectedProblem = ProblemDAO.retrieveProblemByProblemId(probKey);

    //retrieve worker data
    java.util.Date regDate;
    String createdBy;
    String name;
    String gender;
    String nationality;
    java.util.Date dob;
    String phNum;

    if (selectedWorker != null) {
        regDate = selectedWorker.getRegistrationDate();
        createdBy = selectedWorker.getCreatedBy();
        name = selectedWorker.getName();
        gender = selectedWorker.getGender();
        nationality = selectedWorker.getNationality();
        dob = selectedWorker.getDateOfBirth();

        ArrayList<Integer> sgPhList = WorkerComplementsDAO.retrieveSgCountryPhoneNumIdsOfWorker(selectedWorker);
        if (sgPhList != null && sgPhList.size() > 0) {
            WorkerSgPhNum sgPh = WorkerComplementsDAO.retrieveWorkerSgPhNumById(sgPhList.get(sgPhList.size() - 1));
            phNum = sgPh.getPhNumber();
        }

    }


    //retrieve job data
    String employer;
    String workpass;
    String jobStart;

    String currentPassType;
    String currentPassNumber;
    java.util.Date currentPassIsDate;

    if (selectedJob != null) {
        employer = selectedJob.getEmployerName();
        workpass = selectedJob.getWorkPassType();
        jobStart = selectedJob.getJobStartDate();

        ArrayList<Integer> passList = JobComplementsDAO.retrievePassDetailsIdsOfJob(selectedJob);
        if (passList != null && passList.size() > 0) {
            int passId = passList.get(passList.size() - 1);
            JobPassDetails currentPass = JobComplementsDAO.retrieveJobPassDetailsById(passId);

            currentPassType = currentPass.getPassType();
            currentPassNumber = currentPass.getPassNum();
            currentPassIsDate = currentPass.getIssueDate();
        }
        
    }

    java.util.Date probRegDate;
    String problemType;

    java.util.Date injuryDate;
    String injuryBodyPart;
    
    String hospitalName;
    String hospitalMore;
    
    String lawFirm;
    String lawFirmMore;

    String lcw;
    String acw;
    String wicaStatus;
    String wicaStatusMore;
    java.util.Date wicaUpdate;


    if (selectedProblem != null) {
        probRegDate = selectedProblem.getProblemRegisteredDate();
        problemType = selectedProblem.getProblem();
        
        ArrayList<Integer> injuryIdList = ProblemComplementsDAO.retrieveProblemInjuryIdsOfProblem(selectedProblem);
        if(injuryIdList != null && injuryIdList.size() > 0){
            int injuryId = injuryIdList.get(injuryIdList.size()-1);
            ProblemInjury injury = ProblemComplementsDAO.retrieveProblemInjuryById(injuryId);
            injuryDate = injury.getInjuryDate();
            injuryBodyPart = injury.getInjuryBodyPart();
        }
        
        ArrayList<Integer> hospitalIdList = ProblemComplementsDAO.retrieveProblemHospitalIdsOfProblem(selectedProblem);
        if(hospitalIdList != null && hospitalIdList.size() > 0){
            int hospitalId = hospitalIdList.get(hospitalIdList.size()-1);
            ProblemHospital hospital = ProblemComplementsDAO.retrieveProblemHospitalById(hospitalId);
            hospitalName = hospital.getHospitalName();
            hospitalMore = hospital.getHospitalNameMore();
        }
        
        ArrayList<Integer> lawFirmList = ProblemComplementsDAO.retrieveProblemLawyerIdsOfProblem(selectedProblem);
        

    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!--css-->
        <link rel="stylesheet" href="../css/bootstrap.css" media="screen" />
        <link rel="stylesheet" href="../css/custom.css" media="screen" /> 
        <link rel="stylesheet" href="../css/jquery-ui-1.9.2.custom.css">
        <link rel="stylesheet" href="../css/jquery-ui.structure.css">
        <link rel="stylesheet" href="../css/jquery-ui.theme.css">
        <!-------------->

        <!--javascript-->
        <script src="../js/jquery-2.1.1.js"></script>
        <script src="../js/bootstrap.min.js"></script>
        <script src="../js/jquery-ui-1.9.2.custom.js"></script>
        <!------------->

        <!--tab icon-->
        <link rel="shortcut icon" href="../img/twc_logo.png">

        <!--page title-->
        <title>CAMANS</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
