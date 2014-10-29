<%--
  Created by IntelliJ IDEA.
  User: huaichao
  Date: 10/27/14
  Time: 10:29 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
    <style type="text/css">
        td {
            line-height: 40px;
        }

        input[type="text"], input[type="password"] {
            height: 25px;
            line-height: 25px;
            width: 300px;
        }

        input[type="submit"] {
            font-size: 16px;
            box-sizing: content-box;
            border: 1px solid #ccc;
            padding: 5px 10px;
            border-radius: 30px;
        }
    </style>
</head>
<body>
<form action="${pageContext.request.contextPath}/login" method="post">
    <table>
        <tr>
            <td>Username:</td>
            <td><input type='text' name='username'/></td>
        </tr>
        <tr>
            <td>Password:</td>
            <td><input type='password' name='password'></td>
        </tr>
        <tr>
            <td></td>
            <td><input name="submit" type="submit" value="Submit"></td>
        </tr>
    </table>


    <hr/>

    <span style="color: darkgreen;">
    Contact us <b>hchwang001@163.com</b> to get an account for free!
    </span>
</form>
</body>
</html>
