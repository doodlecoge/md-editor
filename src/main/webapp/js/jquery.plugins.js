/**
 * Created by hch on 2014/7/31.
 */


(function ($) {
    var dialog = $.widget('hch.dialog', {
        _create: function () {
            if(this.wrapper) return;
            this.wrapper = $('<div>').addClass("hch-dialog").hide();
            $(document.body).append(this.wrapper);
            this.element.show().appendTo(this.wrapper);
        },
        _init: function () {
            this.open();
        },
        open: function () {
            this._createOverlay();
            this.wrapper.show();
            this.wrapper.position({
                my: "center",
                at: "center",
                of: window
            });
        },
        _createOverlay: function () {
            if (this.overlay) return;
            this.overlay = $('<div>').addClass('hch-overlay').appendTo(document.body);
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