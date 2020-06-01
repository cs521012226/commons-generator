package org.ltsh.generator.amms.controller;

import org.ltsh.generator.amms.common.BaseTemplate;

public class ControllerTemplate extends BaseTemplate{
	
	public ControllerTemplate(String rootPath, String packagePath) {
		super(rootPath, packagePath);
	}
	
	@Override
	protected String getFileSuffix() {
		return "Controller.java";
	}
}
