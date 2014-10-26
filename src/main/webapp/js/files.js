/**
 * Created by huaichao on 10/12/14.
 */


var crud = function () {
};

crud.prototype = {
    noop: new Function(),
    set: function (key, val) {
        this[key] = val;
    },
    _call: function (args, callback) {
        if (typeof callback != "function") callback = this.noop;
        var xhr = $.ajax(args);
        xhr.done(callback).fail(callback);
    },
    createFile: function (type, name, pid, callback) {
        this._call({
            "type": "POST",
            "url": (this.baseUrl || "") + "/file",
            "data": { "pid": pid, "type": type, "name": name },
            "dataType": "json"
        }, callback);
    },
    deleteFile: function (fid, callback) {
        this._call({
            "type": "DELETE",
            "url": (this.baseURI || "") + "/file/" + fid,
            "dataType": "json"
        }, callback);
    },
    renameFile: function (fid, newName, callback) {
        this._call({
            "type": "POST",
            "url": (this.baseURI || "") + "/file/" + fid,
            "data": { "name": newName },
            "dataType": "json"
        }, callback);
    },
    retriveFile: function (fid, callback) {
        this._call({
            "url": (this.baseURI || "") + "/file/" + fid,
            "dataType": "json"
        }, callback);
    },
    getFileContent: function (fid, callback) {
        this._call({
            "url": (this.baseURI || "") + "/content/" + fid,
            "dataType": "json"
        }, callback);
    },
    saveFileContent: function (fid, content, callback) {
        this._call({
            "type": "POST",
            "url": (this.baseURI || "") + "/content/" + fid,
            "data": { "content": content },
            "dataType": "json"
        }, callback);
    }
};