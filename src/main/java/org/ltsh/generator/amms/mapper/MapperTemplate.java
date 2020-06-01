package org.ltsh.generator.amms.mapper;

import org.ltsh.generator.amms.common.BaseTemplate;

public class MapperTemplate extends BaseTemplate{
	
	public MapperTemplate(String rootPath, String packagePath) {
		super(rootPath, packagePath);
	}

	@Override
	protected String getFileSuffix() {
		return "Mapper.java";
	}
}
