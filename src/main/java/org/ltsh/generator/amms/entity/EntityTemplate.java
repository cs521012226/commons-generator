package org.ltsh.generator.amms.entity;

import org.ltsh.generator.amms.common.BaseTemplate;

public class EntityTemplate extends BaseTemplate{
	
	public EntityTemplate(String rootPath, String packagePath) {
		super(rootPath, packagePath);
	}

	@Override
	protected String getFileSuffix() {
		return ".java";
	}

}
