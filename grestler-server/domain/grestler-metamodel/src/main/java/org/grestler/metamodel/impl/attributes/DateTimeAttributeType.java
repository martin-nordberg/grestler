//
// (C) Copyright 2015 Martin E. Nordberg III
// Apache 2.0 License
//

package org.grestler.metamodel.impl.attributes;

import org.grestler.metamodel.api.attributes.IDateTimeAttributeType;
import org.grestler.metamodel.api.elements.IPackage;
import org.grestler.utilities.revisions.V;

import javax.json.stream.JsonGenerator;
import java.time.Instant;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import java.util.Optional;
import java.util.UUID;

/**
 * Date/time attribute type implementation.
 */
public final class DateTimeAttributeType
    extends AttributeType
    implements IDateTimeAttributeType {

    /**
     * Constructs a new date/time attribute type.
     *
     * @param id            the unique ID of the attribute type.
     * @param parentPackage the parent attribute type.
     * @param name          the name of the attribute type.
     * @param minValue      the minimum value for attributes of this type.
     * @param maxValue      the minimum value for attributes of this type.
     */
    public DateTimeAttributeType(
        UUID id, IPackage parentPackage, String name, Optional<Instant> minValue, Optional<Instant> maxValue
    ) {

        super( id, parentPackage, name );

        this.maxValue = new V<>( maxValue );
        this.minValue = new V<>( minValue );

    }

    @Override
    public void generateJsonAttributes( JsonGenerator json ) {

        super.generateJsonAttributes( json );

        DateTimeFormatter jsonDateTimeFormatter = DateTimeFormatter.ofPattern( "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" )
                                                                   .withZone( ZoneOffset.UTC );

        this.maxValue.get().ifPresent(
            maxValue -> json.write(
                "maxValue", jsonDateTimeFormatter.format( maxValue )
            )
        );
        this.minValue.get().ifPresent(
            minValue -> json.write(
                "minValue", jsonDateTimeFormatter.format( minValue )
            )
        );

    }

    @Override
    public Optional<Instant> getMaxValue() {
        return this.maxValue.get();
    }

    @Override
    public Optional<Instant> getMinValue() {
        return this.minValue.get();
    }

    /** The maximum allowed value for attributes with this type. */
    private final V<Optional<Instant>> maxValue;

    /** The minimum allowed value for attributes with this type. */
    private final V<Optional<Instant>> minValue;

}
