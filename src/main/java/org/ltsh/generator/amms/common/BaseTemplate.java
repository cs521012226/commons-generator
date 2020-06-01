package org.ltsh.generator.amms.common;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.ltsh.core.codeutil.mvc.TemplateBuilder;
import org.ltsh.core.core.db.jdbc.bean.DBTable;
import org.ltsh.core.core.db.jdbc.bean.DBTableColumn;
import org.ltsh.core.core.util.DateUtil;
import org.ltsh.core.core.util.StringUtil;

public abstract class BaseTemplate extends TemplateBuilder{
	
	public BaseTemplate(String rootPath, String packagePath) {
		super(rootPath, packagePath);
	}
	
	@Override
	public Object getModel(DBTable table) {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		for(DBTableColumn f : table.getColumns()){
			list.add(getFieldList(f));
		}
		Map<String, Object> cur = new HashMap<String, Object>();
		cur.put("packagePath", pathToPackage(getSubPath()));
		cur.put("dirPath", packageToPath(getSubPath()));
		
		String tableName = table.getTableName().toLowerCase();		//先统一转为小写
		String entityName = StringUtil.underlineToCamelCase(tableName);	//转驼峰写法
		String entityNameCap = StringUtil.firstCharToUpperCase(entityName);		//首字母转大写
		
		cur.put("entity_name", tableName);
		cur.put("entityName", entityName);
		cur.put("EntityName", entityNameCap);
		cur.put("ENTITY_NAME", tableName.toUpperCase());
		cur.put("entityComment", table.getTableComment().trim().replaceAll("\\s+", " "));
		cur.put("date", DateUtil.convertDateToString(new Date()));
		
		cur.put("fieldList", list);
		
		return cur;
	}
	
	
	protected Map<String, Object> getFieldList(DBTableColumn field) {
		String columnName = field.getColumnName().toLowerCase();		//先统一转为小写
		String fieldName = StringUtil.underlineToCamelCase(columnName);		//转驼峰写法
		String fieldNameCap = StringUtil.firstCharToUpperCase(fieldName);	//首字母大写
		
		Map<String, Object> fieldInfo = new HashMap<String, Object>();
		fieldInfo.put("field_name", columnName);
		fieldInfo.put("fieldName", fieldName);
		fieldInfo.put("FieldName", fieldNameCap);
		fieldInfo.put("FIELD_NAME", columnName.toUpperCase());
		
		fieldInfo.put("fieldJavaType", getTableInfo().dataTypeMapper(field));
		fieldInfo.put("fieldJdbcType", getTableInfo().jdbcTypeMapper(field));
		fieldInfo.put("fieldComment", field.getComment().trim().replaceAll("\\s+", " "));
		
		return fieldInfo;
	}
	
	@Override
	public String getTargetFileName(DBTable table) {
		return table.getTableComment() + "_" + getEntityNameCap(table) + getFileSuffix();
	}
	
	protected String getFileSuffix(){
		return ".tpl";
	}
	
	protected String getEntityNameCap(DBTable table){
		String entityName = table.getTableName().toLowerCase();		//先统一转为小写
		entityName = StringUtil.underlineToCamelCase(entityName);	//先转驼峰写法
		entityName = StringUtil.firstCharToUpperCase(entityName);		//首字母转大写
		return entityName;
	}
}
