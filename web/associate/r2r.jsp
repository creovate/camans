<%-- 
    Document   : r2r
    Created on : Mar 7, 2015, 11:39:50 PM
    Author     : Nyein Su
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="camans.dao.*"%>
<%@page import="camans.entity.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String workerFin = request.getParameter("worker");
    if (workerFin == null || workerFin.equals("")) {
        workerFin = (String) request.getSession().getAttribute("worker");
        request.getSession().removeAttribute("worker");
    }
    String jobKeyStr = request.getParameter("selectedJob");
    if (jobKeyStr == null || jobKeyStr.equals("")) {
        jobKeyStr = (String) request.getSession().getAttribute("selectedJob");
        request.getSession().removeAttribute("selectedJob");
    }
    String probKeyStr = request.getParameter("selectedProb");
    if (probKeyStr == null || probKeyStr.equals("")) {
        probKeyStr = (String) request.getSession().getAttribute("selectedProb");
        request.getSession().removeAttribute("selectedProb");
    }
    String action = request.getParameter("action");
    if (action == null || action.equals("")) {
        probKeyStr = (String) request.getSession().getAttribute("action");
        request.getSession().removeAttribute("action");
    }
    String startDate = "";
    String endDate = "";
    ArrayList<Integer> r2rIds = new ArrayList<Integer>();
    if (action == null) {
        action = (String) request.getSession().getAttribute("action");
        request.getSession().removeAttribute("action");

        startDate = (String) request.getSession().getAttribute("startDate");
        request.getSession().removeAttribute("action");

        endDate = (String) request.getSession().getAttribute("endDate");
        request.getSession().removeAttribute("action");

        r2rIds = (ArrayList<Integer>) request.getSession().getAttribute("r2rIds");
        request.getSession().removeAttribute("action");
    }


    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
    DecimalFormat df = new DecimalFormat("#,###,##0.00");

    String successMsg = (String) request.getSession().getAttribute("successProbCompMsg");
    request.getSession().removeAttribute("successProbCompMsg");

    String errorMsg = (String) request.getSession().getAttribute("errorProbCompMsg");
    request.getSession().removeAttribute("errorProbCompMsg");
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
            .alert{
                position: absolute;
                z-index: 999;
                top: 18vh;
            }
            .btn-grey{
                background : #999999;
                color: white;
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

                $('#problemComplements')
                        .bootstrapValidator({
                    fields: {
                        //r2r
                        r2rTime: {
                            validators: {
                                stringLength: {
                                    max: 20,
                                    message: 'This field must be less than 20 characters.'
                                }
                            }
                        },
                        r2rHosp: {
                            validators: {
                                stringLength: {
                                    max: 20,
                                    message: 'This field must be less than 20 characters.'
                                },
                                notEmpty: {
                                    message: 'This field cannot be empty.'
                                }
                            }
                        },
                        r2rDept: {
                            validators: {
                                stringLength: {
                                    max: 50,
                                    message: 'This field must be less than 50 characters.'
                                }
                            }
                        },
                        r2r1: {
                            validators: {
                                stringLength: {
                                    max: 20,
                                    message: 'This field must be less than 20 characters.'
                                }
                            }
                        },
                        r2r2: {
                            validators: {
                                stringLength: {
                                    max: 20,
                                    message: 'This field must be less than 20 characters.'
                                }
                            }
                        },
                        r2rPurpose: {
                            validators: {
                                stringLength: {
                                    max: 50,
                                    message: 'This field must be less than 50 characters.'
                                }
                            }
                        },
                        r2rPreApptNotes: {
                            validators: {
                                stringLength: {
                                    max: 200,
                                    message: 'This field must be less than 200 characters.'
                                }
                            }
                        },
                        r2rPostApptNotes: {
                            validators: {
                                stringLength: {
                                    max: 200,
                                    message: 'This field must be less than 200 characters.'
                                }
                            }
                        },
                        r2rFeedback: {
                            validators: {
                                stringLength: {
                                    max: 200,
                                    message: 'This field must be less than 200 characters.'
                                }
                            }
                        },
                        r2rMed: {
                            validators: {
                                regexp: {
                                    regexp: /^(\d+)?(,\d+)*(\.[0-9]{1,2})?$/,
                                    message: 'This value must have maximum 2 decimal place.'
                                }
                            }
                        }
                    }
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

        <div class="alert alert-danger col-xs-offset-1 col-xs-10" role="alert">
            <a style="cursor:pointer" class="close" data-dismiss="alert">&times;</a>
            <%=errorMsg%>
        </div>

        <% }
            }%>

        <%        if (action != null && action.equals("viewHistory")) {
                Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(workerFin);
                String workerName = worker.getName();

                int jobKey = Integer.parseInt(jobKeyStr);
                Job job = JobDAO.retrieveJobByJobId(jobKey);
                String employer = job.getEmployerName();


                int probKey = Integer.parseInt(probKeyStr);
                Problem problem = ProblemDAO.retrieveProblemByProblemId(probKey);
                String probType = problem.getProblem();
                ArrayList<Integer> r2rIdList = ProblemComplementsDAO.retrieveProblemR2RIdsOfProblem(problem);
        %>
        <div class="col-xs-12 col-md-offset-2 col-md-8 col-sm-offset-2 col-sm-8" style="padding: 0;">
            <br/>
            <label class="col-xs-5">Worker Name</label><p class="col-xs-7"><%=workerName%></p><br/>
            <label class="col-xs-5">FIN Number</label><p class="col-xs-7"><%=workerFin%></p><br/>
            <label class="col-xs-5">Employer</label><p class="col-xs-7"><%=employer%></p><br/>
            <label class="col-xs-5">Problem</label><p class="col-xs-7"><%=probType%></p><br/><br/><br/><br/>
            <%
                if (r2rIdList != null && r2rIdList.size() > 0) {
            %>
            <h5>List of 5 most recent R2R appointments</h5>
            <table class="table table-responsive table-striped">
                <%
                    int counter = 0;
                    for (int i = 0; i < r2rIdList.size();i++) {
                        counter++;
                        int id = r2rIdList.get(i);
                        ProblemR2R r2r = ProblemComplementsDAO.retrieveProblemR2RById(id);
                        java.util.Date r2rDate = r2r.getR2RDate();
                        String r2r1 = r2r.getR2R1();
                %>

                <tr style="cursor: pointer" onclick="window.location = 'r2r.jsp?worker=<%=workerFin%>&selectedJob=<%=jobKeyStr%>&selectedProb=<%=probKeyStr%>&action=viewEdit&id=<%=r2r.getId()%>';">
                    <td><%=sdf.format(r2rDate)%></td>
                    <td><%=r2r1%></td>
                    <td><span class='glyphicon glyphicon-edit'></span></td>
                </tr>
                <%
                        if (counter == 5) {
                            break;
                        }
                    }

                %>
            </table>
            <button type='button' class='btn edit_comp btn-grey input-sm pull-right' style="margin-right: 5%;" onclick="goBack();">Back</button>
        </div>
        <%
        } else {
        %>
        <label style="color:grey; padding: 2%;">There is no R2R record for this case yet.</label>
        <button type='button' class='btn edit_comp btn-grey input-sm pull-right' style="margin-right: 5%;" onclick="goBack();">Back</button>
        <%                            }
        } else if (action != null && action.equals("viewEdit")) {
            Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(workerFin);
            String workerName = worker.getName();

            int jobKey = Integer.parseInt(jobKeyStr);
            Job job = JobDAO.retrieveJobByJobId(jobKey);
            String employer = job.getEmployerName();


            int probKey = Integer.parseInt(probKeyStr);
            Problem problem = ProblemDAO.retrieveProblemByProblemId(probKey);
            String probType = problem.getProblem();

            String idStr = request.getParameter("id");
            int id = Integer.parseInt(idStr);
            ProblemR2R r2r = ProblemComplementsDAO.retrieveProblemR2RById(id);
            java.util.Date r2rDate = r2r.getR2RDate();
            String time = r2r.getR2RTime();
            String hosp = r2r.getR2RHosp();
            String dept = r2r.getR2RDept();
            String r2r1 = r2r.getR2R1();
            String r2r2 = r2r.getR2R2();
            String purpose = r2r.getR2RPurpose();
            String preNote = r2r.getR2RPreApptNotes();
            String postNote = r2r.getR2RPostApptNotes();
            String feedback = r2r.getR2RFeedback();
            double cost = r2r.getR2RMedCost();
            double outlay = r2r.getR2ROutlay();
        %>
        <div class='row'>
            <div class="col-xs-12 col-md-offset-2 col-md-8 col-sm-offset-2 col-sm-8" >
                <br/>
                <label class="col-xs-5">Worker Name</label><p class="col-xs-7"><%=workerName%></p><br/>
                <label class="col-xs-5">FIN Number</label><p class="col-xs-7"><%=workerFin%></p><br/>
                <label class="col-xs-5">Employer</label><p class="col-xs-7"><%=employer%></p><br/>
                <label class="col-xs-5">Problem</label><p class="col-xs-7"><%=probType%></p><br/><br/><br/><br/>

                <h5>Edit existing record</h5>
                <form method="POST" action="../addProblemComplement.do" class="col-xs-12 col-md-12 col-sm-12 form form-horizontal" id="problemComplements">
                    <div class='form-group'>
                        <label for='r2rDate' class="control-label col-xs-4 col-sm-4 col-md-4"><span style="color: red">*</span>Date of appt:</label>
                        <div class="col-xs-8 col-sm-7 col-md-6">
                            <input class="form-control dateInput" type='text' name="date" 
                                   value="<%=(r2rDate == null) ? "" : sdf.format(r2rDate)%>">
                        </div>
                    </div>
                    <div class='form-group'>
                        <label for='r2rTime' class="control-label col-xs-4 col-sm-4 col-md-4">Time of appt:</label>
                        <div class="col-xs-8 col-sm-7 col-md-6">
                            <input class="form-control" type='text' name="r2rTime" value="<%=time%>">
                        </div>
                    </div>
                    <div class='form-group'>
                        <label for='r2rHosp' class="control-label col-xs-4 col-sm-4 col-md-4"><span style="color: red">*</span>Hospital of appt:</label>
                        <div class="col-xs-8 col-sm-7 col-md-6">
                            <input class="form-control" type='text' name="r2rHosp" value="<%=hosp%>">
                        </div>
                    </div>
                    <div class='form-group'>
                        <label for='r2rDept' class="control-label col-xs-4 col-sm-4 col-md-4">Dept/doctor:</label>
                        <div class="col-xs-8 col-sm-7 col-md-6">
                            <input class="form-control" type='text' name="r2rDept" value="<%=dept%>">
                        </div>
                    </div>
                    <div class='form-group'>
                        <label for='r2r1' class="control-label col-xs-4 col-sm-4 col-md-4">First volunteer:</label>
                        <div class="col-xs-8 col-sm-7 col-md-6">
                            <input class="form-control" type='text' name="r2r1" value="<%=r2r1%>">
                        </div>
                    </div>
                    <div class='form-group'>
                        <label for='r2r2' class="control-label col-xs-4 col-sm-4 col-md-4">Second volunteer:</label>
                        <div class="col-xs-8 col-sm-7 col-md-6">
                            <input class="form-control" type='text' name="r2r2" value="<%=r2r2%>">
                        </div>
                    </div>
                    <div class='form-group'>
                        <label for='r2rPurpose' class="control-label col-xs-4 col-sm-4 col-md-4">Purpose of appt:</label>
                        <div class="col-xs-8 col-sm-7 col-md-6">
                            <input class="form-control" type='text' name="r2rPurpose" value="<%=purpose%>">
                        </div>
                    </div>
                    <div class='form-group'>
                        <label for='r2rPreApptNotes' class="control-label col-xs-4 col-sm-4 col-md-4">Pre-appt notes:</label>
                        <div class="col-xs-8 col-sm-7 col-md-6">
                            <textarea class="form-control" name="r2rPreApptNotes" rows="3" style='width: 100%'><%=(preNote == null) ? "" : preNote%></textarea>
                        </div>
                    </div>
                    <div class='form-group'>
                        <label for='r2rPostApptNotes' class="control-label col-xs-4 col-sm-4 col-md-4">Post-appt notes:</label>
                        <div class="col-xs-8 col-sm-7 col-md-6">
                            <textarea class="form-control" name="r2rPostApptNotes" rows="3" style='width: 100%'><%=(postNote == null) ? "" : postNote%></textarea>
                        </div>
                    </div>
                    <div class='form-group'>
                        <label for='r2rFeedback' class="control-label col-xs-4 col-sm-4 col-md-4">Feedback:</label>
                        <div class="col-xs-8 col-sm-7 col-md-6">
                            <textarea class="form-control" name="r2rFeedback" rows="3" style='width: 100%'><%=(feedback == null) ? "" : feedback%></textarea>
                        </div>
                    </div>
                    <div class='form-group'>
                        <label for='r2rMed' class="control-label col-xs-4 col-sm-4 col-md-4">Medical cost of this appt(S$):</label>
                        <div class="col-xs-8 col-sm-7 col-md-6">
                            <input class="form-control" type='text' name="r2rMed" value="<%=(cost == 0.0) ? "" : df.format(cost)%>">
                        </div>
                    </div>
                    <div class='form-group'>
                        <label for='r2rOut' class="control-label col-xs-4 col-sm-4 col-md-4">How much paid by volunteer(S$):</label>
                        <div class="col-xs-8 col-sm-7 col-md-6">
                            <input class="form-control" type='text' name="r2rOut" value="<%=(outlay == 0.0) ? "" : df.format(outlay)%>">
                        </div>
                    </div>
                    <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
                    <input type="hidden" name="complementName" value="r2r"/>
                    <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
                    <input type="hidden" name="probKey" value="<%=probKey%>"/>
                    <input type="hidden" name="Id" value="<%=id%>"/>

                    <input type="hidden" name="associate" value="associate"/>
                    <div class="form-group btn_group pull-right">
                        <button type='submit' class="btn btn-blue modal_btn edit_comp ">Save</button>
                        <button type='button' class='btn edit_comp btn-grey' onclick="goBack()">Cancel</button>
                    </div>
                </form>
            </div>
        </div>
        <%
        } else if (action != null && action.equals("review")) {
            if (r2rIds != null && r2rIds.size() > 0) {
                for (int i = 0; i < r2rIds.size(); i++) {
                    int id = r2rIds.get(i);
                    ProblemR2R r2r = ProblemComplementsDAO.retrieveProblemR2RById(id);
                    java.util.Date r2rDate = r2r.getR2RDate();
                    String r2r1 = r2r.getR2R1();

        %>

        <%
                    }
                }
            }
        %>
    </body>
</html>
