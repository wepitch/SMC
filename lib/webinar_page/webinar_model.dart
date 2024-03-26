class WebinarModel {
  String? webinarImage;
  String? webinarTitle;
  String? webinarDate;
  String? webinarBy;
  String? speakerProfile;
  bool? registered;

  WebinarModel(
      {this.webinarImage,
      this.webinarTitle,
      this.webinarDate,
      this.webinarBy,
      this.speakerProfile,
      this.registered});

  WebinarModel.fromJson(Map<String, dynamic> json) {
    webinarImage = json['webinar_image'] ?? 'N/A';
    webinarTitle = json['webinar_title'] ?? 'N/A';
    webinarDate = json['webinar_date'] ?? 'N/A';
    webinarBy = json['webinar_by'] ?? 'N/A';
    speakerProfile = json['speaker_profile'] ?? 'N/A';
    registered = json['registered'] ?? 'N/A';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['webinar_image'] = webinarImage;
    data['webinar_title'] = webinarTitle;
    data['webinar_date'] = webinarDate;
    data['webinar_by'] = webinarBy;
    data['speaker_profile'] = speakerProfile;
    data['registered'] = registered;
    return data;
  }
}
