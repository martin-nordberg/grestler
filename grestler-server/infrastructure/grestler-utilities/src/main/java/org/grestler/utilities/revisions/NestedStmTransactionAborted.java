//
// (C) Copyright 2015 Martin E. Nordberg III
// Apache 2.0 License
//

package org.grestler.utilities.revisions;

import java.util.Optional;

/**
 * Exception thrown when a nested transaction is aborted.
 */
public class NestedStmTransactionAborted
    extends RuntimeException {

    /**
     * Constructs a new exception.
     */
    public NestedStmTransactionAborted( Optional<Exception> e ) {
        super( "Nested transaction aborted. (Partial recovery not supported.)", e.orElse( null ) );
    }

}