///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class UsersModel {
/*
{
  "id": 1,
  "email": "admin@jp.com",
  "name": "Admin",
  "image": "${Constant.url}/uploads//data/user/0/com.example.chatjob/cache/4cf9f849-2f3e-46db-b4d5-aaced7ff5def/1000004056.jpg",
  "phone": "+420 | 123 456 7800",
  "country": "",
  "city": "South Moravia, Czech Republic",
  "bio": "lorem and these things ",
  "face_id": false,
  "lang": "en",
  "currency": "usd",
  "tfa": false,
  "role": "admin",
  "wallpaper_id": 1,
  "active": true,
  "created_at": "2023-12-03T10:59:41.266Z",
  "updated_at": "2023-12-19T17:03:12.414Z"
} 
*/

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
  List<dynamic>? groups;
  UsersModel(
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
      this.groups});
  UsersModel.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    email = json['email']?.toString();
    name = json['name']?.toString();
    image = json['image']?.toString();
    phone = json['phone']?.toString();
    country = json['country']?.toString();
    city = json['city']?.toString();
    bio = json['bio']?.toString();
    faceId = json['face_id'];
    lang = json['lang']?.toString();
    currency = json['currency']?.toString();
    tfa = json['tfa'];
    role = json['role']?.toString();
    wallpaperId = json['wallpaper_id']?.toInt();
    active = json['active'];
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
    groups = json['groups'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
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
  }
}
