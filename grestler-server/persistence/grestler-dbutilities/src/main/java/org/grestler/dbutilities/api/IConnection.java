//
// (C) Copyright 2015 Martin E. Nordberg III
// Apache 2.0 License
//

package org.grestler.dbutilities.api;

import java.util.Map;

/**
 * Interface to a database connection.
 */
public interface IConnection
    extends AutoCloseable {

    /**
     * Closes this connection.
     *
     * @throws DatabaseException if closing fails (overriding AutoCloseable's Exception).
     */
    @Override
    void close();

    /**
     * Executes a SQL command.
     *
     * @param sqlQuery the SQL command (with named parameters).
     * @param args     the arguments to substitute into the query.
     *
     * @return the number of rows affected by the command.
     *
     * @throws DatabaseException if the command fails.
     */
    int executeCommand( String sqlQuery, Map<String, Object> args );

    /**
     * Executes a task while a transaction is open for the connection.
     *
     * @param transactionalCallback the task to execute inside a transaction.
     */
    void executeInTransaction( ITransactionalCallback transactionalCallback );

    /**
     * Executes a single SQL select query. Calls a callback for each record found.
     *
     * @param queryCallback the callback function called with each record of the result.
     * @param sqlQuery      the text of the SQL query to execute.
     *
     * @throws DatabaseException if the query process fails.
     */
    void executeQuery( IQueryCallback queryCallback, String sqlQuery );

    /**
     * Interface for query result callbacks.
     */
    @FunctionalInterface
    interface IQueryCallback {

        /**
         * Callback receiving the result set for each row of a query.
         *
         * @param resultSet the result set on a given row.
         *
         * @throws DatabaseException if reading the result fails.
         */
        void handleRecord( IResultSet resultSet );

    }

    /**
     * Interface for transactional callbacks.
     */
    @FunctionalInterface
    interface ITransactionalCallback {

        /**
         * Callback occurring with a transaction open.
         *
         * @throws DatabaseException if the transactional task fails.
         */
        void execute();

    }

}