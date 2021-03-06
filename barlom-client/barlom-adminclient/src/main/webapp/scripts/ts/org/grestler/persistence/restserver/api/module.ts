//
// (C) Copyright 2015 Martin E. Nordberg III
// Apache 2.0 License
//

/**
 * Module: org/grestler/domain/metamodel/impl/module
 */

import restserver_api_commands = require( './commands' )
import restserver_api_queries = require( './queries' )
import spi_commands = require( '../../../domain/metamodel/spi/commands' )
import spi_queries = require( '../../../domain/metamodel/spi/queries' )

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

export var restserverApiModule = {

    /**
     * Service for loading all attribute declarations into a metamodel repository.
     */
    provideAttributeDeclLoader: function provideAttributeDeclLoader() : spi_queries.IAttributeDeclLoader {
        return new restserver_api_queries.AttributeDeclLoader();
    },

    /**
     * Service for loading all attribute types into a metamodel repository.
     */
    provideAttributeTypeLoader: function provideAttributeTypeLoader() : spi_queries.IAttributeTypeLoader {
        return new restserver_api_queries.AttributeTypeLoader();
    },

    /**
     * Service for loading all directed edge types into a metamodel repository.
     */
    provideDirectedEdgeTypeLoader: function provideDirectedEdgeTypeLoader() : spi_queries.IDirectedEdgeTypeLoader {
        return new restserver_api_queries.DirectedEdgeTypeLoader();
    },

    /**
     * Provides a factory for persisting commands.
     */
    provideMetamodelCommandWriterFactory: function provideMetamodelCommandWriterFactory() : spi_commands.IMetamodelCommandWriterFactory {
        return new restserver_api_commands.MetamodelCommandWriterFactory();
    },

    /**
     * Service for loading all package dependencies into a metamodel repository.
     */
    providePackageDependencyLoader: function providePackageDependencyLoader() : spi_queries.IPackageDependencyLoader {
        return new restserver_api_queries.PackageDependencyLoader();
    },

    /**
     * Service for loading all packages into a metamodel repository.
     */
    providePackageLoader: function providePackageLoader() : spi_queries.IPackageLoader {
        return new restserver_api_queries.PackageLoader();
    },

    /**
     * Service for loading all undirected edge types into a metamodel repository.
     */
    provideUndirectedEdgeTypeLoader: function provideUndirectedEdgeTypeLoader() : spi_queries.IUndirectedEdgeTypeLoader {
        return new restserver_api_queries.UndirectedEdgeTypeLoader();
    },

    /**
     * Service for loading all vertex types into a metamodel repository.
     */
    provideVertexTypeLoader: function provideVertexTypeLoader() : spi_queries.IVertexTypeLoader {
        return new restserver_api_queries.VertexTypeLoader();
    }

};

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

