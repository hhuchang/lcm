<%--
  Created by IntelliJ IDEA.
  User: changcan
  Date: 2018/8/21
  Time: 15:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
    <%@include file="../page/title.jsp"%>
    <script type="text/javascript" src="<c:url value="/js/jquery.min.js"/>"></script>

    <script type="text/javascript" src="<c:url value="/js/jquery.easyui.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/js/locale/easyui-lang-zh_CN.js"/>"></script>
    <link rel="stylesheet" href="<c:url value="/js/themes/default/easyui.css"/>" type="text/css"/>
    <link rel="stylesheet" href="<c:url value="/js/themes/icon.css"/>" type="text/css"/>
    <link rel="stylesheet" href="<c:url value="/css/main.css"/>"/>

    <script>
        $(function () {
//
            $('#devtype').tree({
                onLoadSuccess:checkedIsChecked
            });
            //图片上传预览功能
            var userAgent=navigator.userAgent;
            $('#screenshot-input').change(function () {
                //获取选择图片
                var docObj=$(this)[0];
                var picDiv=$(this).parents(".picDiv");
                //得到所有的图片文件
                var fileList=docObj.files;

                //循环遍历
                for (var i=0;i<fileList.length;i++){
                    //动态添加html元素
                    var picHtml="<div class='imageDiv' ><img id='img"+fileList[i].name+"'/><div class='cover'><i class='delBtn'>删除</i></div></dvi> ";
                    console.log("HTML:"+picHtml);
                    picDiv.prepend(picHtml);
                    //
                    //获取图片img的对象
                    var imgObjPreview=document.getElementById("img"+fileList[i].name);
                    if(fileList&&fileList[i]){
                        //图片属性
                        imgObjPreview.style.display='block';
                        imgObjPreview.style.width='160px';
                        imgObjPreview.style.height='130px';
                        if (userAgent.indexOf('MSIE')==-1){
                            //IE以外的浏览器
                            imgObjPreview.src=window.URL.createObjectURL(docObj.files[i]);//获取上传图片文件的物理路径
                            //console.info(imgObjPreview.src);

                        }else {
                            //IE浏览器
                            if (docObj.value.indexOf(",")!=-1){
                                var scrArray=docObj.value.split(",");
                                imgObjPreview.src=scrArray[i];
                            }else {
                                imgObjPreview.src=docObj.value;
                            }
                        }
                        console.info("image 地址"+imgObjPreview.src);
                    }
                }



                /*删除功能*/
                $('.delBtn').click(function () {
                    var _this=$(this);
                    _this.parents(".imageDiv").remove();

                });

            });

        });
        function submitForm() {
//            $("#progressbar").show();
//            $("#divupload").hide();
            $("#devhidden").val(getChecked());
            $("#devhidden").attr("value",getChecked());
            console.info($("#devhidden").attr("name"));
            console.info($("#devhidden").attr("value"));
            return true;
        }
        function collapsethisAll() {
            $("#devtype").tree('collapseAll');

        }



        function checkedIsChecked() {
            $.ajax({
                url:'',<%--求当前app 的所有devtype 的id醉成的数组--%>
                dataType:"json",
                success:function (data) {
                    console.log("当前app的devtype："+data);
                    checkByid(data);

                }
            });

        }
        function checkByid(data) {
            for (var i = data.length - 1; i >= 0; i--) {

                var node=$('#devtype').tree('find',data[i]);
                console.log("需要自动勾选："+node.id);
                //alert("需要自动勾选："+node.id);
                $('#devtype').tree("check",node.target);
            }

        }
        /**
         * 获取已经勾选的devtype的id
         * @returns {string}
         */
        function getChecked(){
            var nodes=$('#devtype').tree('getChecked')
            var s='';
            for (var i = 0; i <nodes.length; i++) {
                if (s!='') s+=',';
                s+=nodes[i].id;
            }
            //alert(s);
            return s;
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
            <%--<%@include file="../../../content/app/newApp.jsp"%>--%>

            <div style="width: 100%;height: 100%">


                <div class="easyui-panel" title="新增App信息"  style="width: 100%;height: 100%;">
                    <div style="margin: 20px 0;"></div>

                    <%--以一个上传表单--%>
                    <form id="formid" method="post"  action="<%--/uploadPa_execte--%>/appAction_addNewApp" enctype="multipart/form-data"
                          onsubmit="return submitForm()">
                        <s:token name="tokenSession"></s:token>
                        <%--表单的隐藏域--%>
                        <input type="hidden" name="orgapk" value="${uploadapk}">
                            <%--这里需要用到--icon的路径  、下载路径、hash打散文件夹路径、权限要求、简拼--%>

                            <input type="hidden" name="app_ico" value="${uploadapk.app_ico}">
                            <input type="hidden" name="down_url" value="${uploadapk.down_url}">
                            <input type="hidden" name="savePath" value="${uploadapk.savePath}">
                            <input type="hidden" name="userPermissions" value="${uploadapk.userPermissions}">
                            <input type="hidden" name="jianpin" value="${uploadapk.jianpin}">


                        <%--<div id="progressbar" class="easyui-progressbar" style="width: 500px"></div>
                        <div  id="divupload" style="margin-bottom: 10px;margin-left: 50px">
                            &lt;%&ndash;上传文件&ndash;%&gt;
                            <input  id="upload" class="easyui-filebox" name="uploadFile" multiple="multiple" label="APK文件："
                            data-options="prompt:'请选择一个apk文件...'"
                            onchange=""
                            style="width: 50%;">
                            &lt;%&ndash;进度条&ndash;%&gt;
                            &lt;%&ndash;&ndash;%&gt;
                             &lt;%&ndash;<s:submit class="easyui-linkbutton" style="width:100px;height:30px" value="上传"/>&ndash;%&gt;
                            &lt;%&ndash;上传按钮&ndash;%&gt;
                            <input id="uloadsubmit" type="submit" style="margin-left: 20px;height: 28px;width: 60px" value="上传" />

                        </div>--%>
                        <%--<div id="progressbar" class="easyui-progressbar" style="width: 50%"/>--%>

                        <div id="app_icon" style="margin-left: 50px;margin-bottom: 10px">
                            应用图标：<img id="icon_id" src="<c:url value="${uploadapk.app_ico}" />"  height="66" width="66" >
                        </div>
                        <div id="app_name" style="margin-left: 50px;margin-bottom: 10px">
                            <input label="应用名称：" class="easyui-textbox" value="${uploadapk.app_name}" name="app_name" style="width: 400px;" >
                        </div>


                        <div id="package_name" style="margin-left: 50px;margin-bottom: 10px">
                            <input label="Package ：" class="easyui-textbox" value="${uploadapk.pack_name}" name="pack_name" style="width: 400px;">
                        </div>
                        <div id="app_version" style="margin-left: 50px;margin-bottom: 10px">
                            <input label="应用版本：" class="easyui-textbox" value="${uploadapk.app_ver}" name="app_ver" style="width: 400px;">
                        </div>
                        <div id="app_size" style="margin-left: 50px;margin-bottom: 10px">
                            <input label="应用大小：" class="easyui-textbox" value="${uploadapk.app_size}" name="app_size" style="width: 400px;">
                        </div>
                        <div id="app_minsdkversion" style="margin-left: 50px;margin-bottom: 10px">
                                <input label="系统要求：" class="easyui-textbox" value="${uploadapk.androidVersion}" name="min_sdkversion" style="width: 400px;">
                        </div>

                        <div id="apptypeid" style="margin-bottom: 10px;margin-left: 50px">
                            <input label="选择分类：" id="apptype"  class="easyui-combobox" name="apptypes" style="width: 400px;"
                                              data-options="
                                            url:'appTypeAction_getAllAppTypes',

                                            method:'get',
                                            valueField: 'id',<%--这两个值一定要与json数据对应正确，否则将不能正确提交--%>
                                            textField: 'apptype_name',
                                            panelHeight:'auto',
                                                            ">

                        </div>
                        <div id="divdevtype" style="margin-left: 50px;margin-bottom: 10px">
                            适配机型：<div style="margin: 20px 0;">
                                        <a class="easyui-linkbutton" href="javascript:void(0)"  onclick="getChecked()">显示勾选的信息</a>
                                        <a class="easyui-linkbutton" href="javascript:void(0)" onclick="collapsethisAll()">隐藏所有子分类</a>
                                     </div>
                            <div style="margin: 20px 0;">
                                <div class="easyui-panel" style="padding: 5px" width="600px">
                                    <ul id="devtype" class="easyui-tree" name=""
                                        data-options="
                                            url:'devTypeAction_getAllDevTypeToTree',<%--此处为获得所有的分类的json--%>
                                            method:'GET',
                                            animate:true,
                                            line:true,
                                            checkbox:true,
                                            onLoadSuccess: function () {$('#devtype').tree('collapseAll')},


                                            ">

                                    </ul>
                                </div>
                            </div>
                        </div>
                        <input type="hidden" id="devhidden" name="devtypes" value="">
                        <%-- 上传截图 --%>
                        <div style="margin-left: 50px">上传截图：</div><div id="screenshot" style="margin-left:50px;margin-bottom: 10px;">
                            
                            <%--<input class="easyui-filebox" name="screenshot" label="上传截图：" style="width: 400px;">--%>
                            <p><span style="color: red">注：每张图片大小不得超过2M，且最多可以传10张(请一次性选择所有需要上传的图片)</span> </p>
                            <div class="picDiv">
                                <div class="addImages">

                                    <input class="file" type="file" id="screenshot-input" multiple="multiple" accept="image/png,image/jpeg,image/gif,image/jpg" name="screenshotupload">
                                    <div class="text-detail">
                                        <span>+</span>
                                        <p>点击上传</p>
                                    </div>

                                </div>
                            </div>
                        </div>

                        <div id="app_dsec" style="margin-left: 50px;margin-bottom: 10px">

                            <input class="easyui-textbox" label="应用描述："data-options="multiline:true" name="summary" style="width: 450px;height: 80px;">

                        </div>
                        <div id="update_log" style="margin-left: 50px;margin-bottom: 10px">
                            <input class="easyui-textbox" label="升级日志：" data-options="multiline:true" name="update_info" style="width: 450px;height: 80px;">
                        </div>

                        <div id="divaddapksubmit" style="margin-left: 50px;margin-bottom: 10px" align="center">
                                <input id="addsubmit" class="easyui-linkbutton" type="submit"  style="margin-top:20px;height: 35px;width: 100px" value="添加APP" />
                        </div>





                    </form>
                </div>




            </div>

        </div>
    </div>
</div>

</body>
</html>
