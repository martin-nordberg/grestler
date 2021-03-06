//
// (C) Copyright 2014-2015 Martin E. Nordberg III
// Apache 2.0 License
//

package org.barlom.presentation.webutilities.logging;

import org.apache.logging.log4j.LogManager;
import org.eclipse.jetty.util.log.Logger;

/**
 * Adapter routes Jetty logging into Log4J2. This code is mostly cloned from Jetty's standard Logger implementations.
 */
public class Log4j2JettyLogger
    implements Logger {

    public Log4j2JettyLogger( String name ) {
        this.logger = LogManager.getLogger( name );
    }

    @Override
    public void debug( String msg, Object... args ) {
        if ( this.logger.isDebugEnabled() ) {
            this.logger.debug( Log4j2JettyLogger.format( msg, args ) );
        }
    }

    @Override
    public void debug( String msg, long value ) {
        this.logger.debug( msg, value );
    }

    @Override
    public void debug( Throwable thrown ) {
        this.logger.debug( "", thrown );
    }

    @Override
    public void debug( String msg, Throwable thrown ) {
        this.logger.debug( msg, thrown );
    }

    @Override
    public Logger getLogger( String name ) {
        return new Log4j2JettyLogger( name );
    }

    @Override
    public String getName() {
        return this.logger.getName();
    }

    @Override
    public void ignore( Throwable ignored ) {
        // TBD
    }

    @Override
    public void info( String msg, Object... args ) {
        if ( this.logger.isInfoEnabled() ) {
            this.logger.info( Log4j2JettyLogger.format( msg, args ) );
        }
    }

    @Override
    public void info( Throwable thrown ) {
        this.logger.info( "", thrown );
    }

    @Override
    public void info( String msg, Throwable thrown ) {
        this.logger.info( msg, thrown );
    }

    @Override
    public boolean isDebugEnabled() {
        return this.logger.isDebugEnabled();
    }

    @Override
    public void setDebugEnabled( boolean enabled ) {
        // TBD
    }

    @Override
    public void warn( String msg, Object... args ) {
        if ( this.logger.isWarnEnabled() ) {
            this.logger.warn( Log4j2JettyLogger.format( msg, args ) );
        }
    }

    @Override
    public void warn( Throwable thrown ) {
        this.logger.warn( "", thrown );
    }

    @Override
    public void warn( String msg, Throwable thrown ) {
        this.logger.warn( msg, thrown );
    }

    private static String format( String message, Object... args ) {

        String msg = String.valueOf( message ); // Avoids NPE

        String braces = "{}";

        StringBuilder builder = new StringBuilder();

        int start = 0;

        for ( Object arg : args ) {
            int bracesIndex = msg.indexOf( braces, start );

            if ( bracesIndex < 0 ) {
                builder.append( msg.substring( start ) );
                builder.append( " " );
                builder.append( arg );
                start = msg.length();
            }
            else {
                builder.append( msg.substring( start, bracesIndex ) );
                builder.append( arg );
                start = bracesIndex + braces.length();
            }
        }

        builder.append( msg.substring( start ) );

        return builder.toString();
    }

    private final org.apache.logging.log4j.Logger logger;

}
