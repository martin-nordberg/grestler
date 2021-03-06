//
// (C) Copyright 2015 Martin E. Nordberg III
// Apache 2.0 License
//

package org.barlom.persistence.h2database.api.exceptions;

import org.apache.logging.log4j.Logger;
import org.barlom.infrastructure.utilities.exceptions.EValidationType;
import org.barlom.persistence.dbutilities.api.DatabaseException;

import java.util.HashMap;
import java.util.Map;

/**
 * Concrete exception for H2 database errors.
 */
public class H2DatabaseException
    extends DatabaseException {

    /**
     * Constructs a new H2 database exception.
     *
     * @param log     the logger for logging the exception.
     * @param message the message for the error.
     */
    public H2DatabaseException( Logger log, String message ) {

        super( log, message );

        this.validationError = new ValidationError( EValidationType.NONSPECIFIC, message );

    }

    /**
     * Constructs a new H2 database exception wrapping a lower level exception.
     *
     * @param log     the logger for logging the exception.
     * @param message the message for the error.
     * @param cause   the lower level exception.
     */
    public H2DatabaseException( Logger log, String message, Throwable cause ) {

        super( log, message, cause );

        this.validationError = H2DatabaseException.determineValidationError( cause );

    }

    @Override
    public String getValidationMessage() {
        return this.validationError.validationMessage;
    }

    @Override
    public EValidationType getValidationType() {
        return this.validationError.validationType;
    }

    /**
     * Class combining the attributes of a validation error.
     */
    private static final class ValidationError {

        private ValidationError( EValidationType validationType, String validationMessage ) {
            this.validationType = validationType;
            this.validationMessage = validationMessage;
        }

        public final String validationMessage;

        public final EValidationType validationType;

    }

    /**
     * Determines a more useful determination of a validation error by parsing fragments of the SQL exception message.
     *
     * @param cause the SQL exception to look at.
     *
     * @return the validation error message and type.
     */
    private static ValidationError determineValidationError( Throwable cause ) {

        String msg = cause.getMessage();

        EValidationType vtype = EValidationType.NONSPECIFIC;
        StringBuilder vmsg = new StringBuilder();

        if ( msg == null ) {
            vmsg.append( "Unknown error." );
        }
        else if ( msg.startsWith( "Referential integrity constraint violation" ) ) {
            vtype = EValidationType.RELATED_ENTITY_NOT_FOUND;
            vmsg.append( "Related " );
            vmsg.append(
                H2DatabaseException.determineValidationMessage(
                    msg, H2DatabaseException.RELATED_ENTITY_FRAGMENTS
                )
            );
            vmsg.append( " not found." );
        }
        else if ( msg.startsWith( "Unique index or primary key violation" ) ) {
            vtype = EValidationType.DUPLICATE_ENTITY_CREATION;
            vmsg.append( "Duplicate " );
            vmsg.append(
                H2DatabaseException.determineValidationMessage(
                    msg, H2DatabaseException.DUPLICATE_ENTITY_FRAGMENTS
                )
            );
            vmsg.append( " creation." );
        }
        else {
            vmsg.append( msg );
        }

        return new ValidationError( vtype, vmsg.toString() );

    }

    private static String determineValidationMessage( String msg, Map<String, String> relatedEntityFragments ) {
        for ( Map.Entry<String, String> entry : relatedEntityFragments.entrySet() ) {
            if ( msg.contains( entry.getKey() ) ) {
                return entry.getValue();
            }
        }
        return "element";
    }

    /** Mapped fragments for duplicate entity problems. */
    private static final Map<String, String> DUPLICATE_ENTITY_FRAGMENTS = new HashMap<>();

    /** Mapped fragments for missing related entity problems. */
    private static final Map<String, String> RELATED_ENTITY_FRAGMENTS = new HashMap<>();

    /** Serialization version. */
    private static final long serialVersionUID = 1L;

    /** The underlying validation error represented by this exception. */
    private final ValidationError validationError;

    static {
        H2DatabaseException.DUPLICATE_ENTITY_FRAGMENTS.put( "PK_GRESTLER_PACKAGE", "package" );
        H2DatabaseException.DUPLICATE_ENTITY_FRAGMENTS.put( "PK_GRESTLER_VERTEX_TYPE", "vertex type" );
        // TODO: more entries ...
    }

    static {
        H2DatabaseException.RELATED_ENTITY_FRAGMENTS.put( "__PARENT_PACKAGE", "package" );
        // TODO: more entries ...
    }

}
