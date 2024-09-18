class CompanyModel {
  int? id;
  String? name;
  String? image;
  String? cashInBank;
  String? description;
  String? category;
  String? website;
  String? openSea;
  String? instagram;
  String? facebook;
  String? discord;
  String? color;
  bool? active;
  String? createdAt;
  String? updatedAt;

  CompanyModel(
      {this.id,
      this.name,
      this.image,
      this.cashInBank,
      this.description,
      this.category,
      this.website,
      this.openSea,
      this.instagram,
      this.facebook,
      this.discord,
      this.color,
      this.active,
      this.createdAt,
      this.updatedAt});

  CompanyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    cashInBank = json['cash_in_bank'];
    description = json['description'];
    category = json['category'];
    website = json['website'];
    openSea = json['open_sea'];
    instagram = json['instagram'];
    facebook = json['facebook'];
    discord = json['discord'];
    color = json['color'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
