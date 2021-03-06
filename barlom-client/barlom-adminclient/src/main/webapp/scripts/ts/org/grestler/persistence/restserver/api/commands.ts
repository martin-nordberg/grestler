//
// (C) Copyright 2015 Martin E. Nordberg III
// Apache 2.0 License
//

/**
 * Module: org/grestler/persistence/restserver/api/commands
 */

import ajax = require( '../../../infrastructure/utilities/ajax' );
import values = require( '../../../infrastructure/utilities/values' );
import api_elements = require( '../../../domain/metamodel/api/elements' );
import api_queries = require( '../../../domain/metamodel/api/queries' );
import spi_commands = require( '../../../domain/metamodel/spi/commands' );
import spi_queries = require( '../../../domain/metamodel/spi/queries' );

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Abstract REST Server command writer.
 */
class AbstractMetamodelCommandWriter implements spi_commands.IMetamodelCommandWriter {

    /**
     * Constructs a new vertex type creation command.  -- TODO: shared REST server configuration
     */
    constructor() {
    }

    public execute(
        jsonCmdArgs : any, cmdFinisher : spi_commands.IMetamodelCommandSpi
    ) : Promise<values.ENothing> {

        return this.writeCommand( jsonCmdArgs ).then(
            function () {
                cmdFinisher.finish( jsonCmdArgs );
                return values.nothing;
            }
        );

    }

    /**
     * Performs the database inserts needed to save the command in the given connection.
     *
     * @param jsonCmdArgs the JSON for the command.
     */
    public writeCommand( jsonCmdArgs : any ) : Promise<values.ENothing> {
        throw new Error( "Abstract method must be overridden in a derived class." );
    }

}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Command to create a directed edge type.
 */
class DirectedEdgeTypeCreationCmdWriter extends AbstractMetamodelCommandWriter {

    /**
     * Constructs a new directed edge type creation command.
     */
    constructor() {
        super();
    }

    public writeCommand( jsonCmdArgs : any ) : Promise<values.ENothing> {

        var content = JSON.stringify( jsonCmdArgs );

        // TODO: either a generic name-parameterized command that passes its JSON through like above or else specific commands that do data validation first

        return ajax.httpPost(
            "http://localhost:8080/grestlerdata/metadata/commands/directededgetypecreation",
            "application/json",
            content
        ).then(
            function () {
                return values.nothing;
            }
        );

    }

}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Command to change the abstractness of an edge type.
 */
class EdgeTypeAbstractnessChangeCmdWriter extends AbstractMetamodelCommandWriter {

    /**
     * Constructs a new edge type abstractness change command.
     */
    constructor() {
        super();
    }

    public writeCommand( jsonCmdArgs : any ) : Promise<values.ENothing> {

        // Parse the JSON arguments.
        // TODO: handle input validation problems
        var cmdId : string = jsonCmdArgs.cmdId;
        var id : string = jsonCmdArgs.id;
        var abstractness : string = jsonCmdArgs.abstractness;

        var content = JSON.stringify(
            {
                cmdId: cmdId,
                id: id,
                abstractness: abstractness
            }
        );

        return ajax.httpPost(
            "http://localhost:8080/grestlerdata/metadata/commands/edgetypeabstractnesschange",
            "application/json",
            content
        ).then(
            function () {
                return values.nothing;
            }
        );

    }

}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Command to change the cyclicity of an edge type.
 */
class EdgeTypeCyclicityChangeCmdWriter extends AbstractMetamodelCommandWriter {

    /**
     * Constructs a new edge type cyclicity change command.
     */
    constructor() {
        super();
    }

    public writeCommand( jsonCmdArgs : any ) : Promise<values.ENothing> {

        // Parse the JSON arguments.
        // TODO: handle input validation problems
        var cmdId : string = jsonCmdArgs.cmdId;
        var id : string = jsonCmdArgs.id;
        var cyclicity : string = jsonCmdArgs.cyclicity;

        var content = JSON.stringify(
            {
                cmdId: cmdId,
                id: id,
                cyclicity: cyclicity
            }
        );

        return ajax.httpPost(
            "http://localhost:8080/grestlerdata/metadata/commands/edgetypecyclicitychange",
            "application/json",
            content
        ).then(
            function () {
                return values.nothing;
            }
        );

    }

}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Command to change the multi-edgedness of an edge type.
 */
class EdgeTypeMultiEdgednessChangeCmdWriter extends AbstractMetamodelCommandWriter {

    /**
     * Constructs a new edge type multi-edgedness change command.
     */
    constructor() {
        super();
    }

    public writeCommand( jsonCmdArgs : any ) : Promise<values.ENothing> {

        // Parse the JSON arguments.
        // TODO: handle input validation problems
        var cmdId : string = jsonCmdArgs.cmdId;
        var id : string = jsonCmdArgs.id;
        var multiEdgedness : string = jsonCmdArgs.multiEdgedness;

        var content = JSON.stringify(
            {
                cmdId: cmdId,
                id: id,
                multiEdgedness: multiEdgedness
            }
        );

        return ajax.httpPost(
            "http://localhost:8080/grestlerdata/metadata/commands/edgetypemultiedgednesschange",
            "application/json",
            content
        ).then(
            function () {
                return values.nothing;
            }
        );

    }

}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Command to change the self-looping of an edge type.
 */
class EdgeTypeSelfLoopingChangeCmdWriter extends AbstractMetamodelCommandWriter {

    /**
     * Constructs a new edge type self-looping change command.
     */
    constructor() {
        super();
    }

    public writeCommand( jsonCmdArgs : any ) : Promise<values.ENothing> {

        // Parse the JSON arguments.
        // TODO: handle input validation problems
        var cmdId : string = jsonCmdArgs.cmdId;
        var id : string = jsonCmdArgs.id;
        var selfLooping : string = jsonCmdArgs.selfLooping;

        var content = JSON.stringify(
            {
                cmdId: cmdId,
                id: id,
                selfLooping: selfLooping
            }
        );

        return ajax.httpPost(
            "http://localhost:8080/grestlerdata/metadata/commands/edgetypeselfloopingchange",
            "application/json",
            content
        ).then(
            function () {
                return values.nothing;
            }
        );

    }

}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Command to create a package.
 */
class PackageCreationCmdWriter extends AbstractMetamodelCommandWriter {

    /**
     * Constructs a new package creation command.
     */
    constructor() {
        super();
    }

    public writeCommand( jsonCmdArgs : any ) : Promise<values.ENothing> {

        // Parse the JSON arguments.
        // TODO: handle input validation problems
        var cmdId : string = jsonCmdArgs.cmdId;
        var id : string = jsonCmdArgs.id;
        var parentPackageId : string = jsonCmdArgs.parentPackageId;
        var name : string = jsonCmdArgs.name;

        var content = JSON.stringify(
            {
                cmdId: cmdId,
                id: id,
                parentPackageId: parentPackageId,
                name: name
            }
        );

        return ajax.httpPost(
            "http://localhost:8080/grestlerdata/metadata/commands/packagecreation",
            "application/json",
            content
        ).then(
            function () {
                return values.nothing;
            }
        );

    }

}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Command to rename a packaged element.
 */
class PackagedElementNameChangeCmdWriter extends AbstractMetamodelCommandWriter {

    /**
     * Constructs a new packaged element rename command.
     */
    constructor() {
        super();
    }

    public writeCommand( jsonCmdArgs : any ) : Promise<values.ENothing> {

        // Parse the JSON arguments.
        // TODO: handle input validation problems
        var cmdId : string = jsonCmdArgs.cmdId;
        var id : string = jsonCmdArgs.id;
        var name : string = jsonCmdArgs.name;

        var content = JSON.stringify(
            {
                cmdId: cmdId,
                id: id,
                name: name
            }
        );

        return ajax.httpPost(
            "http://localhost:8080/grestlerdata/metadata/commands/packagedelementnamechange",
            "application/json",
            content
        ).then(
            function () {
                return values.nothing;
            }
        );

    }

}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Command to create an undirected edge type.
 */
class UndirectedEdgeTypeCreationCmdWriter extends AbstractMetamodelCommandWriter {

    /**
     * Constructs a new undirected edge type creation command.
     */
    constructor() {
        super();
    }

    public writeCommand( jsonCmdArgs : any ) : Promise<values.ENothing> {

        var content = JSON.stringify( jsonCmdArgs );

        return ajax.httpPost(
            "http://localhost:8080/grestlerdata/metadata/commands/undirectededgetypecreation",
            "application/json",
            content
        ).then(
            function () {
                return values.nothing;
            }
        );

    }

}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Command to change the abstractness of a vertex type.
 */
class VertexTypeAbstractnessChangeCmdWriter extends AbstractMetamodelCommandWriter {

    /**
     * Constructs a new vertex type abstractness change command.
     */
    constructor() {
        super();
    }

    public writeCommand( jsonCmdArgs : any ) : Promise<values.ENothing> {

        // Parse the JSON arguments.
        // TODO: handle input validation problems
        var cmdId : string = jsonCmdArgs.cmdId;
        var id : string = jsonCmdArgs.id;
        var abstractness : string = jsonCmdArgs.abstractness;

        var content = JSON.stringify(
            {
                cmdId: cmdId,
                id: id,
                abstractness: abstractness
            }
        );

        return ajax.httpPost(
            "http://localhost:8080/grestlerdata/metadata/commands/vertextypeabstractnesschange",
            "application/json",
            content
        ).then(
            function () {
                return values.nothing;
            }
        );

    }

}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Command to create a vertex type.
 */
class VertexTypeCreationCmdWriter extends AbstractMetamodelCommandWriter {

    /**
     * Constructs a new vertex type creation command.
     */
    constructor() {
        super();
    }

    public writeCommand( jsonCmdArgs : any ) : Promise<values.ENothing> {

        // Parse the JSON arguments.
        // TODO: handle input validation problems
        var cmdId : string = jsonCmdArgs.cmdId;
        var id : string = jsonCmdArgs.id;
        var parentPackageId : string = jsonCmdArgs.parentPackageId;
        var name : string = jsonCmdArgs.name;
        var superTypeId : string = jsonCmdArgs.superTypeId;
        var abstractness : boolean = jsonCmdArgs.abstractness;

        var content = JSON.stringify(
            {
                cmdId: cmdId,
                id: id,
                parentPackageId: parentPackageId,
                name: name,
                superTypeId: superTypeId,
                abstractness: abstractness
            }
        );

        return ajax.httpPost(
            "http://localhost:8080/grestlerdata/metadata/commands/vertextypecreation",
            "application/json",
            content
        ).then(
            function () {
                return values.nothing;
            }
        );

    }

}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Command to change the super type of a vertex type.
 */
class VertexTypeSuperTypeChangeCmdWriter extends AbstractMetamodelCommandWriter {

    /**
     * Constructs a new vertex type super type change command.
     */
    constructor() {
        super();
    }

    public writeCommand( jsonCmdArgs : any ) : Promise<values.ENothing> {

        // Parse the JSON arguments.
        // TODO: handle input validation problems
        var cmdId : string = jsonCmdArgs.cmdId;
        var id : string = jsonCmdArgs.id;
        var superTypeId : string = jsonCmdArgs.superTypeId;

        var content = JSON.stringify(
            {
                cmdId: cmdId,
                id: id,
                superTypeId: superTypeId
            }
        );

        return ajax.httpPost(
            "http://localhost:8080/grestlerdata/metadata/commands/vertextypesupertypechange",
            "application/json",
            content
        ).then(
            function () {
                return values.nothing;
            }
        );

    }

}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Factory for metamodel commands supported by the H2 Database provider.
 */
export class MetamodelCommandWriterFactory implements spi_commands.IMetamodelCommandWriterFactory {

    /**
     * Constructs a new factory for creating metamodel commands.
     * TODO: configuration of REST server
     */
    constructor() {
    }

    public makeCommandWriter( commandTypeName : string ) : spi_commands.IMetamodelCommandWriter {

        switch ( commandTypeName.toLowerCase() ) {
            case "directededgetypecreation":
                return new DirectedEdgeTypeCreationCmdWriter();
            case "edgetypeabstractnesschange":
                return new EdgeTypeAbstractnessChangeCmdWriter();
            case "edgetypecyclicitychange":
                return new EdgeTypeCyclicityChangeCmdWriter();
            case "edgetypemultiedgednesschange":
                return new EdgeTypeMultiEdgednessChangeCmdWriter();
            case "edgetypeselfloopingchange":
                return new EdgeTypeSelfLoopingChangeCmdWriter();
            case "packagecreation":
                return new PackageCreationCmdWriter();
            case "packagedelementnamechange":
                return new PackagedElementNameChangeCmdWriter();
            case "undirectededgetypecreation":
                return new UndirectedEdgeTypeCreationCmdWriter();
            case "vertextypeabstractnesschange":
                return new VertexTypeAbstractnessChangeCmdWriter();
            case "vertextypecreation":
                return new VertexTypeCreationCmdWriter();
            case "vertextypesupertypechange":
                return new VertexTypeSuperTypeChangeCmdWriter();
            default:
                throw new Error( "Unknown command type: \"" + commandTypeName + "\"." );
        }

    }

}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

