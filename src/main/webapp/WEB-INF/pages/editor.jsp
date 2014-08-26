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
          href="<%=request.getContextPath()%>/css/editor2.css"/>
</head>
<body>

<div id="tool_bar">
    <table style="width: 100%">
        <tr>
            <td style="width: 0;">
                <ul>
                    <li class="fa fa-chevron-left toggle-tool-win"></li>
                    <li class="sep"></li>
                    <li class="dis fa fa-arrow-left dis"></li>
                    <li class="dis fa fa-arrow-right"></li>
                </ul>
            </td>
            <td style="width: 100%; padding: 0 5px;">
                <input type="text" class="title">
            </td>
            <td style="width: 0;">
                <ul>
                    <li class="fa fa-rotate-90 fa-bars layout_horizontal"></li>
                    <li class="fa fa-bars layout_vertical"></li>
                </ul>
            </td>
        </tr>
    </table>
</div>

<div id="content">
    <div class="tool-win">
        <div class="sub-files"></div>
    </div>
    <div class="designer vertical trans">
        <div class="editor trans"></div>
        <div class="preview trans"></div>
    </div>
</div>


<script src="<%= request.getContextPath() %>/js/ace/ace.js"
        type="text/javascript" charset="utf-8"></script>
<script src="<%= request.getContextPath() %>/jstree/jstree.js"
        type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
if (!console) {
    console = {};
    console.log = new Function();
}

var currid = null;
var fstack = [];
var bstack = [];

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
    $(".preview").html(html);
});
editor.session.on('changeScrollTop', syncPreview);

function syncPreview() {
    var v = $(".preview");
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
    $("li.fa-save").click(save_content);
    $("li.layout_vertical").click(layout_vertical);
    $("li.layout_horizontal").click(layout_horizontal);
    $(".sub-files").click(onClickFile);
    $("li.fa-arrow-left").click(backward);
    $("li.fa-arrow-right").click(forward);

    var tool_win = $.cookie(_consts.k_tws);
    toggle_tool_window(null, tool_win);
    if (_consts.b_ls) {
        editor.setValue(localStorage.getItem('txt'));
        editor.clearSelection();
    }

    load_sub_files(0);
});

function backward(e) {
    var el = $(e.target);
    if (el.hasClass('dis')) return;
    var id = bstack.pop();
    fstack.push(currid);
    load_sub_files(id);
}

function forward(e) {
    var el = $(e.target);
    if (el.hasClass('dis')) return;
    var id = fstack.pop();
    bstack.push(currid);
    load_sub_files(id);
}

function onClickFile(e) {

    fstack = [];
    var e = $(e.target);
    var li = e.closest('li');
    var fid = li.attr('fid');
    if (li.attr('t') == 'D') {
        bstack.push(currid);
        load_sub_files(fid);
    }
    else load_file_content(fid);
}

function load_file_content(fid) {
    var xhr = $.ajax({
        "url": "<%=request.getContextPath()%>/content/" + fid,
        "dataType": "json"
    });

    xhr.done(function (data) {
        if (data.status_code === 200) {
            editor.setValue(data.response_text);
            editor.clearSelection();
        }
    });

    xhr.fail(function (data) {
        console.log(data);
    });
}

function save_content() {
    var sel = $(".tree").jstree(true).get_selected();
    if (sel.length !== 1) {
        alert("multiple selected nodes not allowed while saving");
        return;
    }

    sel = sel[0];
    var cont = editor.getValue();

    var xhr = $.ajax({
        "type": "POST",
        "url": "<%=request.getContextPath()%>/content/" + sel,
        "data": {
            "content": cont
        },
        "dataType": "json"
    });

    xhr.done(function (data) {
        console.log(data);
    });

    xhr.fail(function (data) {
        console.log(data);
    });
}

function toggle_tool_window(e, state) {
    var b;
    if (e == null) b = state == 'close';
    else b = $(this).hasClass("fa-chevron-left");

    var _this = $("li.toggle-tool-win");

    if (b) { // close tool window
        _this.removeClass("fa-chevron-left");
        _this.addClass("fa-chevron-right");
        $("#content").addClass("t0");
        $.cookie(_consts.k_tws, 'close');
    } else {
        _this.removeClass("fa-chevron-right");
        _this.addClass("fa-chevron-left");
        $("#content").removeClass("t0");
        $.cookie(_consts.k_tws, 'open');
    }
    resize_editor();
}

function resize_editor() {
    // this time should be a little greater than
    // the transition time set in css.
    setTimeout(function () {
        editor.resize();
    }, 300);
}

function toggle_editor(e) {
    var d = $("#content");
    var b = d.hasClass('e');
    if (b) hide_editor();
    else hide_preview();
}

function hide_editor() {
    $("#content").removeClass("v");
    $("#content").removeClass("h");

    $("#content").removeClass("e");
    $("#content").addClass("p");

    resize_editor();
}

function hide_preview() {
    $("#content").removeClass("v");
    $("#content").removeClass("h");

    $("#content").removeClass("p");
    $("#content").addClass("e");

    resize_editor();
}

function layout_vertical(e) {
    $("#content").removeClass("e");
    $("#content").removeClass("p");

    $("#content").removeClass("h");
    $("#content").addClass("v");

    resize_editor();
}

function layout_horizontal(e) {
    $("#content").removeClass("e");
    $("#content").removeClass("p");

    $("#content").addClass("h");
    $("#content").removeClass("v");

    resize_editor();
}

function load_sub_files(id) {
    if (fstack.length == 0)
        $("li.fa-arrow-right").addClass('dis');
    else
        $("li.fa-arrow-right").removeClass('dis');

    if (bstack.length == 0)
        $("li.fa-arrow-left").addClass('dis');
    else
        $("li.fa-arrow-left").removeClass('dis');

    currid = id;

    var xhr = $.ajax({
        "url": "<%= request.getContextPath() %>/file/" + id,
        "dataType": "text"
    });

    xhr.done(function (data) {
        var c = $(".sub-files").html('').append('<ul></ul>');
        var lst = c.find('ul');
        var data = eval("(" + data + ")");
        $.each(data, function (i, file) {
            var d = file.type === "D";
            var cls = 'fa-folder-o';
            if (!d) cls = 'fa-file-text-o';
            var item = $('<li></li>');
            item.attr('fid', file.id);
            item.attr('t', file.type);
            item.append('<i class="fa ' + cls + '"></i>');
            item.append('<span>' + file.name + '</span>');
            lst.append(item);
        });
    });

    xhr.fail(function (data) {
        console.log(data);
    });
}

function show_mask() {
    $('').loading();
    $(document.body).dialog();

//    console.log("abc");
//    var cover = $("#cover");
//    cover.removeClass('hide');
//
//    $(".tree").dialog();
}

</script>


</body>
</html>
