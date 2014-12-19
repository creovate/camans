<%-- 
    Document   : userProfile
    Created on : Dec 19, 2014, 2:33:34 PM
    Author     : pyaephyo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        
        <!--jasny-bootstrap v3.1.3, added by soemyatmayt-->
        <link rel="stylesheet" href="css/jasny-bootstrap.css"/>
        <link rel="stylesheet" href="css/custom.css" media="screen" /> 
        
        
        <script src="js/jquery-2.1.1.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <!-- BootstrapValidator JS, Added by soemyatmyat-->
        <script type="text/javascript" src="js/bootstrapValidator.min.js"></script>
        <!-- DataTables JS, Added by soemyatmyat -->
        <script src="js/jquery.dataTables.js"></script>
        <script src="js/dataTables.bootstrap.js"></script>        
        <!--jasny-bootstrap v3.1.3, added by soemyatmyat-->
        <script src="js/jasny-bootstrap.js"></script>     
        
        <link rel="shortcut icon" href="img/twc_logo.png">
   
        <title>CAMANS</title>
    </head>
    <body style='background:white'>
        <jsp:include page="include/navbartop.jsp"/>
        <jsp:include page="include/navbarside.jsp"/>
        <div class="main_div">
            <div class="col-md-10">
                <div class="page-header">
                    <center><h1 style="color:#2980b9">User Profile Page</h1></center>    
                </div>
                <form id="editUserForm" method="post" action="processUser.do" class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-3">NRIC Number <span style="color: red">*</span></label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control edit_nric" id="InputNRIC" name="nNRIC"
                                placeholder="Enter NRIC Number" readOnly="readOnly">
                            </input>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3" for="InputFullName">Full Name <span style="color: red">*</span></label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control edit_fullName" id="InputFullName" name="nFullName"
                                placeholder="Enter Full Name">
                        </div>    
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3" for="InputAlias">Alias</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control edit_alias" id="InputAlias" name="nAlias"
                                placeholder="Enter Alia">
                        </div>    
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3" for="InputUsername">Username<span style="color: red">*</span></label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control edit_username" id="InputUsername" name="nUsername"
                                   placeholder="Username" readOnly="readOnly">
                            <!--<span class="form-control edit_username"></span>-->
                        </div>    
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3" for="InputGender">Gender</label>
                        <div class="col-sm-9">
                            <select class="form-control edit_gender" id="InputGender" name="nGender">
                                <option selected>Male</option>
                                <option>Female</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3" for="InputRole">Role</label>
                        <div class="col-sm-9">
                            <select class="form-control edit_role" id="InputRole" name="nRole">
                                <option selected>Associate</option>
                                <option>Specialist</option>
                                <option>Manager</option>
                                <option>Administrator</option>
                            </select>
                        </div>    
                    </div>  

                    <div class="form-group">
                        <label class="col-sm-3" for="InputEmail1">Email address<span style="color: red">*</span></label>
                        <div class="col-sm-9">
                            <input type="email" class="form-control edit_email" id="InputEmail1" name="nEmail"
                                placeholder="Enter email">
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-3" for="InputPhNum">Phone Number</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control edit_phone" id="InputPhNum" name="nPhNum"
                                   placeholder="Enter Phone Number">
                        </div>    
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3" for="InputProfilePic">Profile Picture Upload</label>
                        <div class="col-sm-9 fileinput fileinput-new" data-provides="fileinput">
                          <div class="fileinput-new thumbnail" style="width: 200px; height: 150px;">
                            <img data-src="holder.js/100%x100%" alt="...">
                          </div>
                          <div class="fileinput-preview fileinput-exists thumbnail" style="max-width: 200px; max-height: 150px;"></div>
                          <div>
                            <span class="btn btn-default btn-file">
                                <span class="fileinput-new">Select image</span>
                                <span class="fileinput-exists">Change</span><input type="file" name="facePic">
                            </span>
                            <a href="#" class="btn btn-default fileinput-exists" data-dismiss="fileinput">Remove</a>
                          </div>
                        </div>  
                   </div>
            </div>
        </div>
    </body>     
</html>
