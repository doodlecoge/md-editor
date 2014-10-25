/**
 * Created by hch on 2014/7/31.
 */
(function ($) {
    $.obj = $.obj || {};

    function _H(name, prototype) {
        if ($.obj.name) return;
        var constructor = function () {

        }
        constructor.prototype = prototype || {};
        return $.obj[name] = new constructor();
    }

    _H('dialog', {
        showDelay: null,
        closeDelay: null,
        _init: function () {
            if (this.overlay) return;
            this.overlay = $('<div class="overlay">').appendTo(document.body).hide();
            this.dlg = $('<div id="dialog">').appendTo(document.body).hide();
        },
        loading: function (ajax, msg, cb) {
            this._init();
            this.overlay.show();
            this.dlg.show().html(msg);

            this.dlg.css('margin-left', (-this.dlg.width() / 2) + 'px');
            this.dlg.css('margin-top', (-this.dlg.height() / 2) + 'px');

            var xhr = $.ajax(ajax);
            xhr.done(cb).fail(cb);
        },
        show: function (msg, delay) {
            this._init();
            var _this = this;
            this.showDelay = setTimeout(function () {
                _this.overlay.show();
                _this.dlg.show();
                _this.dlg.html(msg);
            }, delay);
        },
        close: function () {
            if (this.showDelay) {
                clearTimeout(this.showDelay);
                this.showDelay = null;
            }
            this.overlay.hide();
            this.dlg.hide();
        }
    });


    _H('confirm', {
        show: function (title, msg, cb_ok) {
            var _this = this;
            this._init();
            this.dlg.show();
            this.overlay.show();

            this.dlg.find('.title').html(title);
            this.dlg.find('.content').html(msg);
            this.dlg.find('.ok').unbind().click(function () {
                cb_ok();
                _this._close();
            });

            this.dlg.css('margin-left', (-this.dlg.width() / 2) + 'px');
            this.dlg.css('top', '0');
            var top = ($(window).height() - this.dlg.height());
            if (top > 0) this.dlg.animate({'top': (top / 4) + 'px'});
            else this.dlg.css('top', (top / 2) + 'px');
        },
        _close: function () {
            this.dlg.animate({'top': '0'}).hide();
            this.overlay.hide();
        },
        _init: function () {
            if (this.dlg) return;
            this.dlg = $(document.body).find('#confirm_dialog');
            if (this.dlg.length == 0) {
                var str = '' +
                    '<div id="confirm_dialog">' +
                    '   <div class="title"></div>' +
                    '   <div class="content"></div>' +
                    '   <div class="buttons">' +
                    '       <button class="ok">OK</button>' +
                    '       <button class="cancel">Cancel</button>' +
                    '   </div>' +
                    '</div>';
                var dlg = this.dlg = $(str).appendTo(document.body).hide();
                var overlay = this.overlay = $('<div class="overlay">')
                    .hide().appendTo(document.body);

                this.dlg.find('.cancel').click(function () {
                    dlg.slideUp(200);
                    overlay.fadeOut(200);
                });
            }
        }
    });
})(jQuery);