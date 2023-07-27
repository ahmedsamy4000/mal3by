class PlayModel {
  String? pId;
  String? name;
  String? owner;
  String? region;
  String? phone;
  String? ownerphone;
  String? address;
  String? location;
  String? image;

  PlayModel(
      {this.pId,
      this.name,
      this.owner,
      this.region,
      this.phone,
      this.address,
      this.location,
      this.ownerphone,
      this.image});

  PlayModel.fromJson(Map<String, dynamic> json) {
    pId = json['pid'];
    name = json['name'];
    owner = json['owner'];
    phone = json['phone'];
    region = json['region'];
    address = json['address'];
    ownerphone = json['ownerphone'];
    location = json['location'];
    image = json['image'];
  }
  Map<String, dynamic> toMap() {
    return {
      'pid': pId,
      'name': name,
      'owner': owner,
      'phone': phone,
      'address': address,
      'region': region,
      'location': location,
      'ownerphone': ownerphone,
      'image': image
    };
  }
}
