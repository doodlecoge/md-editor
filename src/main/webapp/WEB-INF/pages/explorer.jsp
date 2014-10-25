<%@ page import="java.util.regex.Pattern" %>
<%@ page import="java.util.regex.Matcher" %>
<%--
  Created by IntelliJ IDEA.
  User: huaichao
  Date: 10/12/14
  Time: 5:22 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
<head>
<title>File Explorer</title>
<link type="text/css" rel="stylesheet"
      href="<%=request.getContextPath()%>/css/font-awesome.css">
<%--<link type="text/css" rel="stylesheet"--%>
<%--href="<%=request.getContextPath()%>/css/explorer.css">--%>


<script type="text/javascript"
        src="<%=request.getContextPath()%>/js/files.js"></script>

<%
    Pattern ptn = Pattern.compile("^http://(localhost|127\\.0\\.0\\.1)");
    String url = request.getRequestURL().toString();
    Matcher m = ptn.matcher(url);
    if (m.find()) {
%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap-theme.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.11.1.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/bootstrap.js"></script>
<%
} else {
%>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<%
    }
%>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/jquery.plugins.css">
<script type="text/javascript"
        src="<%=request.getContextPath()%>/js/jquery.plugins.js"></script>


<style type="text/css">
#tool_bar {
    display: table;
    width: 100%;
    padding: 5px 2px;
    background-color: #eeeeee;
    background-image: -moz-linear-gradient(#f0f0f0, #ddd);
    background-image: -webkit-linear-gradient(#f0f0f0, #ddd);
    background-image: linear-gradient(#f0f0f0, #ddd);
    background-repeat: repeat-x;
    border-bottom: 1px solid #aaa;
    height: 45px;
    overflow: hidden;
}

#tool_bar .path {
    width: 100%;
    padding: 0 4px;
    height: 33px;
    line-height: 33px;
    outline: none;
    border: 1px solid #bbb;
    background: #f8f8f8;
    -moz-border-radius: 3px; /* Gecko browsers */
    -webkit-border-radius: 3px; /* Webkit browsers */
    border-radius: 3px; /* W3C syntax */
    font-size: 16px;
    box-sizing: border-box;
}

#tool_bar .btns {
    display: table-cell;
    width: 0;
    white-space: nowrap;
    padding: 0 0 0 10px;
}

#tool_bar a.btn {
    font-size: 14px;
    font-weight: bold;
    color: #fff;
    font-family: Helvetica, Arial, "微软雅黑", "宋体", Tahoma, Geneva, sans-serif;
    text-shadow: 0 1px 1px rgba(0, 0, 0, 0.35);
    text-decoration: none;
    outline: none;

    border: 1px solid #1b5480;
    -webkit-border-radius: 3px;
    -moz-border-radius: 3px;
    -ms-border-radius: 3px;
    -o-border-radius: 3px;
    border-radius: 3px;

    padding: 0 10px;
    line-height: 24px;

    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;

    background-color: #287bbc;
    filter: progid:DXImageTransform.Microsoft.gradient(gradientType=0, startColorstr='#FF287BBC', endColorstr='#FF23639A');
    background-image: -webkit-linear-gradient(top, #287bbc 0%, #23639a 100%);
    background-image: -moz-linear-gradient(top, #287bbc 0%, #23639a 100%);
    background-image: -o-linear-gradient(top, #287bbc 0%, #23639a 100%);
    background-image: linear-gradient(top, #287bbc 0%, #23639a 100%);
    white-space: nowrap;

    display: -moz-inline-stack;
    display: inline-block;
    zoom: 1;
    *display: inline;
}

#tool_bar a.btn:hover {
    background-color: #2672ae;
    filter: progid:DXImageTransform.Microsoft.gradient(gradientType=0, startColorstr='#FF2672AE', endColorstr='#FF1E4F7E');
    background-image: -webkit-linear-gradient(top, #2672ae 0%, #1e4f7e 100%);
    background-image: -moz-linear-gradient(top, #2672ae 0%, #1e4f7e 100%);
    background-image: -o-linear-gradient(top, #2672ae 0%, #1e4f7e 100%);
    background-image: linear-gradient(top, #2672ae 0%, #1e4f7e 100%);
    -webkit-box-shadow: 0 1px 3px rgba(0, 0, 0, 0.25);
    -moz-box-shadow: 0 1px 3px rgba(0, 0, 0, 0.25);
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.25)
}

#tool_bar a.btn:active {
    color: darkorange;
}

#tool_bar a.btn:focus {
    color: darkorange;
}

table.list {
    width: 100%;
}

table.list td {
    width: 24px;
    /*padding: 0 5px;*/
    text-align: center;
    height: 30px;
}

table.list tr {
    border-bottom: 1px solid #cccccc;
}

table.list tr.even {
    background: #efefef;
}

table.list tr:hover {
}

table.list td.c2 {
    width: auto;
    text-align: left;
}

input.text {
    border: 0;
    border-bottom: 1px dashed #cccccc;
    padding: 0;
    width: 100%;
    background: transparent;
    outline: none;
}

table.list i.del {
    color: #f00;
}

table.list i.ok {
    color: green;
}

table.list i.cancel {
    color: orange;
}

table.list i._btn {
    cursor: pointer;
}

#tool_bar table {
    width: 100%;
    padding: 0;
    margin: 0;
}

#tool_bar table td {
    white-space: nowrap;
    padding: 0 2px;
}

#file_name {
    width: 50px;
    border: 1px solid #bbb;
    height: 33px;
    background: #f8f8f8;
    -moz-border-radius: 3px; /* Gecko browsers */
    -webkit-border-radius: 3px; /* Webkit browsers */
    border-radius: 3px; /* W3C syntax */
    font-size: 16px;
    box-sizing: border-box;
    line-height: 25px;
    padding: 0 5px;
    outline: none;
    -webkit-transition: width 0.5s ease;
    transition: width 0.5s ease;
}

#file_name:focus {
    width: 200px;
}

#work_area {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: #ddd;
    display: none;
}

#work_area .btns {
    position: absolute;
    top: 0;
    left: 0;
    right: 50%;
    margin-right: 4px;
    background: #ccc;
    border-right: 1px solid #bbb;
    border-bottom: 1px solid #bbb;
    height: 45px;
    line-height: 45px;
    background: #ddd;
    padding-bottom: 5px;

    background-color: #eeeeee;
    background-image: -moz-linear-gradient(#f0f0f0, #ddd);
    background-image: -webkit-linear-gradient(#f0f0f0, #ddd);
    background-image: linear-gradient(#f0f0f0, #ddd);
    background-repeat: repeat-x;
}

#work_area .editor {
    position: absolute;
    top: 45px;
    right: 50%;
    bottom: 0;
    left: 0px;
    margin-right: 4px;
    background: #fff;
    border-right: 1px solid #bbb;
}

#work_area .viewer {
    position: absolute;
    top: 0;
    right: 0px;
    bottom: 0;
    left: 50%;
    margin-left: 3px;
    background: #fff;
    border-left: 1px solid #bbb;
}
</style>
</head>
<body>

<div id="tool_bar">
    <table style="width: 100%;">
        <tr>
            <td>
                <div class="path"></div>
            </td>
            <td style="width: 1%;">
                <input type="text" id="file_name">
            </td>
            <td style="width: 1%;">
                <div class="dropdown">
                    <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1"
                            data-toggle="dropdown">
                        Add
                        <span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu dropdown-menu-right" role="menu" aria-labelledby="dropdownMenu1">
                        <li role="presentation">
                            <a role="menuitem" tabindex="-1" href="javascript:;" id="btn_add_file">
                                <i class="fa fa-file-text-o"></i> Add File
                            </a>
                        </li>
                        <li role="presentation">
                            <a role="menuitem" tabindex="-1" href="javascript:;" id="btn_add_folder">
                                <i class="fa fa-folder-o"></i> Add Folder
                            </a>
                        </li>
                    </ul>
                </div>
            </td>
        </tr>
    </table>
</div>

<div id="content">
</div>
<div id="work_area">
    <div class="btns">&nbsp;
        <div class="btn-group">
            <button type="button" class="btn btn-default">
                <i class="fa fa-save"></i>
            </button>
            <button type="button" class="btn btn-default">
                <i class="fa fa-reply"></i>
            </button>
        </div>
    </div>
    <div class="editor"></div>
    <div class="viewer"></div>
</div>

<script type="text/javascript">
    var fop = new crud();
    dirid = 0;

    $(function () {
        $("#btn_add_file").click(function () {
            var txt = $('#file_name').val().trim();
            if (txt == '') return;

            $.obj.dialog.show('adding file...', 200);
            fop.createFile('F', txt, dirid, function () {
                $.obj.dialog.close();
                retrieveFile(dirid);
            });
        });
        $("#btn_add_folder").click(function () {
            var txt = $('#file_name').val().trim();
            if (txt == '') return;

            $.obj.dialog.show('adding folder...', 200);
            fop.createFile('D', txt, dirid, function () {
                $.obj.dialog.close();
                retrieveFile(dirid);
            });
        });
        // list sub files
        retrieveFile(0);

        // handle click on file item event
        $("#content").click(function (e) {
            var el = $(e.target);
            var tr = el.closest('tr');
            if (tr.length == 0) return;
            var fid = tr.data('fid');

            // click the file name then show sub files or show file content
            if (el.get(0).nodeName.toLowerCase() == 'span') {
                retrieveFile(fid);
            }

            // delete file
            else if (el.hasClass('del')) {
                $.obj.confirm.show('Waning!', 'Delte this file?', function (e) {
                    $.obj.dialog.loading({
                        "type": "DELETE",
                        "url": "<%=request.getContextPath()%>/file/" + fid,
                        "dataType": "json"
                    }, 'loading...', function (data) {
                        if (data.error == false)
                            $.obj.dialog.close();
                        retrieveFile(dirid);
                    });
                });
            }

            // edit file name
            else if (el.hasClass('edit')) {
                var ipt = $(document.body).find('#edit_file_name_ipt_box');
                if (ipt.length == 0) {
                    ipt = $('<input type="text" class="text" id="edit_file_name_ipt_box">')
                            .hide().appendTo(document.body);
                }

                // cancel current editing
                var td = ipt.parent();
                if (td.get(0).nodeName.toLowerCase() == 'td') {
                    td.find('span').show();
                    td.parent().find('i.ok').removeClass('ok').addClass('edit')
                            .removeClass('fa-check').addClass('fa-edit');
                    td.parent().find('i.cancel').removeClass('cancel').addClass('del');
                }

                if (tr.find('.ipt').length > 0) return;
                var a = tr.find('span').hide();
                var name = a.html();

                var td = tr.children().get(1);
                ipt.show().val(name).appendTo(td).focus().select();
                $(td).find('span').hide();
                tr.find('.del').removeClass('del').addClass('cancel');
                tr.find('.edit').removeClass('edit').addClass('ok')
                        .removeClass('fa-edit').addClass('fa-check');
            }

            // cancel editing
            else if (el.hasClass('cancel')) {
                console.log('canceling');
                tr.find('span').show();
                tr.find('i.ok').removeClass('ok').addClass('edit')
                        .removeClass('fa-check').addClass('fa-edit');
                tr.find('i.cancel').removeClass('cancel').addClass('del');
                tr.find('input').hide();
            }

        });
    });

    // get sub files or file content
    // todo: add pagination for sub files
    function retrieveFile(fid) {
        fop.retriveFile(fid, function (data) {
            if (typeof data['content'] != "undefined") {
                $("#work_area").show(200);
//                $("#content").html(data['content'] || '');
            } else if (data['files']) {
                dirid = fid;
                displaySubFiles(data['files']);
            } else {
                // todo: error handling
            }
        });
    }

    // -----------------------------------------------------
    // - callbacks
    // -----------------------------------------------------

    // show sub files
    function displaySubFiles(files) {
        var p = $("#content");
        p.find('table').remove();
        var tbl = $('<table class="list">').appendTo(p);
        $.each(files, function (i, file) {
            var cls = file.type == 'D' ? 'fa-folder-o' : 'fa-file-text-o';
            var even = i % 2 == 1 ? ' class="even"' : '';
            var str = '' +
                    '<tr' + even + '>' +
                    '   <td class="c1"><i class="fa ' + cls + '"></i></td>' +
                    '   <td class="c2"><span>' + file.name + '</span></td>' +
                    '   <td class="c3"><i class="_btn fa fa-edit edit"></i></td>' +
                    '   <td class="c4"><i class="_btn fa fa-times del"></i></td>' +
                    '</tr>';
            $(str).data('fid', file.id).appendTo(tbl);
        });
    }


</script>


<script type="text/javascript"
        src="<%= request.getContextPath() %>/js/marked.js"></script>
<script src="<%= request.getContextPath() %>/js/ace/ace.js"
        type="text/javascript" charset="utf-8"></script>

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

    var editor = ace.edit($(".editor").get(0));
    editor.setTheme("ace/theme/chrome");
    editor.setPrintMarginColumn(80);
    editor.session.setMode("ace/mode/text");
    var doc = editor.getSession().doc;
    doc.on('change', function (e) {
        var txt = editor.getValue();
        var html = marked(txt);
        $(".viewer").html(html);
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
</script>
</body>
</html>
