class Country {
    Country({
        this.countryId,
        this.countryName,
    });

    String countryId;
    String countryName;

    factory Country.fromJson(Map<String, dynamic> json) => Country(
        countryId: json["country_id"],
        countryName: json["country_name"],
    );

    Map<String, dynamic> toJson() => {
        "country_id": countryId,
        "country_name": countryName,
    };
}