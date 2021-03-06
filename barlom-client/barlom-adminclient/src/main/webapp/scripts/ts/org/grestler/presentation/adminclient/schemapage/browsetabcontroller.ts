//
// (C) Copyright 2015 Martin E. Nordberg III
// Apache 2.0 License
//

/**
 * Module: org/grestler/presentation/adminclient/schemapage/creationcontrollers
 */

import api_commands = require( '../../../domain/metamodel/api/commands' );
import api_elements = require( '../../../domain/metamodel/api/elements' );
import api_queries = require( '../../../domain/metamodel/api/queries' );
import elementmodel = require( '../../metamodel/elementmodel' );
import uuids = require( '../../../infrastructure/utilities/uuids' );
import values = require( '../../../infrastructure/utilities/values' );

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Controller for creating packages.
 */
export class BrowseTabController {

    /**
     * Constructs a new schema page package creation controller.
     * @param elementSelection the browsed element holding the parent package for the new child package.
     * @param metamodelCommandFactory the factory for command creation.
     * @param metamodelRepository the repository for querying root elements when needed.
     */
    constructor(
        elementSelection : elementmodel.ElementSelection,
        metamodelCommandFactory : api_commands.IMetamodelCommandFactory,
        metamodelRepository : api_queries.IMetamodelRepository
    ) {
        this._elementSelection = elementSelection;
        this._metamodelCommandFactory = metamodelCommandFactory;
        this._metamodelRepository = metamodelRepository;
    }

    /**
     * Responds to clicking a link to add an element. The element type is determined from the link's class list.
     * @param event
     */
    public onAddClicked( event : any ) : void {

        if ( event.node.classList.contains( "DirectedEdgeType" ) ) {
            this._onAddDirectedEdgeTypeClicked( event );
        }
        else if ( event.node.classList.contains( "Package" ) ) {
            this._onAddPackageClicked( event );
        }
        else if ( event.node.classList.contains( "UndirectedEdgeType" ) ) {
            this._onAddUndirectedEdgeTypeClicked( event );
        }
        else if ( event.node.classList.contains( "VertexType" ) ) {
            this._onAddVertexTypeClicked( event );
        }
        else {
            console.log( "Unknown add link type" );
        }

    }

    /**
     * Responds to clicking an "Add a directed edge type" link.
     * @param event
     */
    private _onAddDirectedEdgeTypeClicked( event : any ) : void {

        // TODO: UUIDs from server
        var cmdId = uuids.makeUuid();
        var pkgId = uuids.makeUuid();
        var parentPkg = <api_elements.IPackage> this._elementSelection.elementSelection;
        var parentPkgId = parentPkg.id;
        var superTypeId = this._metamodelRepository.findRootDirectedEdgeType().id;
        var tailVertexTypeId = this._metamodelRepository.findRootVertexType().id;
        var headVertexTypeId = this._metamodelRepository.findRootVertexType().id;

        var etName = "Edge Type";
        for ( var counter = 1; counter < 1000; counter += 1 ) {
            if ( !parentPkg.findOptionalPackagedElementByName( etName ) ) {
                break;
            }
            etName = "Edge Type " + counter;
        }

        var etJson = {
            cmdId: cmdId,
            id: pkgId,
            parentPackageId: parentPkgId,
            name: etName,
            superTypeId: superTypeId,
            abstractness: "CONCRETE",
            cyclicity: "POTENTIALLY_CYCLIC",
            multiEdgedness: "MULTI_EDGES_NOT_ALLOWED",
            selfLooping: "SELF_LOOPS_NOT_ALLOWED",
            tailVertexTypeId: tailVertexTypeId,
            headVertexTypeId: headVertexTypeId,
            tailRoleName: null,
            headRoleName: null,
            minTailOutDegree: null,
            maxTailOutDegree: null,
            minHeadInDegree: null,
            maxHeadInDegree: null
        };

        var cmd = this._metamodelCommandFactory.makeCommand( "directededgetypecreation" );

        cmd.execute( etJson ).then(
            ( nothing : values.ENothing ) => {
                this._elementSelection.elementSelection = parentPkg.findOptionalDirectedEdgeTypeByName( etName );
            }
        );

    }

    /**
     * Responds to clicking an "Add a package" link.
     * @param event
     */
    private _onAddPackageClicked( event : any ) : void {

        // TODO: UUIDs from server
        var cmdId = uuids.makeUuid();
        var pkgId = uuids.makeUuid();
        var parentPkg = <api_elements.IPackage> this._elementSelection.elementSelection;
        var parentPkgId = parentPkg.id;

        var pkgName = "package";
        for ( var counter = 1; counter < 1000; counter += 1 ) {
            if ( !parentPkg.findOptionalPackagedElementByName( pkgName ) ) {
                break;
            }
            pkgName = "package" + counter;
        }

        var pkgJson = {
            cmdId: cmdId,
            id: pkgId,
            parentPackageId: parentPkgId,
            name: pkgName
        };

        var cmd = this._metamodelCommandFactory.makeCommand( "packagecreation" );

        cmd.execute( pkgJson ).then(
            ( nothing : values.ENothing ) => {
                this._elementSelection.elementSelection = parentPkg.findOptionalChildPackageByName( pkgName );
            }
        );

    }

    /**
     * Responds to clicking an "Add an undirected edge type" link.
     * @param event
     */
    private _onAddUndirectedEdgeTypeClicked( event : any ) : void {

        // TODO: UUIDs from server
        var cmdId = uuids.makeUuid();
        var pkgId = uuids.makeUuid();
        var parentPkg = <api_elements.IPackage> this._elementSelection.elementSelection;
        var parentPkgId = parentPkg.id;
        var superTypeId = this._metamodelRepository.findRootUndirectedEdgeType().id;
        var vertexTypeId = this._metamodelRepository.findRootVertexType().id;

        var etName = "Edge Type";
        for ( var counter = 1; counter < 1000; counter += 1 ) {
            if ( !parentPkg.findOptionalPackagedElementByName( etName ) ) {
                break;
            }
            etName = "Edge Type " + counter;
        }

        var etJson = {
            cmdId: cmdId,
            id: pkgId,
            parentPackageId: parentPkgId,
            name: etName,
            superTypeId: superTypeId,
            abstractness: "CONCRETE",
            cyclicity: "POTENTIALLY_CYCLIC",
            multiEdgedness: "MULTI_EDGES_NOT_ALLOWED",
            selfLooping: "SELF_LOOPS_NOT_ALLOWED",
            vertexTypeId: vertexTypeId,
            minDegree: null,
            maxDegree: null
        };

        var cmd = this._metamodelCommandFactory.makeCommand( "undirectededgetypecreation" );

        cmd.execute( etJson ).then(
            ( nothing : values.ENothing ) => {
                this._elementSelection.elementSelection = parentPkg.findOptionalUndirectedEdgeTypeByName( etName );
            }
        );

    }

    /**
     * Responds to clicking an "Add a vertex type" link.
     * @param event
     */
    private _onAddVertexTypeClicked( event : any ) : void {

        // TODO: UUIDs from server
        var cmdId = uuids.makeUuid();
        var pkgId = uuids.makeUuid();
        var parentPkg = <api_elements.IPackage> this._elementSelection.elementSelection;
        var parentPkgId = parentPkg.id;
        var superTypeId = this._metamodelRepository.findRootVertexType().id;

        var vtName = "Vertex Type";
        for ( var counter = 1; counter < 1000; counter += 1 ) {
            if ( !parentPkg.findOptionalPackagedElementByName( vtName ) ) {
                break;
            }
            vtName = "Vertex Type " + counter;
        }

        var pkgJson = {
            cmdId: cmdId,
            id: pkgId,
            parentPackageId: parentPkgId,
            name: vtName,
            superTypeId: superTypeId,
            abstractness: "CONCRETE"
        };

        var cmd = this._metamodelCommandFactory.makeCommand( "vertextypecreation" );

        cmd.execute( pkgJson ).then(
            ( nothing : values.ENothing ) => {
                this._elementSelection.elementSelection = parentPkg.findOptionalVertexTypeByName( vtName );
            }
        );

    }

    /** Counter for adding to names for more likely uniqueness. */
    private static _counter : number = 1;

    /** The selected element to be watched. */
    private _elementSelection : elementmodel.ElementSelection;

    /** The factory for commands. */
    private _metamodelCommandFactory : api_commands.IMetamodelCommandFactory;

    /** The repository of all elements. */
    private _metamodelRepository : api_queries.IMetamodelRepository;


}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
