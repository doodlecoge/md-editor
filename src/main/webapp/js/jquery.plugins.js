/**
 * Created by hch on 2014/7/31.
 */
$(function () {
    if (window)
        window.hch = function (name, prototype) {
            function foo() {
            }

            foo.prototype = prototype;
            var obj = hch[name] = new foo();
            return obj;
        };

    hch('alert', {
        _init: function () {
            var el = document.body;
            this.dialog = $('<div>').addClass('hch-alert')
                .hide().appendTo(el);

            // use shared overlay
            if ($(el).data('hch.overlay')) {
                this.overlay = $(el).data('hch.overlay');
            } else {
                this.overlay = $("<div>")
                    .addClass("ui-widget-overlay ui-front")
                    .hide().appendTo(el);
                $(el).data('hch.overlay', this.overlay);
            }
        },
        show: function (msg, modal, duration) {
            if (!this.dialog) this._init();
            if (modal) this.overlay.show();
            this.dialog.html(msg).show().position({
                my: "center top",
                at: "center top+10",
                of: window
            });
            // close after 'duration' milliseconds
            if (typeof duration === 'number') {
                setTimeout((function (_this) {
                    return function () {
                        _this.close();
                    }
                })(this), duration);
            }
            return this;
        },
        close: function (duration, delay) {
            if (!this.dialog) this._init();
            duration = duration || 0;
            if (typeof delay === 'number') {
                setTimeout((function (_this) {
                    return function () {
                        _this.overlay.hide(duration);
                        this.dialog.hide(duration).html('');
                    }
                })(this), delay);
            } else {
                this.overlay.hide(duration);
                this.dialog.hide(duration).html('');
            }
            return this;
        }
    })
    ;
});


//(function ($) {
//    var alert = $.widget('hch.alert', {
//        _create: function () {
//            if (this.alert) return;
//            this.alert = $('<div>').addClass('hch-alert').hide()
//                .appendTo(document.body);
//        },
//        _init: function () {
//            this.open();
//        },
//        open: function () {
//            this._createOverlay();
//            this.alert.show();
//            this.alert.position({
//                my: "center top",
//                at: "center top+10",
//                of: window
//            });
//        },
//        show: function (msg) {
//            this.alert.html(msg);
//        },
//        _createOverlay: function () {
//            if (this.overlay) return;
//            this.overlay = $("<div>")
//                .addClass("ui-widget-overlay ui-front")
//                .appendTo(document.body);
//        },
//        _destroyOverlay: function () {
//            this.overlay.hide();
//        },
//        close: function () {
//            this.alert.hide();
//            this._destroyOverlay();
//        },
//        _destroyOverlay: function () {
//            this.overlay.hide();
//        }
//    });
//})(jQuery);