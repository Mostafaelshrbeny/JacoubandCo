class NotificationModel {
  int? id;
  String? title;
  String? body;
  int? recordId;
  String? recordType;
  int? parentRecordId;
  String? parentRecordType;
  String? createdAt;
  String? updatedAt;

  NotificationModel(
      {this.id,
      this.title,
      this.body,
      this.recordId,
      this.recordType,
      this.parentRecordId,
      this.parentRecordType,
      this.createdAt,
      this.updatedAt});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    recordId = json['recordId'];
    recordType = json['recordType'];
    parentRecordId = json['parentRecordId'];
    parentRecordType = json['parentRecordType'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
