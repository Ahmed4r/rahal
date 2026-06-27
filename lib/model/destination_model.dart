class DestinationModel {
  int id;
  String name;
  String imageUrl;
  double rating;
  bool isFavorite;
  String location;
  String description;
  String price;
  String duration;

  DestinationModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.isFavorite,
    required this.location,
    required this.description,
    required this.price,
    required this.duration,
  });

  Map<String, Object> tojson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'rating': rating,
      'isFavorite': isFavorite,
      'location': location,
      'description': description,
      'price': price,
      'duration': duration,
    };
  }

  DestinationModel fromjson(Map<String, Object> json) {
    return DestinationModel(
      id: json['id'] as int,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      rating: json['rating'] as double,
      isFavorite: json['isFavorite'] as bool,
      location: json['location'] as String,
      description: json['description'] as String,
      price: json['price'] as String,
      duration: json['duration'] as String,
    );
  }
}
