//
// (C) Copyright 2015 Martin E. Nordberg III
// Apache 2.0 License
//

package org.grestler.domain.javamodel.api.elements;

import org.grestler.infrastructure.utilities.collections.IIndexable;

import java.util.Optional;

/**
 * An enumeration.
 */
public interface IJavaEnumeration
    extends IJavaConcreteComponent {

    /** Creates an new enum constant within this enumeration. */
    IJavaEnumConstant addEnumConstant(
        String name, Optional<String> description, Integer uniqueId, String parametersCode, String referencePrefix
    );

    /** @return the enum constants within this enumeration. */
    IIndexable<IJavaEnumConstant> getEnumConstants();

}
