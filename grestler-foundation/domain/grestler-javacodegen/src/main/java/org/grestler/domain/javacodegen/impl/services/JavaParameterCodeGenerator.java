package org.grestler.domain.javacodegen.impl.services;

import org.grestler.domain.javacodegen.api.services.JavaCodeGenerator;
import org.grestler.domain.javamodel.api.elements.IJavaParameter;
import org.grestler.domain.javamodel.api.services.IJavaModelConsumerService;
import org.grestler.persistence.ioutilities.codegen.CodeWriter;

/**
 * Code generator for a Java parameter.
 */
public final class JavaParameterCodeGenerator
    extends JavaAnnotatableModelElementCodeGenerator
    implements IJavaModelConsumerService<IJavaParameter, CodeWriter> {

    private JavaParameterCodeGenerator() {
    }

    @SuppressWarnings( "ParameterNameDiffersFromOverriddenParameter" )
    @Override
    public void consume(
        IJavaParameter parameter, CodeWriter writer
    ) {

        this.writeAnnotations( parameter, writer, false );

        parameter.getType().consume( JavaCodeGenerator.INSTANCE, writer );

        writer.spaceOrWrap()
              .append( parameter.getJavaName() );

    }

    public static final JavaParameterCodeGenerator INSTANCE = new JavaParameterCodeGenerator();

}
