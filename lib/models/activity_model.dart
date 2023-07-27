class ActivityModel {
  String? name;
  String? playgroundname;
  String? activityId;
  String? personalId;
  String? activityDate;
  String? time;
  bool? status;

  ActivityModel(
      {this.name,
      this.activityDate,
      this.time,
      this.activityId,
      this.status,
      this.personalId,
      this.playgroundname});

  ActivityModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    playgroundname = json['playgroundname'];
    personalId = json['personalId'];
    activityId = json['activityId'];
    activityDate = json['activityDate'];
    time = json['time'];
    status = json['status'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'playgroundname': playgroundname,
      'personalId': personalId,
      'activityId': activityId,
      'activityDate': activityDate,
      'time': time,
      'status': status
    };
  }
}
