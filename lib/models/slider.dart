class SliderModel {
    String id;
    String url;
    String photo;

    SliderModel({
        this.id,
        this.url,
        this.photo,
    });

    factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
        id: json["id"],
        url: json["url"],
        photo: json["photo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "photo": photo,
    };
}