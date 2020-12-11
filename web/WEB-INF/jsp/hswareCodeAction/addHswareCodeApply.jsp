<%@ taglib prefix="s" uri="/struts-tags" %>
<%--
  Created by IntelliJ IDEA.
  User: changcan
  Date: 2018/11/8
  Time: 14:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>软硬件版本号申请列表</title>
</head>
<body>
<table border="1">
    <thead>
    <tr>
        <th>序号</th>
        <th>软件应版本号</th>
        <th>主板名</th>
        <th>配屏</th>
        <th>详情</th>
        <th>删除</th>

    </tr>
    </thead>
    <tbody>
    <s:iterator value="hswareCodes" status="st" var="everyitem">
        <tr>
            <td>${st.count}</td>
            <td>${everyitem.hsWareCode}</td>
            <td>${everyitem.mainBoard}</td>
            <td>${everyitem.productModel}</td>
            <td>${everyitem.screenModel}</td>
            <td>${everyitem.shellModel}</td>



        </tr>
    </s:iterator>
    </tbody>

</table>

</body>
</html>
