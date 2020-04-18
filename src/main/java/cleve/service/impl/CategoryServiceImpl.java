package cleve.service.impl;

import cleve.dao.CategoryDao;
import cleve.entity.Book;
import cleve.entity.Category;
import cleve.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * CategoryServiceImpl
 */
@Service
public class CategoryServiceImpl implements CategoryService {
    private final CategoryDao categoryDao;

    @Autowired
    public CategoryServiceImpl(CategoryDao categoryDao) {
        this.categoryDao = categoryDao;
    }

    @Override
    public void addCategory(Category category) {
        if (category != null) {
            categoryDao.addCategory(category);
        }
    }

    @Override
    public void deleteCategoryByCategoryName(String categoryName) {
        categoryDao.deleteCategoryByCategoryName(categoryName);
    }

    @Override
    public void deleteCategoryByCategoryID(int categoryID) {
        categoryDao.deleteCategoryByCategoryID(categoryID);
    }

    @Override
    public void updateCategory(Category category) {
        if (category != null) {
            categoryDao.updateCategory(category);
        }
    }

    @Override
    public Category findCategoryBycategoryName(String categoryName) {
        return  categoryDao.findCategoryBycategoryName(categoryName);
    }

    @Override
    public Category findCategoryBycategoryID(int categoryID) {
        return categoryDao.findCategoryBycategoryID(categoryID);
    }

    @Override
    public List<Category> getAllCategory() {
        return categoryDao.getAllCategory();
    }
}
