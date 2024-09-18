class AllGroupsModel {
  int? id;
  String? name;
  String? image;
  String? description;
  bool? active;
  String? createdAt;
  String? updatedAt;
  String? lastPublishingDate;
  int? createdBy;
  int? unreadPostsCount;
  Settings? settings;

  AllGroupsModel(
      {this.id,
      this.name,
      this.image,
      this.description,
      this.active,
      this.createdAt,
      this.updatedAt,
      this.lastPublishingDate,
      this.createdBy,
      this.unreadPostsCount,
      this.settings});

  AllGroupsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    lastPublishingDate = json['last_publishing_date'];
    createdBy = json['created_by'];
    unreadPostsCount = json['unread_posts_count'];
    settings =
        json['settings'] != null ? Settings.fromJson(json['settings']) : null;
  }

  /*Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['description'] = this.description;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['last_publishing_date'] = this.lastPublishingDate;
    data['created_by'] = this.createdBy;
    data['unread_posts_count'] = this.unreadPostsCount;
    if (this.settings != null) {
      data['settings'] = this.settings!.toJson();
    }
    return data;
  }*/
}

class Settings {
  int? groupId;
  int? userId;
  bool? isPinned;
  bool? isUnread;
  String? mute;
  String? saveToGallery;
  String? createdAt;
  String? updatedAt;

  Settings(
      {this.groupId,
      this.userId,
      this.isPinned,
      this.isUnread,
      this.mute,
      this.saveToGallery,
      this.createdAt,
      this.updatedAt});

  Settings.fromJson(Map<String, dynamic> json) {
    groupId = json['group_id'];
    userId = json['user_id'];
    isPinned = json['is_pinned'];
    isUnread = json['is_unread'];
    mute = json['mute'];
    saveToGallery = json['save_to_gallery'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  /* Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['group_id'] = this.groupId;
    data['user_id'] = this.userId;
    data['is_pinned'] = this.isPinned;
    data['is_unread'] = this.isUnread;
    data['mute'] = this.mute;
    data['save_to_gallery'] = this.saveToGallery;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }*/
}
