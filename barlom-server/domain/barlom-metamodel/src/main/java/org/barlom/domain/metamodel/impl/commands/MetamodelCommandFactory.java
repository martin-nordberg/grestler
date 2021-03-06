//
// (C) Copyright 2015 Martin E. Nordberg III
// Apache 2.0 License
//

package org.barlom.domain.metamodel.impl.commands;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.barlom.domain.metamodel.api.commands.IMetamodelCommand;
import org.barlom.domain.metamodel.api.commands.IMetamodelCommandFactory;
import org.barlom.domain.metamodel.api.exceptions.MetamodelException;
import org.barlom.domain.metamodel.spi.commands.DirectedEdgeTypeCreationCmdRecord;
import org.barlom.domain.metamodel.spi.commands.EdgeTypeAbstractnessChangeCmdRecord;
import org.barlom.domain.metamodel.spi.commands.EdgeTypeCyclicityChangeCmdRecord;
import org.barlom.domain.metamodel.spi.commands.EdgeTypeMultiEdgednessChangeCmdRecord;
import org.barlom.domain.metamodel.spi.commands.EdgeTypeSelfLoopingChangeCmdRecord;
import org.barlom.domain.metamodel.spi.commands.IMetamodelCommandSpi;
import org.barlom.domain.metamodel.spi.commands.IMetamodelCommandWriter;
import org.barlom.domain.metamodel.spi.commands.IMetamodelCommandWriterFactory;
import org.barlom.domain.metamodel.spi.commands.NamedElementNameChangeCmdRecord;
import org.barlom.domain.metamodel.spi.commands.PackageCreationCmdRecord;
import org.barlom.domain.metamodel.spi.commands.UndirectedEdgeTypeCreationCmdRecord;
import org.barlom.domain.metamodel.spi.commands.VertexTypeAbstractnessChangeCmdRecord;
import org.barlom.domain.metamodel.spi.commands.VertexTypeCreationCmdRecord;
import org.barlom.domain.metamodel.spi.commands.VertexTypeSuperTypeChangeCmdRecord;
import org.barlom.domain.metamodel.spi.queries.IMetamodelRepositorySpi;

/**
 * Factory for metamodel commands.
 */
public class MetamodelCommandFactory
    implements IMetamodelCommandFactory {

    /**
     * Constructs a new factory for creating metamodel commands.
     *
     * @param metamodelRepository the metamodel repository the commands will act upon.
     */
    public MetamodelCommandFactory(
        IMetamodelRepositorySpi metamodelRepository, IMetamodelCommandWriterFactory cmdWriterFactory
    ) {
        this.metamodelRepository = metamodelRepository;
        this.cmdWriterFactory = cmdWriterFactory;
    }

    @SuppressWarnings( "unchecked" )
    @Override
    public IMetamodelCommand makeCommand( String commandTypeName ) {

        IMetamodelCommandWriter<? extends IMetamodelCommandSpi.CmdRecord> cmdWriter = this.cmdWriterFactory.makeCommandWriter(
            commandTypeName
        );

        switch ( commandTypeName.toLowerCase() ) {
            case "directededgetypecreation":
                return new DirectedEdgeTypeCreationCmd(
                    this.metamodelRepository, (IMetamodelCommandWriter<DirectedEdgeTypeCreationCmdRecord>) cmdWriter
                );
            case "edgetypeabstractnesschange":
                return new EdgeTypeAbstractnessChangeCmd(
                    this.metamodelRepository, (IMetamodelCommandWriter<EdgeTypeAbstractnessChangeCmdRecord>) cmdWriter
                );
            case "edgetypecyclicitychange":
                return new EdgeTypeCyclicityChangeCmd(
                    this.metamodelRepository, (IMetamodelCommandWriter<EdgeTypeCyclicityChangeCmdRecord>) cmdWriter
                );
            case "edgetypemultiedgednesschange":
                return new EdgeTypeMultiEdgednessChangeCmd(
                    this.metamodelRepository, (IMetamodelCommandWriter<EdgeTypeMultiEdgednessChangeCmdRecord>) cmdWriter
                );
            case "edgetypeselfloopingchange":
                return new EdgeTypeSelfLoopingChangeCmd(
                    this.metamodelRepository, (IMetamodelCommandWriter<EdgeTypeSelfLoopingChangeCmdRecord>) cmdWriter
                );
            case "packagecreation":
                return new PackageCreationCmd(
                    this.metamodelRepository, (IMetamodelCommandWriter<PackageCreationCmdRecord>) cmdWriter
                );
            case "packagedelementnamechange":
                return new PackagedElementNameChangeCmd(
                    this.metamodelRepository, (IMetamodelCommandWriter<NamedElementNameChangeCmdRecord>) cmdWriter
                );
            case "undirectededgetypecreation":
                return new UndirectedEdgeTypeCreationCmd(
                    this.metamodelRepository, (IMetamodelCommandWriter<UndirectedEdgeTypeCreationCmdRecord>) cmdWriter
                );
            case "vertextypeabstractnesschange":
                return new VertexTypeAbstractnessChangeCmd(
                    this.metamodelRepository, (IMetamodelCommandWriter<VertexTypeAbstractnessChangeCmdRecord>) cmdWriter
                );
            case "vertextypecreation":
                return new VertexTypeCreationCmd(
                    this.metamodelRepository, (IMetamodelCommandWriter<VertexTypeCreationCmdRecord>) cmdWriter
                );
            case "vertextypesupertypechange":
                return new VertexTypeSuperTypeChangeCmd(
                    this.metamodelRepository, (IMetamodelCommandWriter<VertexTypeSuperTypeChangeCmdRecord>) cmdWriter
                );
            default:
                throw new MetamodelException(
                    MetamodelCommandFactory.LOG, "Unknown command type: \"" + commandTypeName + "\"."
                );
        }

    }

    /** The logger for this class. */
    private static final Logger LOG = LogManager.getLogger();

    /** Factory to create the writers needed for commands. */
    private final IMetamodelCommandWriterFactory cmdWriterFactory;

    /** The data source the commands made by this factory will make use of. */
    private final IMetamodelRepositorySpi metamodelRepository;

}
