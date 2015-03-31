//
// (C) Copyright 2015 Martin E. Nordberg III
// Apache 2.0 License
//

/**
 * Module: org/grestler/presentation/adminclient/main/console
 */

require(
    [
        'scripts/js/org/grestler/presentation/adminclient/navigation/schemapagenavview',
        'scripts/js-gen/org/grestler/presentation/adminclient/main/topnavviewmodel',
        'scripts/js-gen/org/grestler/presentation/adminclient/main/topnavcontroller',
        'ractive',
        'jquery',
        'text!templates/org/grestler/presentation/adminclient/main/console.html.mustache',
        'css!styles/css-gen/org/grestler/presentation/adminclient/main/console.css'
    ],
    function ( schemapagenavview, topnavviewmodel, topnavcontroller, Ractive, $, consoleTemplate ) {

        // Load the viewmodel (page visibilities).
        var pageVisibilities = topnavviewmodel.loadPageVisibilities();

        // Define the view.
        var view = new Ractive(
            {
                components: {
                    "schema-page" : schemapagenavview.SchemaPageView
                },
                data: pageVisibilities,
                el: 'console-id',
                magic: true,
                template: consoleTemplate
            }
        );

        // Define the behavior (event handlers).
        var controller = new topnavcontroller.TopNavController( pageVisibilities.pageSelection );

        view.on(
            'queriesClicked', function ( event ) {
                controller.onQueriesClicked( event );
                return false;
            }
        );
        view.on(
            'schemaClicked', function ( event ) {
                controller.onSchemaClicked( event );
                return false;
            }
        );
        view.on(
            'searchClicked', function ( event ) {
                controller.onSearchClicked( event );
                return false;
            }
        );
        view.on(
            'serverClicked', function ( event ) {
                controller.onServerClicked( event );
                return false;
            }
        );

    }
);


