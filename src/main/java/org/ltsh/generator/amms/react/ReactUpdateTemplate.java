package org.ltsh.generator.amms.react;


public class ReactUpdateTemplate extends ReactTemplate{

	public ReactUpdateTemplate(String rootPath, String packagePath) {
		super(rootPath, packagePath);
	}

	@Override
	protected String getFileSuffix() {
		return "_update.js";
	}
}
