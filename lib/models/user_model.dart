class UserModel {
  String? userId;
  String? name;
  String? phone;
  String? address;
  String? email;
  String? image;
  String? region;

  UserModel(
      {this.userId,
      this.name,
      this.email,
      this.image,
      this.address,
      this.phone,
      this.region});

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
    email = json['email'];
    image = json['image'];
    region = json['region'];
  }
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'image': image,
      'address': address,
      'phone': phone,
      'region': region
    };
  }
}
