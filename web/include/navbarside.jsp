<%@page import="camans.entity.User"%>
<%
    User _user = (User) session.getAttribute("userLogin");
%>



<%-- 
    Document   : navbar
    Created on : Oct 23, 2014, 5:58:05 PM
    Author     : Nyein Su
--%>
<style>
    .selected{
        background: #197aa4 ;
        border-bottom: 2px solid #004C6C;
        border-right: 5px solid #004C6C;
    }

    .selected a{
        color: white;
        font-weight: bolder;


    }
    ul li a{
        color: #006C9A;
    }
    
</style>
<script>
    $(document).ready(function() {
        var bodyTag = document.getElementsByTagName("body");

        var bodyTag_id = $(bodyTag).attr('id');
        var tag_id = "#" + bodyTag_id + "_tab";
        $(tag_id).attr('class', 'selected');
        $(tag_id).attr('active',true);
    });


</script>

<!-- nav bar -->
<div class="col-sm-2 col-md-2" style="padding:0">
    <div class="side-menu">
        <nav id="side-menu" class="navbar" role="navigation">
            <div class="side-menu-container">

                <ul class="nav navbar-nav nav-tabs col-md-12" role="tablist" id="nav_maintabs" style="padding-right: 1%">
                    <li id='home_tab' class=''><a class='' href="home.jsp" role="tab" active><span class="glyphicon glyphicon-search"></span>&nbsp;Search Worker</a></li>
                    <li id='createCase_tab'><a href="createCase.jsp" role="tab"><span class="glyphicon glyphicon-plus"></span>&nbsp;Create Worker</a></li>
                    <li id='report_tab'><a href="report.jsp" role="tab" ><span class="glyphicon glyphicon-book"></span>&nbsp;Reports</a></li>
                        <%
                            if (_user.getRole().equals("Administrator")) {
                        %>

                    <li><a href="admin.jsp" tabindex="-1"><span class="glyphicon glyphicon-dashboard"></span>&nbsp;Admin Dashboard</a></li>
                    <li><a href="userManagement.jsp" tabindex="-1"><span class="glyphicon glyphicon-user"></span>&nbsp;User Management</a></li>
                    <li><a href="importexport.jsp" tabindex="-1"><span class="glyphicon glyphicon-upload"></span>&nbsp;Import/Export Data</a></li>
                    <li ><a href="dropdownSetting.jsp" tabindex="-1"><span class="glyphicon glyphicon-random"></span>&nbsp;Dropdown Settings</a></li>
                    <li ><a href="auditLog.jsp" tabindex="-1"><span class="glyphicon glyphicon-list"></span>&nbsp;Audit Log  </a></li>

                    <%                            }
                    %>
                </ul>
            </div><!-- /.navbar-collapse -->

        </nav>
    </div>
</div>


