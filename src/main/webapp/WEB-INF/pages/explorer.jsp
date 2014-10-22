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
    <link type="text/css" rel="stylesheet"
          href="<%=request.getContextPath()%>/css/explorer.css">

    <script type="text/javascript"
            src="<%=request.getContextPath()%>/js/jquery-1.11.1.js"></script>
    <script type="text/javascript"
            src="<%=request.getContextPath()%>/js/files.js"></script>


    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">

    <!-- Optional theme -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">

    <!-- Latest compiled and minified JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>

</head>
<body>

<div id="tool_bar">
    <table style="width: 100%">
        <tr>
            <td style="width: 100%; padding: 0 5px;">
                <div id="path" class="path"></div>
            </td>
            <td style="width: 0;">
                <div class="dropdown">
                    <a data-toggle="dropdown" class="btn" href="#">
                        <i class="fa fa-plus"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-right"
                        role="menu" aria-labelledby="dLabel"
                        style="margin-right: 9px; min-width: 100px;">
                        <li role="presentation">
                            <a role="menuitem" tabindex="-1" href="#">
                                <i class="fa fa-file-text-o"></i> New File
                            </a>
                        </li>
                        <li role="presentation">
                            <a role="menuitem" tabindex="-1" href="#">
                                <i class="fa fa-folder-o"></i> New Folder
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

<script type="text/javascript">
    var fop = new crud();

    $(function () {
        // list sub files
        retrieveFile(0);

        // handle click on file item event
        $("#content").click(function (e) {
            var el = $(e.target);
            var p = el.parent();
            if (!p.data('fid')) return;
            var fid = p.data('fid');

            // retrieve file
            if (el.get(0).nodeName.toLowerCase() == 'a') {
                retrieveFile(fid);
            }
            // delete file
            else if (el.hasClass('times')) {

            }
            // edit file name
            else if (el.hasClass('edit')) {
                var ipt = $(document.body).find('#edit_file_name_ipt_box');
                if (ipt.length == 0) {
                    ipt = $('<input type="text" id="edit_file_name_ipt_box">');
                    ipt.hide().appendTo(document.body);
                }
                if (p.find('.ipt').length > 0) return;
                var a = p.find('a');
                var name = a.html();
                a.hide();
                $('<input type="text" class="ipt">').val(name).appendTo(p);
            }
        });
    });

    // get sub files or file content
    // todo: add pagination for sub files
    function retrieveFile(fid) {
        fop.retriveFile(fid, function (data) {
            if (typeof data['content'] == "string") {
                $("#content").html(data['content']);
            } else if (data['files']) {
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
        p.find('ul').remove();
        var ul = $('<ul>').appendTo(p);
        $.each(files, function (i, file) {
            var cls = file.type == 'D' ? 'fa-folder-o' : 'fa-file-text-o';
            var li = $('<li>').data('fid', file.id);
            $('<i class="fa ' + cls + '">').appendTo(li);
            $('<a href="javascript:;">').html(file['name']).appendTo(li);
            $('<i class="fa fa-times times">').appendTo(li);
            $('<i class="fa fa-pencil-square-o edit">').appendTo(li);
            li.appendTo(ul);
        });
    }
</script>
</body>
</html>
