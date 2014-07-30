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
                    <li class="fa fa-angle-double-left toggle-tool-win">

                    </li>
                    <li>
                        <i class="fa fa-plus"></i>
                        <i class="fa fa-sort-down" style="font-size: 8px;"></i>
                    </li>
                    <li class="fa fa-edit"></li>
                    <li class="fa fa-save"></li>
                    <li class="fa fa-trash-o"></li>
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
        <%--<div class="root">All Notes</div>--%>
        <div class="tree">

        </div>
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
    $("li.fa-save").click(toggle_editor);
    $("li.layout_vertical").click(layout_vertical);
    $("li.layout_horizontal").click(layout_horizontal);

    var tool_win = $.cookie(_consts.k_tws);
    toggle_tool_window(null, tool_win);
    if (_consts.b_ls) editor.setValue(localStorage.getItem('txt'));

    loadFolders();
});

function toggle_tool_window(e, state) {
    var b;
    if (e == null) b = state == 'close';
    else b = $(this).hasClass("fa-angle-double-left");

    var _this = $("li.toggle-tool-win");

    if (b) { // close tool window
        _this.removeClass("fa-angle-double-left");
        _this.addClass("fa-angle-double-right");
        $("#content").addClass("t0");
        $.cookie(_consts.k_tws, 'close');
    } else {
        _this.removeClass("fa-angle-double-right");
        _this.addClass("fa-angle-double-left");
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


function loadFolders() {
    var tree = $.jstree.reference(".tree");
    if (!tree) tree = $(".tree").jstree({
        "core": {
            "check_callback": true,
            "data": function (obj, cb) {
                load_sub_files(obj.id, cb, this);
            }
        },
        'contextmenu': {
            'items': function (node) {
                var tmp = $.jstree.defaults.contextmenu.items();
                delete tmp.ccp;
                if (this.get_type(node) === "file") {
                    delete tmp.create;
                    return tmp;
                }

                delete tmp.create.action;
                tmp.create.label = "New";
                tmp.create.submenu = {
                    "create_folder": {
                        "separator_after": true,
                        "label": "Folder",
                        "action": function (data) {
                            var inst = $.jstree.reference(data.reference);
                            var obj = inst.get_node(data.reference);
                            var type = inst.get_type(obj);
                            inst.create_node(obj, {
                                type: "folder",
                                text: "New folder",
                                data: "D"
                            }, "last", function (new_node) {
                                setTimeout(function () {
                                    inst.edit(new_node);
                                }, 0);
                            });
                        }
                    },
                    "create_file": {
                        "label": "File",
                        "action": function (data) {
                            var inst = $.jstree.reference(data.reference);
                            var obj = inst.get_node(data.reference);
                            inst.create_node(obj, {
                                type: "file",
                                text: "New file",
                                data: "F"
                            }, "last", function (new_node) {
                                setTimeout(function () {
                                    inst.edit(new_node);
                                }, 0);
                            });
                        }
                    }
                };
                return tmp;
            }
        },
        'types': {
            'folder': { 'icon': 'fa fa-folder-o' },
            'file': { 'valid_children': [], 'icon': 'fa fa-file-text-o' }
        },
        "plugins": ['state', 'dnd', 'sort', 'types', 'contextmenu', 'unique']
    });

    $(".jstree").on('delete_node.jstree', function (e, data) {
        var xhr = $.ajax({
            "type": "DELETE",
            "url": "<%=request.getContextPath()%>/file/" + data.node.id,
            "dataType": "json"
        });

        xhr.done(function (data) {
            if (data.error) {
                reload_node();
            }
        });

        xhr.fail(function () {
            reload_node();
        });

        function reload_node() {
            var p = data.instance.get_node(data.node.parent);
            data.instance.refresh_node(p);
        }
    });

    $(".jstree").on('create_node.jstree', function (e, data) {
        console.log(data);
        var xhr = $.ajax({
            "type": "POST",
            "url": "<%=request.getContextPath()%>/file",
            "data": {
                "name": data.node.text,
                "pid": data.parent,
                "type": data.node.data
            },
            "dataType": "json"
        });

        xhr.done(function (data) {
            if (data.error) {
                reload_node();
            }
        });

        xhr.fail(function () {
            reload_node();
        });
    });

    $(".jstree").on('rename_node.jstree', function (e, data) {
        $.get('?operation=rename_node', { 'id': data.node.id, 'text': data.text })
                .done(function (d) {
                    data.instance.set_id(data.node, d.id);
                })
                .fail(function () {
                    data.instance.refresh();
                });
    });


    $(".tree").jstree(true);
    $(".tree").bind("select_node.jstree", function (e, sel) {
        var id = sel.node.id;

        var xhr = $.ajax({
            "url": "<%=request.getContextPath()%>/content/" + id,
            "dataType": "json"
        });

        xhr.done(function (data) {
            if (data.status_code === 200)
                editor.setValue(data.response_text);
        });

        xhr.fail(function (data) {
            console.log(data);
        });
    });
}

function load_sub_files(id, cb, el) {
    if (id === "#") id = 0;
    var xhr = $.ajax({
        "url": "<%= request.getContextPath() %>/file/" + id,
        "dataType": "text"
    });

    xhr.done(function (data) {
        var data = eval("(" + data + ")");
        var nodes = []
        $.each(data, function (i, file) {
            var d = file.type === "D";
            nodes.push({
                "id": file.id,
                "text": file.name,
                "children": d ? true : false,
                "opened": true,
                "icon": d ? "fa fa-folder-o" : "fa fa-file-text-o",
                "type": d ? "folder" : "file",
                "state": {
                    "opened": false
                }
            });
        });
        cb.call(el, nodes);
    });

    xhr.fail(function (data) {
        console.log(data);
    });
}


</script>
</body>
</html>
