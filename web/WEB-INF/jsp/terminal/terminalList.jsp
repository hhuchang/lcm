<%--
  Created by IntelliJ IDEA.
  User: changcan
  Date: 2018/9/19
  Time: 15:42
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="s" uri="/struts-tags" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>终端管理</title>

    <script type="text/javascript" src="<c:url value="/js/jquery.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/js/jquery.easyui.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/js/locale/easyui-lang-zh_CN.js"/>"></script>
    <link rel="stylesheet" href="<c:url value="/js/themes/default/easyui.css"/>" type="text/css"/>
    <link rel="stylesheet" href="<c:url value="/js/themes/icon.css"/>" type="text/css"/>
    <link rel="stylesheet" href="<c:url value="/css/main.css"/>"/>
    <script type="text/javascript">

        $(function () {
            updateClose();
        });

        var toolbar=[{
            text:'导入数据',
            iconCls:'icon-add',
            handler:function () {
                $('#importFac').window('open');
            }
        }];

        function updateClose(){
            $('.easyui-window').window('close');

        }

        function submitForm() {
            if(checkUpload()){
                setInterval("refreshProcessBar()",1000);
                return true;
            }else{
                alert("请选择一个文件");
                return false;
            }


        }
        function refreshProcessBar() {
            //console.info("请求上传进度。。。。");
            $.ajax({
                url:'terminalAction_getProgressCvsProcess?nocache='+new Date().getTime(),
                data:{'timestamp':new Date().getTime()},
                type:'get',
                dataType:'json',
                success:function (data) {
//                    console.info(data);
                    var flag=refreshProcessBarCallBack(data);

                },
                error:function () {

                }
            });
        }

        function refreshProcessBarCallBack(returnXMLParam) {

            var percent=returnXMLParam.percent;

//            console.info("返回数据的百分比："+percent);
            var processinfo="已完成:"+percent+"%";

            //processinfo=processinfo+"\n正在处理第"+returnXMLParam.rowNow+"个数据";
            //processinfo=processinfo+"\n(共"+returnXMLParam.rowCounts+"个数据)";
            processinfo=processinfo+"\n已导入有效数据"+returnXMLParam.validData+"个";

//
            $('#progressbar').progressbar('setValue',percent);
            $('#progressInfo').empty();
            $('#progressInfo').text(processinfo);
            setTimeout("refreshProcessBar()",1000);
            if (percent==100){
                $('#progressInfo').empty();
                $('#progressInfo').text("数据导入完毕(共导入"+returnXMLParam.validData+"个数据)，请稍后...");
                return true;

            }else {
                return false;
            }



        }




        /***判断file 为空的提交不提交**/
        function checkUpload(){
            //var filelength= $('#upload').value;
            var fileisExist=$("#upload").filebox('getValue');

//            console.info("filebox-getValue"+fileisExist+"?");
            if (fileisExist==""){
                console.info("空文件");
                return false;
            }
            else {
                console.info("有文件");
                return true;
            }

        }





        function deleteConfirm(id,name){

            $.messager.confirm('删除应用分类','您确定要删除：管理员 '+name+' 吗?',function (re) {
                if(re){
                    $.post('${pageContext.request.contextPath}/adminAction_deleteById',{'id':id},function (data) {
                        $(location).attr('href', '${pageContext.request.contextPath}/adminAction_getAllAdmin');
                    });
                    //alert("data+++"+id);
                }
            })
        }
        function updateIt(id,username) {

            $('#adminId').attr("value",id);
            var user=username;
            console.info(id);
            console.info(username);
            ///在之前插入
            //$('#adminId').after(function () {
            //    return "<div style='padding-left: 50px;padding-top: 30px;'>用户名：" +user+"</div>";
            //});
            $('#username_').html("<div style='padding-left: 50px;padding-top: 30px;'>用户名：" +user+"</div>");
            ///$('#updateAdmin').attr('title','修改管理员：'+user);

            $('#updateAdmin').window('open');

        }




    </script>
    <%@include file="../page/title.jsp"%>
    <script type="text/css">

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


        <div id="mainPage" data-options="region:'center',border:true,href:'<%--/appAction_getAllApps--%>'" >
            <%--main--%>
            <%--数据可视化--%>


            <%--<s:property value="@java.lang.Math@PI"/><br>--%>
            <table id="app_list_datagrid" class="easyui-datagrid" title="终端列表" style="width: 100%;height: auto"
                   data-options="
                   border:false,
            fitColumns:true,
            autoRowHeight:true,
            rownumbers:true,
            loadMsg:'数据加载中....',
            singleSelect:false,
            toolbar:toolbar,
            "

            >
                <thead>
                <tr>

                    <th data-options="field:'checkbox',checkbox:true"></th>

                    <th data-options="field:'model',width:50,align:'center'">机型</th>
                    <th data-options="field:'sn',width:50,align:'center'">序列号</th>
                    <th data-options="field:'mac',width:50,align:'center'">MAC</th>




                    <th data-options="field:'pTime',width:50,align:'center'">生产时间</th>

                    <th data-options="field:'online',width:30,align:'center'">在线状态</th>
                    <th data-options="field:'status',width:80,align:'center'">最后登陆</th>

                    <th data-options="field:'region',width:50,align:'center'">状态</th>
                    <th data-options="field:'edit',width:80,align:'center'">操作</th>
                    <%--<th data-options="field:'edit',width:80">编辑</th>--%>
                </tr>
                </thead>
                <tbody>

                <s:iterator value="terminalList" status="st" var="terminal">
                    <tr>
                        <td></td>
                        <td>${terminal.devType.devtype_name}</td>

                        <td>${terminal.sn}</td>
                        <td>${terminal.mac}</td>

                        <td><fmt:formatDate value="${terminal.production_time}" type="date" pattern="yyyy-MM-dd HH:mm"/></td>
                        <%--<td><fmt:formatDate value="${admin.last_update}" type="date" pattern="yyyy-MM-dd HH:mm"/></td>--%>
                        <s:if test="#terminal.online_state==0">
                            <td>未知</td>
                        </s:if>
                        <s:elseif test="#terminal.online_state==1">
                            <td><img src="<c:url value="/images/yes.gif"/>">在线</td>
                        </s:elseif>
                        <s:elseif test="#terminal.online_state==2">
                            <td><img src="<c:url value="/images/no.gif"/>">离线</td>
                        </s:elseif>

                        <s:else>
                            <td>未激活</td>
                        </s:else>


                            <%--<td><s:property value="#app.app_size"/></td>--%>


                            <%--<td><s:property value="#app.app_region_id"/></td>--%>

                            <%--<td><a href="/appAction_updateAppById?id=${app.app_id}">
                                    <img src="<c:url value="/images/icon_edit.gif"/>" alt="编辑" width="20px" height="20px"></a>
                                <a href="/appAction_deleteAppById?id=${app.app_id}">
                                    <img src="<c:url value="/images/icon_trash.gif"/>" alt="删除" width="20px" height="20px"></a>

                            </td>--%>
                        <%--<td><a href="javascript:void(0)" onclick="javascript:updateIt('${admin.id}','${admin.username}')">
                            <img src="<c:url value="/images/icon_edit.gif"/>" alt="编辑" width="20px" height="20px"></a>
                            <a href="javascript:void(0)" onclick="javascript:deleteConfirm('${admin.id}','${admin.username}')">
                            <img src="<c:url value="/images/icon_trash.gif"/>" alt="删除" width="20px" height="20px"></a>

                        </td>--%>


                    </tr>

                </s:iterator>
                </tbody>

                <%--实现分页的表格datagrid--%>
            </table>

            <%--删除的window--%>



            <%--修改管理员密码--%>
            <div id="updateAdmin" class="easyui-window" title="修改管理员" style="width: 400px;height: 260px;padding: 5px;">
                <form action="/adminAction_updateAdmin" method="POST" >
                    <s:token />
                    <input id="adminId" type="hidden" name="admin_id" value="">
                    <div id="username_"></div>
                    <div style="padding-left: 50px">
                        <p>管理员的新密码：<input type="text" id="newPassword" name="newPass" style="width: 180px;height: 40px"></p>
                    </div>
                    <div style="margin-top: 40px"></div>
                    <div align="center">
                        <button class="easyui-linkbutton" data-options="iconCls:'icon-ok'"  type="submit" style="width: 80px;">确认</button>
                        <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="javascript:updateClose()" style="width: 80px;margin-left: 30px;">取消</a>
                    </div>
                </form>
            </div>
            <%--新增管理员用户--%>

            <div id="addAdmin"   class="easyui-window"  title="新增管理员用户" data-options="" style="width: 500px;height: 300px;padding: 5px;">
                <form action="/adminAction_addAdmin" method="post">
                    <s:token />
                    <div style="padding-left: 50px;padding-top: 20px;">
                        <table>
                            <tr>
                                <%--重名判断--%>
                                <td>输入管理员用户名：</td>
                                <td><input type="text" name="username" style="width: 180px;height: 30px"></td>
                            </tr>
                            <tr>
                                <td>输入管理员密码：</td>
                                <td><input type="text" name="password" style="width: 180px;height: 30px"></td>
                            </tr>
                            <tr>
                                <td>请选择分组:</td>
                                <td>

                                    <select name="admintype" style="width: 180px;height: 30px;">
                                        <option value="超级管理员">超级管理员</option>
                                        <option value="一般管理员">一般管理员</option>
                                        <option value="观察员">观察员</option>
                                    </select>
                                </td>
                            </tr>

                        </table>
                    </div>

                    <div style="margin-top: 40px"></div>
                    <div align="center">
                        <button class="easyui-linkbutton" data-options="iconCls:'icon-ok'"  type="submit" style="width: 80px;">确认</button>
                        <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="javascript:updateClose()" style="width: 80px;margin-left: 30px;">取消</a>
                    </div>
                </form>
            </div>

                <%--导入数据--%>

                <div id="importFac"   class="easyui-window"  title="导入工厂数据" data-options="" style="width: 500px;height: 300px;padding: 5px;">
                    <form action="/terminalAction_importFacData" method="post" enctype="multipart/form-data"
                          onsubmit="return submitForm()">
                        <s:token />

                            <div  id="divupload" style="margin-bottom: 10px;margin-top:15px;margin-left: 0px;" >
                                <%--上传文件--%>

                                    <input  id="upload" class="easyui-filebox" name="csvFile" multiple="multiple" label="工厂数据文件："
                                        data-options="prompt:'请选择一个文件...',"

                                        onchange=""

                                        style="width: 75%;" >


                                    <div id="progressbar"  class="easyui-progressbar" style="margin-top:20px;width: 75%;height: 30px;" ></div>





                            </div>
                            <%--<div id="divprogressbar" align="center">--%>

                            <%--</div>--%>
                            <div id="progressInfo" style="margin-top: 20px;height: 50px;"><p></p></div>


                        <div style="margin-top: 1px"></div>
                        <div align="center">
                            <button class="easyui-linkbutton" data-options="iconCls:'icon-ok'"  type="submit" style="width: 80px;">确认</button>
                            <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="javascript:updateClose()" style="width: 80px;margin-left: 30px;">取消</a>
                        </div>
                    </form>
                </div>



        </div>
    </div>
</div>


</body>

</html>

