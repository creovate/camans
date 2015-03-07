<style>
    #top-navbar {
        background: #004b6b;
        border: none;
    }

    #top-navbar ul li a{
        color: white;
    }

    #top-navbar ul li a:hover, #top-navbar ul li a:focus{
        background: transparent;
        border: none;
    }

    #top-navbar ul li ul{
        background: #006C9A;
    }
    #top-navbar ul li ul li a{
        color: white;
    }
    #top-navbar ul li ul li a :hover, #top-navbar ul li ul li a :focus{
        background: transparent;
    }
    #top-navbar ul li.dropdown.open{
        background: transparent;
        color: white;
    }

    .navbar-collapse{
        color: white;
    }

    .navbar-brand{
        padding-top: 5%;
        padding-left: 7%;

    }
    
    .collapsed :hover, .collapsed :focus{
        background: transparent;
    }
</style>


<nav class="navbar navbar-default navbar-fixed-top" id="top-navbar">
    <div class="container-fluid">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" style="color:white;" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                <span class="glyphicon glyphicon-align-justify"></span>
            </button>
            <a class="navbar-brand" href="home.jsp" style="color:white;">CAMANS</a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">

            <ul class="nav navbar-nav navbar-right">
                <li><a href="home.jsp">
                        <span class="glyphicon glyphicon-home" aria-hidden="true"></span>
                        Home
                    </a>
                </li>
                <li><a href="userProfile.jsp">
                        <span class="glyphicon glyphicon-user" aria-hidden="true"></span>
                        Profile
                    </a>
                </li>

                <li class="divider"></li>
                <li><a href="../logout.jsp">
                        <span class="glyphicon glyphicon-log-out" aria-hidden="true"></span>
                        Log Out
                    </a></li>
            </ul>
        </div><!-- /.navbar-collapse -->
    </div><!-- /.container-fluid -->
</nav>