//
// (C) Copyright 2014 Martin E. Nordberg III
// Apache 2.0 License
//

package org.grestler.application;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.grestler.dbutilities.IDataSource;
import org.grestler.dbutilities.IDataSourceDefinition;
import org.grestler.h2database.H2DataSourceDefinition;

/**
 * Grestler main program.
 */
public class Application {

    /** Executes the Grestler application. */
    public static void main( String[] args ) throws Exception {

        // Capture Jetty logging into Log4J2.
        org.eclipse.jetty.util.log.Log.setLog( new org.grestler.application.JettyToLog4J2Logger( "Jetty" ) );

        LOG.info( "Application started." );

        // Configure the data source.
        // TODO: support different back ends
        IDataSourceDefinition dataSourceDefinition = new H2DataSourceDefinition();

        // Create the data source ...
        try ( IDataSource dataSource = dataSourceDefinition.makeDataSource() ) {

            // Run the web server.
            new WebServer().run( dataSource );

        }

        LOG.info( "Application stopped." );

    }

    private static final Logger LOG = LogManager.getLogger();

}