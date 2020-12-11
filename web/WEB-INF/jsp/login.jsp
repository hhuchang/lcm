<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: changcan
  Date: 2018/5/30
  Time: 13:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>熊猫云后台——登陆</title>
    <script type="text/javascript" src="<c:url value="/js/jquery.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/js/jquery.easyui.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/js/locale/easyui-lang-zh_CN.js"/>"></script>
    <link rel="stylesheet" href="<c:url value="/js/themes/default/easyui.css"/>" type="text/css"/>
    <link rel="stylesheet" href="<c:url value="/js/themes/icon.css"/>" type="text/css"/>
    <link rel="stylesheet" href="<c:url value="/css/main.css"/>"/>
    <%--<script type="text/javascript" src="http://cdn.webfont.youziku.com/wwwroot/js/wf/youziku.api.min.js"></script>--%>
    <script type="text/javascript">


    </script>
    <script type="text/javascript">
        function _changeCode() {
//            console.info("ojokok");
            $("#vcode").attr("src","/loginAction_getVerifyCode?nocache="+new Date().getTime());

        }
    </script>


    <style>
        .redcolorfont{color: red}
        .loginfont{
            font-size: 20px;
        }
        .input{
            width: 200px;height: 26px;border: 1px solid #d9d9d9;padding-top: 4px;padding-left: 8px;font-size: 20px;
        }
        .yzm{
            width: 200px;height: 26px;border: 1px solid #d9d9d9;padding-top: 4px;padding-left: 8px;
            vertical-align: middle;margin-right: 30px;font-size: 20px;
        }
        #vcode{
            vertical-align: middle;width: 80px;height: 46px;border: 1px solid #000;margin-left: 30px;
        }

    </style>
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/regist.css'/>">

</head>
<body>
<%@include file="header.jsp"%>
<div align="center">

    <%--<table width="780" align="center" >
        <tr>

            <td>
                <h2 style="font-size: 20px;">请输入用户名和密码:</h2>
                <br>




                <s:actionerror cssClass="error"/>
                <div class="redcolorfont">
                    ${tip}
                </div>
                <div  align="center" style="font-size: 20px">
                <form action="loginAction_validLogin">
                        &lt;%&ndash;<s:token name="tokenSession"></s:token>&ndash;%&gt;


                        <input type="text" name="username" label="用户名"  class="loginfont"/>
                        <input type="password" name="password" label="密码" class="loginfont"/>
                        <input type="text" name="verifycode" label="验证码" class="loginfont"/>
                        <tr>
                            <td></td>
                            <td>
                                <span class="spanImg"><img width="100" id="vcode" src="/loginAction_getVerifyCode"/></span>
                            </td>
                            <td>
                                <a id="verifyCode" href="javascript:_changeCode()"><p style="font-size: 15px">看不清，换一张</p></a>
                            </td>
                        </tr>

                        <tr>
                            <td colspan="2" style="font-size: 20px">
                                <input type="submit" class="easyui-linkbutton" value="登陆"  style="font-size: 15px;width: 80px;height: 40px"/>
                                <input type="reset"  class="easyui-linkbutton" value="重置" style="font-size: 15px;width: 80px;height: 40px"/>
                            </td>
                        </tr>
                </form>
                </div>



            </td>
        </tr>
    </table>--%>
    <form target="_top" action="loginAction_validLogin" method="post" id="loginForm">
        <s:token/>
        <table>
            <%--错误提示--%>
            <tr>
                <td height="20"></td>
                <td><label class="redcolorfont" id="msg">${tip}</label> </td>
            </tr>
            <tr>
                <td width="80" style="font-size: 20px">用户名</td>
                <td><input class="input" type="text" name="username"></td>
            </tr>
            <tr>
                <td width="80" style="font-size: 20px">密  码</td>
                <td><input class="input" type="password" name="password" value=""></td>
            </tr>
            <tr>
                <td width="80" style="font-size: 20px">验证码</td>
                <td>
                    <input class="input" type="text" name="verifycode"  value=""/>


                </td>
                <td>
                    <img id="vcode" src="/loginAction_getVerifyCode"/>
                    <a id="verifyCodeFresh" href="javascript:_changeCode()" >看不清，换一张</a>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="padding-top: 50px;" align="center">
                    <input type="submit" class="easyui-linkbutton" value="登陆"  style="font-size: 15px;width: 80px;height: 40px"/>
                    <input type="reset"  class="easyui-linkbutton" value="重置" style="font-size: 15px;width: 80px;height: 40px"/>
                </td>
            </tr>
        </table>
    </form>





<div />


<%@include file="footer.jsp"%>

</body>
</html>