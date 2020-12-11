<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: changcan
  Date: 2018/8/16
  Time: 15:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>熊猫云管理后台</title>
    <script type="text/javascript" src="<c:url value="/js/jquery.min.js"/>"></script>

    <script type="text/javascript" src="<c:url value="/js/jquery.easyui.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/js/locale/easyui-lang-zh_CN.js"/>"></script>
    <link rel="stylesheet" href="<c:url value="/js/themes/default/easyui.css"/>" type="text/css"/>
    <link rel="stylesheet" href="<c:url value="/js/themes/icon.css"/>" type="text/css"/>
    <link rel="stylesheet" href="<c:url value="/css/main.css"/>"/>



</head>
<body>

        <div align="center" style="width: 100%;height: 100%;" >

        <div class="easyui-layout" align="center" style="width:90%;height: 98%;">
            <div data-options="region:'north'" style="height: 10%;">
                <%--header--%>
                <%@include file="admin_main_head.jsp"%>

            </div>
            <div data-options="region:'south'" style="height: 50px;">
                <%--footer--%>
                <%@include file="admin_main_foot.jsp"%>
            </div>
            <div data-options="region:'west',collapsible:false" title="管理菜单" style="width: 200px;">
            <%@include file="admin_main_left.jsp"%>
            </div>
            <div id="mainPage" data-options="region:'center',border:true,href:'<%--/appAction_getAllApps--%>'" >
                    <%--main--%>
                    <%--数据可视化--%>
                        <div >熊猫云后台欢迎您!</div>


            </div>


        </div>
        </div>



</body>

</html>
