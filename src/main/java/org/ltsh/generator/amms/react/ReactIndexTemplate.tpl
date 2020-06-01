var App = require('../common/app');
var BreadCrumb = require('../../src/base/breadcrumb');

var Button = require('../../src/base/button');
var Toast = require('../../src/base/toast');
var Layer = require("../../src/complex/layer");
var Alert = require("../../src/complex/alert/index");
var WgTable = require("../../src/complex/table-page");
var WgForm = require("../../src/complex/wg-form");
var TaskButton = require('../common/button/task-button');

var Const = require('../common/utils/const');
var SeaFood = require('../common/utils/localstorage');
var ColumnName = require("../common/utils/column-const");
var SimpleUtils = require("../common/utils/utils");
var DateUtils = require("../common/utils/date-utils");
var SimpleApi = require("../common/utils/api-utils");
var SystemData = require("../common/utils/system-data");

var DetailLayer = require("./detail");
var UpdateLayer = require("./update");
var UploadLayer = require("./upload");

// var actDate = DateUtils.getActDate();

var Root = React.createClass({
    getInitialState() {
        var _this = this;
        var state = {
            permission : {
	            // query: SeaFood.checkElementByCode('${entityName}Manager:query'),
	            // create: SeaFood.checkElementByCode('${entityName}Manager:create'),
	            // modify: SeaFood.checkElementByCode('${entityName}Manager:modify'),
	            // remove: SeaFood.checkElementByCode('${entityName}Manager:remove'),
	            // importFile: SeaFood.checkElementByCode('${entityName}Manager:importFile'),
	            // exportFile: SeaFood.checkElementByCode('${entityName}Manager:exportFile'),
	            query: true,
	            create: true,
	            modify: true,
	            remove: true,
	            importFile: true,
	            exportFile: false,
	        },
            url : BASE_URL + "/business/${entityName}Manager/query",
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
                                {_this.state.permission.modify ?
                                    <a href="javascript:void(0)" onClick={_this.updateItemConfirm.bind(null, item, ColumnName.COLUMN_NAME.EDIT)}>
                                        {ColumnName.COLUMN_NAME.EDIT}
                                    </a> : ''
                                }
                                {_this.state.permission.remove ?
                                    <a href="javascript:void(0)" onClick={_this.deleteItemConfirm.bind(null, item)}>
                                        {ColumnName.COLUMN_NAME.DELETE}
                                    </a> : ''
                                }
                                {_this.state.permission.query ?
                                    <a href="javascript:void(0)" onClick={_this.showDetail.bind(null, item)}>
                                        {ColumnName.COLUMN_NAME.DETAIL}
                                    </a> : ''
                                }
                            </div>
                        );
                    }
                }
            ],
            searchColumns : [
        	<#list fieldList as field>
				{
			        name: "${field.fieldName}",
			        header: "${field.fieldComment}"
			    <#if field.fieldJdbcType == 'INTEGER' || field.fieldJdbcType == 'DATETIME'>
				  	,type : Const.ITEM_TYPE.DATETIME
				<#elseif field.fieldJdbcType == 'DECIMAL'>
					
				<#elseif (field.dictKey)??>
					, type : ${field.dictKey.type}, data : ${field.dictKey.data}
				<#else>
				</#if>
			    },
			</#list>
            ]
        };
        return state;
    },
    query(){
        var form = this.refs.searchForm;
        var table = this.refs.table;
        if(form.validate()){
            table.query(form.getData());
        }
    },
    getQueryParam(){
        return this.refs.searchForm.getData();
    },
    clear(){
        this.refs.searchForm.clearData();
    },
    showDetail(item){
        this.refs.detailLayer.open(item);
    },
    updateItemConfirm(item, submitType){
        var updateLayer = this.refs.updateLayer;
        this.setState({
            submitType: submitType
        }, function () {
            updateLayer.open(item, submitType);
        })
    },
    onLoad(item){
        this.query();
    },
    deleteItemConfirm(item){
        this.refs.alert.showAlert("确定要删除吗？", this.deleteItem.bind(null, item));
    },
    deleteItem(item){
        var _this = this;
        var url = BASE_URL + "/business/${entityName}Manager/remove";
        Ajax.post({
            url: url,
            data : item,
            success: function (res) {
                if (res.status == 200) {
                    Toast.info({
                        content: Const.CONSTANT_MSG.OPERATION_SUCCESS,
                        duration: Const.IMPORT_DEFAULT_FAIL_SHOW_SECONDS
                    })
                    _this.query();
                } else {
                    Toast.info({
                        content: res.message,
                        duration: Const.IMPORT_DEFAULT_FAIL_SHOW_SECONDS
                    })
                }
            },
        });
    },
    importConfirm(){
        this.refs.uploadLayer.open();
    },
    componentWillMount() {
    },
    render() {
        var _this = this;
        return (
            <div className="account-date-manager">
                <BreadCrumb>
                    <BreadCrumb.Item href="../index/index.html">首页</BreadCrumb.Item>
                    <BreadCrumb.Item>${entityComment}管理</BreadCrumb.Item>
                    <BreadCrumb.Item>${entityComment}管理</BreadCrumb.Item>
                </BreadCrumb>
                <div className="content-body body-cell">
                    <div className="search-layer">
                        <label className="cell-title">筛选条件：</label>
                        <WgForm ref="searchForm" showLabel={false} columns={this.state.searchColumns}/>
                        <div className="clear"></div>
                        <div className="button-wrap">
                            <Button value="搜索" onClick={this.query}></Button>
                            <Button value="清空" onClick={this.clear}></Button>
                            {this.state.permission.create ? <Button value="新增" onClick={this.updateItemConfirm.bind(null, null, ColumnName.COLUMN_NAME.CREATE)}></Button> : ''}
                            {this.state.permission.importFile ? <Button value="导入" onClick={this.importConfirm}></Button> : ''}
                            {this.state.permission.exportFile ?
                                <TaskButton name="导出"
                                            channel="report"
                                            common="${entityName}Export"
                                            params={this.getQueryParam}></TaskButton> : ''}
                        </div>
                        <div className="clear"></div>
                    </div>
                </div>
                <div className="content-body">
                    <WgTable ref="table"
                               url={this.state.url}
                               columns={this.state.listColumns}></WgTable>
                </div>
                <Alert ref="alert"/>

                <DetailLayer ref="detailLayer"></DetailLayer>
                <UpdateLayer ref="updateLayer" title={this.state.submitType} onSubmit={this.onLoad}></UpdateLayer>
                <UploadLayer ref="uploadLayer"
                             name="${entityComment}导入"
                             templateName="${entityName}"
                             channel="business"
                             common="${entityName}Import"></UploadLayer>
            </div>
        )
    }
});

ReactDOM.render(<App url="${entityName}Manager" title="${entityComment}管理"><Root /></App>, document.getElementById('merry'));