class MessagesModel {
  List<Data>? data;
  int? page;
  int? lastPage;
  int? totalCount;

  MessagesModel({this.data, this.page, this.lastPage, this.totalCount});

  MessagesModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    page = json['page'];
    lastPage = json['last_page'];
    totalCount = json['total_count'];
  }
}

class Data {
  int? id;
  int? groupId;
  String? body;
  String? createdAt;
  String? updatedAt;
  int? createdBy;
  List<Tags>? tags;
  List<Attachments>? attachments;
  bool? isRead;
  int? commentsCount;
  List<LastCommenters>? lastCommenters;
  List<Reactions>? reactions;

  Data(
      {this.id,
      this.groupId,
      this.body,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.tags,
      this.attachments,
      this.isRead,
      this.commentsCount,
      this.lastCommenters,
      this.reactions});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupId = json['group_id'];
    body = json['body'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) {
        tags!.add(Tags.fromJson(v));
      });
    }
    if (json['attachments'] != null) {
      attachments = <Attachments>[];
      json['attachments'].forEach((v) {
        attachments!.add(Attachments.fromJson(v));
      });
    }
    isRead = json['is_read'];
    commentsCount = json['comments_count'];
    if (json['last_commenters'] != null) {
      lastCommenters = <LastCommenters>[];
      json['last_commenters'].forEach((v) {
        lastCommenters!.add(LastCommenters.fromJson(v));
      });
    }
    if (json['reactions'] != null) {
      reactions = <Reactions>[];
      json['reactions'].forEach((v) {
        reactions!.add(Reactions.fromJson(v));
      });
    }
  }
}

class Tags {
  int? id;
  int? groupPostId;
  String? tag;
  String? createdAt;

  Tags({this.id, this.groupPostId, this.tag, this.createdAt});

  Tags.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupPostId = json['group_post_id'];
    tag = json['tag'];
    createdAt = json['created_at'];
  }
}

class Attachments {
  int? id;
  int? groupPostId;
  int? groupId;
  String? url;
  String? type;
  String? createdAt;

  Attachments(
      {this.id,
      this.groupPostId,
      this.groupId,
      this.url,
      this.type,
      this.createdAt});

  Attachments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupPostId = json['group_post_id'];
    groupId = json['group_id'];
    url = json['url'];
    type = json['type'];
    createdAt = json['created_at'];
  }
}

class LastCommenters {
  int? id;
  String? name;
  String? image;

  LastCommenters({this.id, this.name, this.image});

  LastCommenters.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}

class Reactions {
  String? reaction;
  int? count;

  Reactions({this.reaction, this.count});

  Reactions.fromJson(Map<String, dynamic> json) {
    reaction = json['reaction'];
    count = json['count'];
  }
}
