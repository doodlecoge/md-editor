<%@ page import="java.util.regex.Pattern" %>
<%@ page import="java.util.regex.Matcher" %>
<%--
  Created by IntelliJ IDEA.
  User: huaichao
  Date: 10/28/14
  Time: 4:08 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title><c:out value="${file.name}"/></title>

    <%
        Pattern ptn = Pattern.compile("^http://(localhost|127\\.0\\.0\\.1)");
        String url = request.getRequestURL().toString();
        Matcher m = ptn.matcher(url);
        if (m.find()) {
    %>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.11.1.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath() %>/js/marked.js"></script>
    <% } else { %>
    <script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
    <script src="https://github.com/chjj/marked/blob/master/lib/marked.js"></script>
    <% } %>

</head>
<body>
<div id="content"></div>
<input type="hidden" id="m" value="<c:out value='${content.content}'/>">
<script type="text/javascript">
    marked.setOptions({
        renderer: new marked.Renderer(),
        gfm: true,
        tables: true,
        breaks: false,
        pedantic: false,
        sanitize: true,
        smartLists: true,
        smartypants: false
    });


    $(function () {
        var txt = $('#m').val();
        var html = marked(txt);
        $("#content").html(html);
    });
</script>

</body>
</html>
