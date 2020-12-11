<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: changcan
  Date: 2018/8/23
  Time: 23:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
    <script type="text/javascript" src="<c:url value="/js/jquery.min.js"/>"></script>

    <script type="text/javascript">
        $('#devtype').tree({
            onLoadSuccess:checkedIsChecked
        });
        function checkedIsChecked() {
            $.ajax({
                url:'../../../test/test05.json',<%--求当前app 的所有devtype 的id醉成的数组--%>
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
    <div style="margin: 20px 0;">
        <div class="easyui-panel" style="padding: 5px" width="800px">
            <ul id="devtype" class="easyui-tree"
                data-options="
                    url:'../../../test/test04.json',<%--此处为获得所有的分类的json--%>
                    method:'GET',
                    animate:true,
                    line:true,
                    checkbox:true,

                    ">

            </ul>
        </div>
    </div>

</body>
</html>
