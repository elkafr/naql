class ChatMessage {
    ChatMessage({
        this.messageId,
        this.messageTitle,
        this.messageContent,
        this.messageView,
        this.messageSender,
        this.messageSenderImage,
        this.senderUserId,
        this.messageAds,
        this.messageDate,
        this.delete,
    });

    String messageId;
    String messageTitle;
    String messageContent;
    String messageView;
    String messageSender;
    String messageSenderImage;
    String senderUserId;
    String messageAds;
    String messageDate;
    String delete;

    factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
        messageId: json["message_id"],
        messageTitle: json["message_title"],
        messageContent: json["message_content"],
        messageView: json["message_view"],
        messageSender: json["message_sender"],
        messageSenderImage: json["message_sender_image"],
        senderUserId: json["sender_user_id"],
        messageAds: json["message_ads"],
        messageDate: json["message_date"],
        delete: json["delete"],
    );

    Map<String, dynamic> toJson() => {
        "message_id": messageId,
        "message_title": messageTitle,
        "message_content": messageContent,
        "message_view": messageView,
        "message_sender": messageSender,
        "message_sender_image": messageSenderImage,
        "sender_user_id": senderUserId,
        "message_ads": messageAds,
        "message_date": messageDate,
        "delete": delete,
    };
}
