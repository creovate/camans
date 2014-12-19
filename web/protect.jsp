
<%@page import="camans.entity.User"%>
<%
    User _user = (User) session.getAttribute("userLogin"); 

    
    if (_user== null) {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
        return;
    } 

%>    