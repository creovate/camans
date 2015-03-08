<%-- 
    Document   : referCase
    Created on : Dec 29, 2014, 11:56:13 AM
    Author     : Nyein Su
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="camans.entity.*"%>
<%@page import="camans.dao.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
    String workerFin = request.getParameter("workerFin");
    String jobKeyStr = request.getParameter("jobkey");
    String probKeyStr = request.getParameter("probkey");
    String referredByNRIC = request.getParameter("user");
    java.util.Date today = new java.util.Date();
    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");

    Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(workerFin);
    int jobKey = Integer.parseInt(jobKeyStr);
    int probKey = Integer.parseInt(probKeyStr);

    Job job = JobDAO.retrieveJobByJobId(jobKey);
    Problem problem = ProblemDAO.retrieveProblemByProblemId(probKey);

    String workerName = worker.getName();

    /**
     * Get Phone Number *
     */
    ArrayList<Integer> phNumIdList = WorkerComplementsDAO.retrieveSgCountryPhoneNumIdsOfWorker(worker);
    String sgPhone = "";
    if (phNumIdList.size() > 0) {
        WorkerSgPhNum sgPhNumObj = WorkerComplementsDAO.retrieveWorkerSgPhNumById(phNumIdList.get(phNumIdList.size() - 1));
        sgPhone = sgPhNumObj.getPhNumber();
    }

    /**
     * Get Employer name *
     */
    ArrayList<Integer> empIdList = JobComplementsDAO.retrieveJobEmployerIdsOfJob(job);
    String empName = "";
    if (empIdList.size() > 0) {
        JobEmployer empObj = JobComplementsDAO.retrieveJobEmployerById(empIdList.size() - 1);
        empName = empObj.getEmployerOfficialName();
    }

    /**
     * Get Problem type *
     */
    String problemType = problem.getProblem();

    User referredByUser = UserDAO.retrieveUserByNRIC(referredByNRIC);
    String referredByName = referredByUser.getFullName();


%>
<script>
    $('.cancel_btn').click(function() {
        $('#pop_up_content').dialog("destroy");
        $('#pop_up_content').empty();
    });

    $(function() {
        $(".date_input").datepicker({
            dateFormat: 'dd-M-yy',
            changeMonth: true,
            changeYear: true
        });

    });

    //for date inputs
    $(document).ready(function() {
        $('.date_input').focus(function() {
            $('.date_input').blur();

        });
        $('.no_change').focus(function() {
            $('.no_change').blur();
        });
    });
</script>
<form method="POST" action="referCase.do"  id='caseReferral_form' class="form" >

    <div class='form-group'>
        <label for='refDate' id="refDate_lbl" class="control-label">Referred Date<span style="color: red">*</span>:</label>
        <br/>
        <input class="form-control no_change" type='text' name="refDate" value="<%=sdf.format(today)%>">
    </div>
    <div class='form-group'>
        <label for='workerName' id="workerName_lbl" class="control-label">Name of Worker<span style="color: red">*</span>: </label>
        <br/>
        <input class="form-control no_change" type='text' name="workerName" value="<%=workerName%>">
    </div>
    <div class='form-group'>
        <label for='workerName' id="workerFin_lbl" class="control-label">Worker FIN Number<span style="color: red">*</span>: </label>
        <br/>
        <input class="form-control no_change" type='text' name="workerFin" value="<%=workerFin%>">
    </div>
    <div class='form-group'>
        <label for='phNum' class="control-label" id="phNum_lbl">Worker Phone Number: </label>
        <br/>
        <input class="form-control no_change" type='text' name="phNum" value="<%=sgPhone%>">
    </div>
    <div class='form-group'>
        <label for='empName' id="empName_lbl" class="control-label">Employer Name: </label>
        <br/>
        <input class="form-control no_change" type='text' name="empName" value="<%=empName%>">
    </div>
    <div class='form-group'>
        <label for='probType' id="probType_lbl" class="control-label">Problem: </label>
        <br/>
        <input class="form-control no_change" type='text' name="probType" value="<%=problemType%>">
    </div>
    <div class='form-group'>
        <label for='refDesc' class="control-label">Description: </label>
        <br/>
        <textarea class='form-control' row='3' name="refDesc"></textarea>
    </div>
    <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
    <input type="hidden" name="probkey" value="<%=probKey%>"/>
    <input type="hidden" name="referredBy" value="<%=referredByNRIC%>"/>
    <div class="form-group btn_group">
        <button type='submit' class="btn btn-blue modal_btn ">Refer</button>
        <button type='button' class='btn modal_btn pull-right cancel_btn'>Cancel</button>

    </div>
</form>