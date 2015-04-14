//
// (C) Copyright 2015 Martin E. Nordberg III
// Apache 2.0 License
//

/**
 * Module: org/grestler/presentation/adminclient/schemapage/module
 */

import browsedelementmodel = require( './browsedelementmodel' );
import leftnavcontroller = require( './leftnavcontroller' );
import leftnavmodel = require( './leftnavmodel' );
import leftnavviewmodel = require( './leftnavviewmodel' );
import rightnavcontroller = require( './rightnavcontroller' );
import rightnavmodel = require( './rightnavmodel' );
import rightnavviewmodel = require( './rightnavviewmodel' );

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/** The one and only element currently being browsed. */
var theBrowsedElement : browsedelementmodel.ElementSelection = null;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/** The one and only schema page selection instance. */
var theLeftTabSelection : leftnavmodel.LeftTabSelection = null;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/** The singleton page visibilities viewmodel instance. */
var theLeftTabVisibilities : leftnavviewmodel.LeftTabVisibilities = null;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/** The one and only schema page selections instance. */
var theRightTabSelection : rightnavmodel.RightTabSelection = null;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/** The singleton page visibilities viewmodel instance. */
var theRightTabVisibilities : rightnavviewmodel.RightTabVisibilities = null;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

export var schemaPageModule = {

    /**
     * Provides a schema page left nav controller for given tab selection model.
     * @param schemaPageLeftTabSelection the tab selection model to control.
     * @returns {LeftNavController} the newly created controller.
     */
    provideSchemaPageLeftNavController: function provideSchemaPageLeftNavController( schemaPageLeftTabSelection : leftnavmodel.LeftTabSelection ) : leftnavcontroller.LeftNavController {

        return new leftnavcontroller.LeftNavController( schemaPageLeftTabSelection );

    },

    /**
     * Creates or returns the one and only schema page left tab selection model, loading it when first requested.
     * @returns {LeftTabSelection} the left tab selection.
     */
    provideSchemaPageLeftTabSelection: function provideSchemaPageLeftTabSelection() : leftnavmodel.LeftTabSelection {

        // Create the page selection first time through.
        if ( theLeftTabSelection == null ) {
            theLeftTabSelection = new leftnavmodel.LeftTabSelection();
        }

        return theLeftTabSelection;

    },

    /**
     * Provides the singleton page visibilities viewmodel.
     * @returns the viewmodel instance.
     */
    provideSchemaPageLeftTabVisibilities: function provideSchemaPageLeftTabVisibilities( schemaPageLeftTabSelection : leftnavmodel.LeftTabSelection ) : leftnavviewmodel.LeftTabVisibilities {

        // Create the singleton on the first time through.
        if ( theLeftTabVisibilities == null ) {
            theLeftTabVisibilities = new leftnavviewmodel.LeftTabVisibilities( schemaPageLeftTabSelection );
        }

        return theLeftTabVisibilities;

    },

    /**
     * Provides a schema page right nav controller for given tab selection model.
     * @param schemaPageRightTabSelection the tab selection model to control.
     * @returns {RightNavController} the newly created controller.
     */
    provideSchemaPageRightNavController: function provideSchemaPageRightNavController( schemaPageRightTabSelection : rightnavmodel.RightTabSelection ) : rightnavcontroller.RightNavController {

        return new rightnavcontroller.RightNavController( schemaPageRightTabSelection );

    },

    /**
     * Creates or returns the one and only schema page right tab selection model, loading it when first requested.
     * @returns {RightTabSelection} the right tab selection.
     */
    provideSchemaPageRightTabSelection: function provideSchemaPageRightTabSelection() : rightnavmodel.RightTabSelection {

        // Create the page selection first time through.
        if ( theRightTabSelection == null ) {
            theRightTabSelection = new rightnavmodel.RightTabSelection();
        }

        return theRightTabSelection;

    },

    /**
     * Loads the page visibilities viewmodel asynchronously.
     * @returns a promise for the viewmodel instance.
     */
    provideSchemaPageRightTabVisibilities: function provideSchemaPageRightTabVisibilities( schemaPageRightTabSelection : rightnavmodel.RightTabSelection ) : rightnavviewmodel.RightTabVisibilities {

        // Create the singleton on the first time through.
        if ( theRightTabVisibilities == null ) {
            theRightTabVisibilities = new rightnavviewmodel.RightTabVisibilities( schemaPageRightTabSelection );
        }

        return theRightTabVisibilities;

    }
};

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
