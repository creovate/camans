<%-- 
    Document   : dropdownSettings
    Created on : Dec 29, 2014, 2:40:15 PM
    Author     : soemyatmyat
--%>

<%@page import="camans.entity.Dropdown"%>
<%@page import="java.util.ArrayList"%>
<%@page import="camans.dao.DropdownDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    ArrayList<String> nationalityList = DropdownDAO.retrieveAllDropdownListOfNationalities();
    ArrayList<String> digitalType = DropdownDAO.retrieveAllDropdownListOfDigitalContactType();
    ArrayList<String> languageList = DropdownDAO.retrieveAllDropdownListOfLanguage();
    ArrayList<String> spokenEnglishStandardList = DropdownDAO.retrieveAllDropdownListOfSpokenEnglish();
    ArrayList<String> workPassType = DropdownDAO.retrieveAllDropdownListOfWorkpassType();
    ArrayList<String> jobSectorList = DropdownDAO.retrieveAllDropdownListOfJobSector();
    ArrayList<String> jobPassType = DropdownDAO.retrieveAllDropdownListOfPassType();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/bootstrap.min.css" media="screen" />
        <link rel="stylesheet" href="css/bootstrap-theme.min.css" media="screen" />
        <!-- DataTables CSS, added by soemyatmyat -->
        <link rel="stylesheet" href="css/dataTables.bootstrap.css"/>
        <!-- Bootstrap Validator CSS, Added by soemyatmyat -->
        <link rel="stylesheet" href="css/bootstrapValidator.min.css"/>
        <link rel="stylesheet" href="css/custom.css" media="screen" /> 
        
        
        <script src="js/jquery-2.1.1.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <!-- BootstrapValidator JS, Added by soemyatmyat-->
        <script type="text/javascript" src="js/bootstrapValidator.min.js"></script>
        <!-- DataTables JS, Added by soemyatmyat -->
        <script src="js/jquery.dataTables.js"></script>
        <script src="js/dataTables.bootstrap.js"></script>            
        <!--bootstrap session timeout, added by soemyatmyat-->
        <script src="js/bootstrap-session-timeout.min.js"></script>  
        <script src="//code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
        
        <link rel="shortcut icon" href="img/twc_logo.png">
   
        <title>CAMANS</title>
     
    </head>

    <body style='background:white'>
        <jsp:include page="include/navbartop.jsp"/>
        <jsp:include page="include/navbarside.jsp"/>
        
        <style>
ul#sortable
{
	margin: 0;
	padding: 0;
	width: 15em;
	float: left;
}

ul#sortable li
{
	border: 0;
	padding: 0.2em;
	margin-bottom: 0.2em;
	border: 1px solid #CCC;
	list-style-type: none;
	cursor: move;
}

ul#sortable li.clone
{
	background: rgba(255, 212, 170, 0.3);
}
        </style>
        <div class="col-md-10" id="content">
            <div class="page-header">
            <center><h2 style="color:#2980b9">Configure Dropdown Settings</h2></center>    
            </div>
            
            <div class="col-md-6">
                <!--Nationality-->
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-3 text-left">
                                    <a style="color: white" data-toggle="collapse" href="#collapseNationality" 
                                       aria-expanded="false" aria-controls="collapseNationality">
                                        <span data-toggle="tooltip" title="Minimize" class="glyphicon glyphicon-chevron-down"></span>
                                    </a>
                                </div>
                                <div class="col-xs-9">
                                    Nationality
                                </div>
                            </div>
                        </div>
                        <div class="panel-body collapse" id="collapseNationality">
                            <div class="row">
                                <div class="col-xs-12 text-right">
                                    <a style="color: black" href="">
                                        <span data-toggle="tooltip" title="Add" class="glyphicon glyphicon-plus"></span>
                                    </a>&nbsp;
                                    <a style="color: black" onclick="changeEdit()">
                                        <span data-toggle="tooltip" title="Edit" class="glyphicon glyphicon-pencil"></span>
                                    </a><br/><br/>
                                </div> 
                            </div>
                            <form id="editRank" method="post" action="#" class="form-horizontal">
                            <div class="row">
                                <div class="col-xs-12">
                                    <table class="table table-striped table-bordered table-hover" id="users-table">
                                        <thead>
                                            <tr>
                                                <th>S/N</font</th>
                                                <th>Name</th>
                                                <th>Edit</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                for (String str: nationalityList) {
                                                    Dropdown dropdown = DropdownDAO.retrieveDropdownItem("Nationality_type", str);
                                                    int rank = dropdown.getDisplayRank();
                                                    int id = dropdown.getId();
                                            %>
                                            <tr>
                                                <td><%=rank%></td>
                                                <td><%=str%></td>
                                                <td width="30%">
                                                    <input type="text" class="form-control" id="InputRank<%=id%>" 
                                                           name="nRank<%=id%>" value=<%=rank%> readOnly="readOnly">
                                                </td>
                                           
                                            </tr>
                                            <%  }   %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="row">
                            <div class="col-xs-10 text-right">
                                <button type="button" class="btn btn-primary" disabled>Save</button> 
                            </div>
                            <div class="col-xs-2 text-right">    
                                <button type="button" class="btn btn-primary" disabled onClick="changeReadOnly()">Cancel</button>
                            </div>
                            </div>    
                            </form>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                <!--end of Nationality-->

               <!--<div class="col-lg-6">-->    
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-3 text-left">
                                    
                                </div>
                                <div class="col-xs-9">
                                    Digital Contact Type
                                </div>
                            </div>
                        </div>
                        <div class="panel-body" id="collapseDigital">
                            <div class="row">
                                <div class="col-xs-12 text-right">
                                    <a style="color: black" href="">
                                        <span data-toggle="tooltip" title="Add" class="glyphicon glyphicon-plus"></span>
                                    </a>&nbsp;
                                    <a style="color: black" href="">
                                        <span data-toggle="tooltip" title="Edit" class="glyphicon glyphicon-pencil"></span>
                                    </a><br/><br/>
                                </div> 
                            </div>
                            <form id="editRank" method="post" action="#">
                                
                            <div class="row">
                                <div class="col-xs-12">
                                   
                            <ul id="sortable">
                                <!--<div class="list-group">-->
                                <%
                                    for (String str: nationalityList) {
                                        Dropdown dropdown = DropdownDAO.retrieveDropdownItem("Nationality_type", str);
                                        int rank = dropdown.getDisplayRank();
                                        int id = dropdown.getId();
                                %>
                                <li id="item-<%=id%>"><%=str%>
                                <%  }   %>
                                <!--</div>-->
                            </ul>
   
                                    </div>
                            </div>
                            <button type="submit" id="save" onclick="saveChanges()"class="btn btn-primary">Save Changes</button>
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                            </form>
                        </div>
                    </div>
               <!--</div>-->                          

               <!--<div class="col-lg-6">-->     
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-3 text-left">
                                    <a style="color: white" data-toggle="collapse" href="#collapseSpokenEng" 
                                       aria-expanded="false" aria-controls="collapseSpokenEng">
                                        <span data-toggle="tooltip" title="Minimize" class="glyphicon glyphicon-chevron-down"></span>
                                    </a>
                                </div>
                                <div class="col-xs-9">
                                    Spoken English Standard
                                </div>
                            </div>
                        </div>
                        <div class="panel-body collapse" id="collapseSpokenEng">
                            <div class="row">
                                <div class="col-xs-12 text-right">
                                    <a style="color: black" href="">
                                        <span data-toggle="tooltip" title="Add" class="glyphicon glyphicon-plus"></span>
                                    </a>&nbsp;
                                    <a style="color: black" href="">
                                        <span data-toggle="tooltip" title="Edit" class="glyphicon glyphicon-pencil"></span>
                                    </a><br/><br/>
                                </div> 
                            </div>
                            <div class="row">
                                <div class="col-xs-12">
                                    <table class="table table-striped table-bordered table-hover" id="users-table">
                                        <thead>
                                            <tr>
                                                <th>S/N</font</th>
                                                <th>Name</th>
                                                <th>Edit Field</th>
                                            </tr>
                                        </thead>
                                        <%
                                            for (String str: spokenEnglishStandardList) {
                                        %>
                                        <tbody>
                                            <tr>
                                                <td>S/N</td>
                                                <td><%=str%></td>
                                                <td>Username</td>
                                            </tr>
                                        </tbody>
                                        <%  }   %>
                                    </table>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </div>
               <!--</div>-->  

               <!--<div class="col-lg-6">-->      
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-3 text-left">
                                    <a style="color: white" data-toggle="collapse" href="#collapseLanguage" 
                                       aria-expanded="false" aria-controls="collapseLanguage">
                                        <span data-toggle="tooltip" title="Minimize" class="glyphicon glyphicon-chevron-down"></span>
                                    </a>
                                </div>
                                <div class="col-xs-9">
                                    Language
                                </div>
                            </div>
                        </div>
                        <div class="panel-body collapse" id="collapseLanguage">
                            <div class="row">
                                <div class="col-xs-12 text-right">
                                    <a style="color: black" href="">
                                        <span data-toggle="tooltip" title="Add" class="glyphicon glyphicon-plus"></span>
                                    </a>&nbsp;
                                    <a style="color: black" href="">
                                        <span data-toggle="tooltip" title="Edit" class="glyphicon glyphicon-pencil"></span>
                                    </a><br/><br/>
                                </div> 
                            </div>
                            <div class="row">
                                <div class="col-xs-12">
                                    <table class="table table-striped table-bordered table-hover" id="users-table">
                                        <thead>
                                            <tr>
                                                <th>S/N</font</th>
                                                <th>Name</th>
                                                <th>Edit Field</th>
                                            </tr>
                                        </thead>
                                        <%
                                            for (String str: languageList) {
                                        %>
                                        <tbody>
                                            <tr>
                                                <td>S/N</td>
                                                <td><%=str%></td>
                                                <td>Username</td>
                                            </tr>
                                        </tbody>
                                        <%  }   %>
                                    </table>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </div>
               <!--</div>-->    

               <!--<div class="col-lg-6">-->       
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-3 text-left">
                                    <a style="color: white" data-toggle="collapse" href="#collapseWorkPass" 
                                       aria-expanded="false" aria-controls="collapseWorkPass">
                                        <span data-toggle="tooltip" title="Minimize" class="glyphicon glyphicon-chevron-down"></span>
                                    </a>
                                </div>
                                <div class="col-xs-9">
                                    Work Pass Type
                                </div>
                            </div>
                        </div>
                        <div class="panel-body collapse" id="collapseWorkPass">
                            <div class="row">
                                <div class="col-xs-12 text-right">
                                    <a style="color: black" href="">
                                        <span data-toggle="tooltip" title="Add" class="glyphicon glyphicon-plus"></span>
                                    </a>&nbsp;
                                    <a style="color: black" href="">
                                        <span data-toggle="tooltip" title="Edit" class="glyphicon glyphicon-pencil"></span>
                                    </a><br/><br/>
                                </div> 
                            </div>
                            <div class="row">
                                <div class="col-xs-12">
                                    <table class="table table-striped table-bordered table-hover" id="users-table">
                                        <thead>
                                            <tr>
                                                <th>S/N</font</th>
                                                <th>Name</th>
                                                <th>Edit Field</th>
                                            </tr>
                                        </thead>
                                        <%
                                            for (String str: workPassType) {
                                        %>
                                        <tbody>
                                            <tr>
                                                <td>S/N</td>
                                                <td><%=str%></td>
                                                <td>Username</td>
                                            </tr>
                                        </tbody>
                                        <%  }   %>
                                    </table>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </div>
               <!--</div>-->      
           
           </div>  
                                    
           <div class="col-md-6">
                               <!--<div class="col-lg-6">-->
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-3 text-left">
                                    <a style="color: white" data-toggle="collapse" href="#collapseJobsector" 
                                       aria-expanded="false" aria-controls="collapseJobsector">
                                        <span data-toggle="tooltip" title="Minimize" class="glyphicon glyphicon-chevron-down"></span>
                                    </a>
                                </div>
                                <div class="col-xs-9">
                                    Job Sector
                                </div>
                            </div>
                        </div>
                        <div class="panel-body collapse" id="collapseJobsector">
                            <div class="row">
                                <div class="col-xs-12 text-right">
                                    <a style="color: black" href="">
                                        <span data-toggle="tooltip" title="Add" class="glyphicon glyphicon-plus"></span>
                                    </a>&nbsp;
                                    <a style="color: black" href="">
                                        <span data-toggle="tooltip" title="Edit" class="glyphicon glyphicon-pencil"></span>
                                    </a><br/><br/>
                                </div> 
                            </div>
                            <div class="row">
                                <div class="col-xs-12">

                                    <table class="table table-striped table-bordered table-hover" id="users-table">
                                        <thead>
                                            <tr>
                                                <th>S/N</font</th>
                                                <th>Name</th>
                                                <th>Edit Field</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                for (String str: jobPassType) {
                                            %>
                                            <tr>
                                                <td>S/N</td>
                                                <td><%=str%></td>
                                                <td>Username</td>
                                            </tr>
                                            <%  }   %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                <!--</div>-->

               <!--<div class="col-lg-6">-->    
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-3 text-left">
                                    <a style="color: white" data-toggle="collapse" href="#collapseJobPassType" 
                                       aria-expanded="false" aria-controls="collapseJobPassType">
                                        <span data-toggle="tooltip" title="Minimize" class="glyphicon glyphicon-chevron-down"></span>
                                    </a>
                                </div>
                                <div class="col-xs-9">
                                    Job Pass Details
                                </div>
                            </div>
                        </div>
                        <div class="panel-body collapse" id="collapseJobPassType">
                            <div class="row">
                                <div class="col-xs-12 text-right">
                                    <a style="color: black" href="">
                                        <span data-toggle="tooltip" title="Add" class="glyphicon glyphicon-plus"></span>
                                    </a>&nbsp;
                                    <a style="color: black" href="">
                                        <span data-toggle="tooltip" title="Edit" class="glyphicon glyphicon-pencil"></span>
                                    </a><br/><br/>
                                </div> 
                            </div>
                            <div class="row">
                                <div class="col-xs-12">
                                    <table class="table table-striped table-bordered table-hover" id="users-table">
                                        <thead>
                                            <tr>
                                                <th>S/N</font</th>
                                                <th>Name</th>
                                                <th>Edit Field</th>
                                            </tr>
                                        </thead>
                                        <%
                                            for (String str: digitalType) {
                                        %>
                                        <tbody>
                                            <tr>
                                                <td>S/N</td>
                                                <td><%=str%></td>
                                                <td>Username</td>
                                            </tr>
                                        </tbody>
                                        <%  }   %>
                                    </table>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </div>
               <!--</div>-->                          
  
           </div>                         
        </div>                  
            
        <script>
            function changeEdit() {
                $('input').prop({
                   'readonly': false 
                });
                $('button').prop({
                   'disabled': false 
                });
            };
            
            function changeReadOnly() {
                $('input').prop({
                   'readonly': true 
                });
                $('button').prop({
                   'disabled': true 
                });
            };
            
            $(document).ready(function() {
                $('#sortable').sortable();
                $( "#sortable" ).disableSelection();
             });

             function saveChanges() {
                var items = 'items=' + $('#sortable').sortable('serialize');
                items = items.replace(/&/g, ",");
                alert(items);
                $.ajax({
                    type: "post",
                    data: "items=" + items,
                    url: "NewServlet",
                    success: function(){
                        alert("success");
                    }
               })
             }
             
        </script>
        
    </body>
</html>
 
