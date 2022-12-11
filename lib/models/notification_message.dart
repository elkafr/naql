class NotificationMsg {
    NotificationMsg({
        this.messageId,
        this.messageTitle,
        this.messageContent,
        this.messageAdsId,
        this.messageView,
        this.messageIsViewed,
        this.messageSender,
        this.messageDate,
        this.messageType,
        this.messageRecever,
        this.messageReceverName,
        this.messageReceverPhone,
        this.messageReceverPhoto,
        this.messageSenderId,
        this.messageSenderName,
        this.messageSenderPhone,
        this.messageSenderPhoto,
        this.delete,
    });

    String messageId;
    String messageTitle;
    String messageContent;
    String messageAdsId;
    int messageView;
    String messageIsViewed;
    String messageSender;
    String messageDate;
    String messageType;
    String messageRecever;
    String messageReceverName;
    String messageReceverPhone;
    String messageReceverPhoto;
    String messageSenderId;
    String messageSenderName;
    String messageSenderPhone;
    String messageSenderPhoto;
    String delete;

    factory NotificationMsg.fromJson(Map<String, dynamic> json) => NotificationMsg(
        messageId: json["message_id"],
        messageTitle: json["message_title"],
        messageContent: json["message_content"],
        messageAdsId: json["message_ads_id"],
        messageView: json["message_view"],
        messageIsViewed: json["message_is_viewed"],
        messageSender: json["message_sender"],
        messageDate: json["message_date"],
        messageType: json["message_type"],
        messageRecever: json["message_recever"],
        messageReceverName: json["message_recever_name"],
        messageReceverPhone: json["message_recever_phone"],
        messageReceverPhoto: json["message_recever_photo"],
        messageSenderId: json["message_sender_id"],
        messageSenderName: json["message_sender_name"],
        messageSenderPhone: json["message_sender_phone"],
        messageSenderPhoto: json["message_sender_photo"],
        delete: json["delete"],
    );

    Map<String, dynamic> toJson() => {
        "message_id": messageId,
        "message_title": messageTitle,
        "message_content": messageContent,
        "message_ads_id": messageAdsId,
        "message_view": messageView,
        "message_is_viewed": messageIsViewed,
        "message_sender": messageSender,
        "message_date": messageDate,
        "message_type": messageType,
        "message_recever": messageRecever,
        "message_recever_name": messageReceverName,
        "message_recever_phone": messageReceverPhone,
        "message_recever_photo": messageReceverPhoto,
        "message_sender_id": messageSenderId,
        "message_sender_name": messageSenderName,
        "message_sender_phone": messageSenderPhone,
        "message_sender_photo": messageSenderPhoto,
        "delete": delete,
    };
}
