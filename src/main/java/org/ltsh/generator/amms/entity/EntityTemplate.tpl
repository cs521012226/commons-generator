package ${packagePath};

import io.swagger.annotations.ApiModelProperty;

import javax.persistence.Column;
import javax.persistence.Table;
import java.util.Date;


/**
 * @author ych
 * ${entityComment}
 */
@Table(name = "${entity_name}")
public class ${EntityName} {
    
<#list fieldList as field>
	/**
     * ${field.fieldComment}
     */
    @ApiModelProperty(value = "${field.fieldComment}")
    @Column(name = "${field.field_name}")
    private ${field.fieldJavaType} ${field.fieldName};
</#list>

<#list fieldList as field>
	/**
	*	${field.fieldComment}
	*/
	public void set${field.FieldName}(${field.fieldJavaType} ${field.fieldName}){
		this.${field.fieldName} = ${field.fieldName};
	}
	/**
	*	${field.fieldComment}
	*/
	public ${field.fieldJavaType} get${field.FieldName}(){
		return ${field.fieldName};
	}
</#list>

	@Override
	public String toString() {
		return JSON.toJSONString(this);
	}
}
