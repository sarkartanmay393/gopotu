class SubCategoryResponseModel11 {
  String status;
  String message;
  ApiData data;

  SubCategoryResponseModel11({required this.status, required this.message, required this.data});

  factory SubCategoryResponseModel11.fromJson(Map<String, dynamic> json) {
    return SubCategoryResponseModel11(
      status: json['status'],
      message: json['message'],
      data: ApiData.fromJson(json['data']),
    );
  }
}

class ApiData {
  List<SubCategory> subCategories;

  ApiData({required this.subCategories});

  factory ApiData.fromJson(Map<String, dynamic> json) {
    var subCategoriesList = json['sub_categories'] as List;
    List<SubCategory> subCategories =
    subCategoriesList.map((e) => SubCategory.fromJson(e)).toList();

    return ApiData(subCategories: subCategories);
  }
}

class SubCategory {
  int id;
  int parentId;
  int schemeId;
  String name;
  String icon;
  String type;
  String status;
  String isFeatured;
  String createdAt;
  String updatedAt;
  dynamic deletedAt; // It's dynamic as it can be null
  String iconPath;

  SubCategory({
    required this.id,
    required this.parentId,
    required this.schemeId,
    required this.name,
    required this.icon,
    required this.type,
    required this.status,
    required this.isFeatured,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.iconPath,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'],
      parentId: json['parent_id'],
      schemeId: json['scheme_id'],
      name: json['name'],
      icon: json['icon'],
      type: json['type'],
      status: json['status'],
      isFeatured: json['is_featured'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
      iconPath: json['icon_path'],
    );
  }
}
