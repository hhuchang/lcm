<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%--
  Created by IntelliJ IDEA.
  User: changcan
  Date: 2018/8/31
  Time: 16:41
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
    <script type="text/javascript" src="<c:url value="/js/treegrid-dnd.js"/>"></script>
    <link rel="stylesheet" href="<c:url value="/js/themes/default/easyui.css"/>" type="text/css"/>
    <link rel="stylesheet" href="<c:url value="/js/themes/icon.css"/>" type="text/css"/>
    <link rel="stylesheet" href="<c:url value="/css/main.css"/>"/>
    <script type="text/javascript">
        $(function () {
            closeaddDevtypeClassTop();
            closeaddChild();
            closeupdate();


        });
        var toolbar=[{
            text:'新增顶级分类',
            iconCls:'icon-add',
            handler:function () {
                $('#addDevtypeClassTop').window('open');
            }
        },{
            text:'增加子分类',
            iconCls:'icon-add',
            handler:function () {
                append();
            }

        },{
            text:'删除',
            iconCls:'icon-remove',
            handler:function () {
                removeIt();
            }
        },{
            text:'修改',
            iconCls:'icon-edit',
            handler:function () {
            updateIt();
        }
        },{
            text:'移动',
            iconCls:'icon-cut',
            handler:function () {
                moveIt();
            }
        }]
        function closeaddDevtypeClassTop() {
            $('#addDevtypeClassTop').window('close');
        }
        function closeaddChild() {
            $('#addChild').window('close');
        }
        function closeupdate() {
            $('#update').window('close');
        }
        function onContextMenu(e,row) {
            e.preventDefault();
            $(this).treegrid('select',row.id);
            $('#menu').menu('show',{left:e.pageX,top:e.pageY});
        }

        function collapse(){
            var node = $('#devtype_tablegrid').treegrid('getSelected');
            if (node){
                $('#devtype_tablegrid').treegrid('collapse', node.id);
            }
        }
        function expand(){
            var node = $('#devtype_tablegrid').treegrid('getSelected');
            if (node){
                $('#devtype_tablegrid').treegrid('expand', node.id);
            }
        }

        //隐藏所有
        function collapseAll(){
            $('#devtype_tablegrid').treegrid('collapseAll');
        }
        //显示所有
        function expandAll(){
            $('#devtype_tablegrid').treegrid('expandAll');
        }

        function append() {
            var node=$('#devtype_tablegrid').treegrid('getSelected');
            //console.info(node.id);
            //console.info(node.text);
            if (node!==null){
                $('#parentShow').text('确认在分类：【' + node.text + '】下增加子分类？');
                $('#addChild').window('open');
                $('#devtypeParentid').attr('value',node.id);
            }
            else {

                alert("请选择一个分类");
            }
        }
        /**
         * 删除有两种情况
         * 末梢分类，可以直接删除，
         * 如果下面有子分类，则不能删除。
         *
         */
        function removeIt() {
            var node=$('#devtype_tablegrid').treegrid('getSelected');
            if (node){
                //
                var chi=node.children.length;
                console.info(chi);

                if (chi>0){
                    alert('【'+node.text+"】有子分类,无法直接删除");
                }else {
                    //删除devtypebyid
                    deleteConfirm(node.id,node.text);

                }

            }else alert("请选择一个分类");

            
        }
        function moveIt() {
            $.messager.confirm('移动机型分类','提示:可以直接拖动到目标分类下,然后释放鼠标！',function (re) {
                if(re){
                }
            })

        }
        /**
         * 删除分类devtype确认对话框
         * @param id
         * @param data
         */
        function deleteConfirm(id,data) {
            $.messager.confirm('删除机型分类','您确定要删除：分类【'+data+'】吗?',function (re) {
                if(re){
                    $.get('${pageContext.request.contextPath}/devTypeAction_deleteById',{'id':id},function (data) {
                        $(location).attr('href', '${pageContext.request.contextPath}/devTypeAction_getAllDevtype');
                    });

                }
            })
        }
        function updateIt() {
            var node=$('#devtype_tablegrid').treegrid('getSelected');
            if (node){

                $('#updateid').attr('value',node.id);
                $('#devtypename').attr('value',node.text);
                $('#update').window('open');
            }else alert('请选择一个分类！');

        }

        /**
         * 机型父子结果拖动改变归属的数据同步到服务器。
         * @param targetRow
         * @param sourceRow
         */
        function updateToServer(targetRow,sourceRow){

            console.info(targetRow.id);
            console.info(sourceRow.id);
            $.ajax({
                url:'devTypeAction_updateTypeParent',
                dataType:'json',
                type:'post',
                data:{
                    "srcId":sourceRow.id,
                    "tarId":targetRow.id,
                },
                success:function (data) {
                    if (data.result){
                        $('#devtype_tablegrid').treegrid('reload');
                    }
                    
                }
            });
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
            <table id="devtype_tablegrid"  class="easyui-treegrid" title="机型分类" style="width: 100%;height: 100%"
                   data-options="
            iconCls:'icon-ok',
            autoRowHeight:true,
            rownumbers:true,
            animate:true,

            fitColumns:true,
            collapsible:true,
            lines: true,
            method:'get',
            idField:'id',
            treeField:'text',
            url:'devTypeAction_getAllDevTypeToTree',
            onContextMenu:onContextMenu,
            toolbar:toolbar,
            onLoadSuccess: function(row){
				$(this).treegrid('enableDnd', row?row.id:null);
			},
			onDrop:function(targetRow,sourceRow){
			    updateToServer(targetRow,sourceRow);
			},




            "

            >
                <thead>
                <tr>

                    <th data-options="field:'checkbox',checkbox:true"></th>
                    <th data-options="field:'id',width:40,align:'center'">编号</th>

                    <th data-options="field:'text',width:260,">机型分类</th>
                    <th data-options="field:'count',width:100,halign:'center'">分类下app的个数</th>


                    <%--<th data-options="field:'appid9',width:80">app_size</th>--%>
                    <th data-options="field:'lastupdate',width:80,align:'center'">创建日期</th>
                    <%--<th data-options="field:'region',width:80">app_region_id</th>--%>
                    <th data-options="field:'edit',width:120,align:'center'">操作</th>
                    <%--<th data-options="field:'edit',width:80">编辑</th>--%>
                </tr>
                </thead>


                <%--实现分页的表格datagrid--%>
            </table>
            <div id="menu" class="easyui-menu" style="width: 200px;">
                <div onclick="javascript:append()" data-options="iconCls:'icon-add'">在他下面增加子分类</div>
                <div onclick="javascript:removeIt()" data-options="iconCls:'icon-remove'">删除该分类</div>
                <div onclick="javascript:updateIt()" data-options="iconCls:'icon-edit'">修改该分类</div>
                <div class="menu-sep"></div>
                <div onclick="javascript:collapse()">隐藏所有子类</div>
                <div onclick="javascript:expand()">显示所有子类</div>
                <div class="menu-sep"></div>
                <div onclick="javascript:collapseAll()">隐藏所有</div>
                <div onclick="javascript:expandAll()">显示所有</div>
            </div>

                <%--新增顶级分类的对话框--%>
                <div id="addDevtypeClassTop"   class="easyui-window"  title="新增机型分类" data-options="" style="width: 500px;height: 200px;padding: 5px;">
                    <form action="/devTypeAction_addType" method="post">
                        <s:token />
                        <div align="center">
                            <p>输入新分类名称：<input type="text" name="devtypename" style="width: 220px;height: 40px"></p>
                        </div>
                        <div style="margin-top: 40px"></div>
                        <div align="center">
                            <button class="easyui-linkbutton" data-options="iconCls:'icon-ok'"  type="submit" style="width: 80px;">确认</button>
                            <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="javascript:closeaddDevtypeClassTop()" style="width: 80px;margin-left: 30px;">取消</a>
                        </div>
                    </form>
                </div>
            <%--在某分类下增加子分类--%>
                <div id="addChild" class="easyui-window" title="增加子分类" style="width: 500px;height: 230px;padding: 5px;">
                    <form action="/devTypeAction_addType" method="POST">
                        <s:token />
                        <input id="devtypeParentid" type="hidden" name="parentId" value="">
                        <p id="parentShow" align="center"></p>
                        <div align="center">
                            <p>子分类名称：<input type="text" id="typename" name="devtypename" style="width: 220px;height: 40px"></p>
                        </div>
                        <div style="margin-top: 40px"></div>
                        <div align="center">
                            <button class="easyui-linkbutton" data-options="iconCls:'icon-ok'"  type="submit" style="width: 80px;">确认</button>
                            <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="javascript:closeaddChild()" style="width: 80px;margin-left: 30px;">取消</a>
                        </div>
                    </form>
                </div>
            <%--修改分类  窗口--%>
                <div id="update" class="easyui-window" title="修改分类" style="width: 500px;height: 200px;padding: 5px;">
                    <form action="/devTypeAction_updateType" method="POST">
                        <s:token />
                        <input id="updateid" type="hidden" name="devtype_id" value="">
                        <div align="center">
                            <p>分类的新名称：<input type="text" id="devtypename" name="type" style="width: 220px;height: 40px"></p>
                        </div>
                        <div style="margin-top: 40px"></div>
                        <div align="center">
                            <button class="easyui-linkbutton" data-options="iconCls:'icon-ok'"  type="submit" style="width: 80px;">确认</button>
                            <a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="javascript:closeupdate()" style="width: 80px;margin-left: 30px;">取消</a>
                        </div>
                    </form>
                </div>




        </div>
    </div>
</div>



</body>
</html>