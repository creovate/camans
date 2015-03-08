<%-- 
    Document   : benefection
    Created on : Mar 7, 2015, 2:28:08 PM
    Author     : Nyein Su
--%>

<%@page import="camans.dao.ProblemComplementsDAO"%>
<%@page import="camans.dao.JobDAO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="camans.dao.WorkerDAO"%>
<%@page import="camans.entity.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="camans.dao.BenefitDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="camans.entity.Problem"%>
<%@page import="camans.dao.ProblemDAO"%>
<%@ include file="../protect.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String workerFin = request.getParameter("worker");
    String selectedJob = request.getParameter("selectedJob");
    String selectedProb = request.getParameter("selectedProb");
    String category = request.getParameter("beneCategory");
    if (category == null || category.equals("")) {
        category = (String) request.getSession().getAttribute("category");
        request.getSession().removeAttribute("action");
    }

    String action = request.getParameter("action");
    if (action == null || action.equals("")) {
        action = (String) request.getSession().getAttribute("action");
        request.getSession().removeAttribute("action");
    }

    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
    DecimalFormat df = new DecimalFormat("#,###,##0.00");

    String startDateIn = request.getParameter("startDate");
    java.util.Date startDate = null;
    if (startDateIn == null || startDateIn.equals("")) {
        startDateIn = (String) request.getSession().getAttribute("startDate");
        request.getSession().removeAttribute("startDate");
    }
    String endDateIn = request.getParameter("endDate");
    java.util.Date endDate = null;
    if (endDateIn == null || endDateIn.equals("")) {
        endDateIn = (String) request.getSession().getAttribute("endDate");
        request.getSession().removeAttribute("endDate");
    }
    ArrayList<Integer> benefitIds = new ArrayList<Integer>();

    String categoryTitle = "";
    if (category != null) {
        if (category.equals("Food")) {
            categoryTitle = "Meal Card";
        } else if (category.equals("Transport")) {
            categoryTitle = "FareGo";
        } else if (category.equals("Medical") || category.contains("Medical")) {

            category = "Medical & Karunya";
            categoryTitle = "Medical & Karunya";
        } else if (category.equals("Roof")) {
            categoryTitle = "Roof";
        } else if (category.equals("Other")) {
            categoryTitle = "Other";
        } else if (category.equals("r2r")) {
            categoryTitle = "R2R";
        }
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
        <style>
            h4, h5{
                padding: 3%;
                color:#006c9a;
            }
            label{
                color: #006c9a;
            }
        </style>
        <script>
            $(document).ready(function() {
                //initializing data picker
                $(".dateInput").datepicker({
                    dateFormat: 'dd-M-yy',
                    changeMonth: true,
                    changeYear: true,
                    yearRange: "-100:nn"
                });
                //disabling manual input
                $('.dateInput').focus(function() {
                    $('.dateInput').blur();
                });
                $('.no_change').focus(function() {
                    $('.no_change').blur();
                });

            });
            function goBack() {
                window.history.back();
            }
        </script>
    </head>
    <body>
        <!-- Nav Bar -->
        <jsp:include page="navbar.jsp"/>
        <!-- End of Nav Bar-->
        <%
            if (action != null && action.equals("viewRecent")) {
                Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(workerFin);
                String workerName = worker.getName();

                int jobKey = Integer.parseInt(selectedJob);
                Job job = JobDAO.retrieveJobByJobId(jobKey);
                String employer = job.getEmployerName();


                int probKey = Integer.parseInt(selectedProb);
                Problem problem = ProblemDAO.retrieveProblemByProblemId(probKey);
                String probType = problem.getProblem();

                benefitIds = BenefitDAO.retrieveBenefitsIdsOfCategory(problem, category);

        %>
        <div class="col-xs-12 col-md-offset-2 col-md-8 col-sm-offset-2 col-sm-8" style="padding: 0;">
            <br/>
            <label class="col-xs-5">Worker Name</label><p class="col-xs-6"><%=workerName%></p><br/>
            <label class="col-xs-5">FIN Number</label><p class="col-xs-6"><%=workerFin%></p><br/>
            <label class="col-xs-5">Employer</label><p class="col-xs-6"><%=employer%></p><br/>
            <label class="col-xs-5">Problem</label><p class="col-xs-6"><%=probType%></p><br/><br/><br/><br/>
            <%
                if (benefitIds.size() > 0) {
            %>
            <h5>List of 5 most recent <%=categoryTitle%> benefits</h5>
            <table class="table table-responsive table-striped">
                <%
                    int counter = 0;
                    for (int i = benefitIds.size() - 1; i >= 0; i--) {
                        counter++;
                        int id = benefitIds.get(i);
                        Benefit benefit = BenefitDAO.retrieveBenefitById(id);
                        if (benefit != null) {
                            java.util.Date beneDate = benefit.getIssueDate();
                            String beneType = benefit.getBenefitType();
                            double beneValue = benefit.getBenefitValue();

                %>
                <tr>
                    <td><%=sdf.format(beneDate)%></td>
                    <td ><%=beneType%></td>
                    <td class="text-right"><%=df.format(beneValue)%></td>
                </tr>
                <%
                            if (counter == 5) {
                                break;
                            }
                        }
                    }
                %>

            </table>
        </div>
        <%
        } else {
        %>
        <label style="color:grey; padding: 2%;">There is no record of <%=categoryTitle%> benefit for this case yet.</label>
        <%                }
        } else {
        %>
        <div class="col-xs-12 col-md-offset-2 col-md-8 col-sm-offset-2 col-sm-8" style="padding: 0;">
            <br/>
            <h4>Review <%=categoryTitle%> records</h4>
            <form method="POST" class=" col-xs-12 col-md-12 col-sm-12 form form-horizontal" action="../retrieveBenefit.do">
                <div class='form-group'>
                    <label for='nisDate' class="control-label col-xs-4 col-sm-4 col-md-4"><span style="color: red">*</span>Start Date: </label>
                    <div class="col-xs-8 col-sm-7 col-md-6">
                        <input class="form-control dateInput input-sm" type='text' id='start' name="startDate" value="<%=(startDateIn == null) ? "" : startDateIn%>" required='true'>
                    </div>
                </div>
                <div class='form-group'>
                    <label for='nisDate' class="control-label col-xs-4 col-sm-4 col-md-4"><span style="color: red">*</span>End Date: </label>
                    <div class="col-xs-8 col-sm-7 col-md-6">
                        <input class="form-control dateInput input-sm" type='text' id='end' name="endDate" value="<%=(endDateIn == null) ? "" : endDateIn%>" required='true'>
                    </div>
                </div>
                <input type='hidden' name="category" value="<%=category%>"/>
                <div class="form-group pull-right">
                    <button type="submit" class="btn btn-blue btn-sm">List</button>
                    <button type="button" class="btn btn-sm" onclick="goBack();">Cancel</button>
                </div>
            </form>
            <hr>
            <table class="table table-responsive table-striped">
                <%
                    if (category != null && category.equals("r2r")) {
                        ArrayList<Integer> r2rIds = (ArrayList<Integer>) request.getSession().getAttribute("r2rIds");
                        request.getSession().removeAttribute("r2rIds");

                        if (r2rIds != null) {
                            if (r2rIds.size() > 0) {
                                for (int i = 0; i < r2rIds.size(); i++) {
                                    int id = r2rIds.get(i);
                                    ProblemR2R r2r = ProblemComplementsDAO.retrieveProblemR2RById(id);
                                    java.util.Date r2rDate = r2r.getR2RDate();
                                    String r2r1 = r2r.getR2R1();
                                    String tempFin = r2r.getWorkerFinNumber();
                                    Worker tempWorker = WorkerDAO.retrieveWorkerbyFinNumber(tempFin);
                                    String tempName = tempWorker.getName();
                                    int tempJobKey = r2r.getJobKey();
                                    int tempProbKey = r2r.getProblemKey();
                %>
                <tr style="cursor: pointer" onclick="window.location = 'r2r.jsp?worker=<%=tempFin%>&selectedJob=<%=tempJobKey%>&selectedProb=<%=tempProbKey%>&action=viewEdit&id=<%=id%>';">
                    <td><%=sdf.format(r2rDate)%></td>
                    <td><%=tempName%><br/>
                        <%=tempFin%><br/>
                        <%=r2r1%></td>
                </tr>
                <%
                                }
                            } else {
                %>
                <label style="color:grey; padding: 2%;">There is no record of <%=categoryTitle%> benefit in selected period.</label>
                <%
                    }
                } else {
                %>
                <label style="color:grey; padding: 2%;">Please select start date and end date to get a list of <%=categoryTitle%> benefits.</label>
                <%
                    }
                } else {
                    benefitIds = (ArrayList<Integer>) request.getSession().getAttribute("benefitIds");
                    request.getSession().removeAttribute("benefitIds");
                    if (benefitIds != null) {
                        if (benefitIds.size() == 0) {
                %>
                <label style="color:grey; padding: 2%;">There is no record of <%=categoryTitle%> benefit in selected period.</label>
                <%
                    }
                    for (int i = 0; i < benefitIds.size(); i++) {
                        int id = benefitIds.get(i);
                        Benefit benefit = BenefitDAO.retrieveBenefitById(id);
                        if (benefit != null) {
                            java.util.Date beneDate = benefit.getIssueDate();
                            String beneType = benefit.getBenefitType();
                            double beneValue = benefit.getBenefitValue();
                            String tempFin = benefit.getWorkerFinNumber();
                            Worker tempWorker = WorkerDAO.retrieveWorkerbyFinNumber(tempFin);
                            String tempName = tempWorker.getName();
                %>
                <tr>
                    <td><%=sdf.format(beneDate)%></td>
                    <td><%=tempFin%><br/>
                        <%=tempName%><br/>
                        <%=beneType%><br/>
                        <%=df.format(beneValue)%></td>
                </tr>
                <%
                        }
                    }
                } else {
                %>
                <label style="color:grey; padding: 2%;">Please select start date and end date to get a list of <%=categoryTitle%> benefits.</label>
                <%
                        }
                    }
                %>

            </table>
        </div>
        <%
            }
        %>
    </body>
</html>