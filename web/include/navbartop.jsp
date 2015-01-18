<%-- 
    Document   : topnavbar
    Created on : Nov 19, 2014, 2:10:11 PM
    Author     : Nyein Su
--%>
<%@page import="camans.dao.CaseManagementDAO"%>
<%@page import="camans.entity.Problem"%>
<%@page import="java.util.ArrayList"%>
<%@page import="camans.entity.User"%>
<%
    User _user = (User) session.getAttribute("userLogin");
    ArrayList<Problem> problemList = CaseManagementDAO.retrieveUnassignedCases();
    //ArrayList<Problem> problemList = new ArrayList<Problem>();
%>

<div class="row">

    <nav class="navbar navbar-default navbar-fixed-top" role="navigation">
        <div class="container-fluid">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#sidebar-navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="home.jsp"><img id="logo" src="img/twc_logo.png"></a>
            </div>
           

                <ul class="nav navbar-nav navbar-right">
                    <li><a href="caseReferral.jsp">Referred Cases <span class="badge"><%=problemList.size()%></span></a></li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><img src="<%=(_user.getPhotoPath()==null)?"img/profile_pic.jpg":_user.getPhotoPath()%>"><%=_user.getUsername()%> <span class="caret"></span></a>
                        <ul class="dropdown-menu" role="menu">
                            <li><a href="userProfile.jsp">
                                    <span class="glyphicon glyphicon-wrench" aria-hidden="true"></span>
                                    Profile Setting
                                </a>
                            </li>

                            <li class="divider"></li>
                            <li><a href="logout.jsp">
                                    <span class="glyphicon glyphicon-log-in" aria-hidden="true"></span>
                                    Log Out
                                </a></li>
                        </ul>
                    </li>
                </ul>
            </div><!-- /.navbar-collapse -->
    </nav>

</div>
