<%--
  Created by IntelliJ IDEA.
  User: changcan
  Date: 2018/7/10
  Time: 14:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>


</head>
<body>
<div class="logofont">熊猫云管理中心</div>
<div >

    <div align="right">
        <div id="headerpanel" class="easyui-panel"  style="width: 300px;text-align: right;border: 0">
        <a href="#" class="easyui-linkbutton" data-options="plain:true"><span>用户：${sessionScope.admin.username}</span></a>
        <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-help'">帮助 </a>
        <a href="/loginAction_Logout" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-back'">退出</a>
        </div>
    </div>
</div>

</body>
</html>
