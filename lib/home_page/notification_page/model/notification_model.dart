class NotificationModel {
  String? id;
  String date;
  String title;
  String description;

  NotificationModel({
    this.id,
    required this.date,
    required this.title,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'date': date,
      'title': title,
      'description': description,
    };
  }

  static NotificationModel fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'],
      date: map['date'],
      title: map['title'],
      description: map['description'],
    );
  }
}
