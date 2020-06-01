/**
 * @Author Ych
 * @Description ${entityComment}管理
 * @Date 
 */
@Controller
@RequestMapping("/${entityName}Manager")
@Validated
@Api(description = "权益管理-${entityComment}管理")
public class ${EntityName}Controller extends BaseController<${EntityName}Biz, ${EntityName}> {
    private Logger logger = LoggerFactory.getLogger(getClass());

    @ApiOperation(value = "查询",notes = "查询")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "Authorization", value = "token", dataType = "String", paramType = "header"),
            @ApiImplicitParam(name = "Content-Type", value = "application/json", dataType = "String", paramType = "header"),
            @ApiImplicitParam(name="${entityName}VO",value = "查询条件", paramType = "body" , dataType = "${EntityName}VO")})
    @RequestMapping(value = "/query" ,method = RequestMethod.POST)
    @ResponseBody
    public TableResultResponse<${EntityName}VO> queryByPage(@RequestBody ${EntityName}VO ${entityName}VO) throws Exception{
        return baseBiz.query(${entityName}VO);
    }

    @ApiOperation(value = "新增",notes = "新增")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "Authorization", value = "token", dataType = "String", paramType = "header"),
            @ApiImplicitParam(name = "Content-Type", value = "application/json", dataType = "String", paramType = "header"),
            @ApiImplicitParam(name="${entityName}",value = "实体参数", paramType = "body" , dataType = "${EntityName}")})
    @RequestMapping(value = "/save" ,method = RequestMethod.POST)
    @ResponseBody
    public MsgResponse save(@RequestBody ${EntityName} ${entityName}) throws Exception{
        baseBiz.save(${entityName});
        return MsgResponse.info("新增成功");
    }

    @ApiOperation(value = "修改",notes = "修改")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "Authorization", value = "token", dataType = "String", paramType = "header"),
            @ApiImplicitParam(name = "Content-Type", value = "application/json", dataType = "String", paramType = "header"),
            @ApiImplicitParam(name="${entityName}",value = "实体参数", paramType = "body" , dataType = "${EntityName}")})
    @RequestMapping(value = "/modify" ,method = RequestMethod.POST)
    @ResponseBody
    public MsgResponse modify(@RequestBody ${EntityName} ${entityName}) throws Exception{
        baseBiz.modify(${entityName});
        return MsgResponse.info("修改成功");
    }

    @ApiOperation(value = "删除",notes = "删除")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "Authorization", value = "token", dataType = "String", paramType = "header"),
            @ApiImplicitParam(name = "Content-Type", value = "application/json", dataType = "String", paramType = "header"),
            @ApiImplicitParam(name = "${entityName}",value = "实体参数",paramType = "body" ,dataType = "${EntityName}" )})
    @RequestMapping(value = "/remove" ,method = RequestMethod.POST)
    @ResponseBody
    public MsgResponse remove(@RequestBody ${EntityName} ${entityName}) throws Exception{
        baseBiz.removeById(${entityName}.getId());
        return MsgResponse.info("删除成功");
    }


    @ApiOperation(value = "导入",notes = "导入")
    @RequestMapping(value = "/importFile" ,method = RequestMethod.POST)
    @ApiImplicitParams({
            @ApiImplicitParam(name = "Authorization", value = "token", dataType = "String", paramType = "header"),
            @ApiImplicitParam(name = "Content-Type", value = "application/json", dataType = "String", paramType = "header"),
            @ApiImplicitParam(name="${entityName}",value = "查询条件", paramType = "body" , dataType = "${EntityName}")
})
    public void importFile(HttpServletRequest request, HttpServletResponse response,
                           @RequestBody ${EntityName} ${entityName}) throws Exception {
        // ExcelUtil.export(baseBiz.handleData(${entityName}), response);
    }

}