//
// (C) Copyright 2014 Martin E. Nordberg III
// Apache 2.0 License
//

package org.grestler.utilities.revisions;

/**
 * Exception indicating a failed transaction due to a concurrent transaction writing values before the completion of the
 * current transaction that has read older versions of those values.
 */
class WriteConflictException
    extends RuntimeException {

    /**
     * Constructs a new exception.
     */
    WriteConflictException() {
    }

}
