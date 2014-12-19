<%-- 
    Document   : test
    Created on : Oct 23, 2014, 8:18:05 PM
    Author     : pyaephyo
just a test page
--%>

<%@page import="camans.entity.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="camans.dao.*"%>
<%@page import="camans.dao.JobComplementsDAO"%>
<%@page import="java.text.ParseException"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date"%>
<%@page import="java.sql.SQLException"%>
<%@page import="camans.dao.ConnectionManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
<%
Worker worker = WorkerDAO.retrieveWorkerbyFinNumber("afdaafsdfsfa");
    ArrayList<Integer> jobIds = JobDAO.retrieveJobIdsOfWorker(worker);
    Job latestJob = JobDAO.retrieveJobByJobId(jobIds.get(jobIds.size() - 1));
    ArrayList<Integer> problemIds = ProblemDAO.retrieveProblemsIdsOfWorkerAndJob(worker, latestJob);
    Problem latestProblem = ProblemDAO.retrieveProblemByProblemId(problemIds.get(problemIds.size() - 1));

    //String complementName = request.getParameter("complementName");
            //String workerFinNum = request.getParameter("workerFinNum");
            //int jobKey = Integer.parseInt(request.getParameter("jobkey"));
            //int problemKey = Integer.parseInt(request.getParameter("jobkey"));
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
            
                String leadName = request.getParameter("nleadCaseWorkerName");
                String leadStartStr = request.getParameter("nstartDate");
                String leadEndStr = request.getParameter("nendDate");
                          
                java.sql.Date leadStart = null;
                if (!leadStartStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(leadStartStr);
                        leadStart = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }
                
                java.sql.Date leadEnd = null;
                if (!leadEndStr.equals("")) {
                    try {
                        java.util.Date tmp = sdf.parse(leadEndStr);
                        leadEnd = new java.sql.Date(tmp.getTime());
                    } catch (ParseException ex) {
                        out.println(ex);
                    }
                }
                //create object
                ProblemLeadCaseWorker problemLeadCaseWrk = new ProblemLeadCaseWorker(worker.getFinNumber(),
                        latestJob.getJobKey(), latestProblem.getProbKey(), leadName, leadStart, leadEnd);
                //add into db
                //ProblemComplementsDAO.updateProblemLeadCaseWorker(problemLeadCaseWrk);

Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_lead_case_worker SET Lead_case_worker = ? , Lead_start = ?,"
                    + "Lead_end =? "
                    + "WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "G1234567");
            pstmt.setDate(2, problemLeadCaseWrk.getLeadStart());
            pstmt.setDate(3, problemLeadCaseWrk.getLeadEnd());
            pstmt.setInt(4, problemLeadCaseWrk.getId());

            pstmt.executeUpdate();
        } catch (Exception ex) {
            out.println(ex);
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }      
%>  

    </body>
</html>
