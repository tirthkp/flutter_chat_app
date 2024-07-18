class CallModel {
  String? id;
  String? callerName;
  String? callerId;
  String? callerEmail;
  String? callerPic;
  String? receiverName;
  String? receiverId;
  String? receiverEmail;
  String? receiverPic;
  String? status;
  String? type;

  CallModel(
      {this.id,
      this.callerName,
      this.callerId,
      this.callerEmail,
      this.callerPic,
      this.receiverName,
      this.receiverId,
      this.receiverEmail,
      this.receiverPic,
      this.status,
      this.type});

  CallModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    callerName = json["callerName"];
    callerId = json["callerId"];
    callerEmail = json["callerEmail"];
    callerPic = json["callerPic"];
    receiverName = json["receiverName"];
    receiverId = json["receiverId"];
    receiverEmail = json["receiverEmail"];
    receiverPic = json["receiverPic"];
    status = json["status"];
    type = json["type"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["callerName"] = callerName;
    data["callerId"] = callerId;
    data["callerEmail"] = callerEmail;
    data["callerPic"] = callerPic;
    data["receiverName"] = receiverName;
    data["receiverId"] = receiverId;
    data["receiverEmail"] = receiverEmail;
    data["receiverPic"] = receiverPic;
    data["status"] = status;
    data["type"] = type;
    return data;
  }
}
