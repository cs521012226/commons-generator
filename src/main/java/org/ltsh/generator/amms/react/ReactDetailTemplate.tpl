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
    open(item){
        this.refs.form.setData(item);
        this.refs.layer.layerOpen();
    },
    close(){
        this.refs.layer.layerClose();
        this.refs.form.clearData();
    },
    render() {
        var _this = this;
        return (
            <Layer ref="layer" title="明细" closeBack={_this.close} overflow width={950}>
                <div className="form-layer">
                    <WgForm ref="form" columns={this.state.columns}></WgForm>
                </div>
                <div className="clearfix"></div>
            </Layer>
        )
    }
});
module.exports = Root;