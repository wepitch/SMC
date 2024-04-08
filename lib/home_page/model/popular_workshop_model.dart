class PopularWorkShopModel {
  String? sId;
  String? sessionCounsellor;
  Null? sessionUser;
  String? sessionDate;
  int? sessionTime;
  int? sessionDuration;
  String? sessionType;
  int? sessionFee;
  String? sessionStatus;
  int? sessionSlots;
  String? sessionLink;
  String? createdAt;
  String? updatedAt;
  int? sessionAvailableSlots;
  int? iV;
  String? sessionMassagedDate;

  PopularWorkShopModel(
      {this.sId,
        this.sessionCounsellor,
        this.sessionUser,
        this.sessionDate,
        this.sessionTime,
        this.sessionDuration,
        this.sessionType,
        this.sessionFee,
        this.sessionStatus,
        this.sessionSlots,
        this.sessionLink,
        this.createdAt,
        this.updatedAt,
        this.sessionAvailableSlots,
        this.iV,
        this.sessionMassagedDate});

  PopularWorkShopModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sessionCounsellor = json['session_counsellor'];
    sessionUser = json['session_user'];
    sessionDate = json['session_date'];
    sessionTime = json['session_time'];
    sessionDuration = json['session_duration'];
    sessionType = json['session_type'];
    sessionFee = json['session_fee'];
    sessionStatus = json['session_status'];
    sessionSlots = json['session_slots'];
    sessionLink = json['session_link'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    sessionAvailableSlots = json['session_available_slots'];
    iV = json['__v'];
    sessionMassagedDate = json['session_massaged_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['session_counsellor'] = this.sessionCounsellor;
    data['session_user'] = this.sessionUser;
    data['session_date'] = this.sessionDate;
    data['session_time'] = this.sessionTime;
    data['session_duration'] = this.sessionDuration;
    data['session_type'] = this.sessionType;
    data['session_fee'] = this.sessionFee;
    data['session_status'] = this.sessionStatus;
    data['session_slots'] = this.sessionSlots;
    data['session_link'] = this.sessionLink;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['session_available_slots'] = this.sessionAvailableSlots;
    data['__v'] = this.iV;
    data['session_massaged_date'] = this.sessionMassagedDate;
    return data;
  }
}
