package serviceTest;

import cleve.entity.Category;
import cleve.service.CategoryService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml","classpath:springMVC.xml"})
public class CategoryTest {

    @Autowired
    private CategoryService categoryService;

    @Test
    public void addCategory()
    {
        Category category = new Category();
        category.setCategoryName("心理");
        categoryService.addCategory(category);
        Category addCategory = categoryService.findCategoryBycategoryName("心理");
        System.out.println(addCategory.toString());
    }

    @Test
    public void updateCategory()
    {
        int categoryID = categoryService.findCategoryBycategoryName("心理").getCategoryID();
        Category category = categoryService.findCategoryBycategoryID(categoryID);
        category.setCategoryName("科学");
        categoryService.updateCategory(category);
        Category updateCategory = categoryService.findCategoryBycategoryID(categoryID);
        System.out.println(updateCategory.toString());
    }

    @Test
    public void getAllCategory()
    {
        List<Category> categoryList =categoryService.getAllCategory();
        System.out.println(categoryList);
    }

    @Test
    public void deleteBookByBookID()
    {
        int categoryID = categoryService.findCategoryBycategoryName("科学").getCategoryID();
        categoryService.deleteCategoryByCategoryID(categoryID);
    }
    @Test
    public void deleteBookByBookName()
    {
        categoryService.deleteCategoryByCategoryName("科学");
    }
}
