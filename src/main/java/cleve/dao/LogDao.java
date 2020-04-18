package cleve.dao;

import cleve.entity.Log;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * LogDao 提供关于借阅以及还书日志的操作接口
 */
@Repository
public interface LogDao {
    /**
     * 添加日志
     *
     * @param log 新增的日志
     */
    void addLog(Log log);

    /**
     * 删除日志
     *
     * @param log 删除日志
     */
    void deleteLog(Log log);


    /**
     * 更新日志信息
     *
     * @param log 需要更新的日志
     */
    void updateLog(Log log);

    /**
     *通过日志ID查找日志
     *
     * @param logID 日志ID
     * @return 日志列表
     */
    Log findLogByLogID(int logID);

    /**
     *通过用户ID查找日志
     *
     * @param userID 用户 ID
     * @return 日志列表
     */
    List<Log> findLogByUserID(int userID);

    /**
     *通过书籍ID查找日志
     *
     * @param bookID 书籍 ID
     * @return 日志列表
     */
    List<Log> findLogBybookID(String bookID);

    /**
     *通过状态sate查找日志
     *
     * @param sate 状态
     * @return 日志列表
     */
    List<Log> findLogBySate(int sate);

    /**
     *查找逾期日志
     *
     * @param
     * @return 日志列表
     */
    List<Log> getOverLog();

    /**
     *获取所有日志
     *
     * @param
     * @return 日志列表
     */
    List<Log> getAllLog();

}
