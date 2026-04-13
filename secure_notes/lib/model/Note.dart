class Note {
  final int? id;
  final String title;
  final String content;
  final String date;

  Note({this.id, required this.title, required this.content, required this.date});

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'description': content,
    'date': date,
  };

  factory Note.fromMap(Map<String, dynamic> map) => Note(
    id: map['id'],
    title: map['title'],
    content: map['description'],
    date: map['date'],
  );
}