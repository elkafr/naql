class ChatMsgBetweenMembers {
    ChatMsgBetweenMembers({
        this.messageId,
        this.messageTitle,
        this.messageContent,
        this.messageView,
        this.messageAds,
        this.messageSender,
        this.messageSenderImage,
        this.messageSenderPhone,
        this.senderUserId,
        this.messageDate,
        this.delete,
    });

    String messageId;
    String messageTitle;
    String messageContent;
    String messageView;
    String messageAds;
    String messageSender;
    String messageSenderImage;
    String messageSenderPhone;
    String senderUserId;
    String messageDate;
    String delete;

    factory ChatMsgBetweenMembers.fromJson(Map<String, dynamic> json) => ChatMsgBetweenMembers(
        messageId: json["message_id"],
        messageTitle: json["message_title"],
        messageContent: json["message_content"],
        messageView: json["message_view"],
        messageAds: json["message_ads"],
        messageSender: json["message_sender"],
        messageSenderImage: json["message_sender_image"],
        messageSenderPhone: json["message_sender_phone"],
        senderUserId: json["sender_user_id"],
        messageDate: json["message_date"],
        delete: json["delete"],
    );

    Map<String, dynamic> toJson() => {
        "message_id": messageId,
        "message_title": messageTitle,
        "message_content": messageContent,
        "message_view": messageView,
        "message_ads": messageAds,
        "message_sender": messageSender,
        "message_sender_image": messageSenderImage,
        "message_sender_phone": messageSenderPhone,
        "sender_user_id": senderUserId,
        "message_date": messageDate,
        "delete": delete,
    };
}
