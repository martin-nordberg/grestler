//
// (C) Copyright 2015 Martin E. Nordberg III
// Apache 2.0 License
//

package org.grestler.metamodel.api.attributes;

import java.time.LocalDateTime;
import java.util.Optional;

/**
 * Interface to a date/time attribute type.
 */
public interface IDateTimeAttributeType
    extends IAttributeType {

    @Override
    default EDataType getDataType() {
        return EDataType.DATETIME;
    }

    /**
     * @return the maximum possible value (inclusive) for attributes of this type.
     */
    Optional<LocalDateTime> getMinValue();

    /**
     * @return the minimum possible value (inclusive) for attributes of this type.
     */
    Optional<LocalDateTime> getMaxValue();

}
