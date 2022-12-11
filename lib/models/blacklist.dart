class Blacklist {
  Blacklist({
    this.isSelected: false,
    this.userId,
    this.userName,
    this.userPhone,
    this.userEmail,
  });
  bool isSelected;
  String userId;
  String userName;
  String userPhone;
  String userEmail;

  factory Blacklist.fromJson(Map<String, dynamic> json) => Blacklist(
    userId: json["user_id"],
    userName: json["user_name"],
    userPhone: json["user_phone"],
    userEmail: json["user_email"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "user_name": userName,
    "user_phone": userPhone,
    "user_email": userEmail
  };
}
