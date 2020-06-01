package org.ltsh.generator.amms.react;

import java.util.HashMap;
import java.util.Map;

import org.ltsh.core.core.db.jdbc.bean.DBTableColumn;
import org.ltsh.generator.amms.common.BaseTemplate;

public class ReactTemplate extends BaseTemplate{
	public static class DataKey{
		
		private String paramCode;
		private String type;
		private String data;
		
		public DataKey(String paramCode, String type, String data) {
			this.paramCode = paramCode;
			this.type = type;
			this.data = data;
		}
		public String getType() {
			return type;
		}
		public void setType(String type) {
			this.type = type;
		}
		public String getData() {
			return data;
		}
		public void setData(String data) {
			this.data = data;
		}
		public String getParamCode() {
			return paramCode;
		}
		public void setParamCode(String paramCode) {
			this.paramCode = paramCode;
		}
		
	}
	private Map<String, DataKey> dictMap = initDictMap();
	
	protected Map<String, DataKey> initDictMap(){
		Map<String, DataKey> rs = new HashMap<String, DataKey>();
		rs.put("brnNo", new DataKey("Const.DICT.BRANCH", "Const.ITEM_TYPE.TREE", "SimpleUtils.getBranchTree()"));
		rs.put("bbkNo", new DataKey("Const.DICT.BRANCH", "Const.ITEM_TYPE.DROPDOWN", "SimpleUtils.getBbkNoOptions()"));
		rs.put("belongNo", new DataKey("Const.DICT.BRANCH", "Const.ITEM_TYPE.DROPDOWN", "SimpleUtils.getBelongOptions()"));
		rs.put("userNo", new DataKey("Const.DICT.USER", "Const.ITEM_TYPE.DROPDOWN", "SystemData.getDictList(Const.DICT.USER)"));
		rs.put("prodType", new DataKey("'PRODTYPE'", "Const.ITEM_TYPE.DROPDOWN", "SystemData.getDictList('PRODTYPE')"));
		rs.put("prodCode", new DataKey("'PRODCODE'", "Const.ITEM_TYPE.DROPDOWN", "SystemData.getDictList('PRODCODE')"));
		rs.put("rcdStatus", new DataKey("'RCD_STATUS'", "Const.ITEM_TYPE.DROPDOWN", "SystemData.getDictList('RCD_STATUS')"));
		return rs;
	}
	
	public ReactTemplate(String rootPath, String packagePath) {
		super(rootPath, packagePath);
	}
	
	@Override
	protected Map<String, Object> getFieldList(DBTableColumn field) {
		Map<String, Object> rs = super.getFieldList(field);
		
		DataKey dictKey = dictMap.get(rs.get("fieldName"));
		rs.put("dictKey", dictKey == null ? null : dictKey);
		
		return rs;
	}

	@Override
	protected String getFileSuffix() {
		return ".js";
	}
}
