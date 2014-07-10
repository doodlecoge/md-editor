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
    <style type="text/css">
        body {
            padding: 0;
            margin: 0;
            overflow: hidden;
        }

        #tool_bar {
            height: 35px;
            padding: 5px;

            background-color: #eeeeee;
            background-image: -moz-linear-gradient(#f0f0f0, #ddd);
            background-image: -webkit-linear-gradient(#f0f0f0, #ddd);
            background-image: linear-gradient(#f0f0f0, #ddd);
            background-repeat: repeat-x;

            border-bottom: 1px solid #aaa;

            /*background: #707070;*/
            /*background: -o-linear-gradient(top, rgba(0, 0, 0, .2) 0, rgba(0, 0, 0, 0) 5%, rgba(0, 0, 0, 0) 97%, rgba(0, 0, 0, .45) 100%), -o-linear-gradient(left, rgba(0, 0, 0, .2) 0, rgba(0, 0, 0, 0) .2%, rgba(0, 0, 0, 0) 99.8%, rgba(0, 0, 0, .2) 100%), url('data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAA9QAAAAkCAMAAABfcIIyAAAAGXRF…x%2BeQqLpPJDae9P5%2FmrVz491%2FWekBlKy7PXVfn9rb9xXsMD2wdOcAAAAAElFTkSuQmCC') no-repeat 50% 50%, -o-linear-gradient(bottom, #666 0, #5e5e5e 50%, #707070 51%, #808080 100%);*/
            /*background: -moz-linear-gradient(top, rgba(0, 0, 0, .2) 0, rgba(0, 0, 0, 0) 5%, rgba(0, 0, 0, 0) 97%, rgba(0, 0, 0, .45) 100%), -moz-linear-gradient(left, rgba(0, 0, 0, .2) 0, rgba(0, 0, 0, 0) .2%, rgba(0, 0, 0, 0) 99.8%, rgba(0, 0, 0, .2) 100%), url('data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAA9QAAAAkCAMAAABfcIIyAAAAGXRF…x%2BeQqLpPJDae9P5%2FmrVz491%2FWekBlKy7PXVfn9rb9xXsMD2wdOcAAAAAElFTkSuQmCC') no-repeat 50% 50%, -moz-linear-gradient(bottom, #666 0, #5e5e5e 50%, #707070 51%, #808080 100%);*/
            /*background: -webkit-gradient(linear, 0 0, 0 100%, from(rgba(0, 0, 0, .2)), color-stop(0.05, rgba(0, 0, 0, 0)), color-stop(0.97, rgba(0, 0, 0, 0)), to(rgba(0, 0, 0, .45))), -webkit-gradient(linear, 0 0, 100% 0, from(rgba(0, 0, 0, .2)), color-stop(0.002, rgba(0, 0, 0, 0)), color-stop(0.998, rgba(0, 0, 0, 0)), to(rgba(0, 0, 0, .2))), url('data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAA9QAAAAkCAMAAABfcIIyAAAAGXRF…x%2BeQqLpPJDae9P5%2FmrVz491%2FWekBlKy7PXVfn9rb9xXsMD2wdOcAAAAAElFTkSuQmCC') no-repeat 50% 50%, -webkit-gradient(linear, 0 100%, 0 0, from(#666), color-stop(0.5, #5e5e5e), color-stop(0.51, #707070), to(#808080));*/

            /*-khtml-border-radius: 4px;*/
            /*-ms-border-radius: 4px;*/
            /*-o-border-radius: 4px;*/
            /*-moz-border-radius: 4px;*/
            /*-webkit-border-radius: 4px;*/
            /*border-radius: 4px;*/
        }

        #tool_bar table {
            padding: 0;
            margin: 0;
            border-spacing: 0;
        }

        #tool_bar table td {
            padding: 0;
            margin: 0;
            white-space: nowrap;
        }

        #tool_bar ul {
            font-size: 0;
            margin: 0;
            padding: 0;
            display: inline-block;

            /*border: 1px solid #ccc;*/
            /*-khtml-border-radius: 4px;*/
            /*-ms-border-radius: 4px;*/
            /*-o-border-radius: 4px;*/
            /*-moz-border-radius: 4px;*/
            /*-webkit-border-radius: 4px;*/
            /*border-radius: 4px;*/
        }

        #tool_bar li {
            font-size: 18px;
            list-style: none;
            display: inline-block;
            /*padding: 0 5px;*/
            width: 33px;
            height: 33px;
            line-height: 33px;
            text-align: center;
            cursor: pointer;
            border: 1px solid transparent;

        }

        #tool_bar li:hover {
            height: 33px;
            width: 33px;
            line-height: 33px;
            border-bottom: 1px solid #888;
            border-top: 1px solid #ccc;
            border-left: 1px solid #bbb;
            border-right: 1px solid #bbb;

            -khtml-border-radius: 3px;
            -ms-border-radius: 3px;
            -o-border-radius: 3px;
            -moz-border-radius: 3px;
            -webkit-border-radius: 3px;
            border-radius: 3px;

            background-image: -moz-linear-gradient(#eee, #ddd);
            background-image: -webkit-linear-gradient(#eee, #ddd);
            background-image: linear-gradient(#eee, #ddd);
            background-repeat: repeat-x;

            /*box-shadow:0px 1px 1px #000;*/
            /*-moz-box-shadow:0px 1px 1px #000;*/
            /*-webkit-box-shadow:0px 1px 1px #000;*/
        }

        input.title {
            width: 100%;
            border: 0;
            padding: 0 4px;
            height: 33px;
            outline: none;
            border: 1px solid #bbb;
            -moz-border-radius: 3px; /* Gecko browsers */
            -webkit-border-radius: 3px; /* Webkit browsers */
            border-radius: 3px; /* W3C syntax */
            font-size: 16px;
            font-weight: bold;
            box-sizing: border-box;
        }

        #content {
            position: absolute;
            background: #ddd;
            top: 46px;
            right: 0;
            left: 0;
            bottom: 0;
        }

        #content .directories {
            position: absolute;
            left: 0;
            top: 0;
            bottom: 0;
            width: 240px;
            background: #fefefe;
            border-right: 1px solid #aaa;
        }

        #content .designer {
            position: absolute;
            background: #ddd;
            top: 0;
            right: 0;
            left: 250px;
            bottom: 0;
        }

        /*#content.hid .directories {*/
            /*left: -10000;*/
        /*}*/

        #content.hid .designer {
            left: -1px;
        }

        #content .designer .editor {
            position: absolute;
            top: 0;
            right: 50%;
            margin-right: 4px;
            left: 0;
            bottom: 0;
            background: #fefefe;
            border-right: 1px solid #aaa;
            border-left: 1px solid #aaa;
            font-size: 16px;
        }

        #content .designer .viewer {
            position: absolute;
            top: 0;
            left: 50%;
            margin-left: 4px;
            right: 0;
            bottom: 0;
            background: #fefefe;
            border-left: 1px solid #aaa;

            overflow-y: auto;
            padding: 0 10px;
        }

        .trans {
            -webkit-transition: left 0.2s ease;  /* Android 2.1+, Chrome 1-25, iOS 3.2-6.1, Safari 3.2-6  */
            transition: left 0.2s ease;  /* Chrome 26, Firefox 16+, iOS 7+, IE 10+, Opera, Safari 6.1+  */
        }

    </style>
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
    <div class="directories"></div>
    <div class="designer trans">
        <div class="editor"></div>
        <div class="viewer preview"></div>
    </div>
</div>


<script src="<%= request.getContextPath() %>/js/ace/ace.js"
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
    editor.getSession().on('changeScrollTop', syncView);

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
