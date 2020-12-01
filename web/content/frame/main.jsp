<%@ taglib prefix="s" uri="/struts-tags" %>
<%--
  Created by IntelliJ IDEA.
  User: changcan
  Date: 2018/7/10
  Time: 14:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>熊猫云后台主页</title>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/locale/easyui-lang-zh_CN.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/themes/default/easyui.css" type="text/css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/themes/icon.css" type="text/css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/css/main.css"/>

</head>
<body>
    <%--<div class="easyui-layout" style="width: 1300px ;height: 600px;margin: 0 auto;">
        <div data-options="region:'west',title:'任务栏',split:true" style="width:10%;padding: 10px">
            <jsp:include page="left.jsp" />
        </div>
        <div data-options="region:'center',title:'中央面板'" >

        </div>
    </div>
    <div class="">

    </div>--%>
    <div id="container">
        <div id="header">
            <s:include value="head.jsp"/>
        </div>
        <div id="content">
            <div id="content-left">
                <s:include value="left.jsp"/>
            </div>
            <div id="content-center">

                <div id="linkbutton">
                    <s:include value="linkbutton.jsp"/>
                </div>
            </div>
        </div>
        <div class="clear"></div>
        <div id="footer">
            <s:include value="foot.jsp"/>
        </div>
    </div>




</body>
</html>
