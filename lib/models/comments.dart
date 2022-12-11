
class Comments {
  Comments({
    this.commentId,
    this.commentDetails,
    this.commentBy,
    this.commentDate,
  });

  String commentId;
  String commentDetails;
  String commentBy;
  String commentDate;


  factory Comments.fromJson(Map<String, dynamic> json) => Comments(
    commentId: json["comment_id"],
    commentDetails: json["comment_details"],
    commentBy: json["comment_by"],
    commentDate: json["comment_date"],
  );

  Map<String, dynamic> toJson() => {
    "comment_id": commentId,
    "comment_details": commentDetails,
    "comment_by": commentBy,
    "comment_date": commentDate,
  };
}
