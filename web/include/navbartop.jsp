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
<style>
    #top-navbar {
        background: #2c3e50;
        border: none;
    }
    
    #top-navbar ul li a{
        color: white;
    }
    
    #top-navbar ul li a:hover, #top-navbar ul li a:focus{
        background: transparent;
        border: none;
    }
    
    #top-navbar ul li ul{
        background: #006C9A;
    }
    #top-navbar ul li ul li a{
        color: white;
    }
    #top-navbar ul li ul li a :hover, #top-navbar ul li ul li a :focus{
        background: transparent;
    }
    #top-navbar ul li.dropdown.open{
        background: transparent;
        color: white;
    }
</style>
<div class="row">

    <nav class="navbar navbar-fixed-top" id="top-navbar" role="navigation">
        <div class="container-fluid">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <div class="col-md-1"></div>
                <!--<a class="navbar-brand" href="home.jsp"><img id="logo" src="img/twc_logo.png"></a>-->
                <h4><a href="home.jsp" style="color:white; font-family: Roboto">CAMANS - Dev</a></h4>
            </div>
            
            <ul class="nav navbar-nav navbar-right">
                <li><a href="caseReferral.jsp">Referred Cases <span class="badge"><%=problemList.size()%></span></a></li>
                <li class="dropdown">
                    <a href="#" data-toggle="dropdown"><%=_user.getUsername()%> <span class="caret"></span></a>
                    <ul class="dropdown-menu" role="menu">
                        <li><a href="userProfile.jsp">
                                <span class="glyphicon glyphicon-wrench" aria-hidden="true"></span>
                                Profile Setting
                            </a>
                        </li>

                        <li class="divider"></li>
                        <li><a href="logout.jsp">
                                <span class="glyphicon glyphicon-log-out" aria-hidden="true"></span>
                                Log Out
                            </a></li>
                    </ul>
                </li>
            </ul>
        </div><!-- /.navbar-collapse -->
    </nav>

</div>
