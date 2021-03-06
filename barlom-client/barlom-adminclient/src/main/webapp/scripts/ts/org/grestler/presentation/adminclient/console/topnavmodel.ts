//
// (C) Copyright 2015 Martin E. Nordberg III
// Apache 2.0 License
//

/**
 * Module: org/grestler/presentation/adminclient/main/topnavmodel
 */

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Enumeration of top schemapage items.
 */
export enum ETopNavSelection {
    QUERIES,
    SCHEMA,
    SERVER
}

/**
 * Converts an ETopNavSelection enum to a string.
 * @param value the enum value to convert.
 * @returns {*} the enum name as a string.
 */
export function topNavSelectionToString( value : ETopNavSelection ) : string {
    if ( value != null ) {
        return ETopNavSelection[value];
    }
    return null;
}

/**
 * Converts a string to a top nav enum value.
 * @param value the string to convert.
 * @returns {*} the enum value or null if not matched.
 */
export function topNavSelectionFromString( value : string ) : ETopNavSelection {
    if ( value != null ) {
        switch ( value ) {
            case 'QUERIES' :
                return ETopNavSelection.QUERIES;
            case 'SCHEMA' :
                return ETopNavSelection.SCHEMA;
            case 'SERVER' :
                return ETopNavSelection.SERVER;
        }
    }
    return null;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * The selection model for the top nav of the console.
 */
export class PageSelection {

    /**
     * Constructs a new page selections object.
     */
    constructor() {
        this._topNavSelection = topNavSelectionFromString( window.localStorage[PageSelection.PREFIX + 'topNavSelection'] );
        if ( this._topNavSelection == null ) {
            this._topNavSelection = ETopNavSelection.SCHEMA;
        }
    }

    /**
     * @returns {ETopNavSelection} The top navigation page selection.
     */
    get topNavSelection() : ETopNavSelection {
        return this._topNavSelection;
    }

    /**
     * Sets the top navigation page selection.
     * @param value the new value.
     */
    set topNavSelection( value : ETopNavSelection ) {
        // Notify observers of the change (happens asynchronously).
        Object['getNotifier']( this ).notify(
            {
                type: 'change.topNavSelection',
                name: 'topNavSelection',
                oldValue: this._topNavSelection,
                newValue: value
            }
        );

        // Make the change.
        this._topNavSelection = value;

        // Save to local storage.
        window.localStorage[PageSelection.PREFIX + 'topNavSelection'] = topNavSelectionToString( value );
    }

    /** The currently selected top navigation item. */
    private _topNavSelection : ETopNavSelection;

    /** Prefix used for browser local storage. */
    private static PREFIX = 'org.grestler.presentation.adminclient.console.topnavmodel.PageSelection.';

}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
