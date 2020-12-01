<%@ page import="java.util.Date" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%--
  Created by IntelliJ IDEA.
  User: changcan
  Date: 2018/6/15
  Time: 10:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html;charset=UTF-8">
    <title>上传</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/css/main.css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/locale/easyui-lang-zh_CN.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/themes/default/easyui.css" type="text/css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/themes/icon.css" type="text/css"/>

    <script language="JavaScript">
        $(function () {
            //$("#progressbar").progressbar('setValue',10);
            //getAllAppTypes();
            //addSelectOptions();

        });
        function addSelectOptions(){
            $("#apptype").combobox({


            });
        }
        /**
         * easyui .combobox()有自己的实现方法
         * 这个方法不能用在easyui下，但是可用用在html标准<select></select>下
         */
        function getAllAppTypes() {
            var idSelect=$("#apptype");

            $.ajax({
                url:'appTypeAction_getAllAppTypes',
                type:'GET',
                dataType:'json',
                success:function (data) {

                    if (data!=""&&data.length!=0){

                        for (var i=0;i<data.length;i++){

                            idSelect.append("<option value="+data[i].apptype_id+">"+data[i].apptype_name+"</option>");
                        }
                    }else {
                        idSelect.append("<option value="+""+">"+暂无分类+"</option>");
                    }

                }
            });

        }
        function refreshProcessBar() {
            console.log("刷新请求-------");
            $.ajax({
                url:'getUploadStateAction_execute?nocache='+new Date().getTime(),
                data:{'timestamp':new Date().getTime()},
                type:'get',
                dataType:'xml',
                success:function (data) {
                    var flag=refreshProcessBarCallBack(data)

                },
                error:function () {
                    
                }
            });

        }
        function refreshProcessBarCallBack(returnXMLParam) {
            var returnXML=returnXMLParam;
            var percent=$(returnXML).find('percent').text();
            var showText="完成："+percent+"%";
            showText=showText+"\n已读取"+$(returnXML).find("uploadByte").text()+"MB";
            showText=showText+"\n文件总大小："+$(returnXML).find('fileSizeByte').text()+"MB";
            showText=showText+"\n上传速率："+$(returnXML).find('speed').text()+"KB/s";
            showText = showText + "\n当前上传文件为第：" + $(returnXML).find('fileIndex').text()
                + "个";
            showText=showText+"\n当前文件名："+$(returnXML).find('filename').text();
            showText = showText + "\n开始上传时间：" + $(returnXML).find('startTime').text();
            $('#progressbar').progressbar('setValue',percent);
            $('#progressInfo').empty();
            $('#progressInfo').text(showText);
            //$('#progressbar').progressbar("option","value",parseInt(percent));
            setTimeout("refreshProcessBar()",1000);
            if (percent==100){
                return true;
            }else {
                return false;
            }



        }
        function submitForm(){
            setInterval("refreshProcessBar()",1000);
            return true;

        }





        function insertFile() {
            //新建一个File表单
            var file_array=${"input"};
            var is_null=false;
            for (var i=0;i<file_array.length;i++){
                if (file_array[i].type=="file"
                && file_array[i].name.substring(0,9)=="uploadFile"){
                    if (file_array[i].value==""){
                        alert("请所有附件增加文件，否则不能继续添加");
                        is_null=true;
                        break;
                    }
                }
            }
            if (is_null){
                return;

            }
            var new_File_element = $('<input>');
            new_File_element.attr('type', 'uploadFile');
            new_File_element.keydown(false);
            $('#fileForm').append(new_File_element);

            var new_a_element=$('<a>');
            new_a_element.html("删除文件");
            new_a_element.attr()





        }

    </script>
</head>

<body>
<h1>上传apk</h1>
<form id="fileForm" method="post" action="/uploadPa_execute" enctype="multipart/form-data"
onsubmit="return submitForm()">
    <s:token name="tokenSession"></s:token>

    <%--<div align="center">--%>
        <%--用户附件<br/><a href="javascript:insertFile()">添加附件</a>--%>
    <%--</div>--%>

    <input type="file" name="uploadFile" multiple="multiple" label="选择文件"/>
    <br/><br/>
    <input type="submit" value="上传" />
</form>

<div id="progressbar" class="easyui-progressbar" style="width: 500px"></div>
<br>
<div id="progressInfo" class="demo-description"><p>进度详细信息显示于此......</p></div>
<div style="margin:20px 0"></div>

<div >
    请为app选择分类：<select id="apptype"  class="easyui-combobox" name="apptypes" style="width: 200px;"
    data-options="
    url:'appTypeAction_getAllAppTypes',
    valueField: 'apptype_id',
    textField: 'apptype_name'"
    >

    </select>
</div>
<div >
    请选择适配机型：
</div>
<div>
    请选择适配地区：

</div>





</body>
</html>
