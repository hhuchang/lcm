<%--
  Created by IntelliJ IDEA.
  User: changcan
  Date: 2018/5/23
  Time: 0:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>$Title$</title>
  </head>
  <body>
  <%
    request.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(request,response);
    //response.sendRedirect("/WEB-INF/jsp/login.jsp");
  %>

  </body>
</html>
