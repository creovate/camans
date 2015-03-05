<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.HashMap"%>
<%@page import="camans.dao.*"%>
<%@page import="camans.entity.*"%>
<%@page import="java.util.ArrayList"%>
<%@ include file="/protect.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Job latestJob = null;
    Problem latestProblem = null;
    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
    java.util.Date today = new java.util.Date();
    User userLogin = (User) request.getSession().getAttribute("userLogin");

    //for search result
    ArrayList<Worker> searchWorkers = (ArrayList<Worker>) request.getSession().getAttribute("searchWorkers");
    request.getSession().removeAttribute("searchWorkers");

    Worker worker = null;

    String workerName = "";
    String workerFin = "";
    if (searchWorkers != null && searchWorkers.size() > 0) {
        worker = searchWorkers.get(0);


    }
    String fin = (String) request.getSession().getAttribute("fin");
    request.getSession().removeAttribute("fin");
    if (fin != null && !fin.equals("")) {
        worker = WorkerDAO.retrieveWorkerbyFinNumber(fin);
    }

    String workerFinNum = (String) request.getSession().getAttribute("worker");
    request.getSession().removeAttribute("worker");
    if (workerFinNum != null && !workerFinNum.equals("")) {
        worker = WorkerDAO.retrieveWorkerbyFinNumber(workerFinNum);
    }

    String selectedJob = (String) request.getSession().getAttribute("selectedJob");
    request.getSession().removeAttribute("selectedJob");
    if (selectedJob == null || selectedJob.equals("")) {
        selectedJob = request.getParameter("selectedJob");
    }

    String selectedProb = (String) request.getSession().getAttribute("selectedProb");
    request.getSession().removeAttribute("selectedProb");
    if (selectedProb == null || selectedProb.equals("")) {
        selectedProb = request.getParameter("selectedProb");
    }


    ArrayList<Integer> jobIdList = new ArrayList<Integer>();
    ArrayList<Integer> problemIdList = new ArrayList<Integer>();

    if (worker != null) {
        workerName = worker.getName();
        workerFin = worker.getFinNumber();
        jobIdList = JobDAO.retrieveJobIdsOfWorker(worker);

        if (selectedJob != null) {
            int selectedJobId = Integer.parseInt(selectedJob);
            latestJob = JobDAO.retrieveJobByJobId(selectedJobId);
            problemIdList = ProblemDAO.retrieveProblemsIdsOfWorkerAndJob(worker, latestJob);
            latestProblem = ProblemDAO.retrieveProblemByProblemId(problemIdList.get(problemIdList.size() - 1));
        } else {
            latestJob = JobDAO.retrieveJobByJobId(jobIdList.get(jobIdList.size() - 1));
            problemIdList = ProblemDAO.retrieveProblemsIdsOfWorkerAndJob(worker, latestJob);
        }
    }

    if (selectedProb != null) {
        int selectedProbId = Integer.parseInt(selectedProb);
        latestProblem = ProblemDAO.retrieveProblemByProblemId(selectedProbId);
        int selectedJobId = latestProblem.getJobKey();
        latestJob = JobDAO.retrieveJobByJobId(selectedJobId);
        problemIdList = ProblemDAO.retrieveProblemsIdsOfWorkerAndJob(worker, latestJob);
    } else if (problemIdList != null && problemIdList.size() > 0) {

        latestProblem = ProblemDAO.retrieveProblemByProblemId(problemIdList.get(problemIdList.size() - 1));
    }

    //prepare for benefit dropdowns
    ArrayList<String> foodDropdownList = DropdownDAO.retreiveAllDropdownListOfBenefits("Food");
    //get transportation benefit dropdown list
    ArrayList<String> faregoDropdownList = DropdownDAO.retreiveAllDropdownListOfBenefits("Transport");
    ArrayList<String> medDropdownList = DropdownDAO.retreiveAllDropdownListOfBenefits("Medical & Karunya");
    ArrayList<String> roofDropdownList = DropdownDAO.retreiveAllDropdownListOfBenefits("Roof");
    ArrayList<String> otherDropdownList = DropdownDAO.retreiveAllDropdownListOfBenefits("Other");

    ArrayList<String> dropdownList = foodDropdownList;
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <!--css-->
        <link rel="stylesheet" href="../css/bootstrap.css" media="screen" />
        <link rel="stylesheet" href="../css/custom.css" media="screen" /> 
        <!-------------->

        <!--javascript-->
        <script src="../js/jquery-2.1.1.js"></script>
        <script src="../js/bootstrap.min.js"></script>
        <!------------->

        <!--tab icon-->
        <link rel="shortcut icon" href="../img/twc_logo.png">

        <!--page title-->
        <title>CAMANS</title>
        <style>
            label{
                color: #006c9a;
            }

            #searcResult{
                background-color: #ededed;
                padding-top: 5%;
                padding-bottom: 5%;
            }
            
            #folderImg{
                width: 20vw;
            }
        </style>
        <script>


            function toggleBenefitDDL() {
                var selected = $('#benefitCategory').val();

                $('#nbenetype').empty();
                if (selected === "Meal Cards") {

            <%
                for (int i = 0; i < foodDropdownList.size(); i++) {
                    String ddlItem = foodDropdownList.get(i);
            %>

                    $('#nbenetype').append("<option><%=ddlItem%></option>");
            <%
                }
            %>

                } else if (selected === "FareGo") {
            <%
                for (int i = 0; i < faregoDropdownList.size(); i++) {
                    String ddlItem = faregoDropdownList.get(i);
            %>

                    $('#nbenetype').append("<option><%=ddlItem%></option>");
            <%
                }
            %>
                    //alert("farego");
                } else if (selected === "med") {
            <%
                for (int i = 0; i < medDropdownList.size(); i++) {
                    String ddlItem = medDropdownList.get(i);
            %>
                    $('#nbenetype').append("<option><%=ddlItem%></option>");
            <%
                }
            %>
                    //alert("med");
                } else if (selected === "Roof") {
            <%
                for (int i = 0; i < roofDropdownList.size(); i++) {
                    String ddlItem = roofDropdownList.get(i);
            %>
                    $('#nbenetype').append("<option><%=ddlItem%></option>");
            <%
                }
            %>
                    //alert("roof");
                } else if (selected === "Others") {
            <%
                for (int i = 0; i < otherDropdownList.size(); i++) {
                    String ddlItem = otherDropdownList.get(i);
            %>
                    $('#nbenetype').append("<option><%=ddlItem%></option>");
            <%
                }
            %>
                    //alert("other");
                }


            }
        </script>
    </head>
    <body>
        <!-- Nav Bar -->
        <jsp:include page="navbar.jsp"/>
        <!-- End of Nav Bar-->

        <!-- Search Box -->
        <div id="searchBox" class="col-xs-12 col-sm-offset-1 col-sm-10 col-md-offset-3 col-md-6">
            <br/>
            <h4 style="color:#006c9a">Search Worker by FIN</h4>

            <!-- Search Worker form-->
            <form class="form-inline" method="POST" action="../searchWorker.do">
                <div class="form-group col-xs-9">
                    <%
                        if (fin != null) {
                    %>
                    <input type="text" class="form-control" id="finNum" name="fin" value="<%=fin%>" placeholder="FIN Number" required>
                    <%
                    } else {
                    %>
                    <input type="text" class="form-control" id="finNum" name="fin" placeholder="FIN Number" required>
                    <%                    }
                    %>

                </div>
                <input type="hidden" name="associate" value="associate"/>
                <button type="submit" class="btn btn-blue col-xs-3">Search</button>
            </form>

        </div>
        <!-- End of Search Box -->

        <%
            if (worker != null) {
                //there will be only one worker with this fin number

        %>
        <!-- Search Result & issue Benefits -->

        <!-- Search Result -->
        <br/>
        <!--div class="col-md-offset-1 col-md-10 col-sm-offset-1 col-sm-10 col-xs-12" id="searcResult"-->
        <div class="row">
        <div class="col-md-12 col-sm-12 col-xs-12" id="searcResult">
            <label class="col-xs-5">Worker Name</label><p class="col-xs-6"><%=workerName%></p><br/>
            <label class="col-xs-5">FIN Number</label><p class="col-xs-6"><%=workerFin%></p><br/>

            <!-- TO DO :: RELATED TWO DROPDOWNS SO THAT THE PROBLEM LIST REFER TO THE JOB SELECTED -->
            <label class="col-xs-4">Employer</label>
            <div class="col-xs-8">
                <form method="POST" action="../changeToSelected">
                    <select class="col-xs-6 col-md-6 form-control input-sm" id="jobList" name='selectedJob' onchange="this.form.submit();">
                        <%
                            for (int i = jobIdList.size() - 1; i >= 0; i--) {
                                int id = jobIdList.get(i);
                                String idStr = id + "";
                                Job job = JobDAO.retrieveJobByJobId(id);
                                String employer = job.getEmployerName();
                                if (selectedJob != null && selectedJob.equals(idStr)) {
                        %>
                        <option value='<%=id%>' selected><%=employer%></option>
                        <%
                        } else {
                        %>
                        <option value='<%=id%>'><%=employer%></option>
                        <%    }
                            }
                        %>
                    </select>
                    <input type='hidden' name="workerFin" value="<%=workerFin%>"/>
                    <input type="hidden" name='selectedType' value='job'/>
                    <input type='hidden' name='associate' value="associate"/>
                </form>
                    
            </div>
                    
                    <br/><br/><br/><br/>
            <label class="col-xs-4">Problem</label>
            <div class="col-xs-8">
                <form method="POST" action="../changeToSelected">
                    <select class="col-xs-6 col-md-6 form-control input-sm" id="probList" name="selectedProblem" onchange="this.form.submit();">
                        <%

                            for (int i = problemIdList.size() - 1; i >= 0; i--) {
                                Problem problem = ProblemDAO.retrieveProblemByProblemId(problemIdList.get(i));
                                String probType = problem.getProblem();
                        %>
                        <option><%=probType%></option>
                        <%                }
                        %>


                    </select>
                    <input type='hidden' name="workerFin" value="<%=workerFin%>"/>
                    <input type="hidden" name='selectedType' value='prob'/>
                    <input type='hidden' name='associate' value="associate"/>
                </form>
            </div>
            <br/><br/><br/>
            <div style="padding: 0 2%">
            <button type="button" class='btn btn-blue btn-sm' onclick="window.location = 'addNew.jsp?workerFin=<%=workerFin%>';"><span class="glyphicon glyphicon-plus"></span> Job</button>
            <button type="button" class='btn btn-blue btn-sm' onclick="window.location = 'addNew.jsp?workerFin=<%=workerFin%>&selectedJob=<%=latestJob.getJobKey()%>';"><span class="glyphicon glyphicon-plus"></span> Problem</button>
            <button type="button" class='btn btn-blue btn-sm pull-right' onclick="window.location = 'caseSummary.jsp?worker=<%=workerFin%>&selectedJob=<%=latestJob.getJobKey()%>&selectedProb=<%=latestProblem.getProbKey()%>';">Case Summary</button>
            </div>
        </div>
            </div>
        <!-- End of Search Result -->


        <!-- Issue Benefits -->
        <div class="col-md-12 col-xs-12 col-sm-12" id="issueBene">
            <div class="row" style="padding-top: 4%; padding-right: 4%;">
            <h4 class="col-xs-8" style="color:#006c9a">Issue Benefits</h4>
            <button class="col-xs-3 btn btn-blue btn-sm pull-right" onclick="window.location = 'r2r.jsp?workerFin=<%=workerFin%>&selectedJob=<%=selectedJob%>&selectedProb=<%=latestProblem.getProbKey() %>';">R2R</button>
            </div>
            <br/>

            <form method="POST" id='add_benefit_pop_up' class="form form-horizontal" action="../addBenefit.do"  style="height:100%">
                <div class='form-group' style="padding-top: 4%; padding-bottom: 4%">
                    <label for='nbenetype' class="control-label col-xs-4 col-sm-4">Benefits: </label>
                    <div class="col-xs-8 col-sm-4">
                        <select class="form-control input-sm" id="benefitCategory" name="benefitCategory" onchange="toggleBenefitDDL();">
                            <option>Meal Cards</option>
                            <option>FareGo</option>
                            <option value="med">Medical & Karunya</option>
                            <option>Roof</option>
                            <option>Others</option>
                        </select>
                    </div>
                </div>
                <hr>

                <div class='form-group'>
                    <label for='nisDate' class="control-label col-xs-4 col-sm-4">Issued Date<span style="color: red">*</span>: </label>
                    <div class="col-xs-8 col-sm-4">
                        <input class="form-control dateInput input-sm" type='text' name="nisDate" value="<%=sdf.format(today)%>">
                    </div>
                </div>
                <div class='form-group'>
                    <label for='ngivenby' class="control-label col-xs-4 col-sm-4" >Given By<span style="color: red">*</span>: </label>
                    <div class="col-xs-8 col-sm-4">
                        <input class="form-control input-sm" type='text' name="ngivenby"/>
                    </div>
                </div>
                <div class='form-group'>
                    <label for='nbenetype' class="control-label col-xs-4 col-sm-4">Benefit Type<span style="color: red">*</span>: </label>
                    <div class="col-xs-8 col-sm-4">
                        <select class="form-control input-sm" id="nbenetype" name="nbenetype">
                            <option value="">Select from list: </option>
                            <%
                                for (String dropdownItem : dropdownList) {
                                    if (dropdownItem.equals("Meal card")) {
                            %>
                            <option value ="<%=dropdownItem%>" selected><%= dropdownItem%></option>
                            <%
                            } else {
                            %>
                            <option value="<%=dropdownItem%>"><%=dropdownItem%></option>
                            <%
                                    }

                                }
                            %>  
                        </select>
                    </div>
                </div>
                <div class='form-group'>
                    <label for='nsernum' class="control-label col-xs-4 col-sm-4">Serial Number: </label>
                    <div class="col-xs-8 col-sm-4">
                        <input class="form-control input-sm" type='text' name="nsernum">
                    </div>
                </div>
                <div class='form-group'>
                    <label for='nremark' class="control-label col-xs-4 col-sm-4">Remarks: </label>
                    <div class="col-xs-8 col-sm-4">
                        <textarea class="form-control input-sm" name="nremark" rows="3"></textarea>
                    </div>
                </div>
                <div class='form-group'>
                    <label for='nvalue' class="control-label col-xs-4 col-sm-4">Value of Benefit(S$): </label>
                    <div class="col-xs-8 col-sm-4">
                        <input class="form-control input-sm" type='text' name="nvalue">
                    </div>
                </div>
                <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
                <input type="hidden" name="jobkey" value="<%=latestJob.getJobKey()%>"/>
                <input type="hidden" name="probKey" value="<%=latestProblem.getProbKey()%>"/>
                <input type="hidden" name="associate" value="associate"/>
                <input type="hidden" name="action" value="add"/>

                <div class="form-group btn_group pull-right">
                    <button type='submit' class="btn btn-blue modal_btn">Save</button>
                    <button type='button' class='btn modal_btn cancel_btn'>Cancel</button>
                </div>

            </form>
        </div>
        <!-- End of Issue Benefits -->


        <!-- End of Search Result & issue Benefits -->
        <%        } else {
        %>
        <!-- Not Found Message & Directory -->
        <div class='row'>
            <div class="col-md-offset-1 col-md-10 col-sm-offset-1 col-sm-10 col-xs-offset-1 col-xs-10" id="searcResult">
                <p style="color:red">Sorry! The worker does not exist in the system.
                </p>
                <p><b>Do you want to create new case?</b></p><br/>

                <!--To do : option buttons to create worker-->
                <div class="col-md-offset-2 col-md-8 col-sm-offset-1 col-sm-10 col-xs-12">
                    <a href="addNew.jsp?workerFin=<%=fin%>&option=createCase"><img class="img-responsive center-block" src="../img/add_folder.png" id="folderImg"/></a>
                </div>
            </div>
        </div>
        <!-- End of Not Found Message & Directory -->
        <%        }
        %>



    </body>
</html>
