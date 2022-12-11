
class Ad {
    Ad({
        this.adsId,
        this.adsTitle,
        this.adsUrl,
        this.adsDate,
        this.adsAge,
        this.adsStar,
        this.adsFullDate,
        this.adsVisits,
        this.adsCat,
        this.adsCatName,
        this.adsCatImage,
        this.adsSub,
        this.adsSubCatName,
        this.adsCatUrl,
        this.adsCountry,
        this.adsCountryName,
        this.adsCountryUrl,
        this.adsCityName,
        this.adsMarka,
        this.adsMarkaName,
        this.adsMarkaUrl,
        this.adsType,
        this.adsTypeName,
        this.adsTypeUrl,
        this.adsModel,
        this.adsModelName,
        this.adsModelUrl,
        this.adsUser,
        this.adsUserName,
        this.adsUserUrl,
        this.adsPhoto,
        this.adsPhoto11,
        this.adsPhoto22,
        this.adsPhoto33,
        this.adsPhoto44,
        this.adsDetails,
        this.adsPrice,
        this.adsPhone,
        this.adsWhatsapp,
        this.adsRate,
        this.adsAdress,
        this.adsLocation,

        this.adsCylinders,
        this.adsDvd,
        this.adsOutColor,
        this.adsOpenRoof,
        this.adsFuel,
        this.adsCamera,
        this.adsGear,
        this.adsGuarantee,
        this.adsSpeedometer,
        this.adsPropulsion,
        this.adsSensors,
        this.adsCd,
        this.adsBluetooth,
        this.adsInColor,
        this.adsChairsType,
        this.adsGps,

        this.adsIsFavorite,
    });

    String adsId;
    String adsTitle;
    String adsUrl;
    String adsDate;
    String adsAge;
    String adsStar;
    String adsFullDate;
    String adsVisits;
    String adsCat;
    String adsCatName;
    String adsCatImage;
    String adsSub;
    String adsSubCatName;
    String adsCatUrl;
    String adsCountry;
    String adsCountryName;
    String adsCountryUrl;
    String adsCityName;
    String adsMarka;
    String adsMarkaName;
    String adsMarkaUrl;
    String adsType;
    String adsTypeName;
    String adsTypeUrl;
    String adsModel;
    String adsModelName;
    String adsModelUrl;
    String adsUser;
    String adsUserName;
    String adsUserUrl;
    String adsPhoto;
    String adsPhoto11;
    String adsPhoto22;
    String adsPhoto33;
    String adsPhoto44;
    String adsDetails;
    String adsPrice;
    String adsPhone;
    String adsWhatsapp;
    String adsRate;
    String adsAdress;
    String adsLocation;

    String adsCylinders;
    String adsDvd;
    String adsOutColor;
    String adsOpenRoof;
    String adsFuel;
    String adsCamera;
    String adsGear;
    String adsGuarantee;
    String adsSpeedometer;
    String adsPropulsion;
    String adsSensors;
    String adsCd;
    String adsBluetooth;
    String adsInColor;
    String adsChairsType;
    String adsGps;


    int adsIsFavorite;

    factory Ad.fromJson(Map<String, dynamic> json) => Ad(
        adsId: json["ads_id"],
        adsTitle: json["ads_title"],
        adsUrl: json["ads_url"],
        adsDate: json["ads_date"],
        adsAge: json["ads_age"],
        adsStar: json["ads_star"],
        adsFullDate: json["ads_full_date"],
        adsVisits: json["ads_visits"],
        adsCat: json["ads_cat"],
        adsCatName: json["ads_cat_name"],
        adsCatImage: json["ads_cat_image"],
        adsSub: json["ads_sub"],
        adsSubCatName: json["ads_sub_cat_name"],
        adsCatUrl: json["ads_cat_url"],
        adsCountry: json["ads_country"],
        adsCountryName: json["ads_country_name"],
        adsCountryUrl: json["ads_country_url"],
        adsCityName: json["ads_city_name"],
        adsMarka: json["ads_marka"],
        adsMarkaName: json["ads_marka_name"],
        adsMarkaUrl: json["ads_marka_url"],
        adsType: json["ads_type"],
        adsTypeName: json["ads_type_name"],
        adsTypeUrl: json["ads_type_url"],
        adsModel: json["ads_model"],
        adsModelName: json["ads_model_name"],
        adsModelUrl: json["ads_model_url"],
        adsUser: json["ads_user"],
        adsUserName: json["ads_user_name"],
        adsUserUrl: json["ads_user_url"],
        adsPhoto: json["ads_photo"],
        adsPhoto11: json["ads_photo11"],
        adsPhoto22: json["ads_photo22"],
        adsPhoto33: json["ads_photo33"],
        adsPhoto44: json["ads_photo44"],
        adsDetails: json["ads_details"],
        adsPrice: json["ads_price"],
        adsPhone: json["ads_phone"],
        adsWhatsapp: json["ads_whatsapp"],
        adsRate: json["ads_rate"],
        adsAdress: json["ads_adress"],
        adsLocation: json["ads_location"],

        adsCylinders: json["ads_cylinders"],
        adsDvd: json["ads_dvd"],
        adsOutColor: json["ads_out_color"],
        adsOpenRoof: json["ads_open_roof"],
        adsFuel: json["ads_fuel"],
        adsCamera: json["ads_camera"],
        adsGear: json["ads_gear"],
        adsGuarantee: json["ads_guarantee"],
        adsSpeedometer: json["ads_speedometer"],
        adsPropulsion: json["ads_propulsion"],
        adsSensors: json["ads_sensors"],
        adsCd: json["ads_cd"],
        adsBluetooth: json["ads_bluetooth"],
        adsInColor: json["ads_in_color"],
        adsChairsType: json["ads_chairs_type"],
        adsGps: json["ads_gps"],


        adsIsFavorite: json["ads_is_favorite"],
    );

    Map<String, dynamic> toJson() => {
        "ads_id": adsId,
        "ads_title": adsTitle,
        "ads_url": adsUrl,
        "ads_date": adsDate,
        "ads_age": adsAge,
        "ads_star": adsStar,
        "ads_full_date": adsFullDate,
        "ads_visits": adsVisits,
        "ads_cat": adsCat,
        "ads_cat_name": adsCatName,
        "ads_cat_image": adsCatImage,
        "ads_sub": adsSub,
        "ads_sub_cat_name": adsSubCatName,
        "ads_cat_url": adsCatUrl,
        "ads_country": adsCountry,
        "ads_country_name": adsCountryName,
        "ads_country_url": adsCountryUrl,
        "ads_city_name": adsCityName,
        "ads_marka": adsMarka,
        "ads_marka_name": adsMarkaName,
        "ads_marka_url": adsMarkaUrl,
        "ads_type": adsType,
        "ads_type_name": adsTypeName,
        "ads_type_url": adsTypeUrl,
        "ads_model": adsModel,
        "ads_model_name": adsModelName,
        "ads_model_url": adsModelUrl,
        "ads_user": adsUser,
        "ads_user_name": adsUserName,
        "ads_user_url": adsUserUrl,
        "ads_photo": adsPhoto,
        "ads_photo11": adsPhoto11,
        "ads_photo22": adsPhoto22,
        "ads_photo33": adsPhoto33,
        "ads_photo44": adsPhoto44,
        "ads_details": adsDetails,
        "ads_price": adsPrice,
        "ads_phone": adsPhone,
        "ads_whatsapp": adsWhatsapp,
        "ads_rate": adsRate,
        "ads_adress": adsAdress,
        "ads_location": adsLocation,

        "ads_cylinders": adsCylinders,
        "ads_dvd": adsDvd,
        "ads_out_color": adsOutColor,
        "ads_open_roof": adsOpenRoof,
        "ads_fuel": adsFuel,
        "ads_camera": adsCamera,
        "ads_gear": adsGear,
        "ads_guarantee": adsGuarantee,
        "ads_speedometer": adsSpeedometer,
        "ads_propulsion": adsPropulsion,
        "ads_sensors": adsSensors,
        "ads_cd": adsCd,
        "ads_bluetooth": adsBluetooth,
        "ads_in_color": adsInColor,
        "ads_chairs_type": adsChairsType,
        "ads_gps": adsGps,

        "ads_is_favorite": adsIsFavorite,
    };
}
