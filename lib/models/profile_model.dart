class ProfileModel {
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
  int? wallpaperId;
  bool? active;
  String? createdAt;
  String? updatedAt;
  Wallpaper? wallpaper;
  int? notificationsCount;

  ProfileModel(
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
      this.updatedAt,
      this.wallpaper,
      this.notificationsCount});

  ProfileModel.fromJson(Map<String, dynamic> json) {
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
    wallpaper = json['wallpaper'] != null
        ? Wallpaper.fromJson(json['wallpaper'])
        : null;
    notificationsCount = json['notifications_count'];
  }
}

class Wallpaper {
  int? id;
  String? url;
  int? userId;
  String? createdAt;
  String? updatedAt;

  Wallpaper({this.id, this.url, this.userId, this.createdAt, this.updatedAt});

  Wallpaper.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
