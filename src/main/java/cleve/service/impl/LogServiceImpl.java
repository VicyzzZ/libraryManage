package cleve.service.impl;

import cleve.dao.LogDao;
import cleve.entity.Log;
import cleve.service.LogService;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * LogServiceImpl
 */
@Service
public class LogServiceImpl implements LogService {
    private final LogDao logDao;

    @Autowired
    public LogServiceImpl(LogDao logDao) {
        this.logDao = logDao;
    }

    @Override
    public void addLog(Log log) {
        if (log != null) {
            logDao.addLog(log);
        }
    }

    @Override
    public void deleteLog(Log log) {
        logDao.deleteLog(log);
    }




    @Override
    public void updateLog(Log log) {
        if (log != null) {
            logDao.updateLog(log);
        }
    }

    @Override
    public Log findLogByLogID(int logID) {
        return logDao.findLogByLogID(logID);
    }

    @Override
    public List<Log> findLogByUserID(int userID) {
        return logDao.findLogByUserID(userID);
    }

    @Override
    public List<Log> findLogBybookID(String bookID) {
        return logDao.findLogBybookID(bookID);
    }


    @Override
    public List<Log> findLogBySate(int sate) {
        return logDao.findLogBySate(sate);
    }

    @Override
    public List<Log> getOverLog() {
        return logDao.getOverLog();
    }

    @Override
    public List<Log> getAllLog() {
        return logDao.getAllLog();
    }
}
