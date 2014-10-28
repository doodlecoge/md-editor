<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: huaichao
  Date: 10/27/14
  Time: 10:40 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Home</title>
    <style type="text/css">
        .articles {

        }
        .articles li {
            line-height: 25px;
        }
        .articles li a {
            text-decoration: none;
        }
    </style>
</head>
<body>

<ul class="articles">

    <c:forEach items="${files}" var="file">
        <li>
            <a href="<c:url value="/a/${file.id}"/>">
                <c:out value="${file.name}"/>
            </a>
        </li>
    </c:forEach>
</ul>

</body>
</html>
