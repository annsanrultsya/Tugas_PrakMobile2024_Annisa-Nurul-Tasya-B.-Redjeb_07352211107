class Book {
  final int? id;
  final String title;
  final String author;
  final String description;

  Book({
    this.id,
    required this.title,
    required this.author,
    required this.description,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'author': author,
        'description': description,
      };
}
