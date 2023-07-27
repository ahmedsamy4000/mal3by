class PendingOrderModel {
  String? name;
  String? phonenumber;
  DateTime? orderDate;
  String? time;

  PendingOrderModel({this.name, this.orderDate, this.time, this.phonenumber});

  PendingOrderModel.fromJson(Map<String, dynamic> json) {
    name = json['ordername'];
    phonenumber = json['phonenumber'];
    orderDate = json['orderdate'];
    time = json['ordertime'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phonenumber': phonenumber,
      'orderdate': orderDate,
      'time': time,
    };
  }
}
