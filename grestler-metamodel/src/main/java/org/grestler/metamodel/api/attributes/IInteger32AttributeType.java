//
// (C) Copyright 2015 Martin E. Nordberg III
// Apache 2.0 License
//

package org.grestler.metamodel.api.attributes;

import java.util.OptionalInt;

/**
 * Interface to 32-bit integer attribute types.
 */
public interface IInteger32AttributeType
    extends IAttributeType {

    @Override
    default EDataType getDataType() {
        return EDataType.INTEGER32;
    }

    /**
     * @return the maximum possible value (inclusive) for attributes of this type.
     */
    OptionalInt getMinValue();

    /**
     * @return the minimum possible value (inclusive) for attributes of this type.
     */
    OptionalInt getMaxValue();


}
