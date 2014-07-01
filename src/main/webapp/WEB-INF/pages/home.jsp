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
            background: #888;
        }

        #tool_bar {
            position: absolute;
            -webkit-box-sizing: border-box;
            -moz-box-sizing: border-box;
            -webkit-box-sizing: border-box;
            -moz-box-sizing: border-box;
            box-sizing: border-box;
            top: 0px;
            left: 0px;
            right: 0px;
            height: 40px;
            background: #444;
            font-size: 0;
        }

        #title {
            border: 0;
            margin: 5px 10px;
            padding: 0 10px;
            line-height: 30px;
            outline: none;
            width: 60%;
        }

        #editor {
            position: absolute;
            margin-right: 5px;
            top: 50px;
            left: 10px;
            bottom: 10px;
            right: 50%;
            -webkit-box-sizing: border-box;
            -moz-box-sizing: border-box;
            -webkit-box-sizing: border-box;
            -moz-box-sizing: border-box;
            box-sizing: border-box;
            -webkit-box-flex: 1;
            -moz-box-flex: 1;
            -ms-box-flex: 1;
            -webkit-box-flex: 1;
            -moz-box-flex: 1;
            -ms-box-flex: 1;
            -o-box-flex: 1;
            box-flex: 1;
            font-size: 16px;
        }

        #viewer {
            position: absolute;
            margin-left: 5px;
            top: 50px;
            right: 10px;
            bottom: 10px;
            left: 50%;
            -webkit-box-sizing: border-box;
            -moz-box-sizing: border-box;
            -webkit-box-sizing: border-box;
            -moz-box-sizing: border-box;
            box-sizing: border-box;
            -webkit-box-flex: 1;
            -moz-box-flex: 1;
            -ms-box-flex: 1;
            -webkit-box-flex: 1;
            -moz-box-flex: 1;
            -ms-box-flex: 1;
            -o-box-flex: 1;
            box-flex: 1;
            background: #ccc;
        }
    </style>
</head>
<body>

<div id="tool_bar"><input type="text" id="title"></div>
<div id="editor"></div>
<div id="viewer"></div>

<script src="<%= request.getContextPath() %>/js/ace/ace.js"
        type="text/javascript" charset="utf-8"></script>
<script>
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
