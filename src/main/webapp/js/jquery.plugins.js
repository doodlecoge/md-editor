/**
 * Created by hch on 2014/7/31.
 */


(function ($) {
    $.fn.dialog = function () {
        var html = '' +
            '<div id="dialog">' +
            '   <div class="title"></div>' +
            '   <div class="content"></div>' +
            '</div>';
    }

    $.fn.loading = function (msg) {
        msg = msg || 'loading...';
        var loading = $("#loading");
        if (loading.length == 0) {
            loading = $('<div id="loading">' +
                '<i class="fa fa-spinner fa-spin"></i>' +
                '&nbsp;' + msg + '</div>');
            $(document.body).append(loading);
        }
        var h = loading.height();
        loading.css('margin-top', (-h / 2) + 'px');
        $.fn.cover();
    }

    $.fn.cover = function () {
        var cover = $("#cover");
        if (cover.length == 0) {
            var cover = $('<div id="cover"></div>');
            $(document.body).append(cover);
        }
    }
})(jQuery);