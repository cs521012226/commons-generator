select
<#list fieldList as field>
	a.${field.field_name},	/* ${field.fieldComment} */
</#list>
	a.*
from ${entity_name} a

where 1=1
<#list fieldList as field>
	and a.${field.field_name} = ''
</#list>
