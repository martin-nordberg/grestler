
// Makes jQuery a privately loaded RequireJS module.

define(['jquery'], function (jq) {
    return jq.noConflict( true );
});