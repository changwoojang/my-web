// Filename : vent.js
define(['backbone.wreqr'], function(Wreqr) {

    "use strict";

    console.log("[vent] init...");

    return new Wreqr.EventAggregator();
});
