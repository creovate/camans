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
        background: #3289ae ;
        border-right: 7px solid #004C6C;
    }

    #side-menu{
        border-top: none;
        border-left: none;
    }
    
    #side-menu ul li a{
        color: #006C9A;
    }
    
    #side-menu ul li a:active{
        color: white;
    }
    
    #side-menu .selected a{
        color: white;
        font-weight: bolder;
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
<div class="col-sm-2 col-md-2" style="padding:0; position: fixed;">
    <div class="side-menu">
        <nav id="side-menu" class="navbar" role="navigation">

                <ul class="nav navbar-nav nav-tabs col-md-12" role="tablist" id="nav_maintabs" style="padding-right: 1%">
                    <li id='home_tab' class=''><a class='' href="index.jsp" role="tab" active><span class="glyphicon glyphicon-search"></span>&nbsp;Search Worker</a></li>
                    <li id='createCase_tab'><a href="createCase.jsp" role="tab"><span class="glyphicon glyphicon-plus"></span>&nbsp;Create Worker</a></li>
                    <li id='report_tab'><a href="report.jsp" role="tab" ><span class="glyphicon glyphicon-book"></span>&nbsp;Reports</a></li>
                        <%
                            if (_user.getRole().equals("Administrator")) {
                        %>

                    <li id="admin_tab"><a href="admin.jsp" tabindex="-1"><span class="glyphicon glyphicon-dashboard"></span>&nbsp;Admin Dashboard</a></li>
                    <li id="usermgmt_tab"><a href="userManagement.jsp" tabindex="-1"><span class="glyphicon glyphicon-user"></span>&nbsp;User Management</a></li>
                    <li id="importexport_tab"><a href="importexport.jsp" tabindex="-1"><span class="glyphicon glyphicon-upload"></span>&nbsp;Import/Export Data</a></li>
                    <li id="ddsetting_tab"><a href="dropdownSetting.jsp" tabindex="-1"><span class="glyphicon glyphicon-random"></span>&nbsp;Dropdown Settings</a></li>
                    <li id="auditLog_tab"><a href="auditLog.jsp" tabindex="-1"><span class="glyphicon glyphicon-list"></span>&nbsp;Audit Log  </a></li>

                    <%                            }
                    %>
                </ul>

        </nav>
    </div>
</div>


