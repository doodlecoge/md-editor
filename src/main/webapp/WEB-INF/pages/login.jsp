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
    <title></title>
</head>
<body>
<form action="${pageContext.request.contextPath}/login" method="post">
    <table>
        <tr>
            <td>Username:</td>
            <td><input type='text' name='username' /></td>
        </tr>
        <tr>
            <td>Password:</td>
            <td><input type='password' name='password'></td>
        </tr>
        <tr>
            <td colspan='2'><input name="submit" type="submit" value="Submit"></td>
        </tr>
    </table>
</form>

<%--<div tiles:fragment="content">--%>
    <%--<form name="f" th:action="@{/login}" method="post">--%>
        <%--<fieldset>--%>
            <%--<legend>Please Login</legend>--%>
            <%--<div th:if="${param.error}" class="alert alert-error">--%>
                <%--Invalid username and password.--%>
            <%--</div>--%>
            <%--<div th:if="${param.logout}" class="alert alert-success">--%>
                <%--You have been logged out.--%>
            <%--</div>--%>
            <%--<label for="username">Username</label>--%>
            <%--<input type="text" id="username" name="username"/>--%>
            <%--<label for="password">Password</label>--%>
            <%--<input type="password" id="password" name="password"/>--%>

            <%--<div class="form-actions">--%>
                <%--<button type="submit" class="btn">Log in</button>--%>
            <%--</div>--%>
        <%--</fieldset>--%>
    <%--</form>--%>
<%--</div>--%>
</body>
</html>
