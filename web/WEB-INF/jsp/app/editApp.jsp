<%--
  Created by IntelliJ IDEA.
  User: changcan
  Date: 2018/10/23
  Time: 13:26
  To change this template use File | Settings | File Templates.
  需要对接action传过来的app参数
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
    <style>
        #page{
            background: url("/images/morocco-blue.png") ;
        }
    </style>
    <script>
        var totalLen=0;
        $(function () {


            /*$('#devtype').tree({
                 onLoadSuccess:checkedIsChecked
            });*/

            /*$('#devtype').tree({
                onLoadSuccess:collapsethisAll
            });*/
            loadImg();

            //图片上传预览功能
            var userAgent=navigator.userAgent;

            $('#screenshot-upload').change(function () {
                //获取选择图片
                var docObj=$(this)[0];
                var picDiv=$(this).parents(".picDiv");
                //得到所有的图片文件
                var fileList=docObj.files;
                totalLen=fileList.length+imageArr.length;
                console.info("当前总个数:"+totalLen);
                if(totalLen>4){
                    alert("只能上传4张图片");
                    return;
                }

                //循环遍历
                for (var i=0;i<fileList.length;i++){
                    //动态添加html元素
                    var picHtml="<div class='imageDiv' id='"+uploadImgIndex+"'><img id='img"+fileList[i].name+"' /><div class='cover'><i class='delBtn' onclick='javascript:delME(this)'>删除</i></div></div> ";
                    console.log("HTML--"+picHtml);
                    picDiv.prepend(picHtml);//添加html
                    //
                    //获取图片img的对象
                    var imgObjPreview=document.getElementById("img"+fileList[i].name);
                    if(fileList&&fileList[i]){
                        imageArr.push(fileList[i]);

                        imgObjPreview.style.display='block';
                        imgObjPreview.style.width='160px';
                        imgObjPreview.style.height='130px';
                        if (userAgent.indexOf('MSIE')==-1){
                            //IE以外的浏览器
                            imgObjPreview.src=window.URL.createObjectURL(docObj.files[i]);//获取上传图片文件的物理路径
                            console.info("非ie浏览器"+imgObjPreview.src);

                        }else {
                            //IE浏览器
                            if (docObj.value.indexOf(",")!=-1){
                                var scrArray=docObj.value.split(",");
                                imgObjPreview.src=scrArray[i];
                            }else {
                                imgObjPreview.src=docObj.value;
                            }
                            console.info("ie浏览器"+imgObjPreview.src);
                        }

                        //为图片建立一个js上传的机制 ，回显 上传进度  ，都传到制定的文件夹下，
                        //还得保存 数据到数据到数据库
                        //

                    }
                    uploadImgIndex++;
                }

            });

            /!*删除功能*!/



        });
        // 为指定的地方添加原有的图片显示
        function loadImg() {

            // 如果不能用过域名空间的方法实现，则可以通过ajax再获取一遍
            var htmlOriginImg="<s:iterator value='app.pic_list' status='st' var='pic'><div class='imageDiv' id='ori"+'${pic.id}'+"'><img  src='<c:url value='${pic.pic_url}' />' width='160px' height='130px' ><div class='cover'><i class='delBtn' onclick='javascript:delME(this)'>删除</i></div> </div></s:iterator>";
            $(htmlOriginImg).insertBefore($(".addImages"));
            //将这些图片些到Imagearr中  删除的同时 则立刻生效 删掉   添加 也是，立刻上传并且换
            //删除图片  不是删除对应关系 删除app_pic 依据id删除掉


            //上传的步骤是  先上传图片到服务器   这时候的分任务  有上传、上传进度、上传结束
            //     上传之后保存信息到app_pic下的  id 为子增长 url为保存路径
            //app_id为当前的app的id
            //













        }
        function delME(data) {
            var rmNow=$(data).parents(".imageDiv");
            //rmNow.remove();
            var indexImg=rmNow.attr("id");
            // 如果这个id是origin +id 则直接删除指定的pic id
            //如果是id img+id 说明是新加载的，需要删除imgarr
            // 然后利用js把这部分局部刷新一下
            console.log("这是第"+indexImg+"个图片遭到删除!");
            //取得id  删除指定id 的pic
            //ajax  恢复seccuss之后，刷新局部
            //就不是自己被干掉了
            var pattern=indexImg.substring(0,3);  //预设两类值 img 和ori
            if(pattern=="ori"){
                var  id=indexImg.substring(3);
                console.info("说明是预先加载的,id:"+id);

                $.ajax({
                    url:'appAction_updatePicByidAndAppid?pic_id='+id,
                    dataType:'text',
                    success:function (data) {
                        //重新加载
                        console.info("有吗？no"+data);
                        rmNow.remove();

                    },
                    error:function () {


                    }

                });

            }
            if(pattern=="img") {
                console.log("删除前------");
                printArr(imageArr);
                imageArr.splice(indexImg, 1);
                console.log("删除后------");
                printArr(imageArr);
                //$("#screenshot-upload").val(imageArr[0].name);
                console.info("上传截图的值" + $("#screenshot-upload").attr(value));
            }

        }
        function printArr(arry) {
            for(var i=0;i<arry.length;i++){
                console.log(i+":"+arry[i].name);
            }
        }
        var uploadImgIndex=0;
        var imageArr=[];
        function submitForm() {
//            $("#progressbar").show();
//            $("#divupload").hide();
            $("#devhidden").val(getChecked());
            $("#devhidden").attr("value",getChecked());
            console.info("属性名字:"+$("#devhidden").attr("name"));
            console.info("属性值："+$("#devhidden").attr("value"));
            // 此时的值是  形如 "52,366"的字符串，需要在appService里面做进一步的处理
            //将传输的的图片信息接到对应的
            // $("#screenshot-upload").val(imageArr);
            // console.info("上传截图的"+$("#screenshot-upload").attr(value));
            return true;
        }
        function collapsethisAll() {
            $("#devtype").tree('collapseAll');

        }
        function expandthisAll() {
            $("#devtype").tree('expandAll');

        }

        function checkedIsChecked() {
            //勾选当前的devtype
            $.ajax({
                url:'appAction_getDevTypesJsonByAppId?id=${app.app_id}',<%--求当前app 的所有devtype 的id组成的数组--%>
                dataType:"json",
                success:function (data) {
                    console.log("当前app的devtype数组为："+data);
                    checkByid(data);
                },
                error:function (data) {
                    console.log("发生了错误:");
                }
            });

        }
        function checkByid(data) {
            for (var i = data.length - 1; i >= 0; i--) {

                var node=$('#devtype').tree('find',data[i]);
                console.log("需要自动勾选："+node.id+":");

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
            console.info("已选择的适配model为:"+s)
            return s;
        }

    </script>
</head>
<body>


<div id="page" align="center" style="" >

    <div class="easyui-layout" align="center" style="width:100%;height: 100%;">
        <div data-options="region:'north'" style="height: 10%;border: 0;background-color:rgba(0,0,0,0)">
            <%--header--%>

            <%@include file="../admin/admin_main_head.jsp"%>

        </div>
        <div data-options="region:'south'" style="height: 22px;border: 0;background-color:rgba(0,0,0,0)">
            <%--footer--%>
            <%@include file="../admin/admin_main_foot.jsp"%>
        </div>
        <div data-options="region:'west',collapsible:false" title="管理菜单" style="width: 15%;">
            <%@include file="../admin/admin_main_left.jsp"%>
        </div>



        <div id="mainPage" data-options="region:'center',border:false,href:'<%--/appAction_getAllApps--%>'" style="width: 50%">

            <div style="">

                <div class="easyui-panel" title="修改App信息"  style="">
                    <div style="margin: 20px 0;"></div>
                    <%--以一个上传表单--%>
                    <form id="formid" method="post"  action="<%--/uploadPa_execte--%>/appAction_updateApp" enctype="multipart/form-data"
                          onsubmit="return submitForm()">
                        <%--<s:token name="tokenSession"></s:token>--%>
                        <%--表单的隐藏域--%>
                        <%--<input type="hidden" name="orgapk" value="${app}">--%>
                        <%--这里需要用到--icon的路径  、下载路径、hash打散文件夹路径、权限要求、简拼--%>
                        <input type="hidden" name="app_id" value="${app.app_id}">
                            <%--<s:iterator value='app.pic_list' status='st' var='pic'>
                                <div >
                                    <img src='<c:url value="${pic.pic_url}" />' width='240px' height='120px'>
                                </div>
                            </s:iterator>--%>

                        <input type="hidden" name="app_ico" value="${app.app_ico}">
                        <%--<input type="hidden" name="down_url" value="${uploadapk.down_url}">--%>
                        <%--<input type="hidden" name="savePath" value="${uploadapk.savePath}">--%>
                        <%--<input type="hidden" name="userPermissions" value="${uploadapk.userPermissions}">--%>
                        <input type="hidden" name="jianpin" value="${app.jianpin}">
                        <div id="app_icon" style="margin-left: 50px;margin-bottom: 10px">
                            应用图标：<img id="icon_id" src="<c:url value="${app.app_ico}" />"  height="66" width="66" >
                        </div>
                        <div id="app_name" style="margin-left: 50px;margin-bottom: 10px">
                            <input label="应用名称：" class="easyui-textbox" value="${app.app_name}" name="app_name" style="width: 400px;" >
                        </div>
                        <div id="package_name" style="margin-left: 50px;margin-bottom: 10px">
                            <input label="Package ：" class="easyui-textbox" value="${app.pack_name}" name="pack_name" style="width: 400px;">
                        </div>
                        <div id="app_version" style="margin-left: 50px;margin-bottom: 10px">
                            <input label="应用版本：" class="easyui-textbox" value="${app.app_ver}" name="app_ver" style="width: 400px;">
                        </div>
                        <div id="app_size" style="margin-left: 50px;margin-bottom: 10px">
                            <input label="应用大小：" class="easyui-textbox" value="${app.app_size}" name="app_size" style="width: 400px;">
                        </div>
                        <div id="app_minsdkversion" style="margin-left: 50px;margin-bottom: 10px">
                            <%--因模型驱动的考虑  将name属性值改为 androidVersion 向Action提交--%>
                            <input label="系统要求：" class="easyui-textbox"
                                   value="${app.androidVersion}" name="androidVersion" style="width: 400px;">
                        </div>
                        <div id="apptypeid" style="margin-bottom: 10px;margin-left: 50px">
                            <%--input 的name需要按照模型驱动来--%>
                            <input label="选择分类：" id="apptype"  class="easyui-combobox" name="app_type.id" style="width: 400px;"
                                   data-options="
                                            url:'appTypeAction_getAllAppTypes',
                                            method:'get',
                                            valueField: 'id',<%--这两个值一定要与json数据对应正确，否则将不能正确提交--%>
                                            textField: 'apptype_name',<%------%>
                                            panelHeight:'auto',
                                            onLoadSuccess:function(){
                                            $('#apptype').combobox('setValue','${app.app_type.id}');
                                            <%--增加了默认apptype 选中的问题.--%>
                                            }
                                                            ">

                        </div>
                        <div id="divdevtype" style="margin-left: 50px;margin-bottom: 10px">
                            适配机型：<div style="margin: 20px 0;">
                            <a  class="easyui-linkbutton" href="javascript:void(0)"
                                onclick="javascript:getChecked()">显示勾选的信息</a>
                            <a  class="easyui-linkbutton" href="javascript:void(0)"
                                onclick="javascript:collapsethisAll()">隐藏所有子分类</a>
                            <a  class="easyui-linkbutton" href="javascript:void(0)"
                                onclick="javascript:expandthisAll()">显示所有子分类</a>
                        </div>
                            <%--提交devtype数据--%>
                            <div style="margin: 20px 0;width:85%">
                                <div class="easyui-panel" style="padding: 5px" >
                                    <ul id="devtype" class="easyui-tree" name=""
                                        data-options="
                                            url:'devTypeAction_getAllDevTypeToTree',<%--此处为获得所有的分类的json--%>
                                            method:'GET',
                                            animate:true,
                                            line:true,
                                            checkbox:true,
                                            onLoadSuccess: function () {
                                                <%--$('#devtype').tree('collapseAll');--%>
                                                <%--勾选默认的选项--%>
                                                checkedIsChecked();
                                                collapsethisAll();
                                                },
                                            ">

                                    </ul>
                                </div>
                            </div>
                        </div>
                            <%--利用js将获取到的值发送到这里
                            name 能不能提交到模型驱动里面呢？有待尝试。先通过提交的数组  通过逗号分开。

                            --%>
                        <input type="hidden" id="devhidden" name="devTypes.ids" value="">
                        <%-- 上传截图 --%>
                        <div style="margin-left: 50px">上传截图：</div>
                        <div id="screenshot" style="margin-left:50px;">
                        <%--上传截图如何回显 修改前的图片？？    --%>

                            <p><span style="color: red">注：每张图片大小不得超过2M，(请一次性选择所有需要上传的图片**此处尚有bug)</span> </p>

                            <div class="picDiv">
                                <div class="addImages">
                                    <input class="file" type="file"  <%--onchange="selectImage(this)"--%> id="screenshot-upload" multiple="multiple" accept="image/png,image/jpeg,image/gif,image/jpg" name="screenshotupload">
                                    <div class="text-detail">
                                        <span>+</span>
                                        <p>点击上传</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div id="app_dsec" style="margin-left: 50px;margin-top:20px;margin-bottom: 10px;">
                            <input class="easyui-textbox" label="应用描述："data-options="multiline:true" name="summary" style="width: 85%;height: 80px;" value="${app.summary}">
                        </div>
                        <div id="update_log" style="margin-left: 50px;margin-bottom: 10px">
                            <input class="easyui-textbox" label="升级日志：" data-options="multiline:true" name="update_info" style="width: 85%;height: 80px;" value="${app.update_info}">
                        </div>
                        <div id="divaddapksubmit" style="margin-left: 50px;margin-bottom: 10px" align="center">
                            <a href="/appAction_getAppPageBean" class ="easyui-linkbutton"  style="margin-top:20px;height: 35px;width: 100px">返回</a>
                            <input id="addsubmit" class="easyui-linkbutton" type="submit"  style="margin-top:20px;height: 35px;width: 100px;margin-left: 100px" value="确认修改APP" />
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
