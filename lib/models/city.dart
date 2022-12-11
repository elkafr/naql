class City {
    City({
      this.isSelected: false,
        this.cityId,
        this.cityName,
        this.cityOrder,
        this.cityCountry,
        this.cityCountryName,
    });
    bool isSelected;
    String cityId;
    String cityName;
    String cityOrder;
    String cityCountry;
    String cityCountryName;

    factory City.fromJson(Map<String, dynamic> json) => City(
        cityId: json["city_id"],
        cityName: json["city_name"],
        cityOrder: json["city_order"],
        cityCountry: json["city_country"],
        cityCountryName: json["city_country_name"],
    );

    Map<String, dynamic> toJson() => {
        "city_id": cityId,
        "city_name": cityName,
        "city_order": cityOrder,
        "city_country": cityCountry,
        "city_country_name": cityCountryName,
    };
}
