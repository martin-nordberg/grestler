//
// (C) Copyright 2015 Martin E. Nordberg III
// Apache 2.0 License
//

/**
 * Module: org/grestler/domain/metamodel/impl/module
 */

import api_commands = require( '../api/commands' )
import api_queries = require( '../api/queries' )
import impl_commands = require( './commands' )
import impl_queries = require( './queries' )
import spi_commands = require( '../spi/commands' )
import spi_queries = require( '../spi/queries' )

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

export var metamodelImplModule = {

    /**
     * Creates a command factory for metamodel changes.
     * @param metamodelRepository the repository being controlled.
     * @param metamodelCommandWriterFactory the corresponding persistence factory.
     * @returns {IMetamodelCommandFactory} the new command factory.
     */
    provideMetamodelCommandFactory: function provideMetamodelCommandFactory(
        metamodelRepository : spi_queries.IMetamodelRepositorySpi,
        metamodelCommandWriterFactory : spi_commands.IMetamodelCommandWriterFactory
    ) : api_commands.IMetamodelCommandFactory {

        return new impl_commands.MetamodelCommandFactory(
            metamodelRepository,
            metamodelCommandWriterFactory
        );

    },

    /**
     * Creates a new metamodel query service.
     * @param metamodelRepository the repository to filter results from.
     * @returns {MetamodelQueries} the new query service.
     */
    provideMetamodelQueries: function provideMetamodelQueries(
        metamodelRepository : spi_queries.IMetamodelRepositorySpi
    ) : api_queries.IMetamodelQueries {

        return new impl_queries.MetamodelQueries( metamodelRepository );

    },

    /**
     * Creates the one and only metamodel repository.
     * @returns {PageSelection} the page selection.
     */
    provideSingletonMetamodelRepository: function provideSingletonMetamodelRepository(
        packageLoader : spi_queries.IPackageLoader,
        packageDependencyLoader : spi_queries.IPackageDependencyLoader,
        attributeTypeLoader : spi_queries.IAttributeTypeLoader,
        vertexTypeLoader : spi_queries.IVertexTypeLoader,
        directedEdgeTypeLoader : spi_queries.IDirectedEdgeTypeLoader,
        undirectedEdgeTypeLoader : spi_queries.IUndirectedEdgeTypeLoader,
        attributeDeclLoader : spi_queries.IAttributeDeclLoader
    ) : api_queries.IMetamodelRepository {

        return new impl_queries.MetamodelRepository(
            packageLoader,
            packageDependencyLoader,
            attributeTypeLoader,
            vertexTypeLoader,
            directedEdgeTypeLoader,
            undirectedEdgeTypeLoader,
            attributeDeclLoader
        );

    }

};

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

