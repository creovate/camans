<%-- 
    Document   : admin
    Created on : Jan 7, 2015, 4:22:18 PM
    Author     : soemyatmyat
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/bootstrap.min.css" media="screen" />
        <link rel="stylesheet" href="css/bootstrap-theme.min.css" media="screen" />
        <link rel="stylesheet" href="css/custom.css" media="screen" /> 
          
        <script src="js/jquery-2.1.1.js"></script>
        <script src="js/bootstrap.min.js"></script>         

        <link rel="shortcut icon" href="img/twc_logo.png">
        <title>Camans</title>
    </head>
    <body>
        <jsp:include page="include/navbartop.jsp"/>
        <jsp:include page="include/navbarside.jsp"/>
        <div class="col-md-10">
            
            <!-- Page Header -->
            <div class="page-header">
            <center><h2 style="color:#2980b9">Administration <small> Dashboard</small></h2>   
            </div>
            
            <div class="row">
                <div class="col-xs-6">
                    <h3 style="color:#2980b9">Bootstrap</h3><br>
                    <form id="" method="post" action="#" enctype="multipart/form-data">           
                        Select file to upload: <input type="file" name="zip" accept="application/zip"/><br>                                   
                        To bootstrap, please select a ZIP file <br>then click on Load Data.<br/><br/>                    
                        <button class="btn btn-primary" type="submit">Load Data</button>

                    </form>
                    <br/>
                </div> 
                <div class="col-xs-6">
                    <h3 style="color:#2980b9">Import/ Export Data</h3><br/>
                </div>
            </div>
            
        </div>
    </body>
</html>
