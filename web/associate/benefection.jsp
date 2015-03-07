<%-- 
    Document   : benefection
    Created on : Mar 7, 2015, 2:28:08 PM
    Author     : Nyein Su
--%>

<%@page import="camans.entity.Problem"%>
<%@page import="camans.dao.ProblemDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
String workerFin = request.getParameter("worker");
String selectedJob = request.getParameter("selectedJob");
String selectedProb = request.getParameter("selectedProb");
String category = request.getParameter("beneCategory");
String action = request.getParameter("action");

int probKey = Integer.parseInt(selectedProb);
Problem problem = ProblemDAO.retrieveProblemByProblemId(probKey);


%>
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
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
