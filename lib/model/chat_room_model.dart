import 'package:flutter_chat_app/model/chat_model.dart';

import 'user_model.dart';

class ChatRoomModel {
  String? id;
  UserModel? sender;
  UserModel? receiver;
  List<ChatModel>? messages;
  int? unreadMessageNo;
  String? lastMessage;
  String? lastMessageTime;
  String? timeStamp;

  ChatRoomModel(
      {this.id,
      this.sender,
      this.receiver,
      this.messages,
      this.unreadMessageNo,
      this.lastMessage,
      this.lastMessageTime,
      this.timeStamp});

  ChatRoomModel.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["sender"] is Map) {
      sender =
          json["sender"] == null ? null : UserModel.fromJson(json["sender"]);
    }
    if (json["receiver"] is Map) {
      receiver = json["receiver"] == null
          ? null
          : UserModel.fromJson(json["receiver"]);
    }
    if (json["messages"] is List) {
      messages = json["messages"] ?? [];
    }
    if (json["unreadMessageNo"] is int) {
      unreadMessageNo = json["unreadMessageNo"];
    }
    if (json["lastMessage"] is String) {
      lastMessage = json["lastMessage"];
    }
    if (json["lastMessageTime"] is String) {
      lastMessageTime = json["lastMessageTime"];
    }
    if (json["timeStamp"] is String) {
      timeStamp = json["timeStamp"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    if (sender != null) {
      data["sender"] = sender?.toJson();
    }
    if (receiver != null) {
      data["receiver"] = receiver?.toJson();
    }
    if (messages != null) {
      data["messages"] = messages;
    }
    data["unreadMessageNo"] = unreadMessageNo;
    data["lastMessage"] = lastMessage;
    data["lastMessageTime"] = lastMessageTime;
    data["timeStamp"] = timeStamp;
    return data;
  }
}
