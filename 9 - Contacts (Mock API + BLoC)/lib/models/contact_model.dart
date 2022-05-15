class Contact{
  String? id;
  String? name;
  String? number;

  Contact({this.id, this.name, this.number});

  Contact.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        number = json['number'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'number': number,
  };
}