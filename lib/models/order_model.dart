class OrderModel {
  String? orderid;
  String? name;
  String? orderdate;
  String? image;
  String? time;
  bool? booked;

  OrderModel(
      {this.orderid,
      this.name,
      this.image,
      this.orderdate,
      this.time,
      this.booked});

  OrderModel.fromJson(Map<String, dynamic> json) {
    orderid = json['orderid'];
    name = json['name'];
    image = json['image'];
    orderdate = json['orderdate'];
    time = json['time'];
    booked = json['booked'];
  }
  Map<String, dynamic> toMap() {
    return {
      'orderid': orderid,
      'name': name,
      'image': image,
      'orderdate': orderdate,
      'time': time,
      'booked': booked
    };
  }
}
