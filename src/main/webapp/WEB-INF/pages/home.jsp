<%--
  Created by IntelliJ IDEA.
  User: huaiwang
  Date: 6/25/14
  Time: 9:13 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Markdown Editor</title>
    <style type="text/css">
        body {
            overflow: hidden;
        }

        #editor {
            margin: 0;
            position: absolute;
            top: 0;
            bottom: 0;
            left: 0;
            right: 50%;
            font-size: 16px;
        }

        #viewer {
            margin: 0;
            position: absolute;
            top: 0;
            bottom: 0;
            left: 50%;
            right: 10px;
            background: #ccc;
        }
    </style>
</head>
<body>
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

    console.log(marked('I am using __markdown__.'));
</script>

<div id="editor"></div>
<div id="viewer"></div>

<script src="<%= request.getContextPath() %>/js/ace/ace.js"
        type="text/javascript" charset="utf-8"></script>
<script>
    var editor = ace.edit("editor");
    editor.setTheme("ace/theme/monokai");
    editor.getSession().setMode("ace/mode/text");
    editor.setPrintMarginColumn(80);
    var doc = editor.getSession().doc;
    doc.on('change', function(e) {
        var txt = editor.getValue();
        var html = marked(txt);
        document.getElementById("viewer").innerHTML = html;
    })
</script>
</body>
</html>
