<%@ page import="com.entity.App" %>
<%@ page import="java.util.Set" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: changcan
  Date: 2018/8/28
  Time: 14:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%--<title>所有应用分类</title>--%>
    <%@include file="../page/title.jsp"%>
    <script type="text/javascript" src="<c:url value="/js/jquery.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/js/jquery.easyui.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/js/locale/easyui-lang-zh_CN.js"/>"></script>
    <link rel="stylesheet" href="<c:url value="/js/themes/default/easyui.css"/>" type="text/css"/>
    <link rel="stylesheet" href="<c:url value="/js/themes/icon.css"/>" type="text/css"/>
    <link rel="stylesheet" href="<c:url value="/css/main.css"/>"/>
    <script type="text/javascript">
        $(function () {
            closewin();
            closewinupdate();

        });
        var toolbar=[{
            text:'新增分类',
            iconCls:'icon-add',
            handler:function () {
                $('#win').window('open');
            }
        }];
        function closewin() {
            $('#win').window('close');
        }
        function closewinupdate() {
            $('#winupdate').window('close');
        }
        function sendToWin(id,name) {
            $('#winupdate').window('open');
            $('#updatetypeid').attr('value',id);
            $('#typename').attr('value',name);
        }
        //发送POST请求跳转到指定页面
        function httpPost(URL, PARAMS) {
            var temp = document.createElement("form");
            temp.action = URL;
            temp.method = "post";
            temp.style.display = "none";

            for (var x in PARAMS) {
                var opt = document.createElement("textarea");
                opt.name = x;
                opt.value = PARAMS[x];
                temp.appendChild(opt);
            }

            document.body.appendChild(temp);
            temp.submit();

            return temp;
        }
        function deleteConfirm(id,data,count) {
            if(count>0){
                alert("当前分类下尚有"+count+"个app，故不能删除该分类！");
            }else{

                $.messager.confirm('删除应用分类','您确定要删除：'+data+' 吗?',function (re) {
                    if(re){
                        $.post('${pageContext.request.contextPath}/appTypeAction_deleteById',{'id':id},function (data) {
                            $(location).attr('href', '${pageContext.request.contextPath}/appTypeAction_getAppTypes');
                        });
                        //alert("data+++"+id);
                    }
                });
            }
        }
        function test(id,typename) {

            alert("typeid="+id+",typename="+typename) ;
        }
        function getCount(id) {
            $.ajax({
                url:"/appTypeAction_getAppCountByappType?apptype_id="+id,
                dataType:'text',
                success:function (data) {
                    //

                },
                error:function () {

                }
            })

        }
    </script>
    
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
            <table id="app_list_datagrid" class="easyui-datagrid" title="应用分类" style="width: 100%;height: 100%"
                   data-options="
            fitColumns:true,
            autoRowHeight:true,
            rownumbers:true,
            loadMsg:'数据加载中....',
            singleSelect:true,
            toolbar:toolbar
            "

            >
                <thead>
                <tr>

                    <th data-options="field:'checkbox',checkbox:true"></th>
                    <th data-options="field:'id',width:40,align:'center'">ID</th>

                    <th data-options="field:'appname',width:100,align:'center'">应用分类</th>
                    <th data-options="field:'apps',width:80,halign:'center'">app个数</th>


                    <%--<th data-options="field:'appid9',width:80">app_size</th>--%>
                    <th data-options="field:'createAt',width:80,align:'center'">创建日期</th>
                    <th data-options="field:'updateBy',width:80,align:'center'">创建人</th>
                    <th data-options="field:'lastupdateAt',width:80,align:'center'">变更日期</th>
                    <th data-options="field:'lastupdateBy',width:80,align:'center'">变更人</th>
                    <%--<th data-options="field:'region',width:80">app_region_id</th>--%>
                    <th data-options="field:'edit',width:120,align:'center'">操作</th>
                    <%--<th data-options="field:'edit',width:80">编辑</th>--%>
                </tr>
                </thead>
                <tbody>

                <s:iterator value="apptypelist" status="st" var="app">
                    <tr>
                        <td></td>
                        <td>${app.id}</td>

                        <td>${app.apptype_name}</td>
                        <td >
                            ${app.appCounts}

                        </td>

                        <td>${app.createAt}</td>
                        <td>${app.createBy.username}</td>
                        <td>${app.lastUpdateAt}</td>
                        <td>${app.lastUpdateBy.username}</td>

                        <%--/appTypeAction_deleteById?id=${app.id}--%>
                        <td><a href="javascript:void(0)" onclick="javascript:sendToWin('${app.id}','${app.apptype_name}')">
                            <img src="<c:url value="/images/icon_edit.gif"/>" alt="编辑" width="20px" height="20px"></a>
                            <a href="javascript:void(0)" onclick="javascript:deleteConfirm('${app.id}','${app.apptype_name}','${app.appCounts}')">
                                <img src="<c:url value="/images/icon_trash.gif"/>" alt="删除" width="20px" height="20px"></a>

                        </td>


                    </tr>

                </s:iterator>
                </tbody>

                <%--实现分页的表格datagrid--%>
            </table>
            <div id="win"   class="easyui-window"  title="新增分类" data-options="" style="width: 500px;height: 200px;padding: 5px;">
                <form action="/appTypeAction_addType" method="post">

                    <s:token/>
                    <div align="center">
                        <p>输入新分类名称：<input type="text" name="apptypename" style="width: 220px;height: 40px"></p>
                    </div>
                    <div style="margin-top: 40px"></div>
                    <div align="center">
                        <button class="easyui-linkbutton" data-options="iconCls:'icon-ok'"  type="submit" style="width: 80px;">确认</button>
                    <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="javascript:closewin()" style="width: 80px;margin-left: 30px;">取消</a>
                    </div>
                </form>
            </div>
            <div id="winupdate" class="easyui-window" title="修改分类" style="width: 500px;height: 200px;padding: 5px;">
                <form action="/appTypeAction_updateType" method="POST">


                    <input id="updatetypeid" type="hidden" name="apptype_id" value="">
                    <div align="center">
                        <p>分类的新名称：<input type="text" id="typename" name="apptypename" style="width: 220px;height: 40px"></p>
                    </div>
                    <div style="margin-top: 40px"></div>
                    <div align="center">
                        <button class="easyui-linkbutton" data-options="iconCls:'icon-ok'"  type="submit" style="width: 80px;">确认</button>
                        <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="javascript:closewinupdate()" style="width: 80px;margin-left: 30px;">取消</a>
                    </div>
                </form>
            </div>



        </div>
    </div>
</div>



</body>
</html>
