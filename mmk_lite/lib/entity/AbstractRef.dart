abstract class AbstractRef {
  String id = '';
  String name = '';

  Map toMap() => {
        'id': id,
        'name': name,
      };

  AbstractRef fromMap(Map m) {
    id = m['id'];
    name = m['name'];
    return this;
  }
}
