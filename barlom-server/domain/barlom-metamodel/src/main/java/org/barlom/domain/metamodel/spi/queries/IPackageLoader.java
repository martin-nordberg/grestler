//
// (C) Copyright 2014 Martin E. Nordberg III
// Apache 2.0 License
//

package org.barlom.domain.metamodel.spi.queries;

/**
 * Interface defining package queries.
 */
@FunctionalInterface
public interface IPackageLoader {

    /**
     * Loads all packages into the metamodel repository.
     *
     * @param repository the repository to be loaded.
     */
    void loadAllPackages( IMetamodelRepositorySpi repository );

}
