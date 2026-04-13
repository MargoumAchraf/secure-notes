class Note {
  int? id;
  String title;
  String description;

  Note({this.id, required this.title, required this.description});

  // Convert a Note to a Map (for inserting into DB)
  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'description': description};
  }

  // Create a Note from a Map (for reading from DB)
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      description: map['description'],
    );
  }
}
