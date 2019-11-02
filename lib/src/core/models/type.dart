class Type {
  final String id;
  final String name;

  Type({
    this.id,
    this.name,
  });

  factory Type.fromMap(Map<String, dynamic> map) => Type(
    id: map['id']?.toString(),
    name: map['name'] as String,
  );

  Map<String, dynamic> toMap() => <String, dynamic>{
    'id': id,
    'name': name,
  };
}
