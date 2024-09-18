class WallpaperModel {
  int? id;
  String? url;
  int? userId;
  String? createdAt;
  String? updatedAt;

  WallpaperModel({
    this.id,
    this.url,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  WallpaperModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
