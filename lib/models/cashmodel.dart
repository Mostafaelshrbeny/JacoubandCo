class CashModel {
  String? name;
  String? value;
  String? createdAt;
  String? updatedAt;

  CashModel({this.name, this.value, this.createdAt, this.updatedAt});

  CashModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
