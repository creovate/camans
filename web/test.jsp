<%@page import="java.util.ArrayList"%>
<%@page import="camans.dao.DropdownDAO"%>
<%@page import="camans.entity.Dropdown"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

<head>
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/mootools/1.2.4/mootools-yui-compressed.js"></script>
	<!-- Please put this on your own server when you use it! It's Sortables from "MooTools More" -->
	<script type="text/javascript" src="http://stuff.dan.cx/common/mootools-1.2.4.4-more-sortables.js"></script>
	<script type="text/javascript" src="scripts.js"></script>
        <script src="js/jquery-2.1.1.js"></script>
	<link rel="stylesheet" href="styles.css" type="text/css" />
</head>

<body>
<form name="myform" action="checkboxes.asp" method="post">
<b>Scripts for Web design and programming</b><br>
<input type="button" name="Check_All" value="Check All"
onClick="Check(document.myform.check_list)">   <br/>
    
<input type="checkbox" name="check_list" value="1">ASP<br>
<input type="checkbox" name="check_list" value="2">PHP<br>
<input type="checkbox" name="check_list" value="3">JavaScript<br>
<input type="checkbox" name="check_list" value="4">HTML<br>
<input type="checkbox" name="check_list" value="5">MySQL<br>



</form>

<SCRIPT LANGUAGE="JavaScript">
<!--


function Check(chk)
{
if(document.myform.Check_All.value=="Check All"){
for (i = 0; i < chk.length; i++)
chk[i].checked = true ;
document.myform.Check_All.value="UnCheck All";
}else{

for (i = 0; i < chk.length; i++)
chk[i].checked = false ;
document.myform.Check_All.value="Check All";
}
}

// End -->
</script>
    </body>
</html>
