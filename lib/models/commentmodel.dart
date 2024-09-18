class CommentsModel {
  int? id;
  int? groupPostId;
  int? userId;
  String? comment;
  String? createdAt;
  User? user;
  List<Attachments>? attachments;
  bool? isMine;

  CommentsModel(
      {this.id,
      this.groupPostId,
      this.userId,
      this.comment,
      this.createdAt,
      this.user,
      this.attachments,
      this.isMine});

  CommentsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupPostId = json['group_post_id'];
    userId = json['user_id'];
    comment = json['comment'];
    createdAt = json['created_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['attachments'] != null) {
      attachments = <Attachments>[];
      json['attachments'].forEach((v) {
        attachments!.add(Attachments.fromJson(v));
      });
    }
    isMine = json['is_mine'];
  }
}

class User {
  int? id;
  String? name;
  String? image;

  User({this.id, this.name, this.image});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}

class Attachments {
  int? id;
  int? commentId;
  String? url;
  String? type;
  String? createdAt;

  Attachments({this.id, this.commentId, this.url, this.type, this.createdAt});

  Attachments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    commentId = json['comment_id'];
    url = json['url'];
    type = json['type'];
    createdAt = json['created_at'];
  }
}
