//
// (C) Copyright 2014-2015 Martin E. Nordberg III
// Apache 2.0 License
//

package org.barlom.presentation.adminserver;

import dagger.ObjectGraph;
import org.eclipse.jetty.http.MimeTypes;
import org.eclipse.jetty.server.handler.ContextHandler;
import org.eclipse.jetty.server.handler.ContextHandlerCollection;
import org.eclipse.jetty.server.handler.ResourceHandler;
import org.eclipse.jetty.servlet.ServletContextHandler;
import org.eclipse.jetty.servlet.ServletHolder;
import org.eclipse.jetty.util.resource.Resource;
import org.barlom.application.apputilities.filters.ThreadNameFilter;
import org.barlom.presentation.webutilities.servlets.ShutdownServlet;

import javax.servlet.DispatcherType;
import java.net.MalformedURLException;
import java.util.EnumSet;

/**
 * Builder class creates and configures the admin server.
 */
public final class AdminServerBuilder {

    /** Static utility class. */
    private AdminServerBuilder() {
    }

    /**
     * Creates a Jetty server for administration.
     *
     * @param webServer The top level web server to be shutdown via the admin console.
     * @param contexts  the context collection to be configured with the Barlom admin application.
     *
     * @throws java.net.MalformedURLException if the configuration is broken.
     */
    public static void makeAdminServer( AutoCloseable webServer, ContextHandlerCollection contexts )
        throws MalformedURLException {

        // Serve static content.
        ContextHandler staticContext = AdminServerBuilder.makeStaticContextHandler();

        // Serve dynamic content plus a shutdown handler.
        ServletContextHandler dynamicContext = AdminServerBuilder.makeDynamicContextHandler( webServer );

        // Combine the two contexts plus a shutdown handler.
        contexts.addHandler( staticContext );
        contexts.addHandler( dynamicContext );

    }

    /**
     * Creates the context handler for the admin server.
     *
     * @return the new context handler.
     */
    private static ServletContextHandler makeDynamicContextHandler( AutoCloseable webServer ) {

        // Set the context for dynamic content
        ServletContextHandler result = new ServletContextHandler( ServletContextHandler.SESSIONS );
        result.setContextPath( "/barlomadmin" );

        // Add a shutdown servlet for the dynamic content.
        ServletHolder servletHolder = new ServletHolder(
            new ShutdownServlet(
                webServer,
                "Barlom application server stopping..."
            )
        );
        result.addServlet( servletHolder, "/exit" );

        // Add a servlet for executing actions.
        AdminServerActionsServlet actionServlet = AdminServerBuilder.objectGraph.get( AdminServerActionsServlet.class );
        servletHolder = new ServletHolder( actionServlet );
        result.addServlet( servletHolder, "/actions/*" );

        // TBD: Any other stuff needed for admin ...

        // Rename request threads for better logging.
        result.addFilter( ThreadNameFilter.class, "/*", EnumSet.of( DispatcherType.REQUEST ) );

        return result;

    }

    /**
     * Creates the static file server context handler.
     *
     * @return the new context handler.
     *
     * @throws java.net.MalformedURLException if things are configured incorrectly.
     */
    private static ContextHandler makeStaticContextHandler() throws MalformedURLException {

        // Set the context for static content.
        ContextHandler fileServerContext = new ContextHandler();
        fileServerContext.setContextPath( "/barlom" );

        // Set the source for static content.
        ResourceHandler fileResourceHandler = new ResourceHandler();
        fileResourceHandler.setCacheControl( "max-age=3600,public" );

        // TODO: only for development to avoid cache clearing:
        fileResourceHandler.setCacheControl( "max-age=0, no-cache, no-store" );

        // TODO: Make internal resource
        fileResourceHandler.setBaseResource(
            Resource.newResource(
                "/home/mnordberg/workspace/barlom/barlom-client/barlom-adminclient/src/main/webapp"
            )
        );

        // Add MIME types for unusual file types.
        if ( fileResourceHandler.getMimeTypes() == null ) {
            fileResourceHandler.setMimeTypes( new MimeTypes() );
        }
        fileResourceHandler.getMimeTypes().addMimeMapping( "mustache", "text/ractive; charset=UTF-8" );

        fileServerContext.setHandler( fileResourceHandler );

        return fileServerContext;

    }

    /**
     * Registers the Dagger object graph that will be used to inject everything below the application itself. This
     * clumsy hack is to work around the seeming inability to dependency inject the application object itself without a
     * JEE container.
     *
     * @param objGraph the already initialized Dagger object graph for dependency injection.
     */
    public static void registerObjectGraph( ObjectGraph objGraph ) {
        AdminServerBuilder.objectGraph = objGraph;
    }

    /**
     * The Dagger dependency injection service. Explicitly used since no clear way to inject Application itself.
     */
    private static ObjectGraph objectGraph = null;

}
