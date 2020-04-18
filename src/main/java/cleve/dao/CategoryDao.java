package cleve.dao;

import cleve.entity.Book;
import cleve.entity.Category;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * CategoryDao 提供关于分类的操作接口
 */
@Repository
public interface CategoryDao {

    /**
     * 添加分类
     *
     * @param category 新增的分类
     */
    void addCategory(Category category);

    /**
     * 通过分类名删除分类
     *
     * @param categoryName 删除分类的分类名
     */
    void deleteCategoryByCategoryName(String categoryName);

    /**
     * 通过分类ID删除分类
     *
     * @param categoryID 删除分类的ID
     */
    void deleteCategoryByCategoryID(int categoryID);

    /**
     * 更新分类信息
     *
     * @param category 需要更新的分类
     */
    void updateCategory(Category category);

    /**
     * 通过分类名查找分类
     *
     * @param categoryName 分类名
     * @return 查找到的分类
     */
    Category findCategoryBycategoryName(String categoryName);

    /**
     * 通过分类ID查找分类
     *
     * @param categoryID 分类ID
     * @return 查找到的分类
     */
    Category findCategoryBycategoryID(int categoryID);


    /**
     * 获取所有的分类信息
     *
     * @return 分类列表
     */
    List<Category> getAllCategory();



}
