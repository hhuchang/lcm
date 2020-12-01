<%@ taglib prefix="s" uri="/struts-tags" %>
<%--
  Created by IntelliJ IDEA.
  User: changcan
  Date: 2018/7/4
  Time: 10:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登陆</title>
</head>
<body>
    <em><strong>We're sorry...you need to log in again.</strong></em>
<form action="/content/testJsp.jsp" method="post">
    <s:token name="tokenSession"></s:token>
    Name:<input name="usernameok" type="text">
    <input name="Submit" type="submit">
</form>

</body>
</html>
