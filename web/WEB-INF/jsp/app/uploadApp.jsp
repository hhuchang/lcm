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
//            $("#update_log").hide();
//            $("#app_dsec").hide();
//
//            $("#screenshot").hide();
////            $("#progressbar").hide();
//            $("#uloadsubmit").click(function () {
//                $("#formid").attr("action","/uploadPa_execute");
//                $("form").submit();
//            });




        });
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
                url:'getUploadStateAction_execute?nocache='+new Date().getTime(),
                data:{'timestamp':new Date().getTime()},
                type:'get',
                dataType:'xml',
                success:function (data) {
                    console.info(data);
                    var flag=refreshProcessBarCallBack(data);

                },
                error:function () {

                }
            });
        }
        function refreshProcessBarCallBack(returnXMLParam) {


            var returnXML=returnXMLParam;
            //if (null!=returnXML){
                //console.info("data不为空！！！！！");
            //}else {
                //console.info("data为空！！！！！");
            //}
            var percent=$(returnXML).find('percent').text();
            var processinfo="已完成:"+percent+"%";
            console.info("比例"+percent);
            processinfo=processinfo+"\n已读取"+$(returnXML).find("uploadByte").text()+"MB";
            processinfo=processinfo+"\n文件总大小:"+$(returnXML).find("fileSizeByte").text()+"MB";
            processinfo=processinfo+"\n上传速率:"+$(returnXML).find("speed").text()+"KB/s";
            $('#progressbar').progressbar('setValue',percent);
            $('#progressInfo').empty();
            $('#progressInfo').text(processinfo);
            setTimeout("refreshProcessBar()",1000);
            if (percent==100){
                $('#progressInfo').empty();
                $('#progressInfo').text("上传已完毕，正在分析APK，请稍后...");
                return true;

            }else {
                return false;
            }


            
        }
        /***判断file 为空的提交不提交**/
       function checkUpload(){
           //var filelength= $('#upload').value;
            var fileisExist=$("#upload").filebox('getValue');

           console.info("filebox-getValue"+fileisExist+"?");
           if (fileisExist==""){
               console.info("空文件");
               return false;
            }
            else {
               console.info("有文件");
               return true;
           }

        }


    </script>
    <style type="text/css">
        #divupload{
            /*display: table-cell;*/
            /*vertical-align: middle;*/
            text-align: center;
        }
        #progressbar{
            text-align: center;
        }
        #divprogressbar{
            margin: 0 auto;
        }
        #progressInfo{
            text-align: center;
        }
        #divuloadsubmit{
            text-align: center;
        }


    </style>
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


                <div class="easyui-panel" title="上传App"  style="width: 100%;height: 100%;">
                    <div style="margin: 20px 0;"></div>

                    <%--以一个上传表单--%>
                    <form id="formid" method="post"  action="/uploadPa_execute" enctype="multipart/form-data"
                          onsubmit="return submitForm()">
                        <s:token name="tokenSession"></s:token>

                        <div  id="divupload" style="margin-bottom: 10px;margin-top:15%;margin-left: 0px">
                            <%--上传文件--%>
                            <input  id="upload" class="easyui-filebox" name="uploadFile" multiple="multiple" label="APK文件："
                            data-options="prompt:'请选择一个apk文件...',accept:'application/vnd.android.package-archive'"

                            onchange=""

                            style="width: 50%;">
                            <%--进度条--%>
                            <%----%>
                             <%--<s:submit class="easyui-linkbutton" style="width:100px;height:30px" value="上传"/>--%>
                            <%--上传按钮--%>


                        </div>
                        <div id="divprogressbar" align="center">
                            <div id="progressbar"  class="easyui-progressbar" style="margin-top:20px;width: 50%;height: 30px;"></div>
                        </div>
                        <div id="progressInfo" style="margin-top: 20px;height: 50px;"><p></p></div>
                        <div id="divuloadsubmit">
                            <input id="uloadsubmit" class="easyui-linkbutton" type="submit" style="margin-top:20px;height: 35px;width: 100px" value="上传" />
                        </div>


                        <%--<div id="progressbar" class="easyui-progressbar" style="width: 50%"/>--%>







                    </form>

                </div>




            </div>

        </div>
    </div>
</div>

</body>
</html>
