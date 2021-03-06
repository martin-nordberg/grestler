//
// (C) Copyright 2014-2015 Martin E. Nordberg III
// Apache 2.0 License
//

package org.barlom.domain.metamodel.api.elements;

import java.util.Optional;
import java.util.OptionalInt;
import java.util.UUID;

/**
 * Top level interface to a directed edge type.
 */
public interface IDirectedEdgeType
    extends IEdgeType {

    /**
     * Data structure holding the attributes of a directed edge type.
     */
    class Record
        extends IEdgeType.Record {

        public Record(
            UUID id,
            UUID parentPackageId,
            UUID superTypeId,
            String name,
            EAbstractness abstractness,
            ECyclicity cyclicity,
            EMultiEdgedness multiEdgedness,
            ESelfLooping selfLooping,
            Optional<String> headRoleName,
            UUID headVertexTypeId,
            OptionalInt maxHeadInDegree,
            OptionalInt maxTailOutDegree,
            OptionalInt minHeadInDegree,
            OptionalInt minTailOutDegree,
            Optional<String> tailRoleName,
            UUID tailVertexTypeId
        ) {
            super( id, parentPackageId, superTypeId, name, abstractness, cyclicity, multiEdgedness, selfLooping );

            this.headRoleName = headRoleName;
            this.headVertexTypeId = headVertexTypeId;
            this.maxHeadInDegree = maxHeadInDegree;
            this.maxTailOutDegree = maxTailOutDegree;
            this.minHeadInDegree = minHeadInDegree;
            this.minTailOutDegree = minTailOutDegree;
            this.tailRoleName = tailRoleName;
            this.tailVertexTypeId = tailVertexTypeId;
        }

        public final Optional<String> headRoleName;

        public final UUID headVertexTypeId;

        public final OptionalInt maxHeadInDegree;

        public final OptionalInt maxTailOutDegree;

        public final OptionalInt minHeadInDegree;

        public final OptionalInt minTailOutDegree;

        public final Optional<String> tailRoleName;

        public final UUID tailVertexTypeId;

    }

    /**
     * @return the name of the role for the vertex at the head of edges of this type.
     */
    Optional<String> getHeadRoleName();

    /**
     * @return the destination vertex type for edges of this type.
     */
    IVertexType getHeadVertexType();

    /**
     * The maximum number of edges into the head vertex for an edge of this type.
     *
     * @return the maximum head in degree (optional).
     */
    OptionalInt getMaxHeadInDegree();

    /**
     * The maximum number of edges out of the tail vertex for an edge of this type.
     *
     * @return the maximum tail out degree (optional).
     */
    OptionalInt getMaxTailOutDegree();

    /**
     * The minimum number of edges into the head vertex for an edge of this type.
     *
     * @return the minimum head in degree (optional).
     */
    OptionalInt getMinHeadInDegree();

    /**
     * The minimum number of edges out of the tail vertex for an edge of this type.
     *
     * @return the minimum tail out degree (optional).
     */
    OptionalInt getMinTailOutDegree();

    /**
     * @return the super type of this edge type.
     */
    Optional<IDirectedEdgeType> getSuperType();

    /**
     * @return the name of the role for the vertex at the tail of edges of this type.
     */
    Optional<String> getTailRoleName();

    /**
     * @return the origin vertex type for edges of this type.
     */
    IVertexType getTailVertexType();

    /**
     * Determines whether this edge type is a direct or indirect subtype of the given edge type.
     *
     * @param edgeType the potential super type
     *
     * @return true if this edge type is the given type or, recursively, if its super type is a subtype of the given
     * type.
     */
    boolean isSubTypeOf( IDirectedEdgeType edgeType );

}
