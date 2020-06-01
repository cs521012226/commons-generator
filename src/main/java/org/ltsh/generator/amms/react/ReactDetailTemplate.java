package org.ltsh.generator.amms.react;


public class ReactDetailTemplate extends ReactTemplate{

	public ReactDetailTemplate(String rootPath, String packagePath) {
		super(rootPath, packagePath);
	}
	
	@Override
	protected String getFileSuffix() {
		return "_detail.js";
	}
}
