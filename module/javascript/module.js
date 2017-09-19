/* global forge */

forge['launchimage'] = {
    'hide': (function () {
        var alreadyHidden = false;
        return function (success, error) {
            if (alreadyHidden) {
                return;
            } else {
                alreadyHidden = true;
                forge.internal.call("launchimage.hide", {}, success, error);
            }
        };
    })()
};

if (!forge.config.modules.launchimage.config || !forge.config.modules.launchimage.config['hide-manually']) {
    if (window.addEventListener) {
        window.addEventListener("load", function () { forge.launchimage.hide(); }, false);
    }
    setTimeout(function () {
        // In case for some reason the load event fails
        forge.launchimage.hide();
    }, 5000);
}
