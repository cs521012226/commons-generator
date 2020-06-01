var App = require('../common/app');
var BreadCrumb = require('../../src/base/breadcrumb');

var Button = require('../../src/base/button');
var Toast = require('../../src/base/toast');
var Layer = require("../../src/complex/layer");
var Alert = require("../../src/complex/alert/index");
var WgTable = require("../../src/complex/table-page");
var WgForm = require("../../src/complex/wg-form");

var Const = require('../common/utils/const');
var SeaFood = require('../common/utils/localstorage');
var ColumnName = require("../common/utils/column-const");
var SimpleUtils = require("../common/utils/utils");
var DateUtils = require("../common/utils/date-utils");
var SimpleApi = require("../common/utils/api-utils");
var SystemData = require("../common/utils/system-data");

var Root = React.createClass({
    getInitialState() {
        var _this = this;
        var state = {
            columns : [
            <#list fieldList as field>
				{
			        name: "${field.fieldName}",
			        header: "${field.fieldComment}"
			    <#if field.fieldJdbcType == 'INTEGER' || field.fieldJdbcType == 'DATETIME'>
				  	,type : Const.ITEM_TYPE.DATETIME
				<#elseif field.fieldJdbcType == 'DECIMAL'>
					
				<#elseif (field.dictKey)??>
					, type : Const.ITEM_TYPE.DROPDOWN, data : SystemData.getDictList(${field.dictKey.paramCode})
				<#else>
				</#if>
			    },
			</#list>
            ],
        };
        return state;
    },
    open(item, submitType){
        if(!item){
            item = {
                //updType : '10',
                //updMode : '11',
            };
        }
        var form = this.refs.form, disabled = false, hide = false;
        this.state.submitType = submitType;
        if(submitType == ColumnName.COLUMN_NAME.CREATE){
            disabled = false;
            hide = false;
        }else if(submitType == ColumnName.COLUMN_NAME.EDIT){
            disabled = true;
            hide = true;
        }
        form.setData(item);
        form.setDisabled('prodCode', 'richNo', disabled);
        form.setHide('rcdStatus', hide);
        this.refs.layer.layerOpen();
    },
    close(){
        this.refs.layer.layerClose();
        this.refs.form.clearData();
    },
    submitConfirm(){
        var form = this.refs.form;
        if(!form.validate()){
            return ;
        }
        this.refs.alert.showAlert("确定要提交吗？", this.submit);
    },
    submit(){
        var _this = this;
        var item = this.refs.form.getData();
        var submitType = this.state.submitType;
        var url = BASE_URL + "/business/${entityName}Manager/";
        url = submitType == ColumnName.COLUMN_NAME.CREATE ? url + 'save' : url + 'modify';

        Ajax.post({
            url: url,
            contentType: 'application/json',
            data : item,
            success: function (res) {
                if (res.status == 200) {
                    Toast.info({
                        content: Const.CONSTANT_MSG.OPERATION_SUCCESS,
                        duration: Const.IMPORT_DEFAULT_FAIL_SHOW_SECONDS
                    })
                    _this.close();
                    _this.props.onSubmit && _this.props.onSubmit(item);
                } else {
                    Toast.info({
                        content: res.message,
                        duration: Const.IMPORT_DEFAULT_FAIL_SHOW_SECONDS
                    })
                }
            },
        });
    },
    render() {
        var _this = this;
        return (
            <div>
            <Layer ref="layer" title={_this.props.title} closeBack={_this.close} overflow width={950} height={600}>
                <div className="form-layer">
                    <WgForm ref="form" columns={this.state.columns}></WgForm>
                </div>
                <div className="clearfix"></div>
                <div className="button-wrap">
                    <Button value="取消" className="btn-general" onClick={_this.close}></Button>
                    <Button value="提交" onClick={_this.submitConfirm}></Button>
                </div>

            </Layer>
            <Alert ref="alert"/>
            </div>
        )
    }
});
module.exports = Root;