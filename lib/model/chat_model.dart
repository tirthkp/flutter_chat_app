class ChatModel {
  String? id;
  String? message;
  String? senderName;
  String? senderId;
  String? receiverId;
  String? timeStamp;
  String? currentTime;
  String? readStatus;
  String? imageUrl;
  String? videoUrl;
  String? audioUrl;
  String? documentId;
  List<String>? reactions;
  List<dynamic>? replies;

  ChatModel(
      {this.id,
      this.message,
      this.senderName,
      this.senderId,
      this.receiverId,
      this.timeStamp,
      this.currentTime,
      this.readStatus,
      this.imageUrl,
      this.videoUrl,
      this.audioUrl,
      this.documentId,
      this.reactions,
      this.replies});

  ChatModel.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["message"] is String) {
      message = json["message"];
    }
    if (json["senderName"] is String) {
      senderName = json["senderName"];
    }
    if (json["senderId"] is String) {
      senderId = json["senderId"];
    }
    if (json["receiverId"] is String) {
      receiverId = json["receiverId"];
    }
    if (json["timeStamp"] is String) {
      timeStamp = json["timeStamp"];
    }
    if (json["currentTime"] is String) {
      currentTime = json["currentTime"];
    }
    if (json["readStatus"] is String) {
      readStatus = json["readStatus"];
    }
    if (json["imageUrl"] is String) {
      imageUrl = json["imageUrl"];
    }
    if (json["videoUrl"] is String) {
      videoUrl = json["videoUrl"];
    }
    if (json["audioUrl"] is String) {
      audioUrl = json["audioUrl"];
    }
    if (json["documentId"] is String) {
      documentId = json["documentId"];
    }
    if (json["reactions"] is List) {
      reactions = json["reactions"] == null
          ? null
          : List<String>.from(json["reactions"]);
    }
    if (json["replies"] is List) {
      replies = json["replies"] ?? [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["message"] = message;
    data["senderName"] = senderName;
    data["senderId"] = senderId;
    data["receiverId"] = receiverId;
    data["timeStamp"] = timeStamp;
    data["currentTime"] = currentTime;
    data["readStatus"] = readStatus;
    data["imageUrl"] = imageUrl;
    data["videoUrl"] = videoUrl;
    data["audioUrl"] = audioUrl;
    data["documentId"] = documentId;
    if (reactions != null) {
      data["reactions"] = reactions;
    }
    if (replies != null) {
      data["replies"] = replies;
    }
    return data;
  }
}
// {
//   "id":"",
//   "message":"",
//   "senderName":"",
//   "senderId":"",
//   "receiverId":"",
//   "timeStamp":"",
//   "currentTime":"",
//   "readStatus":"",
//   "imageUrl":"",
//   "videoUrl":"",
//   "audioUrl":"",
//   "documentId":"",
//   "reactions":["",""],
//   "replies":[]
// }