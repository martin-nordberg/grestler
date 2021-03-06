//
// (C) Copyright 2015 Martin E. Nordberg III
// Apache 2.0 License
//

package org.barlom.domain.metamodel.impl.elements;

import org.barlom.domain.metamodel.api.elements.IFloat64AttributeType;
import org.barlom.domain.metamodel.api.elements.IPackage;
import org.barlom.infrastructure.utilities.revisions.V;

import javax.json.stream.JsonGenerator;
import java.util.OptionalDouble;

/**
 * Implementation for 64-bit floating point attribute types.
 */
public final class Float64AttributeType
    extends AttributeType
    implements IFloat64AttributeType {

    /**
     * Constructs a new floating point attribute type.
     *
     * @param record        the attributes of the attribute type.
     * @param parentPackage the parent attribute type.
     */
    public Float64AttributeType(
        IFloat64AttributeType.Record record, IPackage parentPackage
    ) {
        super( record, parentPackage );

        this.minValue = new V<>( record.minValue );
        this.maxValue = new V<>( record.maxValue );
        this.defaultValue = new V<>( record.defaultValue );
    }

    @Override
    public void generateJsonAttributes( JsonGenerator json ) {

        super.generateJsonAttributes( json );

        this.minValue.get().ifPresent( minValue -> json.write( "minValue", minValue ) );
        this.maxValue.get().ifPresent( maxValue -> json.write( "maxValue", maxValue ) );
        this.defaultValue.get().ifPresent( defaultValue -> json.write( "defaultValue", defaultValue ) );

    }

    @Override
    public OptionalDouble getDefaultValue() {
        return this.defaultValue.get();
    }

    @Override
    public OptionalDouble getMaxValue() {
        return this.maxValue.get();
    }

    @Override
    public OptionalDouble getMinValue() {
        return this.minValue.get();
    }

    /**
     * Changes the default value for attributes of this type.
     *
     * @param defaultValue the new default value.
     */
    public void setDefaultValue( OptionalDouble defaultValue ) {
        this.defaultValue.set( defaultValue );
    }

    /**
     * Changes the maximum value for attributes of this type.
     *
     * @param maxValue the new maximum value.
     */
    public void setMaxValue( OptionalDouble maxValue ) {
        this.maxValue.set( maxValue );
    }

    /**
     * Changes the minimum value for attributes of this type.
     *
     * @param minValue the new minimum value.
     */
    public void setMinValue( OptionalDouble minValue ) {
        this.minValue.set( minValue );
    }

    /** The default value for attributes of this type. */
    private final V<OptionalDouble> defaultValue;

    /** The minimum allowed value for attributes with this type. */
    private final V<OptionalDouble> maxValue;

    /** The maximum allowed value for attributes with this type. */
    private final V<OptionalDouble> minValue;

}
