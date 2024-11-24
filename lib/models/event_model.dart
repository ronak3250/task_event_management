class EventModel {
  String id;
  String title;
  String description;
  String location;
  DateTime date;
  String time;
  String? imageUrl;
  String? recurrence;
  String? userId;

  EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.date,
    required this.time,
    this.imageUrl,
    this.recurrence,
     this.userId='',
  });

  // CopyWith method to update fields
  EventModel copyWith({
    String? id,
    String? title,
    String? description,
    String? location,
    DateTime? date,
    String? time,
    String? imageUrl,
    String? recurrence,
    String? userId,
  }) {
    return EventModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      location: location ?? this.location,
      date: date ?? this.date,
      time: time ?? this.time,
      imageUrl: imageUrl ?? this.imageUrl,
      recurrence: recurrence ?? this.recurrence,
      userId: userId ?? this.userId,
    );
  }

  factory EventModel.fromMap(String id, Map<String, dynamic> data) {
    return EventModel(
      id: id,
      title: data['title'],
      description: data['description'],
      location: data['location'],
      date: DateTime.parse(data['date']),
      time: data['time'],
      imageUrl: data['imageUrl'],
      recurrence: data['recurrence'],
      userId: data['userId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'location': location,
      'date': date.toIso8601String(),
      'time': time,
      'imageUrl': imageUrl,
      'recurrence': recurrence,
      'userId': userId,
    };
  }
}
