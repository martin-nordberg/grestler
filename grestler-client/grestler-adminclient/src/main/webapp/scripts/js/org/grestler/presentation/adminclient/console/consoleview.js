//
// (C) Copyright 2015 Martin E. Nordberg III
// Apache 2.0 License
//

/**
 * Module: org/grestler/presentation/adminclient/main/consoleview
 *
 * Main view class for the whole Grestler Admin Console.
 */

require(
    [
        'scripts/js/org/grestler/presentation/adminclient/schemapage/schemapageview',
        'dependencies',
        'ractive',
        'jquery',
        'text!templates/org/grestler/presentation/adminclient/console/console.html.mustache',

        'css!styles/css-gen/org/grestler/presentation/adminclient/console/console.css'
    ],
    function ( schemapageview, dependencies, Ractive, $, consoleTemplate ) {

        // Load the viewmodel (page visibilities).
        var pageVisibilities = dependencies.context.get( 'topNavViewModelPageVisibilities' );

        // Define the view.
        var view = new Ractive(
            {
                components: {
                    "grestler-schema-page" : schemapageview.SchemaPageView
                },
                data: pageVisibilities,
                el: 'console-id',
                magic: true,
                template: consoleTemplate
            }
        );

        // Define the behavior (event handlers).
        var controller = dependencies.context.get( 'topNavController' );

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

        /** Wire the viewmodel to the model. */
        view.data.observeModelChanges();

    }
);

