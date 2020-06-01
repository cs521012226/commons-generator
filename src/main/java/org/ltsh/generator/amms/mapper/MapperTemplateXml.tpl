<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd" >
<mapper namespace="xxxxxx.${EntityName}Mapper" >

    <resultMap id="${entityName}VO" type="xxxxxx.${EntityName}VO">
    	<#list fieldList as field>
			<result column="${field.field_name}" property="${field.fieldName}" jdbcType="${field.fieldJdbcType}"/>		<!--${field.fieldComment} -->
		</#list>
    </resultMap>

    <!--List<${EntityName}> query(@Param("param") ${EntityName} param);-->
    <select id="query" resultMap="${entityName}VO">
        select  
		<#list fieldList as field>
			<#if field_index != 0>,</#if>a.${field.field_name}	<!--${field.fieldComment} -->
		</#list>
		from ${entity_name} a
        <where>
        <#list fieldList as field>
             <if test="param.${field.fieldName} != null and param.${field.fieldName} != ''">	<!--${field.fieldComment} -->
                and a.${field.field_name} = <#noparse>#{</#noparse>param.${field.fieldName}<#noparse>}</#noparse>
            </if>
        </#list>
        </where>
    </select>
    
    
    <!--List<${EntityName}> save(@Param("param") ${EntityName} param);-->
    <insert id="save" >
        insert into  ${entity_name}( 
		<#list fieldList as field>
			<#if field_index != 0>,</#if>${field.field_name}	<!--${field.fieldComment} -->
		</#list>
		) values
		(
		<#list fieldList as field>
			<#if field_index != 0>,</#if><#noparse>#{</#noparse>param.${field.fieldName}, jdbcType=${field.fieldJdbcType}<#noparse>}</#noparse>
		</#list>
        )
    </insert>
    
    <!--List<${EntityName}> saveBatch(List<${EntityName}> param);-->
    <insert id="saveBatch" >
        insert into  ${entity_name}( 
		<#list fieldList as field>
			<#if field_index != 0>,</#if>${field.field_name}	<!--${field.fieldComment} -->
		</#list>
		) values
		<foreach collection="list" item="item" separator=",">
            (
			<#list fieldList as field>
			<#if field_index != 0>,</#if><#noparse>#{</#noparse>item.${field.fieldName}, jdbcType=${field.fieldJdbcType}<#noparse>}</#noparse>
			</#list>
	        )
        </foreach>
    </insert>

</mapper>
