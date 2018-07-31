class Beer {
  final int id;
  final String name;
  final String imageUrl;

  Beer({this.id, this.name, this.imageUrl});

  @override
  String toString() {
      return '\n(id=$id : name=$name)\n';
  }

  // Static method
  factory Beer.fromJson(Map<String, dynamic> json) {
    return Beer(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image_url'],
    );
  }
}