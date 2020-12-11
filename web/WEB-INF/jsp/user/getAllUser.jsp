<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: changcan
  Date: 2018/9/14
  Time: 14:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户管理</title>

    <script type="text/javascript" src="<c:url value="/js/jquery.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/js/jquery.easyui.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/js/locale/easyui-lang-zh_CN.js"/>"></script>
    <link rel="stylesheet" href="<c:url value="/js/themes/default/easyui.css"/>" type="text/css"/>
    <link rel="stylesheet" href="<c:url value="/js/themes/icon.css"/>" type="text/css"/>
    <link rel="stylesheet" href="<c:url value="/css/main.css"/>"/>
    <script type="text/javascript">
    </script>



    <script type="text/javascript">
        /*$('#app_list_datagrid').datagrid({
         loadMsg:'数据加载中....',
         pagination:true,
         pageSize:10,
         pageNumber:1,
         pageList:[5,10,15,20],


         })*/




        function deleteConfirm(id,name){

            $.messager.confirm('删除应用分类','您确定要删除：'+name+' 吗?',function (re) {
                if(re){
                    $.post('${pageContext.request.contextPath}/appAction_deleteAppById',{'id':id},function (data) {
                        $(location).attr('href', '${pageContext.request.contextPath}/appAction_getAppPageBean');
                    });
                    //alert("data+++"+id);
                }
            })
        }



    </script>
    <%@include file="../page/title.jsp"%>


</head>
<body>

<div align="center" style="width: 100%;height: 100%;" >

    <div class="easyui-layout" align="center" style="width:90%;height: 98%;">
        <div data-options="region:'north'" style="height: 10%;">
            <%--header--%>

            <%@include file="../admin/admin_main_head.jsp"%>

        </div>
        <div data-options="region:'south'" style="height: 50px;">
            <%--footer--%>
            <%@include file="../admin/admin_main_foot.jsp"%>
        </div>
        <div data-options="region:'west',collapsible:false" title="管理菜单" style="width: 200px;">
            <%@include file="../admin/admin_main_left.jsp"%>
        </div>


        <div id="mainPage" data-options="region:'center',border:false,href:'<%--/appAction_getAllApps--%>'" >
            <%--main--%>
            <%--数据可视化--%>


            <%--<s:property value="@java.lang.Math@PI"/><br>--%>
            <table id="app_list_datagrid" class="easyui-datagrid" title="用户列表" style="width: 100%;height: auto"
                   data-options="
            fitColumns:true,
            autoRowHeight:true,
            rownumbers:true,
            loadMsg:'数据加载中....',
            singleSelect:false,
            "

            >
                <thead>
                <tr>

                    <th data-options="field:'checkbox',checkbox:true"></th>


                    <th data-options="field:'appico',width:50,align:'center'">用户名</th>
                    <th data-options="field:'appname',width:120,halign:'center'">分组(权限)</th>



                    <th data-options="field:'apptype',width:60,align:'center'">邮箱</th>

                    <th data-options="field:'pagename',width:60,align:'center'">加入时间</th>
                    <th data-options="field:'status',width:60,align:'center'">最后登陆</th>

                    <th data-options="field:'region',width:60,align:'center'">状态</th>
                    <th data-options="field:'edit',width:100,align:'center'">操作</th>
                    <%--<th data-options="field:'edit',width:80">编辑</th>--%>
                </tr>
                </thead>
                <tbody>

                <s:iterator value="apps" status="st" var="app">
                    <tr>
                        <td></td>

                        <td><img src="<c:url value="${app.app_ico}"/> " alt="${app.app_name}" width="40px" height="40px"/></td>
                        <td>${app.app_name}</td>
                        <td>${app.app_type.apptype_name}</td>
                        <td>${app.pack_name}</td>
                        <s:if test="#app.status==0">
                            <td>已提交/待审核</td>
                        </s:if>
                        <s:elseif test="#app.status==1">
                            <td><img src="<c:url value="/images/yes.gif"/>">上架</td>
                        </s:elseif>
                        <s:elseif test="#app.status==2">
                            <td><img src="<c:url value="/images/no.gif"/>">下架</td>
                        </s:elseif>
                        <s:elseif test="#app.status==3">
                            <td>整改中</td>
                        </s:elseif>
                        <s:else>
                            <td></td>
                        </s:else>
                        <td>${app.app_ver}</td>

                            <%--<td><s:property value="#app.app_size"/></td>--%>
                        <td><fmt:formatDate value="${app.last_update}" type="date" pattern="yyyy-MM-dd HH:mm"/>
                        </td>
                            <%--<td><s:property value="#app.app_region_id"/></td>--%>

                            <%--<td><a href="/appAction_updateAppById?id=${app.app_id}">
                                    <img src="<c:url value="/images/icon_edit.gif"/>" alt="编辑" width="20px" height="20px"></a>
                                <a href="/appAction_deleteAppById?id=${app.app_id}">
                                    <img src="<c:url value="/images/icon_trash.gif"/>" alt="删除" width="20px" height="20px"></a>

                            </td>--%>
                        <td><a href="javascript:void(0)" onclick="javascript:updateIt('${app.app_id}','${app.app_name}')">
                            <img src="<c:url value="/images/icon_edit.gif"/>" alt="编辑" width="20px" height="20px"></a>
                            <a href="javascript:void(0)" onclick="javascript:deleteConfirm('${app.app_id}','${app.app_name}')">
                                <img src="<c:url value="/images/icon_trash.gif"/>" alt="删除" width="20px" height="20px"></a>

                        </td>


                    </tr>

                </s:iterator>
                </tbody>

                <%--实现分页的表格datagrid--%>
            </table>

            <%--删除的window--%>




        </div>
    </div>
</div>


</body>

</html>
