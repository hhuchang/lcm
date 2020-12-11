<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: changcan
  Date: 2018/8/20
  Time: 14:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

    <link rel="stylesheet" type="text/css" href="<c:url value='/css/page.css'/>">
    <script type="text/javascript">
        function _go() {

        }
    </script>


</head>
<body>
    <div class="divBody">
        <div class="divContent">
            <%--上一页--%>
            <c:choose>
                <c:when test="${pageBean.pageNow eq 1}"><span class="spanBtnDisabled">上一页</span> </c:when>
                <c:otherwise><a href="${url}&pageNow=${pageBean.pageNow-1}"class="aBtn bold">上一页</a> </c:otherwise>
            </c:choose>
                <%--我们需要计算页码列表的开始和结束位置，即两个变量begin和end
            计算它们需要通过当前页码！
            1. 总页数不足6页--> begin=1, end=最大页
            2. 通过公式设置begin和end，begin=当前页-1，end=当前页+3
            3. 如果begin<1，那么让begin=1，end=6
            4. 如果end>tp, 让begin=tp-5, end=tp
             --%>
            <c:choose>
                <c:when test="${pageBean.totalPages<=6}">
                    <c:set value="1" var="begin"/>
                    <c:set var="end" value="${pageBean.totalPages}"/>
                </c:when>
                <c:otherwise>
                    <c:set var="begin" value="${pageBean.pageNow-2}"/>
                    <c:set var="end" value="${pageBean.pageNow+3}"/>
                    <c:if test="${begin<1}">
                        <c:set var="begin" value="1"/>
                        <c:set var="end" value="6"/>
                    </c:if>
                    <c:if test="${end>pageBean.totalPages}">
                        <c:set var="begin" value="${pageBean.totalPages-5}"/>
                        <c:set var="end" value="${pageBean.totalPages}"/>
                    </c:if>
                </c:otherwise>
            </c:choose>

            <c:forEach begin="${begin}" end="${end}" var="i">
                <c:choose>
                    <c:when test="${i eq pageBean.pageNow}">
                        <span class="spanBtnSeclect">${i}</span>
                    </c:when>
                    <c:otherwise><a href="${url}&pageNow=${i}" class="aBtn">${i}</a> </c:otherwise>
                </c:choose>
            </c:forEach>
                <%--显示点点点--%>
            <c:if test="${end<pageBean.totalPages}">
                <span class="spanApostrophe">...</span>
            </c:if>
            <%--下一页--%>
            <c:choose>
                <c:when test="${pageBean.pageNow eq pageBean.totalPages}">
                    <span class="spanBtnDisabled">下一页</span>
                </c:when>
                <c:otherwise>
                    <a href="${url}&pageNow=${pageBean.pageNow+1}" class="aBtn bold">下一页</a>
                </c:otherwise>
            </c:choose>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                <%-- 共N页 到M页 --%>
            <span>共${pageBean.totalPages}页</span>
            <span>跳转到第</span>
            <input type="text" class="inputPageCode" id="pageNow" value="${pageBean.pageNow}"/>
            <span>页</span>
            <a href="javascipt:_go();" class="aSubmit">确定</a>

        </div>
    </div>


</body>
</html>
