class Author {
  final String id;
  final String name;

  Author({
    this.id,
    this.name,
  });

  factory Author.fromMap(Map<String, dynamic> map) => Author(
    id: map['id']?.toString(),
    name: map['name'] as String,
  );

  Map<String, dynamic> toMap() => <String, dynamic>{
    'id': id,
    'name': name,
  };
}
