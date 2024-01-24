class NotificationModel {
  String? id;
  String? date;
  String? time;
  String title;
  String description;

  NotificationModel({
    this.id,
    this.date,
    this.time,
    required this.title,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'date': date,
      'time': time,
      'title': title,
      'description': description,
    };
  }

  static NotificationModel fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'],
      date: map['date'],
      time: map['time'],
      title: map['title'],
      description: map['description'],
    );
  }
}
