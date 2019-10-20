class Author {
  final String id;
  final String name;

  Author({
    this.id,
    this.name,
  });

  factory Author.fromMap(Map<String, dynamic> map, String id) => Author(
    id: id,
    name: map['name'] as String,
  );

  Map<String, dynamic> toMap() => <String, dynamic>{
    'id': id,
    'name': name,
  };
}
