import 'package:flutter_chat_app/model/user_model.dart';

class GroupModel {
  String? id;
  String? name;
  String? description;
  String? profileImage;
  List<dynamic>? members;
  String? createdAt;
  String? createdBy;
  String? status;
  String? lastMessage;
  String? lastMessageTime;
  String? lastMessageBy;
  int? unReadCount;
  String? timeStamp;

  GroupModel(
      {this.id,
      this.name,
      this.description,
      this.profileImage,
      this.members,
      this.createdAt,
      this.createdBy,
      this.status,
      this.lastMessage,
      this.lastMessageTime,
      this.lastMessageBy,
      this.unReadCount,
      this.timeStamp});

  GroupModel.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["description"] is String) {
      description = json["description"];
    }
    if (json["profileImage"] is String) {
      profileImage = json["profileImage"];
    }
    if (json["members"] != null) {
      members = List<UserModel>.from(
        json["members"].map(
          (e) => UserModel.fromJson(e),
        ),
      );
    } else {
      members = [];
    }
    if (json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    if (json["created_by"] is String) {
      createdBy = json["created_by"];
    }
    if (json["status"] is String) {
      status = json["status"];
    }
    if (json["lastMessage"] is String) {
      lastMessage = json["lastMessage"];
    }
    if (json["lastMessageTime"] is String) {
      lastMessageTime = json["lastMessageTime"];
    }
    if (json["lastMessageBy"] is String) {
      lastMessageBy = json["lastMessageBy"];
    }
    if (json["unReadCount"] is int) {
      unReadCount = json["unReadCount"];
    }
    if (json["timeStamp"] is String) {
      timeStamp = json["timeStamp"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["description"] = description;
    data["profileImage"] = profileImage;
    if (members != null) {
      data["members"] = members!.toList();
    }
    data["created_at"] = createdAt;
    data["created_by"] = createdBy;
    data["status"] = status;
    data["lastMessage"] = lastMessage;
    data["lastMessageTime"] = lastMessageTime;
    data["lastMessageBy"] = lastMessageBy;
    data["unReadCount"] = unReadCount;
    data["timeStamp"] = timeStamp;
    return data;
  }
}
