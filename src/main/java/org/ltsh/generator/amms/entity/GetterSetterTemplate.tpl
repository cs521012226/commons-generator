${EntityName} ${entityName} = new ${EntityName}();
<#list fieldList as field>
${entityName}.set${field.FieldName}(${field.fieldName});	//${field.fieldComment}
</#list>


<#list fieldList as field>
${field.fieldJavaType} ${field.fieldName} = ${entityName}.get${field.FieldName}();	//${field.fieldComment}
</#list>
