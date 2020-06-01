package org.ltsh.generator.amms.react;


public class ReactIndexTemplate extends ReactTemplate{

	public ReactIndexTemplate(String rootPath, String packagePath) {
		super(rootPath, packagePath);
	}

	@Override
	protected String getFileSuffix() {
		return "_index.js";
	}
}
