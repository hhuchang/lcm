<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="mystool" uri="mySimpleTags"%>
<%--
  Created by IntelliJ IDEA.
  User: changcan
  Date: 2018/7/5
  Time: 0:17
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<html>
<head>
    <title>JSTL测试</title>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8">
</head>
<body>
<ul>
    <li>定义requst范围内的变量</li>
    <br>
    <c:set var="username" value="cc" />
    <c:out value="username为：${username}"/>
    <li>设置属性</li>
    <jsp:useBean id="userInfo" class="com.test.Model.UserInfo"/>
    <c:set target="${userInfo}" property="name" value="goods"/>


    <br>
    <c:out value="userinfo de name 属性值为：${userInfo.name}"/>
    <li>模拟删除</li>
    <c:remove var="username"/>
    <c:out value="username为：${username}"/>

</ul>
<c:catch var="myException">
    <% int x=10/0;%>

</c:catch>
健健康康没烦恼<br>
<c:if test="${myException!=null}">
    <strong>there was an exception:${myException.message}</strong>
</c:if>
<br>

<%--<c:import url="http://www.c2appstore.com"/>--%>
=================================<br>
<mystool:my/><br>
===================================<br>
<mystool:tag2>
    this is the body
</mystool:tag2>
<br>
${userInfo.name}
<br>
<mystool:tag2>
    ${userInfo.name}
</mystool:tag2>
<br>
====================================<br>
</body>
</html>
