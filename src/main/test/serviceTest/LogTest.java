package serviceTest;

import cleve.entity.Log;
import cleve.service.LogService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.sql.Timestamp;
import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml","classpath:springMVC.xml"})
public class LogTest {

    @Autowired
    private LogService logService;

    @Test
    public void addLog()
    {
        Log log = new Log();
        log.setBookID("A101123");
        log.setUserID(1);
        Timestamp createTime = new Timestamp(System.currentTimeMillis());
        log.setBorrowTime(createTime);
        log.setBorrowLong(7);
        log.setReturnTime(null);
        log.setState(1);
        log.setCredit(0);
        logService.addLog(log);
        Log addLog = logService.findLogByLogID(26);
        System.out.println(addLog.toString());
    }

    @Test
    public void updateLog()
    {
        Log log = logService.findLogByLogID(26);
        Timestamp returnTime = new Timestamp(System.currentTimeMillis());
        log.setReturnTime(returnTime);
        log.setState(3);
        logService.updateLog(log);
        Log updateLog = logService.findLogByLogID(26);
        System.out.println(updateLog.toString());
    }

    @Test
    public void getAllLog()
    {
        List<Log> logList =logService.getAllLog();
        System.out.println(logList);
    }

    @Test
    public void deleteUserByUserID()
    {
        Log log = logService.findLogByLogID(26);
        logService.deleteLog(log);
    }
}
