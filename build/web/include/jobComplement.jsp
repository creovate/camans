<%-- 
    Document   : jobComplement
    Created on : Oct 30, 2014, 4:44:46 PM
    Author     : Nyein Su
--%>

<%@page import="camans.entity.JobPassDetails"%>
<%@page import="camans.entity.JobEmployer"%>
<%@page import="camans.entity.JobEmploymentContract"%>
<%@page import="camans.entity.JobWorkHistory"%>
<%@page import="camans.dao.JobComplementsDAO"%>
<%@page import="java.util.ArrayList"%>
<!--job complements here-->
<div class="row">


    <!--Pass Details-->
    <div class="panel panel-default">

        <div class="panel-heading">


            <h4 class="panel-title">Pass Details
                <a style="color: black" data-value='passdetails' data-passdetails='' href="" data-toggle="modal" data-target="#sgFri_pop_up" data-action="viewedit" class="view_btn pop_up_open">
                    <span class="glyphicon glyphicon-plus pull-right" pull-right></span></a></h4>
        </div>

        <div class="panel-body text-capitalize">
            <%
                ArrayList<Integer> jobPassDetailsIds = JobComplementsDAO.retrievePassDetailsIdsOfJob(latestJob);
                if (jobPassDetailsIds != null && !jobPassDetailsIds.isEmpty()) {

            %>

            <table class="table table-condensed">
                <tr>
                    <th>Pass Type</th>
                    <th>Pass Number</th>
                    <th>Issued Date</th>
                    <th>Obsoleted Date</th>
                    <th>Action</th>
                </tr>

                <%
                    for (int i = jobPassDetailsIds.size() - 1; i >= 0; i--) {
                        JobPassDetails tempPass = JobComplementsDAO.retrieveJobPassDetailsById(jobPassDetailsIds.get(i));
                        String passType = tempPass.getPassType();
                        String passNo = tempPass.getPassNum();
                        java.util.Date isDate = tempPass.getIssueDate();
                        java.util.Date obDate = tempPass.getObsoleteDate();



                %>
                <tr>
                    <td><%=passType%></td>
                    <td><%=passNo%></td>
                    <%
                        if (isDate == null) {
                    %>
                    <td>-</td>
                    <%                                                } else {
                    %>
                    <td><%=isDate%></td>
                    <%
                        }
                        if (obDate == null) {
                    %>
                    <td>-</td>
                    <%                                                } else {
                    %>
                    <td><%=obDate%></td>
                    <%
                        }

                    %>

                    <td><a style="color: black" href="editComplement.jsp?Complement=BankAccountDetails&WorkerFin=<%=worker.getFinNumber()%>&Id=<%=bankAcctDetailsIds.get(i)%>"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                </tr>
                <%
                        }
                    }
                %>
            </table>
        </div>
    </div>

    <!--Pass Details-->
    <div class="panel panel-default">

        <div class="panel-heading">

            <h4 class="panel-title">Employer Details
                <a href="addComplement.jsp?Complement=PassDetails&WorkerFin=<%=worker.getFinNumber()%>">
                    <span class="glyphicon glyphicon-plus pull-right" pull-right></span></a></h4>
        </div>

        <div class="panel-body text-capitalize">
            <%
                ArrayList<Integer> empIdsList = JobComplementsDAO.retrieveJobEmployerIdsOfJob(latestJob);
                if (empIdsList != null && !empIdsList.isEmpty()) {

            %>

            <table class="table table-condensed">
                <tr>
                    <th>Employer's Name</th>
                    <th>Employer's Address</th>
                    <th>Employer's Contact</th>
                    <th>Key Person</th>
                    <th>Action</th>
                </tr>

                <%
                    for (int i = empIdsList.size() - 1; i >= 0; i--) {
                        JobEmployer jobEmp = JobComplementsDAO.retrieveJobEmployerById(empIdsList.get(i));
                        String empName = jobEmp.getEmployerOfficialName();
                        String empAddress = jobEmp.getEmployerAddress();
                        String empContact = jobEmp.getEmployerContacts();
                        String empKeyPerson = jobEmp.getEmployerPersons();
                %>
                <tr>
                    <td><%=empName%></td>
                    <td><%=empAddress%></td>
                    <td><%=empContact%></td>
                    <td><%=empKeyPerson%></td>
                    <td><a style="color: black" href="editComplement.jsp?Complement=BankAccountDetails&WorkerFin=<%=worker.getFinNumber()%>&Id=<%=bankAcctDetailsIds.get(i)%>"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                </tr>
                <%
                        }
                    }
                %>
            </table>
        </div>
    </div>


    <!--Employment Contract-->
    <div class="panel panel-default">

        <div class="panel-heading">

            <h4 class="panel-title">Employment Contract
                <a href="addComplement.jsp?Complement=PassDetails&WorkerFin=<%=worker.getFinNumber()%>">
                    <span class="glyphicon glyphicon-plus pull-right" pull-right></span></a></h4>
        </div>

        <div class="panel-body text-capitalize">
            <%
                ArrayList<Integer> empContractIdsList = JobComplementsDAO.retrieveEmploymentContractIdsOfJob(latestJob);
                if (empContractIdsList != null && !empContractIdsList.isEmpty()) {

            %>

            <table class="table table-condensed">
                <tr>
                    <th>Contract Date</th>
                    <th>Where Signed</th>
                    <th>Relationship of Opposing Contracting Party to Job</th>
                    <th>Basic Salary</th>
                    <th>Action</th>
                </tr>

                <%
                    for (int i = empContractIdsList.size() - 1; i >= 0; i--) {
                        JobEmploymentContract empContract = JobComplementsDAO.retrieveEmploymentContractById(empContractIdsList.get(i));
                        java.util.Date contraDate = empContract.getContractDate();
                        String contraWhere = empContract.getContractWhere();
                        String contraRelation = empContract.getContractOppRelationship();
                        String contraSalary = empContract.getContractBasicSalary();
                %>
                <tr>
                    <%
                        if (contraDate == null) {
                    %>
                    <td>-</td>
                    <%                                                } else {
                    %>
                    <td><%=contraDate%></td>
                    <%
                        }

                    %>
                    <td><%=contraWhere%></td>
                    <td><%=contraRelation%></td>
                    <td><%=contraSalary%></td>

                    <td><a style="color: black" href="editComplement.jsp?Complement=BankAccountDetails&WorkerFin=<%=worker.getFinNumber()%>&Id=<%=bankAcctDetailsIds.get(i)%>"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                </tr>
                <%
                        }
                    }
                %>
            </table>
        </div>
    </div>


    <!--Intermediary Agent-->
    <div class="panel panel-default">

        <div class="panel-heading">

            <h4 class="panel-title">Intermediary Agent
                <a href="addComplement.jsp?Complement=PassDetails&WorkerFin=<%=worker.getFinNumber()%>">
                    <span class="glyphicon glyphicon-plus pull-right" pull-right></span></a></h4>
        </div>

        <div class="panel-body text-capitalize">
            <%
                ArrayList<Integer> agentIdsList = JobComplementsDAO.retrieveJobIntermediaryAgentIdsOfJob(latestJob);
                if (agentIdsList != null && !agentIdsList.isEmpty()) {

            %>

            <table class="table table-condensed">
                <tr>
                    <th>Agent Name</th>
                    <th>Location of Agent</th>
                    <th>Amount Paid to this Agent</th>
                    <th>Amount Owed to this Agent at the Start of Work</th>
                    <th>Action</th>
                </tr>

                <%
                    for (int i = agentIdsList.size() - 1; i >= 0; i--) {
                        JobIntermediaryAgent agent = JobComplementsDAO.retrieveJobIntermediaryAgentById(agentIdsList.get(i));

                        String agentName = agent.getAgentCompany();
                        String agentLocation = agent.getAgentAddress();
                        double agentPaidAmt = agent.getAgentAmtPaid();
                        double agentOwedAmt = agent.getAgentAmtOwed();
                %>
                <tr>
                    <td><%=agentName%></td>
                    <td><%=agentLocation%></td>
                    <td><%=agentPaidAmt%></td>
                    <td><%=agentOwedAmt%></td>

                    <td><a style="color: black" href="editComplement.jsp?Complement=BankAccountDetails&WorkerFin=<%=worker.getFinNumber()%>&Id=<%=bankAcctDetailsIds.get(i)%>"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                </tr>
                <%
                        }
                    }
                %>
            </table>
        </div>
    </div>

    <!--Verbal Assurance of Previous Job-->
    <div class="panel panel-default">

        <div class="panel-heading">

            <h4 class="panel-title">Verbal Assurance of Previous Job
                <a href="addComplement.jsp?Complement=PassDetails&WorkerFin=<%=worker.getFinNumber()%>">
                    <span class="glyphicon glyphicon-plus pull-right" pull-right></span></a></h4>
        </div>

        <div class="panel-body text-capitalize">
            <%
                ArrayList<Integer> verbalIdsList = JobComplementsDAO.retrieveVerbalAssuranceOfJob(latestJob);
                if (verbalIdsList != null && !verbalIdsList.isEmpty()) {

            %>

            <table class="table table-condensed">
                <tr>
                    <th>Pass Specified</th>
                    <th>IPA Employer Name</th>
                    <th>IPA Basic Monthly Salary</th>
                    <th>IPA Total Deduction</th>
                    <th>Action</th>
                </tr>

                <%
                    for (int i = verbalIdsList.size() - 1; i >= 0; i--) {
                        JobVerbalAssurance agent = JobComplementsDAO.retrieveVerbalAssuranceDetailsById(verbalIdsList.get(i));

                        String vaPass = agent.getVerbalName();

                %>
                <tr>


                    <td><a style="color: black" href="editComplement.jsp?Complement=BankAccountDetails&WorkerFin=<%=worker.getFinNumber()%>&Id=<%=bankAcctDetailsIds.get(i)%>"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                </tr>
                <%
                        }
                    }
                %>
            </table>
        </div>
    </div>

    <!--Work Place Details-->
    <div class="panel panel-default">

        <div class="panel-heading">

            <h4 class="panel-title">Work Place Details
                <a href="addComplement.jsp?Complement=PassDetails&WorkerFin=<%=worker.getFinNumber()%>">
                    <span class="glyphicon glyphicon-plus pull-right" pull-right></span></a></h4>
        </div>

        <div class="panel-body text-capitalize">
            <%
                ArrayList<Integer> workPlaceIdsList = JobComplementsDAO.retrieveJobWorkplaceIdsOfJob(latestJob);
                if (workPlaceIdsList != null && !workPlaceIdsList.isEmpty()) {

            %>

            <table class="table table-condensed">
                <tr>
                    <th>Workplace Type</th>
                    <th>Workplace Owner</th>
                    <th>Who direct the worker to this workplace?</th>
                    <th>Start Date at the Workplace</th>
                    <th>Action</th>
                </tr>

                <%
                    for (int i = workPlaceIdsList.size() - 1; i >= 0; i--) {
                        JobWorkplace workPlace = JobComplementsDAO.retrieveJobWorkplaceById(workPlaceIdsList.get(i));

                        String wpType = workPlace.getWorkplaceType();
                        String wpOwner = workPlace.getWorkplaceWhose();
                        String wpDirect = workPlace.getWorkplaceDirect();
                        String wpSDate = workPlace.getWorkplaceStart();
                %>
                <tr>
                    <td><%=wpType%></td>
                    <td><%=wpOwner%></td>
                    <td><%=wpDirect%></td>
                    <td><%=wpDirect%></td>

                    <td><a style="color: black" href="editComplement.jsp?Complement=BankAccountDetails&WorkerFin=<%=worker.getFinNumber()%>&Id=<%=bankAcctDetailsIds.get(i)%>"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                </tr>
                <%
                        }
                    }
                %>
            </table>
        </div>
    </div>

    <!--Work History-->
    <div class="panel panel-default">

        <div class="panel-heading">

            <h4 class="panel-title">Work History
                <a href="addComplement.jsp?Complement=PassDetails&WorkerFin=<%=worker.getFinNumber()%>">
                    <span class="glyphicon glyphicon-plus pull-right" pull-right></span></a></h4>
        </div>

        <div class="panel-body text-capitalize">
            <%
                ArrayList<Integer> historyIdsList = JobComplementsDAO.retrieveJobWorkHistoryIdsOfJob(latestJob);
                if (historyIdsList != null && !historyIdsList.isEmpty()) {

            %>

            <table class="table table-condensed">
                <tr>
                    <th>How did worker get into this job?</th>
                    <th>Date Arrived to Singapore</th>
                    <th>Is this first job in Singapore?</th>
                    <th>If not, state the arrival year to Singapore for the First Job</th>
                    <th>Action</th>
                </tr>

                <%
                    for (int i = historyIdsList.size() - 1; i >= 0; i--) {
                        JobWorkHistory history = JobComplementsDAO.retrieveJobWorkHistoryById(historyIdsList.get(i));

                        String historyHow = history.getWorkHistHow();
                        java.util.Date historyArrDate = history.getWorkHistDate();
                        String historyFirstJob = history.getWorkHistFirst();
                        String historyArrYear = history.getWorkHistYearArrive();
                %>
                <tr>
                    <td><%=historyHow%></td>
                    <td><%=historyArrDate%></td>
                    <td><%=historyFirstJob%></td>
                    <td><%=historyArrYear%></td>

                    <td><a style="color: black" href="editComplement.jsp?Complement=BankAccountDetails&WorkerFin=<%=worker.getFinNumber()%>&Id=<%=bankAcctDetailsIds.get(i)%>"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                </tr>
                <%
                        }
                    }
                %>
            </table>
        </div>
    </div>


    <!--Accommodation During Work-->
    <div class="panel panel-default">

        <div class="panel-heading">

            <h4 class="panel-title">Accommodation During Work
                <a href="addComplement.jsp?Complement=PassDetails&WorkerFin=<%=worker.getFinNumber()%>">
                    <span class="glyphicon glyphicon-plus pull-right" pull-right></span></a></h4>
        </div>

        <div class="panel-body text-capitalize">
            <%
                ArrayList<Integer> accomodoIdsList = JobComplementsDAO.retrieveJobAccomodationIdsOfJob(latestJob);
                if (accomodoIdsList != null && !accomodoIdsList.isEmpty()) {

            %>

            <table class="table table-condensed">
                <tr>
                    <th>Name</th>
                    <th>Relationship</th>
                    <th>Contact No</th>
                    <th>Obsoleted Date</th>
                    <th>Action</th>
                </tr>

                <%
                    for (int i = accomodoIdsList.size() - 1; i >= 0; i--) {
                        JobAccomodation accomodation = JobComplementsDAO.retrieveJobAccomodationById(accomodoIdsList.get(i));

                        String accName = accomodation.getAccCondition();
                        String accRel = "accomodaiton.xxx";
                        String accContact = "accomodation.xxx";
                        String ObDate = "accomodation.xxx";
                %>
                <tr>
                    <td><%=accName%></td>
                    <td><%=accRel%></td>
                    <td><%=accContact%></td>
                    <td><%=ObDate%></td>

                    <td><a style="color: black" href="editComplement.jsp?Complement=BankAccountDetails&WorkerFin=<%=worker.getFinNumber()%>&Id=<%=bankAcctDetailsIds.get(i)%>"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                </tr>
                <%
                        }
                    }
                %>
            </table>
        </div>
    </div>

    <!--IPA Details-->
    <div class="panel panel-default">

        <div class="panel-heading">

            <h4 class="panel-title">IPA Details
                <a href="addComplement.jsp?Complement=PassDetails&WorkerFin=<%=worker.getFinNumber()%>">
                    <span class="glyphicon glyphicon-plus pull-right" pull-right></span></a></h4>
        </div>

        <div class="panel-body text-capitalize">
            <%
                ArrayList<Integer> ipaIdList = JobComplementsDAO.retrieveIPADetailsIdsOfJob(latestJob);
                if (ipaIdList != null && !ipaIdList.isEmpty()) {

            %>

            <table class="table table-condensed">
                <tr>
                    <th>Pass Type</th>
                    <th>Remark</th>
                    <th>Employer Name</th>
                    <th>Application Date</th>
                    <th>Agent Name</th>
                    <th>Action</th>
                </tr>

                <%
                    for (int i = ipaIdList.size() - 1; i >= 0; i--) {
                        JobIPADetails ipa = JobComplementsDAO.retrieveJobIPADetailsById(ipaIdList.get(i));
                        String ipaPass = ipa.getIpaPassType();
                        String ipaRemark = ipa.getIpaRemarks();
                        String empName = ipa.getIpaEmployerName();
                        java.util.Date ipaAppDate = ipa.getIpaApplicationDate();
                        String ipaAgent = ipa.getIpaAgentName();

                %>
                <tr>
                    <td><%=ipaPass%></td>
                    <td><%=ipaRemark%></td>
                    <td><%=empName%></td>
                    <td><%=ipaAppDate%></td>
                    <td><%=ipaAgent%></td>
                    <td><a style="color: black" href="editComplement.jsp?Complement=BankAccountDetails&WorkerFin=<%=worker.getFinNumber()%>&Id=<%=bankAcctDetailsIds.get(i)%>"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                </tr>
                <%
                        }
                    }
                %>
            </table>
        </div>
    </div>


</div>