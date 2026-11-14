// Import any needed model functions
import {
  getAllCategories,
  getCategoryDetails,
  getProjectsByCategoryId,
  getCategoriesByProjectId,
  updateCategoryAssignments,
  createCategory,
  updateCategory,
} from "../models/categories.js";
import { getProjectDetails } from "../models/projects.js";
import { body, validationResult } from "express-validator";

const categoryValidation = [
  body("name")
    .trim()
    .notEmpty()
    .withMessage("Category name is required")
    .isLength({ min: 3, max: 100 })
    .withMessage("Category name must be between 3 and 100 characters"),
];

// Define any controller functions
const showCategoriesPage = async (req, res) => {
  const categories = await getAllCategories();
  const title = "Service Categories";

  res.render("categories", { title, categories });
};

const showCategoryDetailsPage = async (req, res, next) => {
  const categoryId = req.params.id;

  if (!/^\d+$/.test(categoryId)) {
    const err = new Error("Category not found");
    err.status = 404;
    return next(err);
  }

  const category = await getCategoryDetails(categoryId);

  if (!category) {
    const err = new Error("Category not found");
    err.status = 404;
    return next(err);
  }

  const projects = await getProjectsByCategoryId(categoryId);
  const title = "Category Details";

  res.render("category", { title, category, projects });
};

const showAssignCategoriesForm = async (req, res, next) => {
  const projectId = req.params.projectId;

  if (!/^\d+$/.test(projectId)) {
    const err = new Error("Project not found");
    err.status = 404;
    return next(err);
  }

  const projectDetails = await getProjectDetails(projectId);

  if (!projectDetails) {
    const err = new Error("Project not found");
    err.status = 404;
    return next(err);
  }

  const categories = await getAllCategories();
  const assignedCategories = await getCategoriesByProjectId(projectId);
  const title = "Assign Categories to Project";

  res.render("assign-categories", {
    title,
    projectId,
    projectDetails,
    categories,
    assignedCategories,
  });
};

const processAssignCategoriesForm = async (req, res) => {
  const projectId = req.params.projectId;
  const selectedCategoryIds = req.body.categoryIds || [];

  // One checked box arrives as a string, several arrive as an array
  const categoryIdsArray = Array.isArray(selectedCategoryIds)
    ? selectedCategoryIds
    : [selectedCategoryIds];

  await updateCategoryAssignments(projectId, categoryIdsArray);

  req.flash("success", "Categories updated successfully.");
  res.redirect(`/project/${projectId}`);
};

const showNewCategoryForm = async (req, res) => {
  const title = "Add New Category";

  res.render("new-category", { title });
};

const processNewCategoryForm = async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    errors.array().forEach((error) => {
      req.flash("error", error.msg);
    });
    return res.redirect("/new-category");
  }

  const { name } = req.body;

  try {
    const newCategoryId = await createCategory(name);

    req.flash("success", "New category created successfully!");
    res.redirect(`/category/${newCategoryId}`);
  } catch (error) {
    console.error("Error creating new category:", error);
    req.flash("error", "There was an error creating the category.");
    res.redirect("/new-category");
  }
};

const showEditCategoryForm = async (req, res, next) => {
  const categoryId = req.params.id;

  if (!/^\d+$/.test(categoryId)) {
    const err = new Error("Category not found");
    err.status = 404;
    return next(err);
  }

  const category = await getCategoryDetails(categoryId);

  if (!category) {
    const err = new Error("Category not found");
    err.status = 404;
    return next(err);
  }

  const title = "Edit Category";

  res.render("edit-category", { title, category });
};

const processEditCategoryForm = async (req, res) => {
  const categoryId = req.params.id;

  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    errors.array().forEach((error) => {
      req.flash("error", error.msg);
    });
    return res.redirect(`/edit-category/${categoryId}`);
  }

  const { name } = req.body;

  try {
    await updateCategory(categoryId, name);

    req.flash("success", "Category updated successfully!");
    res.redirect(`/category/${categoryId}`);
  } catch (error) {
    console.error("Error updating category:", error);
    req.flash("error", "There was an error updating the category.");
    res.redirect(`/edit-category/${categoryId}`);
  }
};

// Export any controller functions
export {
  showCategoriesPage,
  showCategoryDetailsPage,
  showAssignCategoriesForm,
  processAssignCategoriesForm,
  categoryValidation,
  showNewCategoryForm,
  processNewCategoryForm,
  showEditCategoryForm,
  processEditCategoryForm,
};
