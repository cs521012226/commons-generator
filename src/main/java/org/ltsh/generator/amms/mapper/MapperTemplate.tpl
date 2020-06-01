/**
 * @Author Ych
 * @Description ${entityComment}
 * @Date ${date}
 */
public interface ${EntityName}Mapper extends Mapper<${EntityName}> {
    List<${EntityName}VO> query(@Param("param") ${EntityName}VO param);

    void saveBatch(List<${EntityName}> list);
}