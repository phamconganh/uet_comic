class Search {
  final String id;
  final String name;

  Search({
    this.id,
    this.name,
  });

  factory Search.fromMap(Map<String, dynamic> map) => Search(
    id: map['id'] as String,
    name: map['name'] as String,
  );

  Map<String, dynamic> toMap() => <String, dynamic>{
    'id': id,
    'name': name,
  };
}
