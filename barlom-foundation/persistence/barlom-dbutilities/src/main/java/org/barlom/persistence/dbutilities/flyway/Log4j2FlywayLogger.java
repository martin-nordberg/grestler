//
// (C) Copyright 2014 Martin E. Nordberg III
// Apache 2.0 License
//

package org.barlom.persistence.dbutilities.flyway;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.flywaydb.core.internal.util.logging.Log;

/**
 * Adapter sends Flyway logging to Log4j2.
 */
class Log4j2FlywayLogger
    implements Log {

    /**
     * Constructs a new logging adapter for Flyway.
     *
     * @param clazz the class being logged for.
     */
    public Log4j2FlywayLogger( Class<?> clazz ) {
        this.logger = LogManager.getLogger( clazz );
    }

    @Override
    public void debug( String message ) {
        this.logger.debug( message );
    }

    @Override
    public void error( String message ) {
        this.logger.error( message );
    }

    @Override
    public void error( String message, Exception e ) {
        this.logger.error( message, e );
    }

    @Override
    public void info( String message ) {
        this.logger.info( message );
    }

    @Override
    public void warn( String message ) {
        this.logger.warn( message );
    }

    /**
     * The encapsulated Log4J2 logger.
     */
    private final Logger logger;

}
