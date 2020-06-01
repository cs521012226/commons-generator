package org.ltsh.generator.amms.startup;

import java.io.File;
import java.io.FileFilter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.ltsh.core.codeutil.mvc.TemplateBuilder;
import org.ltsh.core.core.db.jdbc.table.MysqlTableInfo;
import org.ltsh.core.core.util.StringUtil;
import org.ltsh.generator.amms.controller.ControllerTemplate;
import org.ltsh.generator.amms.entity.EntityTemplate;
import org.ltsh.generator.amms.entity.GetterSetterTemplate;
import org.ltsh.generator.amms.mapper.MapperTemplate;
import org.ltsh.generator.amms.mapper.MapperTemplateXml;
import org.ltsh.generator.amms.react.ReactDetailTemplate;
import org.ltsh.generator.amms.react.ReactIndexTemplate;
import org.ltsh.generator.amms.react.ReactTemplate;
import org.ltsh.generator.amms.react.ReactUpdateTemplate;
import org.ltsh.generator.amms.service.ServiceTemplate;
import org.ltsh.generator.amms.sql.SqlTemplate;
import org.ltsh.generator.amms.vo.EntityVoTemplate;

/**
 * 代码生成器
 * @author Ych
 */
public class CodeGenarate {

	public static void main(String[] args) throws SQLException {
		
		//源码生成位置的根路径
		final String SRC_ROOT_PATH = "G:\\DEV\\Company\\YingTong\\HePing\\PMS_客户经理管理系统\\代码生成";

		//Mysql表信息实现
		MysqlTableInfo tableInfo = new MysqlTableInfo("11.8.131.124", 3306, "amms", "amms", "amms");
		
		List<String> tables = new ArrayList<String>();
		tables.add("pd_agent_trans");
		tables.add("pd_prod_dist");
		tables.add("pd_base_acct");
		tables.add("pr_upd_acct");
		tables.add("pd_prod_fee_dtl");
		tables.add("pd_prod_fee");
		tables.add("pd_clt_fund");
		tables.add("pd_clt_fin");
		tables.add("gd_grade");
		tables.add("gd_grade_prof");
		
		tableInfo.setTableNamePattern(StringUtil.join(",", tables));	//设置要生成的表实体、支持正则表达式
		
		List<TemplateBuilder> builder = new ArrayList<TemplateBuilder>();
		
		//添加到生成列表
		builder.add(new ControllerTemplate(SRC_ROOT_PATH, "controller"));
		builder.add(new ServiceTemplate(SRC_ROOT_PATH, "service"));
		builder.add(new EntityTemplate(SRC_ROOT_PATH, "entity"));
		builder.add(new EntityVoTemplate(SRC_ROOT_PATH, "vo"));
		
//		builder.add(new ReactTemplate(SRC_ROOT_PATH, "react"));
		builder.add(new ReactIndexTemplate(SRC_ROOT_PATH, "react"));
		builder.add(new ReactUpdateTemplate(SRC_ROOT_PATH, "react"));
		builder.add(new ReactDetailTemplate(SRC_ROOT_PATH, "react"));
		
		builder.add(new MapperTemplate(SRC_ROOT_PATH, "mapper"));
		builder.add(new MapperTemplateXml(SRC_ROOT_PATH, "mapper"));
		builder.add(new SqlTemplate(SRC_ROOT_PATH, "sql"));
		builder.add(new GetterSetterTemplate(SRC_ROOT_PATH, "getterSetter"));
		
		//执行生成列表
		for(TemplateBuilder b : builder){
			//设置是否覆盖文件
			b.setFileFilter(new FileFilter() {
				@Override
				public boolean accept(File pathname) {
					return true;
				}
			});
			//设置表信息实体（必须）
			b.setTableInfo(tableInfo);
			//生成源码
			b.create();
		}
	}

}
