//
// (C) Copyright 2014-2015 Martin E. Nordberg III
// Apache 2.0 License
//

package org.grestler.metamodel.impl.elements

import org.grestler.metamodel.api.elements.IPackage
import org.grestler.utilities.uuids.Uuids
import spock.lang.Specification

/**
 * Specification for packages.
 */
class PackageSpec
        extends Specification {

    UUID id = Uuids.makeUuid();

    String name = "Example";

    def "A top level package is constructed and read"() {

        given:
        IPackage p = new RootPackage( id );

        expect:
        p.id == id;
        p.name == "\$";
        p.parentPackage == p;
        !p.isChildOf( p );

    }

    def "Package parents can be detected correctly"() {

        given:
        IPackage root = new RootPackage( id );
        IPackage p1 = new Package( id, root, name );
        IPackage p2 = new Package( id, p1, name );
        IPackage r = new Package( id, root, name );

        expect:
        p1.parentPackage == root;
        p1.isChildOf( root );
        !p1.isChildOf( p1 );
        p2.parentPackage == p1;
        p2.isChildOf( root );
        p2.isChildOf( p1 );
        !p2.isChildOf( p2 );
        !p1.isChildOf( p2 );
        !r.isChildOf( p1 );

    }

}