<%@ page import="java.util.Calendar" %><%--
  Created by IntelliJ IDEA.
  User: changcan
  Date: 2018/7/10
  Time: 14:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%--<link rel="stylesheet" href="${pageContext.request.contextPath}/js/css/main.css"/>--%>

</head>
<body>
<%
    Calendar calendar=Calendar.getInstance();
    int year =calendar.get(Calendar.YEAR);
%>

<center> &copy;<%=year%><footfont>  南京熊猫家电有限公司  版权所有</footfont></center>

</body>
</html>
