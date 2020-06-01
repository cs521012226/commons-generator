package org.ltsh.generator.amms.sql;

import org.ltsh.generator.amms.common.BaseTemplate;

public class SqlTemplate extends BaseTemplate{
	
	public SqlTemplate(String rootPath, String packagePath) {
		super(rootPath, packagePath);
	}
	
	@Override
	protected String getFileSuffix() {
		return ".sql";
	}
}
