<%--
  Created by IntelliJ IDEA.
  User: changcan
  Date: 2018/11/8
  Time: 15:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <form action="/hswareCodeAction_addHswareCodeApply" method="post" >
        <table >
            <tr>
                <td><h2>申请板卡硬件序列号</h2></td>
            </tr>

            <tr>
                <td>板卡名称：</td>
                <td><input type="text" name="mainBoard"></td>
            </tr>

            <tr>
                <td>产品型号：</td>
                <td><input type="text" name="productType"></td>
            </tr>
            <tr>
                <td>MODEL号：</td>
                <td><input type="text" name="productModel"></td>
            </tr>
            <tr>
                <td>牌照商：</td>
                <td><input type="text" name="licensePlate"></td>
            </tr>

            <tr>
                <td>液晶屏厂家与型号：</td>
                <td><input type="text" name="screenModel"></td>
            </tr>
            <tr>
                <td>机壳厂家：</td>
                <td><input type="text" name="shellModel"></td>
            </tr>

            <tr>
                <td>有无开关：</td>
                <td><input type="radio" name="hasPowerSwitch" value="true">有<input type="radio" name="hasPowerSwitch" value="false">没有</td>
            </tr>

            <tr>
                <td>板卡配置：</td>
                <td>
                    <input type="checkbox" name="hasDolby" value="true">杜比
                    <input type="checkbox" name="hasMHL" value="true">MHL
                    <input type="checkbox" name="hasTeletext" value="true">图文
                    <input type="checkbox" name="hasNICAM" value="true">丽音
                    <input type="checkbox" name="RAM" value="true">RAM
                    <input type="checkbox" name="FLASH" value="true">Flash
                </td>
            </tr>

            <tr>

                <td>背光电压范围：</td>
                <td><select name="blackLight">
                        <option value="10V">10V</option>
                        <option value="15V">15</option>
                    </select>
                </td>


            </tr>

            <tr>
                <td>背光功率：</td>
                <td><input type="text" name="blackLightPower"></td>
            </tr>

            <%--<tr>--%>
                <%--<td>印度专用：</td>--%>
                <%--<td><input type="radio" name="india" value="yes">是<input type="radio" name="india" value="no">否</td>--%>

            <%--</tr>--%>

            <tr>
                <td>相似板卡名称：</td>
                <td><input type="text" ></td>
            </tr>

            <tr>
                <td>相似板卡硬件号：</td>
                <td><input type="text" ></td>
            </tr>

            <tr>
                <td>备注：</td>
                <td><textarea rows="10" cols="50" name="note"></textarea></td>

            </tr>


            <tr>
                <td><input type="reset" value="重填"></td>
                <td><input type="submit" value="提交"></td>

            </tr>

        </table>

    </form>

</body>
</html>
