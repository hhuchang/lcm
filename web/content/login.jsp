<%@ taglib prefix="s" uri="/struts-tags" %>
<%--
  Created by IntelliJ IDEA.
  User: changcan
  Date: 2018/5/24
  Time: 14:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登陆</title>
</head>
<body>
<form action="/userAction_reg" method="post">
    <s:token name="tokenSession"></s:token>
    <table align="center">
        <caption><h2>用户登录</h2></caption>
        <tr>
            <td>用户名：<input type="text" name="username"/> </td>
        </tr>
        <tr>
            <td>密&nbsp;&nbsp;&nbsp;&nbsp;码：<input type="text" name="password"></td>
        </tr>
        <tr align="center">
            <td colspan="2"><input type="submit" value="注册"/><input type="reset" value="重置"></td>
        </tr>
    </table>
</form>

</body>
</html>
