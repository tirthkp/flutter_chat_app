class UserModel {
  String? id;
  String? name;
  String? email;
  String? profileImage;
  String? phoneNumber;
  String? about;
  String? createdAt;
  String? lastOnlineStatus;
  String? status;
  String? role;

  UserModel(
      {this.id,
      this.name,
      this.email,
      this.profileImage,
      this.phoneNumber,
      this.about,
      this.createdAt,
      this.lastOnlineStatus,
      this.status,
      this.role});

  UserModel.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["email"] is String) {
      email = json["email"];
    }
    if (json["profileImage"] is String) {
      profileImage = json["profileImage"];
    }
    if (json["phoneNumber"] is String) {
      phoneNumber = json["phoneNumber"];
    }
    if (json["about"] is String) {
      about = json["about"];
    }
    if (json["createdAt"] is String) {
      createdAt = json["createdAt"];
    }
    if (json["lastOnlineStatus"] is String) {
      lastOnlineStatus = json["lastOnlineStatus"];
    }
    if (json["status"] is String) {
      status = json["status"];
    }
    if (json["role"] is String) {
      role = json["role"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["email"] = email;
    data["profileImage"] = profileImage;
    data["phoneNumber"] = phoneNumber;
    data["about"] = about;
    data["createdAt"] = createdAt;
    data["lastOnlineStatus"] = lastOnlineStatus;
    data["status"] = status;
    data["role"] = role;
    return data;
  }
  /*
  {
    "id":"",
    "name":"",
    "email":"",
    "profileImage":"",
    "phoneNumber":"",
    "about":"",
    "createdAt":"",
    "lastOnlineStatus":"",
    "status":"",
    "role":""
  }
  */
}
