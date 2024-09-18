import 'package:chatjob/models/users_model.dart';

class GroupModel {
  int? id;
  String? name;
  String? image;
  String? description;
  bool? active;
  String? createdAt;
  String? updatedAt;
  void lastPublishingDate;
  int? createdBy;
  Settings? settings;
  List<UsersModel>? users;

  GroupModel(
      {this.id,
      this.name,
      this.image,
      this.description,
      this.active,
      this.createdAt,
      this.updatedAt,
      this.lastPublishingDate,
      this.createdBy,
      this.settings,
      this.users});

  GroupModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    lastPublishingDate = json['last_publishing_date'];
    createdBy = json['created_by'];
    settings =
        json['settings'] != null ? Settings.fromJson(json['settings']) : null;
    if (json['users'] != null) {
      users = <UsersModel>[];
      json['users'].forEach((v) {
        users!.add(UsersModel.fromJson(v));
      });
    }
  }

  /* Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['description'] = description;
    data['active'] = active;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['last_publishing_date'] = lastPublishingDate;
    data['created_by'] = createdBy;
    if (settings != null) {
      data['settings'] = settings!.toJson();
    }
    if (users != null) {
      data['users'] = users!.map((v) => v.toJson()).toList();
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
  User? user;

  Settings(
      {this.groupId,
      this.userId,
      this.isPinned,
      this.isUnread,
      this.mute,
      this.saveToGallery,
      this.createdAt,
      this.updatedAt,
      this.user});

  Settings.fromJson(Map<String, dynamic> json) {
    groupId = json['group_id'];
    userId = json['user_id'];
    isPinned = json['is_pinned'];
    isUnread = json['is_unread'];
    mute = json['mute'];
    saveToGallery = json['save_to_gallery'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  /* Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['group_id'] = groupId;
    data['user_id'] = userId;
    data['is_pinned'] = isPinned;
    data['is_unread'] = isUnread;
    data['mute'] = mute;
    data['save_to_gallery'] = saveToGallery;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }*/
}

class User {
  int? id;
  String? email;
  String? name;
  String? image;
  String? phone;
  String? country;
  String? city;
  String? bio;
  bool? faceId;
  String? lang;
  String? currency;
  bool? tfa;
  String? role;
  void wallpaperId;
  bool? active;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
      this.email,
      this.name,
      this.image,
      this.phone,
      this.country,
      this.city,
      this.bio,
      this.faceId,
      this.lang,
      this.currency,
      this.tfa,
      this.role,
      this.wallpaperId,
      this.active,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    image = json['image'];
    phone = json['phone'];
    country = json['country'];
    city = json['city'];
    bio = json['bio'];
    faceId = json['face_id'];
    lang = json['lang'];
    currency = json['currency'];
    tfa = json['tfa'];
    role = json['role'];
    wallpaperId = json['wallpaper_id'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  /* Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['name'] = name;
    data['image'] = image;
    data['phone'] = phone;
    data['country'] = country;
    data['city'] = city;
    data['bio'] = bio;
    data['face_id'] = faceId;
    data['lang'] = lang;
    data['currency'] = currency;
    data['tfa'] = tfa;
    data['role'] = role;
    data['wallpaper_id'] = wallpaperId;
    data['active'] = active;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }*/
}

class Users {
  int? id;
  String? name;
  String? image;

  Users({this.id, this.name, this.image});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    return data;
  }
}
