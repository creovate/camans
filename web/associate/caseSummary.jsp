<%-- 
    Document   : caseSummary
    Created on : Mar 3, 2015, 9:36:23 PM
    Author     : Nyein Su
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="camans.dao.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="camans.entity.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ include file="../protect.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
    java.util.Date today = new java.util.Date();
    DecimalFormat df = new DecimalFormat("#,###,##0.00");

    User userLogin = (User) request.getSession().getAttribute("userLogin");


    String workerFin = (String) request.getSession().getAttribute("worker");
    request.getSession().removeAttribute("worker");
    if (workerFin == null || workerFin.equals("")) {
        workerFin = request.getParameter("worker");
    }

    String jobKeyStr = (String) request.getSession().getAttribute("selectedJob");
    request.getSession().removeAttribute("selectedJob");
    if (jobKeyStr == null || jobKeyStr.equals("")) {
        jobKeyStr = request.getParameter("selectedJob");
    }

    String probKeyStr = (String) request.getSession().getAttribute("selectedProb");
    request.getSession().removeAttribute("selectedProb");
    if (probKeyStr == null || probKeyStr.equals("")) {
        probKeyStr = request.getParameter("selectedProb");
    }

    if (probKeyStr != null) {
        int selectedProbId = Integer.parseInt(probKeyStr);
        Problem tempProblem = ProblemDAO.retrieveProblemByProblemId(selectedProbId);
        jobKeyStr = tempProblem.getJobKey() + "";
    }

    int jobKey = Integer.parseInt(jobKeyStr);
    int probKey = Integer.parseInt(probKeyStr);

    Worker selectedWorker = WorkerDAO.retrieveWorkerbyFinNumber(workerFin);
    Job selectedJob = JobDAO.retrieveJobByJobId(jobKey);
    Problem selectedProblem = ProblemDAO.retrieveProblemByProblemId(probKey);

    //retrieve worker data
    java.util.Date regDate = null;
    String createdBy = "";
    String name = "";
    String gender = "";
    String nationality = "";
    java.util.Date dob = null;
    String phNum = "";

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
    String employer = "";
    String workpass = "";
    String jobStart = "";

    String currentPassType = "";
    String currentPassNumber = "";
    java.util.Date currentPassIsDate = null;

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

    java.util.Date probRegDate = null;
    String problemType = "";

    java.util.Date injuryDate = null;
    String injuryBodyPart = "";

    String hospitalName = "";
    String hospitalMore = "";

    String lawFirm = "";
    String lawFirmMore = "";

    String lcw = "";
    String acw = "";
    String wicaStatus = "";
    String wicaStatusMore = "";
    java.util.Date wicaDate = null;
    double wicaPoint = 0.0;
    double wicaAmt = 0.0;
    String wicaRemark = "";

    String ncmReached = "";
    java.util.Date ncmDate = null;
    String ncmReachedMore = "";

    String ttrStatus = "";
    String ttrStatusMore = "";
    java.util.Date ttrDate = null;
    String ttrDeptDate = "";

    if (selectedProblem != null) {
        probRegDate = selectedProblem.getProblemRegisteredDate();
        problemType = selectedProblem.getProblem();

        ArrayList<Integer> injuryIdList = ProblemComplementsDAO.retrieveProblemInjuryIdsOfProblem(selectedProblem);
        if (injuryIdList != null && injuryIdList.size() > 0) {
            int injuryId = injuryIdList.get(injuryIdList.size() - 1);
            ProblemInjury injury = ProblemComplementsDAO.retrieveProblemInjuryById(injuryId);
            injuryDate = injury.getInjuryDate();
            injuryBodyPart = injury.getInjuryBodyPart();
        }

        ArrayList<Integer> hospitalIdList = ProblemComplementsDAO.retrieveProblemHospitalIdsOfProblem(selectedProblem);
        if (hospitalIdList != null && hospitalIdList.size() > 0) {
            int hospitalId = hospitalIdList.get(hospitalIdList.size() - 1);
            ProblemHospital hospital = ProblemComplementsDAO.retrieveProblemHospitalById(hospitalId);
            hospitalName = hospital.getHospitalName();
            hospitalMore = hospital.getHospitalNameMore();
        }

        ArrayList<Integer> lawFirmList = ProblemComplementsDAO.retrieveProblemLawyerIdsOfProblem(selectedProblem);
        if (lawFirmList != null && lawFirmList.size() > 0) {
            int lawFirmId = lawFirmList.get(lawFirmList.size() - 1);
            ProblemLawyer lawyer = ProblemComplementsDAO.retrieveProblemLawyerById(lawFirmId);
            lawFirm = lawyer.getLawyerFirm();
            lawFirmMore = lawyer.getLawyerFirmMore();
        }

        lcw = selectedProblem.getcurrentLeadCaseWorker();

        ArrayList<Integer> acwIdList = ProblemComplementsDAO.retrieveProblemAuxiliaryCaseWorkerIdsOfProblem(selectedProblem);
        if (acwIdList != null && acwIdList.size() > 0) {
            int acwId = acwIdList.get(acwIdList.size() - 1);
            ProblemAuxiliaryCaseWorker acwObject = ProblemComplementsDAO.retrieveProblemAuxiliaryCaseWorkerById(acwId);
            acw = acwObject.getAuxName();
        }

        ArrayList<Integer> wicaList = ProblemComplementsDAO.retrieveWicaIdsOfProblem(selectedProblem);
        if (wicaList != null && wicaList.size() > 0) {
            int wicaId = wicaList.get(wicaList.size() - 1);
            ProblemWica wica = ProblemComplementsDAO.retrieveProblemWicaById(wicaId);
            wicaDate = wica.getWicaMonthlyUpdate();
            wicaStatus = wica.getWicaMonthlyStatus();
            wicaStatusMore = wica.getWicaMonthlyStatusMore();
            wicaPoint = wica.getWicaMonthlyPoints();
            wicaAmt = wica.getWicaMonthlyDollars();
            wicaRemark = wica.getWicaMonthlyRemarks();
        }

        ArrayList<Integer> ncmIdList = ProblemComplementsDAO.retrieveProblemCaseMilestoneNCIdsOfProblem(selectedProblem);
        if (ncmIdList != null && ncmIdList.size() > 0) {
            int ncmId = ncmIdList.get(ncmIdList.size() - 1);
            ProblemCaseMilestoneNC ncm = ProblemComplementsDAO.retrieveProblemCaseMilestoneNCById(ncmId);
            ncmReached = ncm.getMilesNCReached();
            ncmReachedMore = ncm.getMilesNCReachedMore();
            ncmDate = ncm.getMilesNCDate();
        }

        ArrayList<Integer> ttrIdList = ProblemComplementsDAO.retrieveProblemTTRIdsOfProblem(selectedProblem);
        if (ttrIdList != null && ttrIdList.size() > 0) {
            int ttrId = ttrIdList.get(ttrIdList.size() - 1);
            ProblemTTR ttr = ProblemComplementsDAO.retrieveProblemTTRById(ttrId);
            ttrStatus = ttr.getTTRStatus();
            ttrStatusMore = ttr.getTTRStatusMore();
            ttrDate = ttr.getTTRUpdate();
            ttrDeptDate = ttr.getDepartureDate();
        }
    }

    //worker complement
    String successMsg = (String) request.getSession().getAttribute("successWrkCompMsg");
    request.getSession().removeAttribute("successWrkCompMsg");

    String errorMsg = (String) request.getSession().getAttribute("errorWrkCompMsg");
    request.getSession().removeAttribute("errorWrkCompMsg");

    //job complement
    if (successMsg == null || successMsg.equals("")) {
        successMsg = (String) request.getSession().getAttribute("successJobCompMsg");
        request.getSession().removeAttribute("successJobCompMsg");
    }

    if (errorMsg == null || errorMsg.equals("")) {
        errorMsg = (String) request.getSession().getAttribute("errorJobCompMsg");
        request.getSession().removeAttribute("errorJobCompMsg");
    }

    //problem complement
    if (successMsg == null || successMsg.equals("")) {
        successMsg = (String) request.getSession().getAttribute("successProbCompMsg");
        request.getSession().removeAttribute("successProbCompMsg");
    }

    if (errorMsg == null || errorMsg.equals("")) {
        errorMsg = (String) request.getSession().getAttribute("errorProbCompMsg");
        request.getSession().removeAttribute("errorProbCompMsg");
    }

    //problem complement
    if (successMsg == null || successMsg.equals("")) {
        successMsg = (String) request.getSession().getAttribute("successMsg");
        request.getSession().removeAttribute("successMsg");
    }

    if (errorMsg == null || errorMsg.equals("")) {
        errorMsg = (String) request.getSession().getAttribute("errorMsg");
        request.getSession().removeAttribute("errorMsg");
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!--css-->
        <link rel="stylesheet" href="../css/bootstrap.css" media="screen" />
        <link rel="stylesheet" href="../css/custom.css" media="screen" /> 
        <link rel="stylesheet" href="../css/jquery-ui-1.9.2.custom.css">
        <link rel="stylesheet" href="../css/jquery-ui.structure.css">
        <link rel="stylesheet" href="../css/jquery-ui.theme.css">
        <link rel="stylesheet" href="../css/bootstrapValidator.min.css"/>
        <!-------------->

        <!--javascript-->
        <script src="../js/jquery-2.1.1.js"></script>
        <script src="../js/bootstrap.min.js"></script>
        <script src="../js/jquery-ui-1.9.2.custom.js"></script>
        <script type="text/javascript" src="../js/bootstrapValidator.min.js"></script>   
        <!------------->

        <!--tab icon-->
        <link rel="shortcut icon" href="../img/twc_logo.png">

        <!--page title-->
        <title>CAMANS</title>

        <style>
            .lbl{
                color: #006c9a;
            }
            a {
                color: black;
                text-decoration: none;
            }

            a:hover 
            {
                color:black; 
                text-decoration:none; 
            }
            .alert{
                position: absolute;
                z-index: 999;
                top: 18vh;
            }
        </style>
        <script>
            function goBack() {
                window.history.back();
            }
            $(document).ready(function() {
                $('.alert').fadeOut(9999);
            })
        </script>
    </head>
    <body>
        <!-- Nav Bar -->
        <jsp:include page="navbar.jsp"/>
        <!-- End of Nav Bar-->

        <% if (successMsg != null) {
                if (!successMsg.equals("")) {%>

        <div class="alert alert-info col-xs-offset-1 col-xs-10" role="alert">
            <a style="cursor:pointer" class="close" data-dismiss="alert">&times;</a>
            <%=successMsg%>
        </div>

        <% }
            }
            if (errorMsg != null) {
                if (!errorMsg.equals("")) {%>

        <div class="alert alert-danger" role="alert">
            <a style="cursor:pointer" class="close" data-dismiss="alert">&times;</a>
            <%=errorMsg%>
        </div>

        <% }
            }%>
        <br/>
        <!-- Case Summary -->
        <div class="col-xs-12 col-md-offset-2 col-md-8 col-sm-offset-2 col-sm-8">
            <h4 style="color:#006c9a">Case Summary</h4>
            <table class="table table-borderless col-md-12 col-xs-12">
                <tr>
                    <td class="lbl">Registration date:</td>
                    <td class="value"><%=(regDate == null) ? "" : sdf.format(regDate)%></td>
                </tr>
                <tr>
                    <td class="lbl">Created by:</td>
                    <td class="value"><%=createdBy%></td>
                </tr>
                <tr>
                    <td class="lbl">Worker's Name:</td>
                    <td class="value"><%=name%></td>
                </tr>
                <tr>
                    <td class="lbl">FIN:</td>
                    <td class="value"><%=workerFin%></td>
                </tr>
                <tr>
                    <td class="lbl">Gender:</td>
                    <td class="value"><%=gender%></td>
                </tr>
                <tr>
                    <td class="lbl">Nationality:</td>
                    <td class="value"><%=nationality%></td>
                </tr>
                <tr>
                    <td class="lbl">Date of birth:</td>
                    <td class="value"><%=(dob == null) ? "" : sdf.format(dob)%></td>
                </tr>
                <tr><td></td><td></td></tr>
                <tr>
                    <td class="lbl">Phone:</td>
                    <td class="value"><%=phNum%>
                        <a href="addComplements.jsp?workerFin=<%=workerFin%>&selectedJob=<%=jobKeyStr%>&selectedProb=<%=probKeyStr%>&complement=sgPhone&action=add" title='Add phone number'><span class='glyphicon glyphicon-plus pull-right'></span></a>
                    </td>
                </tr>
                <tr><td></td><td></td></tr>
                <tr>
                    <td class="lbl">Employer:</td>
                    <td class="value"><%=employer%></td>
                </tr>
                <tr>
                    <td class="lbl">Workpass type:</td>
                    <td class="value"><%=workpass%></td>
                </tr>
                <tr>
                    <td class="lbl">When started this job?:</td>
                    <td class="value"><%=jobStart%></td>
                </tr>
                <tr><td></td><td></td></tr>
                <tr>
                    <td class="lbl">Current pass type:</td>
                    <td class="value"><%=currentPassType%>
                        <a href="addComplements.jsp?workerFin=<%=workerFin%>&selectedJob=<%=jobKeyStr%>&selectedProb=<%=probKeyStr%>&complement=passType&action=add" title='Add current pass'><span class='glyphicon glyphicon-plus pull-right'></span></a>
                    </td>
                </tr>
                <tr>
                    <td class="lbl">Current pass number:</td>
                    <td class="value"><%=currentPassNumber%></td>
                </tr>
                <tr>
                    <td class="lbl">Current pass issue date:</td>
                    <td class="value"><%=(currentPassIsDate == null) ? "" : sdf.format(currentPassIsDate)%></td>
                </tr>
                <tr><td></td><td></td></tr>
                <tr>
                    <td class="lbl">Problem reg date:</td>
                    <td class="value"><%=(probRegDate == null) ? "" : sdf.format(probRegDate)%></td>
                </tr>
                <tr>
                    <td class="lbl">Problem:</td>
                    <td class="value"><%=problemType%></td>
                </tr>
                <tr><td></td><td></td></tr>
                <tr>
                    <td class="lbl">Date of injury:</td>
                    <td class="value"><%=(injuryDate == null) ? "" : sdf.format(injuryDate)%></td>
                </tr>
                <tr>
                    <td class="lbl">Body part(s) injured:</td>
                    <td class="value"><%=injuryBodyPart%></td>
                </tr>
                <tr>
                    <td class="lbl">Current hospital:</td>
                    <td class="value"><%=hospitalName%>
                        <a href="addComplements.jsp?workerFin=<%=workerFin%>&selectedJob=<%=jobKeyStr%>&selectedProb=<%=probKeyStr%>&complement=hospital&action=add" title='Add hospital'><span class='glyphicon glyphicon-plus pull-right'></span></a>
                    </td>
                </tr>
                <tr>
                    <td class="lbl">Explain if above is 'Other':</td>
                    <td class="value"><%=hospitalMore%></td>
                </tr>
                <tr>
                    <td class="lbl">Current law firm:</td>
                    <td class="value"><%=lawFirm%>
                        <a href="addComplements.jsp?workerFin=<%=workerFin%>&selectedJob=<%=jobKeyStr%>&selectedProb=<%=probKeyStr%>&complement=lawFirm&action=add" title='Add law firm'><span class='glyphicon glyphicon-plus pull-right'></span></a>
                    </td>
                </tr>
                <tr>
                    <td class="lbl">Explain if above is 'Other':</td>
                    <td class="value"><%=lawFirmMore%></td>
                </tr>
                <tr><td></td><td></td></tr>
                <tr>
                    <td class="lbl">Lead caseworker:</td>
                    <td class="value"><%=(lcw == null) ? "" : lcw%>
                        <button class='btn btn-blue btn-sm pull-right' onclick="window.location = 'addComplements.jsp?workerFin=<%=workerFin%>&selectedJob=<%=jobKeyStr%>&selectedProb=<%=probKeyStr%>&complement=refer';">Refer</button>
                    </td>
                </tr>
                <tr>
                    <td class="lbl">Auxiliary caseworker:</td>
                    <td class="value"><%=acw%></td>
                </tr>
                <tr>
                    <td class="lbl">Wica status:</td>
                    <td class="value"><%=wicaStatus%>
                        <a href="addComplements.jsp?workerFin=<%=workerFin%>&selectedJob=<%=jobKeyStr%>&selectedProb=<%=probKeyStr%>&complement=wicaStatus&action=add" title='Add wica status'><span class='glyphicon glyphicon-plus pull-right'></span></a>
                    </td>
                </tr>
                <tr>
                    <td class="lbl">Explain if above is 'Other':</td>
                    <td class="value"><%=wicaStatusMore%></td>
                </tr>
                <tr>
                    <td class="lbl">Wica update date:</td>
                    <td class="value"><%=(wicaDate == null) ? "" : wicaDate%></td>
                </tr>
                <tr>
                    <td class="lbl">Wica points:</td>
                    <td class="value"><%=df.format(wicaPoint)%></td>
                </tr>
                <tr>
                    <td class="lbl">Wica $:</td>
                    <td class="value"><%=df.format(wicaAmt)%></td>
                </tr>
                <tr>
                    <td class="lbl">Wica remarks:</td>
                    <td class="value"><%=wicaRemark%></td>
                </tr>
                <tr>
                    <td class="lbl">Milestone reached:</td>
                    <td class="value"><%=ncmReached%>
                        <a href="addComplements.jsp?workerFin=<%=workerFin%>&selectedJob=<%=jobKeyStr%>&selectedProb=<%=probKeyStr%>&complement=ncm&action=add" title='Add case milestone'><span class='glyphicon glyphicon-plus pull-right'></span></a>
                    </td>
                </tr>
                <tr>
                    <td class="lbl">Milestone update date:</td>
                    <td class="value"><%=(ncmDate == null) ? "" : sdf.format(ncmDate)%></td>
                </tr>
                <tr>
                    <td class="lbl">Explain if above is 'Other':</td>
                    <td class="value"><%=ncmReachedMore%></td>
                </tr>
                <tr>
                    <td class="lbl">TTR status:</td>
                    <td class="value"><%=ttrStatus%>
                        <a href="addComplements.jsp?workerFin=<%=workerFin%>&selectedJob=<%=jobKeyStr%>&selectedProb=<%=probKeyStr%>&complement=ttr&action=add" title='Add TTR'><span class='glyphicon glyphicon-plus pull-right'></span></a>
                    </td>
                </tr>
                <tr>
                    <td class="lbl">Explain if above is 'Other':</td>
                    <td class="value"><%=ttrStatusMore%></td>
                </tr>
                <tr>
                    <td class="lbl">TTR update date:</td>
                    <td class="value"><%=(ttrDate == null) ? "" : sdf.format(ttrDate)%></td>
                </tr>
                <tr>
                    <td class="lbl">Departure date:</td>
                    <td class="value"><%=ttrDeptDate%></td>
                </tr>
            </table>
            <button type='button' class='btn input-sm pull-right' style="margin-right: 5%;" onclick="goBack()">Back</button>
            <br/>
        </div>
    </body>
</html>
