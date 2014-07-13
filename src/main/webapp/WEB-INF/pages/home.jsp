<%--
  Created by IntelliJ IDEA.
  User: huaiwang
  Date: 6/25/14
  Time: 9:13 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
<head>
    <title>Markdown Editor</title>
    <link type="text/css" rel="stylesheet"
          href="<%=request.getContextPath()%>/css/preview.css"/>
    <link type="text/css" rel="stylesheet"
          href="<%=request.getContextPath()%>/jstree/style.css"/>
    <link type="text/css" rel="stylesheet"
          href="<%=request.getContextPath()%>/css/editor.css"/>
</head>
<body>

<div id="tool_bar">
    <table style="width: 100%">
        <tr>
            <td style="width: 0;">
                <ul>
                    <li class="fa fa-angle-double-left toggle-tool-win"></li>
                    <li class="fa fa-save"></li>
                    <li class="fa fa-trash-o"></li>
                </ul>
            </td>
            <td style="width: 100%; padding: 0 5px;">
                <input type="text" class="title">
            </td>
            <td style="width: 0;">
                <ul>
                    <li class="fa fa-th-list"></li>
                    <li class="fa fa-th-list"></li>
                    <li class="fa fa-th-list"></li>
                </ul>
            </td>
        </tr>
    </table>
</div>

<div id="content">
    <div class="tool-win">
        <div class="root">All Notes</div>
        <div class="tree">
            Loading...
        </div>
    </div>
    <div class="designer trans">
        <div class="editor"></div>
        <div class="viewer preview"></div>
    </div>
</div>


<script src="<%= request.getContextPath() %>/js/ace/ace.js"
        type="text/javascript" charset="utf-8"></script>
<script src="<%= request.getContextPath() %>/jstree/jstree.js"
        type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
    var _consts = {
        "k_tws": "tool_window_state",
        "b_ls": 'localStorage' in window &&
                window['localStorage'] !== null
    };
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
    var editor = ace.edit($(".editor").get(0));
    editor.setTheme("ace/theme/chrome");
    editor.setPrintMarginColumn(80);
    //    editor.getSession().setMode("ace/mode/text");
    editor.session.setMode("ace/mode/text");
    var doc = editor.getSession().doc;
    doc.on('change', function (e) {
        var txt = editor.getValue();
        if (_consts.b_ls) localStorage.setItem('txt', txt);
        var html = marked(txt);
        $(".viewer").html(html);
    });
    editor.session.on('changeScrollTop', syncView);

    function syncView() {
        var v = $(".viewer");
        var n = editor.getSession().getLength();
        var i = editor.getFirstVisibleRow();
        var r = getScrollHeight(v);
        v.scrollTop(i * r / n);
    }

    function getScrollHeight(e) {
        return e[0].scrollHeight !== undefined ? e[0].scrollHeight : e.find("html")[0].scrollHeight !== undefined && e.find("html")[0].scrollHeight !== 0 ? e.find("html")[0].scrollHeight : e.find("body")[0].scrollHeight
    }

    $(function () {
        $("li.toggle-tool-win").click(toggle_tool_window);

        var tool_win = $.cookie(_consts.k_tws);
        toggle_tool_window(null, tool_win);
        if (_consts.b_ls) editor.setValue(localStorage.getItem('txt'));

        $('.tree').jstree();
    });

    function toggle_tool_window(e, state) {
        var b;
        if (e == null) b = state == 'close';
        else b = $(this).hasClass("fa-angle-double-left");

        var _this = $("li.toggle-tool-win");

        if (b) { // close tool window
            _this.removeClass("fa-angle-double-left");
            _this.addClass("fa-angle-double-right");
            $("#content").addClass("hid");
            $.cookie(_consts.k_tws, 'close');
        } else {
            _this.removeClass("fa-angle-double-right");
            _this.addClass("fa-angle-double-left");
            $("#content").removeClass("hid");
            $.cookie(_consts.k_tws, 'open');
        }
    }

</script>
</body>
</html>
