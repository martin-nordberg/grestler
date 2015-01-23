//
// (C) Copyright 2014-2015 Martin E. Nordberg III
// Apache 2.0 License
//

package org.grestler.metamodel.impl.elements;

import org.grestler.metamodel.api.elements.IEdgeAttributeDecl;
import org.grestler.metamodel.api.elements.IEdgeType;
import org.grestler.metamodel.api.elements.IPackage;
import org.grestler.metamodel.api.elements.IVertexType;

import javax.json.stream.JsonGenerator;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

/**
 * Implementation of the top-level root edge type.
 */
public class RootEdgeType
    implements IEdgeType, IEdgeTypeSpi {

    /**
     * Constructs a new root edge type.
     *
     * @param id             the unique ID of the edge type.
     * @param parentPackage  the package containing the edge type.
     * @param rootVertexType the root vertex type connected by the edge type.
     */
    public RootEdgeType(
        UUID id, IPackage parentPackage, IVertexType rootVertexType
    ) {

        this.id = id;
        this.parentPackage = parentPackage;
        this.rootVertexType = rootVertexType;

        this.attributes = new ArrayList<>();

        ( (IPackageSpi) parentPackage ).addEdgeType( this );

    }

    @Override
    public void addAttribute( IEdgeAttributeDecl attribute ) {
        this.attributes.add( attribute );
    }

    @Override
    public void generateJsonAttributes( JsonGenerator json ) {
        json.write( "id", this.id.toString() )
            .write( "parentPackageId", this.parentPackage.getId().toString() )
            .write( "name", "Vertex" )
            .write( "path", this.getPath() )
            .write( "tailVertexTypeId", this.rootVertexType.getId().toString() )
            .write( "headVertexTypeId", this.rootVertexType.getId().toString() );
    }

    @Override
    public List<IEdgeAttributeDecl> getAttributes() {
        return this.attributes;
    }

    @Override
    public IVertexType getHeadVertexType() {
        return this.rootVertexType;
    }

    @Override
    public UUID getId() {
        return this.id;
    }

    @Override
    public String getName() {
        return "Edge";
    }

    @Override
    public IPackage getParentPackage() {
        return this.parentPackage;
    }

    @Override
    public Optional<IEdgeType> getSuperType() {
        return Optional.empty();
    }

    @Override
    public IVertexType getTailVertexType() {
        return this.rootVertexType;
    }

    @Override
    public boolean isSubTypeOf( IEdgeType edgeType ) {
        return this == edgeType;
    }

    private final List<IEdgeAttributeDecl> attributes;

    private final UUID id;

    private final IPackage parentPackage;

    private final IVertexType rootVertexType;
}