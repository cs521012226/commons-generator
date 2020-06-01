package org.ltsh.generator.amms.vo;

import org.ltsh.generator.amms.common.BaseTemplate;

public class EntityVoTemplate extends BaseTemplate{
	
	public EntityVoTemplate(String rootPath, String packagePath) {
		super(rootPath, packagePath);
	}
	
	@Override
	protected String getFileSuffix() {
		return "VO.java";
	}
}
