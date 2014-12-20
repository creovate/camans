<%-- 
    Document   : topnavbar
    Created on : Nov 19, 2014, 2:10:11 PM
    Author     : Nyein Su
--%>
<%@page import="camans.entity.User"%>
<%
    User _user = (User) session.getAttribute("userLogin");
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
                <a class="navbar-brand" href="#"><img id="logo" src="img/twc_logo.png"></a>
            </div>
           

                <ul class="nav navbar-nav navbar-right">
                    <li><a href="ReferedCase.jsp">Referred Cases <span class="badge">4</span></a></li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                            <img src="img/profile_pic.jpg" ><%=_user.getUsername()%> 
                            <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu" role="menu">
                            <li><a href="userProfile.jsp">Profile</a></li>
                            <li class="divider"></li>
                            <li><a href="logout.jsp">Log Out</a></li>
                        </ul>
                    </li>
                </ul>
            </div><!-- /.navbar-collapse -->
    </nav>

</div>
