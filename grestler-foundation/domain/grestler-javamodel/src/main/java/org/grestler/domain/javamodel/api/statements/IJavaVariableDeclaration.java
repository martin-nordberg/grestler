//
// (C) Copyright 2015 Martin E. Nordberg III
// Apache 2.0 License
//

package org.grestler.domain.javamodel.api.statements;

import org.grestler.domain.javamodel.api.elements.IJavaNamed;
import org.grestler.domain.javamodel.api.elements.IJavaTyped;

import java.util.Optional;

/**
 * A statement defining a variable.
 */
public interface IJavaVariableDeclaration
    extends IJavaStatement, IJavaNamed, IJavaTyped {

    /**
     * @return the initial value of the variable.
     */
    Optional<String> getInitialValue();

}