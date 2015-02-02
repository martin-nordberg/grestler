//
// (C) Copyright 2015 Martin E. Nordberg III
// Apache 2.0 License
//

package org.grestler.metamodel.api;

import java.util.UUID;

/**
 * Interface to a command that changes some element of a metamodel.
 */
public interface IMetamodelCommand {

    /**
     * Executes this command.
     */
    void execute();

    /**
     * @return the unique ID of this command.
     */
    UUID getId();

    // TODO: undo (by creating a new command)

}
