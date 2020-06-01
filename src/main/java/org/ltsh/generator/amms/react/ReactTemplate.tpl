url : BASE_URL + "/business/xxxxxx",
queryParam: {
    <#list fieldList as field>
    ${field.fieldName} : '',	//${field.fieldComment}
	</#list>
},
listColumns: [
<#list fieldList as field>
	{
        name: "${field.fieldName}",
        header: "${field.fieldComment}"
    <#if field.fieldJdbcType == 'INTEGER' || field.fieldJdbcType == 'DATETIME'>
	  	,content: function (item) {
            return UFormatter.formatTime(item.${field.fieldName});
        }
	<#elseif field.fieldJdbcType == 'DECIMAL'>
		,content: function (item) {
            return SimpleUtils.processDicimal(item.${field.fieldName});
        }
	<#elseif (field.dictKey)??>
	  	,content: function (item) {
            return SimpleUtils.formatDisplay(${field.dictKey.paramCode}, item.${field.fieldName});
        }
	<#else>
	</#if>
    },
</#list>
	{ 	
    	name: "option",
	    header: ColumnName.COLUMN_NAME.OPTION,
	    textAlign: "center",
	    content: function (item) {
	        return (
                <div>
                    <a href="javascript:void(0)" onClick={_this.showItem.bind(null, item)}>
                        {ColumnName.COLUMN_NAME.DETAIL}
                    </a>
                    <a href="javascript:void(0)" onClick={_this.deleteItem.bind(null, item)}>
                        {ColumnName.COLUMN_NAME.DELETE}
                    </a>
                    <a href="javascript:void(0)" onClick={_this.updateItem.bind(null, item)}>
                        {ColumnName.COLUMN_NAME.EDIT}
                    </a>
                </div>
            );
	    }
	}
],

detailColumns: [
<#list fieldList as field>
	{ name: "${field.fieldName}", header: "${field.fieldComment}", disabled : true
    <#if field.fieldJdbcType == 'int' || field.fieldJdbcType == 'datetime'>
	  	, type : Const.ITEM_TYPE.DATETIME
	<#elseif (field.dictKey)??>
	  	, type : Const.ITEM_TYPE.DROPDOWN, data : SystemData.getDictList(${field.dictKey.paramCode})
	</#if>
	 },
</#list>
],






<div className="content-body body-cell">
    <div className="search-layer">
        <label className="cell-title">筛选条件：</label>
        
    <#list fieldList as field>
    	<FormItem require={false} ref="formItem_${field.fieldName}">
    	
	    <#if field.fieldJdbcType == 'int' || field.fieldJdbcType == 'datetime'>
            <DatePicker
                format={StaticDics.FORMAT_PATTERN.SLASH}
                //startingTime={UFormatter.formatTime(DateUtils.getActDate())}
                curDate={this.state.queryParam.${field.fieldName}}
                onChange={this.onChangeQuery.bind(null, "${field.fieldName}", StaticDics.FORMAT_PATTERN.SLASH)}
                placeholder="请输入${field.fieldComment}">
            </DatePicker>
		<#elseif (field.dictKey)??>
			<SearchBox
                data={SystemData.getDictList(${field.dictKey.paramCode})}
                value={this.state.queryParam.${field.fieldName}}
                onChange={this.onChangeQuery.bind(null, "${field.fieldName}")}
                placeHolder="请输入${field.fieldComment}">
			</SearchBox>
		<#else>
			<Input value={this.state.queryParam.${field.fieldName}}
                onChange={this.onChangeQuery.bind(null, "${field.fieldName}")}
                placeHolder="请输入${field.fieldComment}">
            </Input>
		</#if>
		</FormItem>
	</#list>
        <div className="clear"></div>
        <div className="button-wrap">
            {this.state.perms.view ? <Button value="搜索" onClick={_this.query}></Button> : ""}
            {this.state.perms.view ? <Button value="清空" onClick={_this.clearSearch}></Button> : ""}
        </div>
        <div className="clear"></div>
    </div>
</div>
<div className="content-body">
    <TablePage ref="table"
               url={this.state.url}
               columns={this.state.columns}
               showCheckbox={false}></TablePage>
</div>