class CategoryModel {
    CategoryModel({
      this.isSelected: false,
        this.catId,
        this.catName,
        this.catOrder,
        this.catImage,
    });
   bool isSelected;
    String catId;
    String catName;
    String catOrder;
    String catImage;

    factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        catId: json["cat_id"],
        catName: json["cat_name"],
        catOrder: json["cat_order"],
        catImage: json["cat_image"],
    );

    Map<String, dynamic> toJson() => {
        "cat_id": catId,
        "cat_name": catName,
        "cat_order": catOrder,
        "cat_image": catImage,
    };
}
