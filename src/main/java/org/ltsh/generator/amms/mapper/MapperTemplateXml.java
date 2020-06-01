package org.ltsh.generator.amms.mapper;

import org.ltsh.generator.amms.common.BaseTemplate;

public class MapperTemplateXml extends BaseTemplate{
	
	public MapperTemplateXml(String rootPath, String packagePath) {
		super(rootPath, packagePath);
	}

	@Override
	protected String getFileSuffix() {
		return ".xml";
	}
}
