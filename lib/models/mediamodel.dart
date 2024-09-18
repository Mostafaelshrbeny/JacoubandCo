class MediaModel {
  List<MData>? data;
  int? page;
  int? lastPage;
  int? totalCount;

  MediaModel({this.data, this.page, this.lastPage, this.totalCount});

  MediaModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <MData>[];
      json['data'].forEach((v) {
        data!.add(MData.fromJson(v));
      });
    }
    page = json['page'];
    lastPage = json['last_page'];
    totalCount = json['total_count'];
  }
}

class MData {
  int? id;
  int? groupPostId;
  int? groupId;
  String? url;
  String? type;
  String? createdAt;

  MData(
      {this.id,
      this.groupPostId,
      this.groupId,
      this.url,
      this.type,
      this.createdAt});

  MData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupPostId = json['group_post_id'];
    groupId = json['group_id'];
    url = json['url'];
    type = json['type'];
    createdAt = json['created_at'];
  }
}
