/**
 * Created by hch on 2014/7/31.
 */


(function ($) {
    var alert = $.widget('hch.alert', {
        _create: function () {
            if (this.wrapper) return;
            this.alert = $('<div>').addClass('hch-alert').hide()
                .appendTo(document.body);
        },
        _init: function () {
            this.open();
        },
        open: function () {
            this._createOverlay();
            this.alert.show();
            this.alert.position({
                my: "center",
                at: "center",
                of: window
            });
        },
        alert: function (msg) {
            this.alert.html(msg);
        },
        _createOverlay: function () {
            if (this.overlay) return;
            this.overlay = $("<div>")
                .addClass("ui-widget-overlay ui-front")
                .appendTo(document.body);
        },
        _destroyOverlay: function () {
            this.overlay.hide();
        },
        close: function () {
            this.wrapper.hide();
            this._destroyOverlay();
        },
        _destroyOverlay: function () {
            this.overlay.hide();
        }
    });
})(jQuery);