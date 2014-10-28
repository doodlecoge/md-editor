<%@ page import="java.util.regex.Pattern" %>
<%@ page import="java.util.regex.Matcher" %>
<%@ page import="me.hch.utils.AppHelper" %>
<%@ page import="java.util.Enumeration" %>
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
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title><decorator:title/> - Online Notes</title>


    <%
        Pattern ptn = Pattern.compile("^http://(localhost|127\\.0\\.0\\.1)");
        String url = request.getRequestURL().toString();
        Matcher m = ptn.matcher(url);
        if (m.find()) {
    %>
    <style type="text/css">
        @font-face {
            font-family: 'Arvo';
            font-style: normal;
            font-weight: 400;
            src: local('Arvo'), url(<%=request.getContextPath()%>/fonts/arvo.woff) format('woff');
        }

        @font-face {
            font-family: 'Arvo';
            font-style: normal;
            font-weight: 700;
            src: local('Arvo Bold'), local('Arvo-Bold'), url(<%=request.getContextPath()%>/fonts/arvo_bold.woff) format('woff');
        }
    </style>
    <%
    } else {
    %>
    <style type="text/css">
        @font-face {
            font-family: 'Arvo';
            font-style: normal;
            font-weight: 400;
            src: local('Arvo'), url(https://fonts.gstatic.com/s/arvo/v8/BM-nqL-L5PgjKPDNaleWB_esZW2xOQ-xsNqO47m55DA.woff) format('woff');
        }

        @font-face {
            font-family: 'Arvo';
            font-style: normal;
            font-weight: 700;
            src: local('Arvo Bold'), local('Arvo-Bold'), url(https://fonts.gstatic.com/s/arvo/v8/_OKjjqM9ed2qvTR07QdjWwLUuEpTyoUstqEm5AMlJo4.woff) format('woff');
        }
    </style>
    <%
        }
    %>


    <style type="text/css">
        body {
            margin: 0;
            background: #f0f0f0;
            font-family: "Arvo", "Helvetica Neue", Helvetica, Arial, sans-serif;
        }

        .c {
            width: 1000px;
            margin: 0 auto;
        }

        #header {
            background: #69c;
            border-bottom: 1px solid #bbb;
        }

        #header .c {
            font-size: 60px;
            color: #f0f0f0;
            line-height: 100px;
        }

        #content {
            padding: 10px;
            background: #fff;

            /*-webkit-box-shadow: 0 0px 10px rgba(0, 0, 0, 0.25);*/
            /*-moz-box-shadow: 0 0px 10px rgba(0, 0, 0, 0.25);*/
            /*box-shadow: 0 0px 10px rgba(0, 0, 0, 0.25);*/

            box-sizing: border-box;
        }

        #nav {
            background: #f0f0f0;
            /*border-bottom: 1px solid #a33;*/
        }

        #nav .c {
            line-height: 30px;
        }

        #nav .c a {
            text-decoration: none;
            font-weight: bold;
            color: #69c;
            margin-right: 20px;
        }

        #nav .c a:hover {
            color: #c66;
        }

        #footer .c {
            text-align: center;
            line-height: 50px;
        }
    </style>

    <script type="text/javascript">
        console = console || {
            log: new Function()
        }
    </script>
    <decorator:head/>
</head>
<body>
<div id="nav">
    <div class="c">
        <a href="/">Home</a>
        <a href="/explorer">Write sth.</a>
    </div>
</div>
<div id="header">
    <div class="c">Online Notes</div>
</div>

<div id="content" class="c">
    <decorator:body/>
</div>
<div id="footer">
    <div class="c">
        &copy; Online Notes, 2014. Want to be a writer, please contact us hchwang001@163.com.
    </div>
</div>
</body>
</html>
