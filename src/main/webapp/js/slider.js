/*
 * Copyright (c) 2017. [j]karef GmbH
 */

/**
 * @author Rene Jablonski <rene.jablonski@jkaref.com>
 * @date 12.01.17
 */

var Slider = (function () {
    "use strict";

    var BASE_SRC = '/RCSSlider-portlet/js';
    var JQUERY_SRC = BASE_SRC + '/jquery-1.7.1.min.js';
    var JQUERY_CAROUFREDSEL_SRC = BASE_SRC + '/jquery.carouFredSel-6.2.1-packed.js';
    var JQUERY_SWIPE_SRC = BASE_SRC + '/jquery.touchSwipe.min.js';

    var loadScripts = function() {
        loadScript(JQUERY_SRC);
        loadScript(JQUERY_CAROUFREDSEL_SRC);
        loadScript(JQUERY_SWIPE_SRC);
    };

    var loadScript = function(src) {
        var el = document.createElement('script');
        el.async = false;
        el.src = src;
        el.type = 'text/javascript';

        (document.getElementsByTagName('HEAD')[0]||document.body).appendChild(el);
    };

    return {
        loadScripts: loadScripts
    };
});

if(typeof $ === "undefined") {
    Slider().loadScripts();
}
