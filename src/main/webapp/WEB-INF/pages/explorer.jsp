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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
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

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/jquery.plugins.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/preview.css">
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

    #tool_bar .path span {
        cursor: pointer;
        background: #ddd;
        -moz-border-radius: 3px; /* Gecko browsers */
        -webkit-border-radius: 3px; /* Webkit browsers */
        border-radius: 3px; /* W3C syntax */
        font-size: 16px;
        margin-right: 5px;
        padding: 2px 5px;
    }

    #tool_bar .path span:hover {
        background: #ccc;
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
        padding: 5px;
        overflow-y: auto;
    }

    .btn {
        height: 30px;
        line-height: 30px;
        padding: 0 10px;
    }


</style>
</head>
<body>

<div id="tool_bar">
    <table style="width: 100%;">
        <tr>
            <td>
                <div class="path" id="path"></div>
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
            <button type="button" class="btn btn-default" id="ok_save_file">
                <i class="fa fa-save"></i>
            </button>
            <button type="button" class="btn btn-default" id="cancel_edit_file">
                <i class="fa fa-reply"></i>
            </button>
        </div>

        <div class="btn-group" id="set_editor_font_size">
            <button type="button" class="btn btn-default btn-danger" size="12">
                <span style="font-size: 12px">A</span>
            </button>
            <button type="button" class="btn btn-default" size="16">
                <span style="font-size: 16px">A</span>
            </button>
            <button type="button" class="btn btn-default" size="20">
                <span style="font-size: 20px">A</span>
            </button>
        </div>
    </div>
    <div class="editor"></div>
    <div class="viewer"></div>
</div>

<script type="text/javascript">
    var fop = new crud();
    dirid = 0;
    fileid = 0;

    $(function () {
        // add new file
        $("#btn_add_file").click(function () {
            var txt = $('#file_name').val().trim();
            if (txt == '') return;

            $.obj.dialog.show('adding file...', 200);
            fop.createFile('F', txt, dirid, function () {
                $.obj.dialog.close();
                retrieveFile(dirid);
            });
        });

        // add new folder
        $("#btn_add_folder").click(function () {
            var txt = $('#file_name').val().trim();
            if (txt == '') return;

            $.obj.dialog.show('adding folder...', 200);
            fop.createFile('D', txt, dirid, function () {
                $.obj.dialog.close();
                retrieveFile(dirid);
            });
        });

        // save file content
        $("#ok_save_file").click(function () {
            var c = editor.getValue();
            fop.saveFileContent(fileid, c, function (data) {
            });
            $("#work_area").hide(200);
        });

        // cancel edit file content
        $("#cancel_edit_file").click(function () {
            $("#work_area").hide(200);
        });

        // change folder
        $("#path").click(function (e) {
            var el = $(e.target);
            var fid = el.data('fid');
            if (typeof fid != 'undefined') {
                retrieveFile(fid);
            }
        });

        // set font size
        $("#set_editor_font_size").click(function (e) {
            var el = $(e.target);

            var size = el.attr('size');
            if (!size) {
                el = el.parent();
                size = el.attr('size');
            }
            if (typeof size != 'undefined') {
                editor.setFontSize(parseInt(size));

                $(this).find('button').removeClass('btn-danger');
                el.addClass('btn-danger');
            }
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

            // start to edit file name
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
                tr.find('span').show();
                tr.find('i.ok').removeClass('ok').addClass('edit')
                        .removeClass('fa-check').addClass('fa-edit');
                tr.find('i.cancel').removeClass('cancel').addClass('del');
                tr.find('input').hide();
            }
            // accept editing
            else if (el.hasClass('ok')) {
                var name = $("#edit_file_name_ipt_box").val().trim();
                if (name == '') return;

                fop.renameFile(fid, name, function (data) {
                    if (!data.error) {
                        retrieveFile(dirid);
                    }
                });
            }

        });
    });

    // get sub files or file content
    // todo: add pagination for sub files
    function retrieveFile(fid) {
        fop.retriveFile(fid, function (data) {
            if (typeof data['content'] != "undefined") {
                $("#work_area").show();
                editor.setValue(data['content'] || '');
                editor.resize();
                fileid = fid;
            } else if (data['files']) {
                dirid = fid;
                displaySubFiles(data);
            } else {
                // todo: error handling
            }
        });
    }

    // -----------------------------------------------------
    // - callbacks
    // -----------------------------------------------------

    // show sub files
    function displaySubFiles(data) {
        var paths = data['paths'];
        $('<span>').data('fid', '0').html('/').appendTo($("#path").html(''));
        $.each(paths, function (i, path) {
            $('<span>').data('fid', path.id).html(path.name).appendTo($("#path"));
        });
        var files = data['files'];
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
    editor.setTheme("ace/theme/eclipse");
    editor.setPrintMarginColumn(80);
    editor.session.setMode("ace/mode/markdown");
    var doc = editor.getSession().doc;
    doc.on('change', function (e) {
        var txt = editor.getValue();
        var html = marked(txt);
        $(".viewer").html(html);
    });
    editor.session.on('changeScrollTop', syncPreview);

    function syncPreview() {
        var v = $(".viewer");
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
