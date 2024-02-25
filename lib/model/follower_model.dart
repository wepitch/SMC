class FollowerModel {
  String? message;
  Data? data;

  FollowerModel({this.message, this.data});

  FollowerModel.fromJson(Map<String, dynamic> json) {
    message = json['message'] ?? '';
    data = json['data'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      "message": message ?? '',
      "data": data ?? '',
    };
  }
}

class Data {
  String? sId;
  String? followedTo;
  String? followedBy;
  bool? followed;
  String? followerProfilePic;
  String? followerName;
  String? followerEmail;
  String? createdAt;
  String? updatedAt;
  num? iV;

  Data(
      {this.sId,
      this.followedTo,
      this.followedBy,
      this.followed,
      this.followerProfilePic,
      this.followerName,
      this.followerEmail,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] ?? '';
    followedTo = json['followed_to'] ?? '';
    followedBy = json['followed_by'] ??'';
    followed = json['followed'];
    followerProfilePic = json['follower_profile_pic'] ?? '';
    followerName = json['follower_name'] ?? '';
    followerEmail = json['follower_email'] ??'';
    createdAt = json['createdAt'] ?? '';
    updatedAt = json['updatedAt'] ??'';
    iV = json['__v'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['followed_to'] = this.followedTo;
    data['followed_by'] = this.followedBy;
    data['followed'] = this.followed;
    data['follower_profile_pic'] = this.followerProfilePic;
    data['follower_name'] = this.followerName;
    data['follower_email'] = this.followerEmail;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
