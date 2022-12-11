class Model {
  Model({
    this.isSelected: false,
    this.modelId,
    this.modelName,
  });
  bool isSelected;
  String modelId;
  String modelName;

  factory Model.fromJson(Map<String, dynamic> json) => Model(
    modelId: json["model_id"],
    modelName: json["model_name"],
  );

  Map<String, dynamic> toJson() => {
    "model_id": modelId,
    "model_name": modelName
  };
}
