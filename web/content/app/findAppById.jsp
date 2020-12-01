<%@ taglib prefix="s" uri="/struts-tags" %>
<%--
  Created by IntelliJ IDEA.
  User: changcan
  Date: 2018/7/10
  Time: 13:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>App详情</title>
</head>
<body>
<center>App编号为:${app.app_id}详情:</center>
app名称:<s:property value="app.app_name"/><br>
appid:<s:property value="app.app_id"/><br>
</body>
</html>
