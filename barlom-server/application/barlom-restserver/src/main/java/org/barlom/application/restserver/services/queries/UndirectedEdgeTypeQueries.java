//
// (C) Copyright 2015 Martin E. Nordberg III
// Apache 2.0 License
//

package org.barlom.application.restserver.services.queries;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.barlom.domain.metamodel.api.elements.IUndirectedEdgeType;
import org.barlom.domain.metamodel.api.queries.IMetamodelRepository;
import org.barlom.infrastructure.utilities.revisions.StmTransactionContext;

import javax.inject.Inject;
import javax.json.stream.JsonGenerator;
import javax.json.stream.JsonGeneratorFactory;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import java.io.StringWriter;
import java.util.Optional;
import java.util.UUID;

/**
 * Service for querying Barlom undirected edge types.
 */
@Path( "/metadata/undirectededgetypes" )
public class UndirectedEdgeTypeQueries {

    /**
     * Constructs a new undirected edge type query service backed by given metamodel repository.
     *
     * @param metamodelRepository  the metamodel repository to query from.
     * @param jsonGeneratorFactory the factory for generating JSON.
     */
    @Inject
    public UndirectedEdgeTypeQueries(
        IMetamodelRepository metamodelRepository, JsonGeneratorFactory jsonGeneratorFactory
    ) {

        this.metamodelRepository = metamodelRepository;
        this.jsonGeneratorFactory = jsonGeneratorFactory;

    }

    /**
     * Queries for all undirected edge types.
     *
     * @return JSON for the undirected edge types found.
     */
    @GET
    @Path( "" )
    @Produces( { "application/json", "application/vnd.barlom.org.v1.undirectededgetype+json" } )
    public String getAllUndirectedEdgeTypes() {

        UndirectedEdgeTypeQueries.LOG.info( "Querying for all undirected edge types." );

        StringWriter result = new StringWriter();
        JsonGenerator json = this.jsonGeneratorFactory.createGenerator( result );

        json.writeStartObject();
        json.writeStartArray( "undirectedEdgeTypes" );

        StmTransactionContext.doInReadOnlyTransaction(
            () -> {
                Iterable<IUndirectedEdgeType> edgeTypes = this.metamodelRepository.findAllUndirectedEdgeTypes();
                edgeTypes.forEach( edgeType -> edgeType.generateJson( json ) );
            }
        );

        json.writeEnd();
        json.writeEnd();

        json.close();
        return result.toString();

    }

    /**
     * Queries for one undirected edge type by ID or by path.
     *
     * @param idOrPath the UUID or the full path of the undirected edge type.
     *
     * @return JSON for the undirected edge type found or null.
     */
    @GET
    @Path( "/{idOrPath}" )
    @Produces( { "application/json", "application/vnd.barlom.org.v1.undirectededgetype+json" } )
    public String getUndirectedEdgeTypeByIdOrPath( @PathParam( "idOrPath" ) String idOrPath ) {

        UndirectedEdgeTypeQueries.LOG.info( "Querying for undirected edge type {}.", idOrPath );

        StringWriter result = new StringWriter();
        JsonGenerator json = this.jsonGeneratorFactory.createGenerator( result );

        // TODO: distinguish UUID from path

        StmTransactionContext.doInReadOnlyTransaction(
            () -> {
                Optional<IUndirectedEdgeType> edgeType = this.metamodelRepository.findOptionalUndirectedEdgeTypeById(
                    UUID.fromString(
                        idOrPath
                    )
                );

                if ( edgeType.isPresent() ) {
                    edgeType.get().generateJson( json );
                }
                else {
                    json.writeNull();
                }
            }
        );

        json.close();
        return result.toString();

    }

    private static final Logger LOG = LogManager.getLogger();

    /** The factory for generating JSON. */
    private final JsonGeneratorFactory jsonGeneratorFactory;

    /** The metamodel repository to query from. */
    private final IMetamodelRepository metamodelRepository;

}
