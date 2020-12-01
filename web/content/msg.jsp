<%@ taglib prefix="s" uri="/struts-tags" %>
<%--
  Created by IntelliJ IDEA.
  User: changcan
  Date: 2018/6/15
  Time: 10:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>上传结果</title>
</head>
<body>
<center>
    上传功能<br/>
    文件标题：<s:property value="+ title"/><br/>

    <h2>${msg}</h2>
    <s:debug></s:debug>
</center>

</body>
</html>
