package ${packagePath};

import java.util.Date;


/**
 * @author ych
 * ${entityComment}
 */
public class ${EntityName}VO extends ${EntityName} {

	@ApiModelProperty(value = "当前页")
    private Integer page;
    @ApiModelProperty(value = "显示条数")
    private Integer limit;

	@Override
	public String toString() {
		return JSON.toJSONString(this);
	}
	
    public Integer getPage() {
        return page;
    }

    public void setPage(Integer page) {
        this.page = page;
    }

    public Integer getLimit() {
        return limit;
    }

    public void setLimit(Integer limit) {
        this.limit = limit;
    }
}
