<%--
  Created by IntelliJ IDEA.
  User: hch
  Date: 2014/5/28
  Time: 18:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator"
           prefix="decorator" %>
<html>
<head>
    <title><decorator:title/> - Huaichao</title>
    <link type="text/css" rel="stylesheet"
          href="<%= request.getContextPath() %>/css/site.css"/>
    <link type="text/css" rel="stylesheet"
          href="<%= request.getContextPath() %>/css/font-awesome.css"/>
    <link type="text/css" rel="stylesheet"
          href="<%= request.getContextPath() %>/css/jquery.plugins.css"/>
    <script type="text/javascript"
            src="<%= request.getContextPath() %>/js/marked.js"></script>
    <script type="text/javascript"
            src="<%= request.getContextPath() %>/js/jquery-1.11.1.js"></script>
    <script type="text/javascript"
            src="<%= request.getContextPath() %>/js/jquery.cookie.js"></script>
    <script type="text/javascript"
            src="<%= request.getContextPath() %>/js/jquery-ui.js"></script>
    <script type="text/javascript"
            src="<%= request.getContextPath() %>/js/jquery.plugins.js"></script>

    <script type="text/javascript">
        console = console || {
            log: new Function()
        }
    </script>
    <decorator:head/>
</head>
<body><decorator:body/></body>
</html>
