<%@ taglib prefix="s" uri="/struts-tags" %>
<%--
  Created by IntelliJ IDEA.
  User: changcan
  Date: 2018/7/11
  Time: 10:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>添加App</title>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/locale/easyui-lang-zh_CN.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/themes/default/easyui.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/themes/icon.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/css/main.css">

    <%--------------------------------%>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/appstore.js"></script>



</head>
<body>

<h2>新增APP</h2>
<p>请为新增apk准备以下信息：</p>
<div style="margin:20px 0;"></div>
<center>
<div class="easyui-panel" title="apk信息" style="width:1000px ;padding:30px 70px 50px 70px">
    <s:form action="/appAction_addApk" method="post" enctype="multipart/form-data">
        <s:token name="tokenSession"></s:token>
    <div style="margin-bottom:20px">
        排序因子：<input class="easyui-textbox" name="orderby" style="width: 300px;">
    </div>
    <div style="margin-bottom:20px">
        应用文件：<input class="easyui-filebox"  name="apkfile" accept="application/vnd.android.package-archive" data-options="prompt:'请选择一个apk文件...'" onchange="loadApk(this)"   style="width: 300px;">
        <%--到struts中继续校验--%>
    </div>
    <div style="margin-bottom: 20px">
        应用名称：<input class="easyui-textbox" name="apkname" style="width: 300px;">
    </div>
    <div style="margin-bottom: 20px">
        应用版本：<input class="easyui-textbox" name="apkversion" style="width: 300px">
    </div>
    <div style="margin-bottom: 20px">
        截图
    </div>
    <div>
        <s:submit  class="easyui-linkbutton" style="width: 100px;height:30px;" value="提交"/>
    </div>
    </s:form>
</div>
</center>
</body>
</html>
