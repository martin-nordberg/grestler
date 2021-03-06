//
// (C) Copyright 2015 Martin E. Nordberg III
// Apache 2.0 License
//

package org.barlom.domain.metamodel.spi.commands;

import org.barlom.domain.metamodel.api.elements.EAbstractness;

import javax.json.JsonObject;
import java.util.UUID;

/**
 * Attributes of a vertex type abstractness change command.
 */
public class VertexTypeAbstractnessChangeCmdRecord
    extends IMetamodelCommandSpi.CmdRecord {

    public VertexTypeAbstractnessChangeCmdRecord( JsonObject jsonCmdArgs ) {
        super( jsonCmdArgs );
        this.id = UUID.fromString( jsonCmdArgs.getString( "id" ) );
        this.abstractness = EAbstractness.valueOf( jsonCmdArgs.getString( "abstractness" ) );
    }

    public final EAbstractness abstractness;

    public final UUID id;

}
