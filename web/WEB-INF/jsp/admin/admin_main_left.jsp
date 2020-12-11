<%--
  Created by IntelliJ IDEA.
  User: changcan
  Date: 2018/8/16
  Time: 16:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%--<script type="text/javascript" src="<c:url value="/js/lefthref.js"/>"/>--%>
    <script type="text/javascript">
        function _href_getallapp() {
         $('#mainPage').load("/appAction_getAllApps");
         }
         function _href_newApp() {
             $('#mainPage').attr("data-options","region:'center',border:false,href:'/content/app/newApp.jsp'")
             <%--load("<c:url value='/content/app/newApp.jsp'/>");--%>
         }
         
        function changeAttr() {
            
        }
         
    </script>

</head>
<body>
        <div class="easyui-accordion" data-options="fit:true,border:false">
            <div title="应用管理" style="padding: 10px">
                <a href="/appAction_getAppPageBean">所有应用</a><br>
                <a href="/appAction_uploadApp">新增应用</a><br>
                <a href="/appTypeAction_getAppTypes">应用分类</a><br>
            </div>
            <div title="机型管理" style="padding-left: 10px">
                <a href="/devTypeAction_getAllDevtype">所有机型</a><br>
                <a href="#">新增机型</a>
            </div>
            <div title="升级管理" style="padding: 10px">
                <a href="#">升级条目</a><br>
                <a href="#">新增升级</a><br>
                <a href="#">升级级别</a>
            </div>
            <div title="终端管理" style="padding-left: 10px">
                <a href="terminalAction_getAllTerminal">所有终端</a><br>
                <a href="#">终端查询</a><br>
                <a href="#">导入工厂数据</a><br>
                <a href="#">导入售后数据</a><br>
                <a href="#">终端状态查询</a><br>
                <a href="hswareCodeAction_toApply">申请软硬件版本号</a><br>
                <a href="hswareCodeAction_getHswareCodeAll">所有软硬件版本号列表</a>
            </div>
            <div title="管理员管理" style="padding-left: 10px">
                <a href="/adminAction_getAllAdmin">管理员列表</a><br>
                <a href="#">新增</a>
            </div>
            <div title="用户管理" style="padding-left: 10px">
                <a href="/adminAction_getAllAdmin">用户列表</a><br>
                <a href="#">新增用户</a>
            </div>
            <div title="系统设置" style="padding-left: 10px">
                <a href="#">上传路径</a><br>
                <a href="#">缓存大小</a><br>
                <a href="/sysAction_backupSQL">数据库备份</a>
            </div>
        </div>

</body>
</html>
