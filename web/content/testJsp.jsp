<%@ page import="com.test.TestJsp.Counter" %>
<%@ page import="com.test.Model.Employee" %>
<%@ page import="com.test.Model.Person" %>
<%--
  Created by IntelliJ IDEA.
  User: changcan
  Date: 2018/6/29
  Time: 13:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>学习Jsp,好榜样！</title>
</head>
<body>
<%request.setCharacterEncoding("utf-8");%>
当前访问次数：
<%=
    Counter.getCount()
%>
<br>
<%--答案

--%>
<%! int count=0; %>
<%=++count%>
<br>

<%="27"%><br>
<%= new String[3] %><br>
<%= 5>3 %><br>
<%=new Counter()%><br>
<%
    response.addCookie(new Cookie("changcan","changshengzhe"));
    Cookie[] cookies=request.getCookies();
    if (!(cookies==null|(cookies!=null&&cookies.length==0))) {
        for (Cookie c : cookies
                ) if (c!=null){
            out.println("cookies--"+c.getName()+":"+c.getValue()+"<br>");
        }
    }else{
        out.println("无cookies<br>");
    }
%>
<br>
<%! int x=42;%>
<% int x=22;
//shi buxui
%>
<%=x%>
<br>
jsp:useBean<br>
<%
    String s=request.getParameter("userName") ;
    String ss="";
    if (s!=null){
 ss=new String(s.getBytes("ISO-8859-1"),"UTF-8");}
 String id=request.getParameter("userId");
    String ids="";
    if (id!=null){
        ids=id;
    }


%>
<jsp:useBean id="person" type="com.test.Model.Person" class="com.test.Model.Employee" scope="request">
    <jsp:setProperty name="person" property="name" value='<%= ss %>'/>
    <%--<jsp:setProperty name="person" property="id" value='<%=ids%>'/>--%>
</jsp:useBean>
Name is:<jsp:getProperty name="person" property="name"/>
<%--id:<jsp:getProperty name="person" property="id"/>--%>
<br>
JSP:PARAM参数：<br>
<jsp:useBean id="person1" type="com.test.Model.Person" class="com.test.Model.Employee" scope="request">
    <jsp:setProperty name="person1" property="name" param="userName"/>
</jsp:useBean>
JSP:PARAM参数： Name is:<jsp:getProperty name="person1" property="name"/>

<br>
JSP:无参数测试：<br>
<jsp:useBean id="person2" type="com.test.Model.Person" class="com.test.Model.Employee" scope="request">
    <jsp:setProperty name="person2" property="*" />
</jsp:useBean>
JSP:无value： Name is:<jsp:getProperty name="person2" property="name"/>
<br>ID is:<jsp:getProperty name="person2" property="id"/>
<br>
Object的实现<br>
<jsp:useBean id="employee" type="com.test.Model.Person" class="com.test.Model.Employee" scope="request"/>
    Dog'name is:<jsp:getProperty name="employee" property="dog"/>

<br>
==================================================<br>
<%--<%=((Person)request.getAttribute("employee")).getDog().getName()%>--%>

<br>
========================EL表达式<br>
Dog'name is::${requestScope.employee.dog.name}
<br>
========================EL表达式2<br>
Dog's name is:${requestScope["employee"]}
<br>
========================EL表达式3<br>
Dog's name is:${array["0"]}
<br>
========================EL表达式4<br>
Dog's name is:${array[1]}
<br>
========================EL表达式4<br>
Dog's name is:${list}
<br>
<jsp:include page="header.jsp">
    <jsp:param name="subTitle" value="STDUY good good ,day day up学习一过中程，继续加油"/>
</jsp:include>

<br>
<%if (request.getParameter("usernameok")==null){%>
    <jsp:forward page="HandleIt.jsp"/>

<%}%>
Hello ${param.usernameok}
<br>















</body>
</html>
