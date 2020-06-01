package org.ltsh.generator.amms.service;

import org.ltsh.generator.amms.common.BaseTemplate;

public class ServiceTemplate extends BaseTemplate{
	
	public ServiceTemplate(String rootPath, String packagePath) {
		super(rootPath, packagePath);
	}

	
	@Override
	protected String getFileSuffix() {
		return "Biz.java";
	}
}
