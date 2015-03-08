<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.HashMap"%>
<%@page import="camans.dao.*"%>
<%@page import="camans.entity.*"%>
<%@page import="java.util.ArrayList"%>
<%@ include file="../protect.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
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
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!--css-->
        <link rel="stylesheet" href="../css/bootstrap.css" media="screen" />
        <link rel="stylesheet" href="../css/custom.css" media="screen" /> 
        <link rel="stylesheet" href="../css/jquery-ui-1.9.2.custom.css">
        <link rel="stylesheet" href="../css/jquery-ui.structure.css">
        <link rel="stylesheet" href="../css/jquery-ui.theme.css">
        <link rel="stylesheet" href="../css/bootstrapValidator.min.css"/>
        <!-------------->

        <!--javascript-->
        <script src="../js/jquery-2.1.1.js"></script>
        <script src="../js/bootstrap.min.js"></script>
        <script src="../js/jquery-ui-1.9.2.custom.js"></script>
        <script type="text/javascript" src="../js/bootstrapValidator.min.js"></script>   
        <!------------->

        <!--tab icon-->
        <link rel="shortcut icon" href="../img/twc_logo.png">

        <!--page title-->
        <title>CAMANS</title>
        <style>
            form{
                margin-bottom: 5%;
            }
            h4, h5{
                padding: 1%;
                color:#006c9a;
            }
        </style>
        <script>
            //passing data for edit form
            $(document).on("click", '.edit_popup', function() {

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
            $(document).on("click", '.changePwd_popup', function() { //Modal class

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
                                    max: 50,
                                    message: 'Fullname must be less than 50 characters long.'
                                }
                            }
                        },
                        nAlias: {
                            validators: {
                                stringLength: {
                                    max: 50,
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
                                    min: 7,
                                    max: 14,
                                    message: 'The password must be at least 7 characters and not more than' +
                                            ' 14 characters long.'
                                },
                                remote: {
                                    message: 'Wrong Password!',
                                    url: 'processUser.do',
                                    data: function(validator) {
                                        return {
                                            nOldPwd: validator.getFieldElements('nOldPwd:').val()
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
                                    min: 7,
                                    max: 14,
                                    message: 'The password must be at least 7 characters and not more than' +
                                            ' 14 characters long.'
                                },
                                identical: {
                                    field: 'nConfirmPwd',
                                    message: 'The password and its confirm are not the same.'
                                }
                            }
                        },
                        nConfirmPwd: {
                            validators: {
                                notEmpty: {
                                    message: 'The password cannot be empty.'
                                },
                                stringLength: {
                                    min: 7,
                                    max: 14,
                                    message: 'The password must be at least 7 characters and not more than' +
                                            ' 14 characters long.'
                                },
                                identical: {
                                    field: 'nPwd',
                                    message: 'The password and its confirm are not the same.'
                                }
                            }
                        }
                    }
                });
            });
        </script>

    </head>
    <body id="home">
        <!-- Nav Bar -->
        <jsp:include page="navbar.jsp"/>
        <!-- End of Nav Bar-->
        <div class="col-xs-12 col-sm-offset-2 col-sm-8 col-md-offset-2 col-md-8">
            <h4>User Profile Page</h4> 
            <!-- success & error display -->
            <% if (successMsg != null) {%>

            <div class="alert alert-info" role="alert">
                <a href="#" class="close" data-dismiss="alert">&times;</a>
                <%=successMsg%>
            </div>

            <% }%>
            <% if (errorMsg != null) {%>

            <div class="alert alert-danger" role="alert">
                <a href="#" class="close" data-dismiss="alert">&times;</a>
                <%=errorMsg%>
            </div>

            <% }%>
            <!-- End of success & error display -->
            <div class="col-xs-12 col-sm-12 col-md-12 text-right" style='padding:0;'>
                <button class="btn btn-blue changePwd_popup btn-sm" data-username='<%=username%>' 
                        data-toggle="modal" data-target="#user_change_pwd">Change Password</button>
                                 <button class="btn btn-blue edit_popup btn-sm" data-nric='<%=userNRIC%>' data-fullname='<%=userFullName%>' 
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
                                             <img src="<%=(userPhoto == null) ? "../img/profile_pic.jpg" : userPhoto%>" style="width: 150px; height: 150px;"/>
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
                                                         <div class="col-sm-4 fileinput fileinput-new" data-provides="fileinput">
                                                             <div class="fileinput-new thumbnail" style="width: 150px; height: 150px;">
                                                                 <img id="InputPhoto" data-src="">
                                                             </div>
                                                             <div class="fileinput-preview fileinput-exists thumbnail col-xs-12"></div>
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
            </body>
        </html>
