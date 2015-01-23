//
// (C) Copyright 2015 Martin E. Nordberg III
// Apache 2.0 License
//

package org.grestler.metamodel.api.elements;

import javax.json.Json;
import javax.json.stream.JsonGenerator;
import java.io.StringWriter;
import java.util.UUID;

/**
 * Shared general interface for metadata elements.
 */
public interface IElement {

    /**
     * Generates the JSON representation of this element to the given generator.
     *
     * @param json the generator to write to.
     */
    default void generateJson( JsonGenerator json ) {
        json.writeStartObject();
        this.generateJsonAttributes( json );
        json.writeEnd();
    }

    /**
     * Generates the JSON representation of this element's attributes to the given generator.
     *
     * @param json the generator to write to.
     */
    void generateJsonAttributes( JsonGenerator json );

    /**
     * @return the unique ID of this element.
     */
    UUID getId();

    /**
     * @return the name of this element.
     */
    String getName();

    /**
     * @return the parent of this element.
     */
    @SuppressWarnings( "ClassReferencesSubclass" )
    IPackage getParentPackage();

    /**
     * @return the fully qualified path to this element.
     */
    default String getPath() {

        String result = this.getParentPackage().getPath();

        if ( !result.isEmpty() ) {
            return result + "." + this.getName();
        }

        return this.getName();

    }

    /**
     * Determines whether this package is a direct or indirect child of the given package.
     *
     * @param parentPackage the potential parent.
     *
     * @return true if this package is a child or grandchild of the given parent package.
     */
    @SuppressWarnings( "ClassReferencesSubclass" )
    default boolean isChildOf( IPackage parentPackage ) {

        IPackage parentPkg = this.getParentPackage();

        return parentPkg == parentPackage || parentPkg.isChildOf( parentPackage );

    }

    /**
     * @return a JSON representation of this element.
     */
    default String toJson() {

        StringWriter result = new StringWriter();
        JsonGenerator json = Json.createGenerator( result );

        this.generateJson( json );

        json.close();
        return result.toString();

    }

}