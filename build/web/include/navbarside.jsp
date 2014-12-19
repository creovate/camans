<%@page import="camans.entity.User"%>
<%
    User _user = (User) session.getAttribute("userLogin");
%>
<%-- 
    Document   : navbar
    Created on : Oct 23, 2014, 5:58:05 PM
    Author     : Nyein Su
--%>


<!-- nav bar -->
<div class="col-sm-2 col-md-2" style="height: inherit">
    <div class="sidebar-nav">
        <nav class="navbar" role="navigation">
            
                <!-- Brand and toggle get grouped for better mobile display -->
                
                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse" id="sidebar-navbar-collapse">

                    <ul class="nav navbar-nav nav-tabs col-md-12" role="tablist" id="nav_maintabs">
                        <li><a href="RecentActivities.jsp" role="tab" >Recent Benefit Activities</a></li>
                        <li class="dropdown">
                            <a href="#" id="case_mgmt" class="dropdown-toggle" data-toggle="dropdown"> 
                                Case Management <span class="caret"></span>
                            </a>
                            <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop1">
                                <li><a id="search_worker_tab" href="home.jsp" tabindex="-1">Search Worker</a></li>
                                <li ><a href="createCase.jsp" tabindex="-1">Create Worker</a></li>
                            </ul>
                        </li>

                        <li ><a href="#report" role="tab" >Report Module</a></li>
                            <%
                                if (_user.getRole().equals("Administrator")) {
                            %>
                        <li class="dropdown">
                            <a href="#" id="admin_mgmt" class="dropdown-toggle" data-toggle="dropdown"> 
                                Admin Special Modules <span class="caret"></span>
                            </a>
                            <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop1">
                                <li><a href="userManagement.jsp" tabindex="-1">User Management</a></li>
                                <li ><a href="#" tabindex="-1">Configurations</a></li>
                                <li ><a href="#" tabindex="-1">Audit Trail  </a></li>
                            </ul>
                        </li>
                        <%                            }
                        %>
                    </ul>
                </div><!-- /.navbar-collapse -->
           
        </nav>
    </div>
</div>


