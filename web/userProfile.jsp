<%-- 
    Document   : userProfile
    Created on : Dec 19, 2014, 2:33:34 PM
    Author     : soemyatmyat
--%>
<%@ include file="protect.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    //==========================================//
    //          Data Collection                 
    //==========================================//

    User userLogin = (User) request.getSession().getAttribute("userLogin");
    String userNRIC = userLogin.getNricNumber();
    String userFullName = userLogin.getFullName();
    String userAlias = userLogin.getAlias();
    String username = userLogin.getUsername();
    String userGender = userLogin.getGender();
    String userRole = userLogin.getRole();
    String userEmail = userLogin.getEmailAddress();
    String userPh = userLogin.getPhoneNumber();
    String userPhoto = userLogin.getPhotoPath();
    String userPwd = userLogin.getPassword();
    
    String successMsg = (String) request.getSession().getAttribute("successMsg");
    request.getSession().removeAttribute("successMsg");
    
    String errorMsg = (String) request.getSession().getAttribute("errorMsg");
    request.getSession().removeAttribute("errorMsg");
    //==========================================//
    //         End of Data Collection                 
    //==========================================//   
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/bootstrap.css" media="screen" />
        <link rel="stylesheet" href="css/bootstrap-theme.min.css" media="screen" />
        <!-- Bootstrap Validator CSS, Added by soemyatmyat -->
        <link rel="stylesheet" href="css/bootstrapValidator.min.css"/>
        
        <!--jasny-bootstrap v3.1.3, added by soemyatmayt-->
        <link rel="stylesheet" href="css/jasny-bootstrap.css"/>
        <link rel="stylesheet" href="css/custom.css" media="screen" /> 
        
        
        <script src="js/jquery-2.1.1.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <!-- BootstrapValidator JS, Added by soemyatmyat-->
        <script type="text/javascript" src="js/bootstrapValidator.min.js"></script>       
        <!--jasny-bootstrap v3.1.3, added by soemyatmyat-->
        <script src="js/jasny-bootstrap.js"></script>     
        <!--bootstrap session timeout, added by soemyatmyat-->
        <script src="js/bootstrap-session-timeout.min.js"></script> 
        
        <link rel="shortcut icon" href="img/twc_logo.png">
   
        <title>CAMANS</title>
    </head>
    <body style='background:white'>
        <jsp:include page="include/navbartop.jsp"/>
        <jsp:include page="include/navbarside.jsp"/>

        <div class="col-md-offset-2 col-md-10">
            
            <div class="page-header col-md-12">
                <center><h2>User Profile Page</h2></center>    
            </div>
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
                <%=errorMsg%>
            </div>

            <% } %>
            <!-- End of success & error display -->
            <div class="col-md-12 text-right" >
                <button class="btn btn-blue changePwd_popup" data-username='<%=username%>' 
                        data-toggle="modal" data-target="#user_change_pwd">Change Password</button>
                <button class="btn btn-blue edit_popup" data-nric='<%=userNRIC%>' data-fullname='<%=userFullName%>' 
                        data-alias='<%=userAlias%>' data-username='<%=username%>' 
                        data-gender='<%=userGender%>'data-role='<%=userRole%>' 
                        data-email='<%=userEmail%>' data-phone='<%=userPh%>' 
                        data-photo='<%=userPhoto%>' data-toggle="modal" data-target="#user_pop_up">
                    Edit Profile
                </button><br/><br/>

                <div class="panel panel-default">
                    <p class="color-header text-center">Profile    </p>
                    <div class="panel-body">
                        <div class="text-center">
                            <img src="<%=(userPhoto==null)?"img/profile_pic.jpg":userPhoto%>" style="width: 150px; height: 150px;"/>
                        </div>
                    </div>

                    <p class="color-header text-center">Basic Information</p>
                    <div class="panel-body">
                        <div class="col-md-12 text-left">
                            <table class="table table-condensed">
                                <tr>
                                    <td class="tbl_lbl">NRIC Number</td>
                                    <td><%=userNRIC%></td>
                                </tr>
                                <tr>
                                    <td class="tbl_lbl">Full Name</td>
                                    <td><%=userFullName%></td>
                                </tr>
                                <tr>
                                    <td class="tbl_lbl">Username</td>
                                    <td><%=username%></td>
                                </tr>
                                <tr>
                                    <td class="tbl_lbl">Role</td>
                                    <td><%=userRole%></td>
                                </tr>
                            </table>
                        </div>
                    </div>

                    <p class="color-header text-center">Personal Particulars</p>
                    <div class="panel-body">
                        <div class="col-md-12 text-left">
                            <table class="table table-condensed">
                                <tr>
                                    <td class="tbl_lbl">Alias</td>
                                    <td><%=userAlias%></td>
                                </tr>
                                <tr>
                                    <td class="tbl_lbl">Gender</td>
                                    <td><%=userGender%></td>
                                </tr>
                                <tr>
                                    <td class="tbl_lbl">Email Address</td>
                                    <td><%=userEmail%></td>
                                </tr>
                                <tr>
                                    <td class="tbl_lbl">Phone Number</td>
                                    <td><%=userPh%></td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>    
            </div>            
        
                     
        <!-- Edit User Modal -->
        <div class="modal fade" id="user_pop_up" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">

              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span>
                    <span class="sr-only">Close</span>
                </button>
                <h3 class="modal-title" id="newUser_pop_up_label"  align="center">
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
                            <input type="text" class="form-control" id="InputRole" name="nRole" readOnly="readOnly">
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
                        <div class="col-sm-4 fileinput fileinput-new" data-provides="fileinput">
                          <div class="fileinput-new thumbnail" style="width: 150px; height: 150px;">
                            <img id="InputPhoto" data-src="">
                          </div>
                          <div class="fileinput-preview fileinput-exists thumbnail" style="max-width: 150px; max-height: 150px;"></div>
                          <div>
                            <span class="btn btn-default btn-file">
                                <span class="fileinput-new">Select image </span>
                                <span class="fileinput-exists">Change</span><input type="file" name="nPhotoPath" accept="image/*">>
                            </span>
                            <a href="#" class="btn btn-default fileinput-exists" data-dismiss="fileinput">Remove</a>
                          </div>
                        </div>  
                   </div>
              </div> <!--modal body -->

              <div class="modal-footer">
                <input type="hidden" name="action" value="edit"/>  
                <input type="hidden" name="page" value="userProfile.jsp"/>
                <!-- Do NOT use name="submit" or id="submit" for the Submit button -->
                <button type="submit" class="btn btn-primary">Save</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
              </div>
            </form>

            </div> <!--modal content -->
          </div> <!--modal dialog -->
        </div> 
        <!-- End of Edit User modal -->     
        
        <!-- Change Password Modal -->
        <div class="modal fade" id="user_change_pwd" tabindex="-1" role="dialog" 
             aria-labelledby="myModalLabel" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">

              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span>
                    <span class="sr-only">Close</span>
                </button>
                <h3 class="modal-title" id="user_reset_pwd_label"  align="center">
                    Change Password
                </h3>
              </div> <!--modal-header-->
              <form id="changePwd" method="post" action="processUser.do" class="form-horizontal">
                <div class="modal-body">

                    <div class="form-group">
                        <label class="col-sm-3" for="InputUsername">Username<span style="color: red">*</span></label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" id="InputUsername" name="nUsername"
                                placeholder="Username" readOnly="readOnly">
                        </div>    
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3" for="InputPwd">Old Password<span style="color: red">*</span></label>
                        <div class="col-sm-9">
                            <input type="password" class="form-control" id="InputOldPwd" name="nOldPwd"
                                placeholder="Enter old password" required>
                        </div>    
                    </div>
                    
                    <div class="form-group">
                        <label class="col-sm-3" for="InputPwd">New Password<span style="color: red">*</span></label>
                        <div class="col-sm-9">
                            <input type="password" class="form-control" id="InputPwd" name="nPwd"
                                placeholder="Enter new Password" required>
                        </div>    
                    </div>
                    
                    <div class="form-group">
                        <label class="col-sm-3" for="InputConfirmPwd">Retype New Password<span style="color: red">*</span></label>
                        <div class="col-sm-9">
                            <input type="password" class="form-control" id="InputConfirmPwd" name="nConfirmPwd"
                                placeholder="Enter new Password" required>
                        </div>    
                    </div>

              </div> <!--modal body -->

              <div class="modal-footer">
                <!-- Do NOT use name="submit" or id="submit" for the Submit button -->
                <input type="hidden" name="action" value="resetPwd"/> 
                <input type="hidden" name="page" value="userProfile.jsp"/>
                <button type="submit" class="btn btn-primary">Change Password</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <!-- Do NOT use name="submit" or id="submit" for the Submit button -->
              </div>
            </form>

            </div> <!--modal content -->
          </div> <!--modal dialog -->
        </div> 
        <!-- End of Reset Password Modal-->
                 
        </div>
        <script>
            
            //session time out
            $(document).ready(function () {
                $.sessionTimeout({
                    message: 'Your session will be expired in five minutes.',
                    keepAliveUrl: 'keep-alive.html',
                    logoutUrl: 'logout.jsp',
                    redirUrl: 'logout.jsp',
                    warnAfter: 900000, //15 minutes
                    redirAfter: 1200000 // 20 minutes
                });
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

            });

            //passing data for change password
            $(document).on( "click", '.changePwd_popup',function() { //Modal class

                    var username = $(this).data('username');

                    $(".modal-body #InputUsername").val(username);
                    //$("#user_delete_confirm").modal('show');

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
                                    message: 'Fullname must not exceed 50 characters.'
                                }
                            }
                        },
                        nAlias: {
                            validators: {
                                stringLength: {
                                    max:50,
                                    message: 'Alias name must not exceed 50 characters.'
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
                                },
                                stringLength: {
                                    max:20,
                                    message: 'Phone number must not exceed 20 characters.'
                                }
                            }
                        }
                    }
                })

            });
            
            //reset password form validation check
            $(document).ready(function() {
                $('#changePwd')
                .bootstrapValidator({
                    feedbackIcons: {
                        valid: 'glyphicon glyphicon-ok',
                        invalid: 'glyphicon glyphicon-remove',
                        validating: 'glyphicon glyphicon-refresh'
                    },
                    fields: {   
                        nOldPwd: {
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
                                remote: {
                                    message:'Wrong Password!',
                                    url:'processUser.do',
                                    data: function(validator) {
                                        return {
                                            nOldPwd:validator.getFieldElements('nOldPwd:').val()
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

        </script>                    
    </body>     
</html>
