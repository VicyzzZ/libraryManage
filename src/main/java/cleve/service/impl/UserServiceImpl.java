package cleve.service.impl;

import cleve.dao.UserDao;
import cleve.entity.User;
import cleve.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * UserServiceImpl
 */
@Service
public class UserServiceImpl implements UserService {
    private final UserDao userDao;

    @Autowired
    public UserServiceImpl(UserDao userDao) {
        this.userDao = userDao;
    }

    @Override
    public void addUser(User user) {
        if (user != null) {
            userDao.addUser(user);
        }
    }

    @Override
    public void deleteUserByUserName(String userName) {
        userDao.deleteUserByUserName(userName);
    }

    @Override
    public void deleteUserByUserID(int userID) {
        userDao.deleteUserByUserID(userID);
    }

    @Override
    public void updateUser(User user) {
        if (user != null) {
            userDao.updateUser(user);
        }
    }

    @Override
    public String getUserPasswordByUserName(String userName) {
        return  userDao.getUserPasswordByUserName(userName);
    }

    @Override
    public User findUserByUserName(String userName) {
        return userDao.findUserByUserName(userName);
    }

    @Override
    public User findUserByUserID(int userID) {
        return userDao.findUserByUserID(userID);
    }

    @Override
    public List<User> getAllUser() {
        return userDao.getAllUser();
    }
}
