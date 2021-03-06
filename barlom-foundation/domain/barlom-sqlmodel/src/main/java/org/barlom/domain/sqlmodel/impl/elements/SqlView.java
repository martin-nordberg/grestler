//
// (C) Copyright 2015 Martin E. Nordberg III
// Apache 2.0 License
//

package org.barlom.domain.sqlmodel.impl.elements;

import org.barlom.domain.sqlmodel.api.elements.ISqlView;

/**
 * A database view.
 */
public class SqlView
    extends SqlRelation
    implements ISqlView {

    /**
     * Constructs a new view.
     *
     * @param parent the parent domain.
     * @param name   the name of the new view.
     */
    SqlView( SqlSchema parent, String name, String description ) {
        super( parent, name, description );

        parent.onAddChild( this );
    }

    @Override
    public String getSqlName() {
        return SqlNamedModelElement.makeSqlName( "V", this.getName() );
    }

}
