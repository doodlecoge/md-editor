/**
 * Created by hch on 2014/7/31.
 */


(function ($) {
    var dialog = $.widget('hch.loading', {
        _create: function () {
            if (this.wrapper) return;
            this.wrapper = $('<div>').addClass('hch-dialog').hide()
                .appendTo(document.body);

            this.title = this.element.attr('title') || '';

            $('<div>').addClass('hch-dialog-titlebar')
                .html(this.title).appendTo(this.wrapper);

            this.element.show().appendTo(this.wrapper);

            var btns = $('<div>').addClass('hch-dialog-buttonpane')
                .appendTo(this.wrapper);
            $('<button>').html('OK').appendTo(btns);
            $('<button>').html('Cancel').appendTo(btns);
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