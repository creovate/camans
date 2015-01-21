<%-- 
    Document   : index
    Created on : Oct 23, 2014, 10:55:34 AM
    Author     : soemyatmyat
--%>
<%  
    session.removeAttribute("userLogin");
    String error = (String) request.getAttribute("errorMsg");
    if (error == null) {
        error = "";    
    }   
   
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/bootstrap.min.css" media="screen" />
        <link rel="stylesheet" href="css/bootstrap-theme.min.css" media="screen" />
        <link rel="stylesheet" href="css/slider.css" media="screen" />
        <link rel="stylesheet" href="css/bootstrap-select.min.css" media="screen" />
        <link rel="stylesheet" href="css/sticky-footer-navbar.css" media="screen" /> 
        <link rel="stylesheet" href="css/custom.css" media="screen" /> 
        <script src="js/jquery-2.1.1.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/bootstrap-slider.js"></script>
        <script src="js/bootstrap-select.min.js"></script>

        <link rel="shortcut icon" href="img/twc_logo.png">
        <title>CAMANS</title>
    </head>
    <body style="background:  white">
        <div class="main_div">
            <div class="row">
                <div id="login_form" class="col-md-offset-4 col-md-4 text-center">
                    <img src="img/twc_logo.png">
                    <br/>
                    <form method="post" action="authenticate.do" role="form">
                        <br/>
                        <div class="form-group">
                            <input type="text" class="form-control" name="username" placeholder="Username" required></input>
                        </div>
                        <br/>
                        <div class="form-group">
                            <input type="password" class="form-control" name="password" placeholder="Password" required></input>
                        </div>
                        <br/>
                        <button type="submit" class="btn btn-blue btn-lg btn-block">Log In</button>
                        <center><h4><span class="label label-danger"><%=error%></span></h4></center>
                    </form>
                    <br/>
                    <!--<a href="#">Forget Password?</a>-->
                </div>
            </div>
        </div>
    </body>    
</html>


