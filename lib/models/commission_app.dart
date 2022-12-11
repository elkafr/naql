class CommissionApp {
    CommissionApp({
        this.response,
        this.message,
        this.commition,
        this.commition1,
        this.about,
        this.banks,
    });

    String response;
    String message;
    String commition;
    String commition1;
    String about;
    List<Bank> banks;

    factory CommissionApp.fromJson(Map<String, dynamic> json) => CommissionApp(
        response: json["response"],
        message: json["message"],
        commition: json["commition"],
        commition1: json["commition1"],
        about: json["about"],
        banks: List<Bank>.from(json["banks"].map((x) => Bank.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "response": response,
        "message": message,
        "commition": commition,
        "commition1": commition1,
        "about": about,
        "banks": List<dynamic>.from(banks.map((x) => x.toJson())),
    };
}

class Bank {
    Bank({
        this.bankId,
        this.bankTitle,
        this.bankName,
        this.bankAcount,
        this.bankIban,
        this.bankPhoto,
    });

    String bankId;
    String bankTitle;
    String bankName;
    String bankAcount;
    String bankIban;
    String bankPhoto;

    factory Bank.fromJson(Map<String, dynamic> json) => Bank(
        bankId: json["bank_id"],
        bankTitle: json["bank_title"],
        bankName: json["bank_name"],
        bankAcount: json["bank_acount"],
        bankIban: json["bank_iban"],
        bankPhoto: json["bank_photo"],
    );

    Map<String, dynamic> toJson() => {
        "bank_id": bankId,
        "bank_title": bankTitle,
        "bank_name": bankName,
        "bank_acount": bankAcount,
        "bank_iban": bankIban,
        "bank_photo": bankPhoto,
    };
}
