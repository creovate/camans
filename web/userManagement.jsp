<%-- 
    Document   : userManagement
    Created on : Nov 16, 2014, 2:00:26 PM
    Author     : soemyatmyat
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="camans.dao.*"%>
<%@page import="java.util.*"%>
<%@page import="camans.entity.*"%>
<%@ include file="protect.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
    String successMsg = (String) request.getSession().getAttribute("successMsg");
    request.getSession().removeAttribute("successMsg");
    
    String errorMsg = (String) request.getSession().getAttribute("errorMsg");
    request.getSession().removeAttribute("errorMsg");
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
        <!--bootstrap session timeout, added by soemyatmyat-->
        <script src="js/bootstrap-session-timeout.min.js"></script>  
        
        <link rel="shortcut icon" href="img/twc_logo.png">
   
        <title>CAMANS</title>
     
    </head>
    
    <body id="usermgmt" style='background:white'>
        <jsp:include page="include/navbartop.jsp"/>
        <div class="row-offcanvas row-offcanvas-left">
            <jsp:include page="include/navbarside.jsp"/>

            <div class="col-md-offset-2 col-md-10">

                <div class="page-header">
                <center><h2 >User Management</h2></center>    
                </div>
                <!-- Add New User Button -->
                <button type="button" class="btn btn-blue pull-right" data-toggle="modal" data-target="#newUser_pop_up">
                    <span class="glyphicon glyphicon-plus"></span> Add A New User
                </button><br/><br/>
                <!-- End of Add New User Button -->

                <!-- success & error display -->
                <% if (successMsg != null)  { %>

                 <div class="alert alert-info" role="alert">
                    <a href="#" class="close" data-dismiss="alert">&times;</a>
                    <%=successMsg%>
                </div>

                <% } %>
                <% if (errorMsg != null)  { %>

                 <div class="alert alert-danger" role="alert">
                    <a href="#" class="close" data-dismiss="alert">&times;</a>
                    <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
                    <%=errorMsg%>
                </div>

                <% } %>
                <!-- End of success & error display -->

                <!-- Users Table -->
                <h3 >All Users</h3>
                <!--<div class="panel panel-default">
                    <div class="panel-body">-->       
                        <table class="table table-bordered table-hover" id="users-table">
                            <thead bgcolor="#4c98b8">
                                <tr>
                                    <th><font color="#FFF">S/N</font></th>
                                    <th><font color="#FFF">Profile Picture</font></th>
                                    <th><font color="#FFF">Username</font></th>
                                    <th><font color="#FFF">Email</font></th>
                                    <th><font color="#FFF">Role</font></th>
                                    <th><font color="#FFF">Registered Date</font></th>
                                    <th><font color="#FFF">Status</font></th>
                                    <th><font color="#FFF">Actions</font></th>
                                </tr>
                            </thead>
                            <tbody>

                                <%
                                    ArrayList<User> latestUserList = new ArrayList<User>();
                                    latestUserList = UserDAO.retrieveAllUsers();
                                    String photoPath;
                                    String username;
                                    String email;
                                    String role;
                                    Date registeredDate;
                                    String status;
                                    for (int i = 0; i < latestUserList.size(); i++) {
                                        User user = latestUserList.get(i);
                                        photoPath = user.getPhotoPath();
                                        username = user.getUsername();
                                        email = user.getEmailAddress();
                                        role = user.getRole();
                                        registeredDate = UserDAO.retrieveRegisteredDate(user);
                                        status = user.getStatus();

                                %>
                                <tr>
                                    <td><%=i+1%></td>
                                    <!--<td><%=(photoPath==null)?"":photoPath%></td>-->
                                    <% if (photoPath == null || photoPath.equals("")) { %>
                                    <td><img src="img/profile_pic.jpg" width="40"></td>
                                    <% } else { %>
                                    <td><img src=<%=photoPath%> width="40"></td>
                                    <% }%>
                                    <td><%=username%></td>
                                    <td><%=email%></td>
                                    <td><%=role%></td>
                                    <td><%=sdf.format(registeredDate)%></td>
                                    <td><%=status%></td>
                                    <td align="center">

                                    <%
                                        if (status.equals("Active")) {
                                    %>
                                        <a style="color: black" href="" class="edit_popup" data-nric='<%=user.getNricNumber()%>' 
                                           data-fullname='<%=user.getFullName()%>' data-alias='<%=user.getAlias()%>'
                                           data-username='<%=username%>' data-gender='<%=user.getGender()%>'
                                           data-role='<%=user.getRole()%>' data-email='<%=email%>'
                                           data-phone='<%=user.getPhoneNumber()%>' data-photo='<%=photoPath%>' 
                                           data-toggle="modal" data-target="#user_pop_up">

                                           <span data-toggle="tooltip" title="Edit" class="glyphicon glyphicon-pencil"></span>
                                        </a>    
                                        &nbsp; &nbsp; &nbsp; &nbsp;
                                        <a style="color: black" href="" class="delete_popup" data-username='<%=username%>'
                                           data-toggle="modal" data-target="#user_delete_confirm">
                                            <span data-toggle="tooltip" title="Deactivate" class="glyphicon glyphicon-remove"></span>
                                        </a>&nbsp; &nbsp; &nbsp; &nbsp;
                                        <a style="color: black" href="" class="user_reset_pwd" data-username='<%=username%>'
                                           data-toggle="modal" data-target="#user_reset_pwd">
                                            <span data-toggle="tooltip" title="Reset Password" class="glyphicon glyphicon-lock"></span>
                                        </a>    
                                    <%
                                        } else {
                                    %>
                                        <a href="" class="delete_popup" data-username='<%=username%>'
                                               data-toggle="modal" data-target="#user_activate_confirm">Re-activate</a>
                                    <%  }   %>

                                   </td>

                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    <!--</div> //panel body
                </div>//panel -->
                <!-- End of Users Table -->    

                <!-- New User Modal -->
                <div class="modal fade" id="newUser_pop_up" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                  <div class="modal-dialog">
                    <div class="modal-content">

                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">
                            <span aria-hidden="true">&times;</span>
                            <span class="sr-only">Close</span>
                        </button>
                        <h3 class="modal-title" id="newUser_pop_up_label" align="center">
                            Add A New User Form
                        </h3>
                      </div> <!--modal-header-->

                      <form id="newUserForm" method="post" action="processUser.do" class="form-horizontal"
                            enctype="multipart/form-data">
                        <div class="modal-body">
                            <div class="form-group">
                                <label class="col-sm-3">NRIC Number <span style="color: red">*</span></label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" id="InputNRIC" name="nNRIC"
                                        placeholder="Enter NRIC Number" required>
                                    </input>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3" for="InputFullName">Full Name <span style="color: red">*</span></label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" id="InputFullName" name="nFullName"
                                        placeholder="Enter Full Name" required>
                                </div>    
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3" for="InputAlias">Alias</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" id="InputAlias" name="nAlias"
                                        placeholder="Enter Alia">
                                </div>    
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3" for="InputUsername">Username<span style="color: red">*</span></label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" id="InputUsername" name="nUsername"
                                        placeholder="Username" required>
                                </div>    
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3" for="InputPwd">Password<span style="color: red">*</span></label>
                                <div class="col-sm-9">
                                    <input type="password" class="form-control" id="InputPwd" name="nPwd"
                                        placeholder="Password" required>
                                </div>    
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3" for="InputConfirmPwd">Retype Password<span style="color: red">*</span></label>
                                <div class="col-sm-9">
                                    <input type="password" class="form-control" id="InputConfirmPwd" name="nConfirmPwd"
                                        placeholder="Password" required>
                                </div>    
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3" for="InputGender">Gender</label>
                                <div class="col-sm-9">
                                    <select class="form-control" id="InputGender" name="nGender">
                                        <option selected>Male</option>
                                        <option>Female</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3" for="InputRole">Role</label>
                                <div class="col-sm-9">
                                    <select class="form-control" id="InputRole" name="nRole">
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
                                    <input type="email" class="form-control" id="InputEmail1" name="nEmail"
                                        placeholder="Enter email" required>
                                </div>
                            </div>
                            <div class="form-group">
                                <label  class="col-sm-3" for="InputPhNum">Phone Number</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" id="InputPhNum" name="nPhNum"
                                           placeholder="Enter Phone Number">
                                </div>    
                            </div>

                            <div class="form-group">
                                <label class="col-sm-3" for="InputProfilePic">Profile Picture Upload
                                    <span style ="color: red"><br/><br/>Only '.jpeg', '.jpg', '.png', '.bmp' formats are allowed.</span>
                                </label>
                                <div class="col-sm-9 fileinput fileinput-new" data-provides="fileinput">
                                  <div class="fileinput-new thumbnail" style="width: 200px; height: 150px;">
                                    <img data-src="holder.js/100%x100%" alt="...">
                                  </div>
                                  <div class="fileinput-preview fileinput-exists thumbnail" style="max-width: 200px; max-height: 150px;"></div>
                                  <div>
                                    <span class="btn btn-default btn-file">
                                        <span class="fileinput-new">Select image</span>
                                        <span class="fileinput-exists">Change</span><input type="file" name="facePic" accept="image/*">
                                    </span>
                                    <a href="#" class="btn btn-default fileinput-exists" data-dismiss="fileinput">Remove</a>
                                  </div>
                                </div>  
                           </div>
                      </div> <!--modal body -->

                      <div class="modal-footer">
                        <input type="hidden" name="action" value="add"/> 
                        <!-- Do NOT use name="submit" or id="submit" for the Submit button -->
                        <button type="submit" class="btn btn-primary">Add</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                      </div>
                    </form>

                    </div> <!--modal content -->
                  </div> <!--modal dialog -->
                </div> 
                <!-- End of New user modal -->    

                <!-- Edit User Modal -->
                <div class="modal fade" id="user_pop_up" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                  <div class="modal-dialog">
                    <div class="modal-content">

                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">
                            <span aria-hidden="true">&times;</span>
                            <span class="sr-only">Close</span>
                        </button>
                        <h3 class="modal-title" id="newUser_pop_up_label" align="center">
                            Edit User Form
                        </h3>
                      </div> <!--modal-header-->

                      <form id="editUserForm" method="post" action="processUser.do" class="form-horizontal" 
                            enctype="multipart/form-data">
                        <div class="modal-body">
                            <div class="form-group">
                                <label class="col-sm-3">NRIC Number <span style="color: red">*</span></label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" id="InputNRIC" name="nNRIC"
                                        placeholder="Enter NRIC Number" readOnly="readOnly">
                                    </input>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3" for="InputFullName">Full Name <span style="color: red">*</span></label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" id="InputFullName" name="nFullName"
                                        placeholder="Enter Full Name">
                                </div>    
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3" for="InputAlias">Alias</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" id="InputAlias" name="nAlias"
                                        placeholder="Enter Alia">
                                </div>    
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3" for="InputUsername">Username<span style="color: red">*</span></label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" id="InputUsername" name="nUsername"
                                           placeholder="Username" readOnly="readOnly">
                                    <!--<span class="form-control edit_username"></span>-->
                                </div>    
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3" for="InputGender">Gender</label>
                                <div class="col-sm-9">
                                    <select class="form-control" id="InputGender" name="nGender">
                                        <option selected>Male</option>
                                        <option>Female</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3" for="InputRole">Role</label>
                                <div class="col-sm-9">
                                    <select class="form-control" id="InputRole" name="nRole">
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
                                    <input type="email" class="form-control" id="InputEmail1" name="nEmail"
                                        placeholder="Enter email">
                                </div>
                            </div>
                            <div class="form-group">
                                <label  class="col-sm-3" for="InputPhNum">Phone Number</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" id="InputPhNum" name="nPhNum"
                                           placeholder="Enter Phone Number">
                                </div>    
                            </div>

                            <div class="form-group">
                                <label class="col-sm-3" for="InputProfilePic">Profile Picture Upload
                                    <span style ="color: red"><br/><br/>Only '.jpeg', '.jpg', '.png', '.bmp' formats are allowed.</span>
                                </label>
                                <!--
                                <div class="col-sm-4">
                                    <img id="InputPhoto" src="" id=""style="width: 150px; height: 150px;">
                                </div>-->
                                <div class="col-sm-4 fileinput fileinput-new" data-provides="fileinput">
                                  <div class="fileinput-new thumbnail" style="width: 150px; height: 150px;">
                                    <img id="InputPhoto" data-src="">
                                  </div>
                                  <div class="fileinput-preview fileinput-exists thumbnail" style="max-width: 150px; max-height: 150px;"></div>
                                  <div>
                                    <span class="btn btn-default btn-file">
                                        <span class="fileinput-new">Select image</span>
                                        <span class="fileinput-exists">Change</span><input type="file" name="nPhotoPath" accept="image/*">
                                    </span>
                                    <a href="#" class="btn btn-default fileinput-exists" data-dismiss="fileinput">Remove</a>
                                  </div>
                                </div>  
                           </div>
                      </div> <!--modal body -->

                      <div class="modal-footer">
                        <input type="hidden" name="action" value="edit"/>  
                        <!-- Do NOT use name="submit" or id="submit" for the Submit button -->
                        <button type="submit" class="btn btn-primary">Save</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                      </div>
                    </form>

                    </div> <!--modal content -->
                  </div> <!--modal dialog -->
                </div> 
                <!-- End of Edit User modal -->    

                <!-- Confirm Deactivate Modal -->
                <div class="modal fade" id="user_delete_confirm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" 
                     aria-hidden="true">
                  <div class="modal-dialog">
                    <div class="modal-content">

                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">
                            <span aria-hidden="true">&times;</span>
                            <span class="sr-only">Close</span>
                        </button>
                        <h3 class="modal-title" id="newUser_pop_up_label" align="center">
                            Deactivate User
                        </h3>
                      </div> <!--modal-header-->
                      <form id="deleteConfirmForm" method="post" action="processUser.do" class="form-horizontal">
                        <div class="modal-body">
                            <!--<input type="hidden" name="deleteUserName" id="deleteUserName" value=""/>-->

                            Are you sure you want to deactivate this user?<br/><br/>
                            <div class="form-group">
                                <label class="col-sm-3" for="InputUsername">Username<span style="color: red">*</span></label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" id="InputUsername" name="nUsername"
                                        placeholder="Username" readOnly="readOnly">
                                </div>    
                            </div>

                        </div> <!--modal body -->

                        <div class="modal-footer">
                          <input type="hidden" name="action" value="inactive"/> 
                          <button type="submit" class="btn btn-primary">Ok</button>
                          <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        </div>
                    </form>

                    </div> <!--modal content -->
                  </div> <!--modal dialog -->
                </div> 
                <!-- End of Confirm Deactivate Modal-->

                <!-- Confirm Activate Modal -->
                <div class="modal fade" id="user_activate_confirm" tabindex="-1" role="dialog" 
                     aria-labelledby="myModalLabel" aria-hidden="true">
                  <div class="modal-dialog">
                    <div class="modal-content">

                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">
                            <span aria-hidden="true">&times;</span>
                            <span class="sr-only">Close</span>
                        </button>
                        <h3 class="modal-title" id="newUser_pop_up_label" align="center">
                            Activate User
                        </h3>
                      </div> <!--modal-header-->
                      <form id="activateUserForm" method="post" action="processUser.do" class="form-horizontal">
                        <div class="modal-body">
                            <!--<input type="hidden" name="deleteUserName" id="deleteUserName" value=""/>-->

                            Are you sure you want to activate this user?<br/><br/>
                            <div class="form-group">
                                <label class="col-sm-3" for="InputUsername">Username<span style="color: red">*</span></label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" id="InputUsername" name="nUsername"
                                        placeholder="Username" readOnly="readOnly">
                                </div>    
                            </div>

                        </div> <!--modal body -->

                        <div class="modal-footer">
                          <input type="hidden" name="action" value="active"/> 
                          <button type="submit" class="btn btn-primary">Ok</button>
                          <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        </div>
                    </form>

                    </div> <!--modal content -->
                  </div> <!--modal dialog -->
                </div> 
                <!-- End of Confirm Activate Modal-->

                <!-- Reset Password Modal -->
                <div class="modal fade" id="user_reset_pwd" tabindex="-1" role="dialog" 
                     aria-labelledby="myModalLabel" aria-hidden="true">
                  <div class="modal-dialog">
                    <div class="modal-content">

                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">
                            <span aria-hidden="true">&times;</span>
                            <span class="sr-only">Close</span>
                        </button>
                        <h3 class="modal-title" id="user_reset_pwd_label" align="center">
                            Reset Password
                        </h3>
                      </div> <!--modal-header-->
                      <form id="resetPwd" method="post" action="processUser.do" class="form-horizontal">
                        <div class="modal-body">

                            <div class="form-group">
                                <label class="col-sm-3" for="InputUsername">Username<span style="color: red">*</span></label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" id="InputUsername" name="nUsername"
                                        placeholder="Username" readOnly="readOnly">
                                </div>    
                            </div>

                            <div class="form-group">
                                <label class="col-sm-3" for="InputPwd">Password<span style="color: red">*</span></label>
                                <div class="col-sm-9">
                                    <input type="password" class="form-control" id="InputPwd" name="nPwd"
                                        placeholder="Password" required>
                                </div>    
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3" for="InputConfirmPwd">Retype Password<span style="color: red">*</span></label>
                                <div class="col-sm-9">
                                    <input type="password" class="form-control" id="InputConfirmPwd" name="nConfirmPwd"
                                        placeholder="Password" required>
                                </div>    
                            </div>

                      </div> <!--modal body -->

                      <div class="modal-footer">
                        <!-- Do NOT use name="submit" or id="submit" for the Submit button -->
                        <input type="hidden" name="action" value="resetPwd"/> 
                        <button type="submit" class="btn btn-primary">Reset Password</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <!-- Do NOT use name="submit" or id="submit" for the Submit button -->
                      </div>
                    </form>

                    </div> <!--modal content -->
                  </div> <!--modal dialog -->
                </div> 
                <!-- End of Reset Password Modal-->

            </div>                    
        </div>
        <script>
            //ready the data in tables
            $(document).ready(function () {
                $.sessionTimeout({
                    message: 'Your session will be expired in one minute.',
                    keepAliveUrl: 'keep-alive.html',
                    logoutUrl: 'index.jsp',
                    redirUrl: 'logout.jsp',
                    warnAfter: 900000,
                    redirAfter: 120000
                });
            });
            
            //ready the data in tables
            $(document).ready(function () {
                $('#users-table').dataTable();
            });    
            //passing data for edit form
            $(document).on( "click", '.edit_popup',function() {

                    var nricNum = $(this).data('nric');
                    var fullName = $(this).data('fullname');
                    var alias = $(this).data('alias');
                    var username = $(this).data('username');
                    var gender = $(this).data('gender');
                    var role = $(this).data('role');
                    var email = $(this).data('email');
                    var phone = $(this).data('phone');
                    var photo = $(this).data('photo');

                    $(".modal-body #InputNRIC").val(nricNum);
                    $(".modal-body #InputFullName").val(fullName);
                    $(".modal-body #InputAlias").val(alias);
                    $(".modal-body #InputUsername").val(username);
                    $(".modal-body #InputGender").val(gender);
                    $(".modal-body #InputRole").val(role);
                    $(".modal-body #InputEmail1").val(email);
                    $(".modal-body #InputPhNum").val(phone);
                    $(".modal-body #InputPhoto").attr('src', photo);
                    //$(".edit_nric").val(nricNum);
                    //$(".edit_fullName").val(fullName);
                    //$(".edit_alias").val(alias);
                    //$(".edit_username").val(username);
                    //$(".edit_gender").val(gender);
                    //$(".edit_role").val(role);
                    //$(".edit_email").val(email);
                    //$(".edit_phone").val(phone);
                    //$(".edit_photo").val(photo);

            });
            //passing data for inactive pop 
            $(document).on( "click", '.delete_popup',function() {

                    var username = $(this).data('username');

                    $(".modal-body #InputUsername").val(username);
                    //$("#user_delete_confirm").modal('show');

            });
            
            //passing data for reset password
            $(document).on( "click", '.user_reset_pwd',function() { //Modal class

                    var username = $(this).data('username');

                    $(".modal-body #InputUsername").val(username);
                    //$("#user_delete_confirm").modal('show');

            });
            //add form validation 
            $(document).ready(function() {
                $('#newUserForm') //Form Id
                    .bootstrapValidator({
                    feedbackIcons: {
                        valid: 'glyphicon glyphicon-ok',
                        invalid: 'glyphicon glyphicon-remove',
                        validating: 'glyphicon glyphicon-refresh'
                    },
                    fields: {
                        nNRIC: {
                            validators: {
                                notEmpty: {
                                    message: 'NRIC number cannot be empty.'
                                },
                                stringLength: {
                                    min:9,
                                    max:9,
                                    message: 'NRIC number must be exactly 9 characters long.'
                                },
                                regexp: {
                                  regexp: /^[A-Z][0-9]{7}[A-Z]/,
                                  message: 'NRIC number must start with an alphabet followed by 7 digits and ends with an alphabet.'
                                },
                                remote: {
                                    message: 'NRIC number already exits in the system',
                                    url: 'processUser.do',
                                    data: function(validator) {
                                        return {
                                            nNRIC:validator.getFieldElements('nNRIC').val()
                                        };
                                    }
                                }
                            }
                        },
                        nFullName: {
                            validators: {
                                notEmpty: {
                                    message: 'Fullname cannot be empty.'
                                },
                                stringLength: {
                                    max:50,
                                    message: 'Fullname must be less than 50 characters long.'
                                }
                            }
                        },
                        nAlias: {
                            validators: {
                                stringLength: {
                                    max:50,
                                    message: 'Alias name must be less than 50 characters long.'
                                }
                            }
                        },
                        nUsername: {
                            validators: {
                                notEmpty: {
                                    message: 'The username cannot be empty.'
                                },
                                stringLength: {
                                    min:6,
                                    max:20,
                                    message: 'The username must be more than 6 and less than 20 characters long.'
                                },
                                regexp: {
                                    regexp: /^[a-zA-Z0-9_]+$/,
                                    message: 'The username can only consists of alphabetical, number and underscore.'
                                },
                                remote: {
                                    message: 'Username already exits in the system',
                                    url: 'processUser.do',
                                    data: function(validator) {
                                        return {
                                            nUsername:validator.getFieldElements('nUsername:').val()
                                        };
                                    }
                                }
                            }
                        },
                        nPwd: {
                            validators: {
                                notEmpty: {
                                    message: 'The password cannot be empty.'
                                },
                                stringLength: {
                                    min:7,
                                    max:14,
                                    message: 'The password must be at least 7 characters and not more than' + 
                                        ' 14 characters long.'
                                },
                                different: {
                                    field: 'nUsername',
                                    message: 'The password cannot be the same as username'
                                },
                                identical: {
                                    field:'nConfirmPwd',
                                    message:'The password and its confirm are not the same.'
                                }
                            }
                        },
                        nConfirmPwd: {
                            validators: {
                                notEmpty: {
                                    message: 'The password cannot be empty.'
                                },
                                stringLength: {
                                    min:7,
                                    max:14,
                                    message: 'The password must be at least 7 characters and not more than' +
                                        ' 14 characters long.'
                                },
                                different: {
                                    field: 'nUsername',
                                    message: 'The password cannot be the same as username'
                                },
                                identical: {
                                    field:'nPwd',
                                    message:'The password and its confirm are not the same.'
                                }
                            }
                        },
                        nEmail: {
                            validators: {
                                notEmpty: {
                                    message: 'Email cannot be empty.'
                                },
                                emailAddress: {
                                    message: 'The email address is not valid.'
                                }
                            }
                        },
                        nPhNum: {
                            validators: {
                                regexp: {
                                    regexp: /^[\d|\-|(|)|+|\s]+$/, 
                                    message: 'Phone No can contain space, - , () , + and digits only.'
                                }
                            }
                        },
                        facePic: {
                           validators: {
                               file: {
                                   extension: 'png,jpeg,jpg,bmp',
                                   type: 'image/png,image/jpeg,image/jpg,image/bmp',
                                   maxSize: 1024*1024,
                                   message: 'Please choose an image file with a size less than 1M only.'
                               }
                           }
                       }
                    }
                })
                /*
                //enable the submit button only after all fields valiation pass
                .on('success.field.bv', function(e, data) {
                    if (data.bv.isValid()) {
                        data.bv.disableSubmitButtons(false);
                    } else {
                        data.bv.disableSubmitButtons(true);
                    }
                });
                */
            });

            //to reset all the fields whenever the modal is opened [***need to resolve for picture]
            $('#newUser_pop_up').on('shown.bs.modal', function() {
                $('#newUserForm').bootstrapValidator('resetForm', true);
            });
            //edit form validation check
            $(document).ready(function() {
                $('#editUserForm')
                .bootstrapValidator({
                    feedbackIcons: {
                        valid: 'glyphicon glyphicon-ok',
                        invalid: 'glyphicon glyphicon-remove',
                        validating: 'glyphicon glyphicon-refresh'
                    },
                    fields: {
                        nFullName: {
                            validators: {
                                notEmpty: {
                                    message: 'Fullname cannot be empty.'
                                },
                                stringLength: {
                                    max:50,
                                    message: 'Fullname must be less than 50 characters long.'
                                }
                            }
                        },
                        nAlias: {
                            validators: {
                                stringLength: {
                                    max:50,
                                    message: 'Alias name must be less than 50 characters long.'
                                }
                            }
                        },
                        nEmail: {
                            validators: {
                                notEmpty: {
                                    message: 'Email cannot be empty.'
                                },
                                emailAddress: {
                                    message: 'The email address is not valid.'
                                }
                            }
                        },
                        nPhNum: {
                            validators: {
                                regexp: {
                                    regexp: /^[\d|\-|(|)|+|\s]+$/, 
                                    message: 'Phone No can contain space, - , () , + and digits only.'
                                }
                            }
                        },
                        nPhotoPath: {
                           validators: {
                               file: {
                                   extension: 'png,jpeg,jpg,bmp',
                                   type: 'image/png,image/jpeg,image/jpg,image/bmp',
                                   maxSize: 1024*1024,
                                   message: 'Please choose an image file with a size less than 1M only.'
                               }
                           }
                       }
                    }
                })

            });
            //reset password form validation check
            $(document).ready(function() {
                $('#resetPwd')
                .bootstrapValidator({
                    feedbackIcons: {
                        valid: 'glyphicon glyphicon-ok',
                        invalid: 'glyphicon glyphicon-remove',
                        validating: 'glyphicon glyphicon-refresh'
                    },
                    fields: {
                        nPwd: {
                            validators: {
                                notEmpty: {
                                    message: 'The password cannot be empty.'
                                },
                                stringLength: {
                                    min:7,
                                    max:14,
                                    message: 'The password must be at least 7 characters and not more than' + 
                                        ' 14 characters long.'
                                },
                                identical: {
                                    field:'nConfirmPwd',
                                    message:'The password and its confirm are not the same.'
                                }
                            }
                        },
                        nConfirmPwd: {
                            validators: {
                                notEmpty: {
                                    message: 'The password cannot be empty.'
                                },
                                stringLength: {
                                    min:7,
                                    max:14,
                                    message: 'The password must be at least 7 characters and not more than' +
                                        ' 14 characters long.'
                                },
                                identical: {
                                    field:'nPwd',
                                    message:'The password and its confirm are not the same.'
                                }
                            }
                        } 
                    }
                })
            }); 
            //to reset all the fields whenever the modal is opened [***need to resolve for picture]
            $('#user_reset_pwd').on('shown.bs.modal', function() {
                $('#resetPwd').bootstrapValidator('resetForm', true);
            });
                    

        </script>
        
    </body>
</html>
    