/**
 * @Author Ych
 * @Description ${entityComment}管理
 * @Date 
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class ${EntityName}Biz extends BaseBiz<${EntityName}Mapper, ${EntityName}> {
    @Autowired
    private BaseAcctBiz baseAcctBiz;

    /**
     * 查询
     * @param vo
     * @return
     */
    public TableResultResponse<${EntityName}VO> query(${EntityName}VO ${entityName}VO){
        Page<Object> resultPage = PageHelper.startPage(${entityName}VO.getPage(), ${entityName}VO.getLimit());
        List<${EntityName}VO> list = mapper.query(${entityName}VO);
        return new TableResultResponse<${EntityName}VO>(resultPage.getTotal(), list);
    }

    /**
     * @Author Ych
     * @Description 保存
     */
    public ${EntityName} save(${EntityName} ${entityName}) throws Exception{
    	saveBefore(${entityName});
        mapper.insertSelective(${entityName});
        return ${entityName};
    }
    /**
     * @Author Ych
     * @Description 逻辑判断
     */
    public void saveBefore(${EntityName} ${entityName}){
    	
	<#list fieldList as field>
	    ${field.fieldJavaType} ${field.fieldName} = ${entityName}.get${field.FieldName}();	//${field.fieldComment}
	</#list>

	<#list fieldList as field>
		${entityName}.set${field.FieldName}(${field.fieldName});	//${field.fieldComment}
	</#list>
    }

    public void saveBatch(List<${EntityName}> list) throws Exception{

        for (${EntityName} vo : list) {
            saveBefore(vo);
        }
        int total = list.size();
        int pageSize = BusinessCommonConstant.OPENID_PHONE_NUM;;
        int pageIndex = 0;
        int pageLimit = pageIndex + pageSize;
        while(true){
            if(pageLimit >= total){
                mapper.saveBatch(list.subList(pageIndex, total));
                break;
            }
            mapper.saveBatch(list.subList(pageIndex, pageLimit));
            pageIndex = pageIndex + pageSize;
            pageLimit = pageIndex + pageSize;
        }
    }

    /**
     * @Author Ych
     * @Description 修改
     */
    public ${EntityName} modify(${EntityName} ${entityName}) throws Exception{
        ${EntityName} rs = mapper.selectByPrimaryKey(${entityName}.getId());
    <#list fieldList as field>
    	rs.set${field.FieldName}(${entityName}.get${field.FieldName}());	//${field.fieldComment}
	</#list>
        mapper.updateByPrimaryKey(rs);
        return rs;
    }

    /**
     * @Author Ych
     * @Description 删除
     * @Date 2020/5/8
     */
    public ${EntityName} removeById(Integer id) throws Exception{
        ${EntityName} ${entityName} = mapper.selectByPrimaryKey(id);
        mapper.deleteByPrimaryKey(id);
        return ${entityName};
    }




}