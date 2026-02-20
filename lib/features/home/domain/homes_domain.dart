class HomesDomain {
  HomesDomain({
    required this.id,
    required this.name,
    required this.image,
    required this.rating,
    required this.location,
  });

  factory HomesDomain.fromMap(Map<String, dynamic> json) {
    return HomesDomain(
      id: json['id'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
      rating: json['rating'] as double,
      location: json['location'] as String,
    );
  }

  final String id;
  final String name;
  final String image;
  final double rating;
  final String location;

  HomesDomain copyWith({
    String? id,
    String? name,
    String? image,
    double? rating,
    String? location,
  }) {
    return HomesDomain(
      id: this.id,
      name: this.name,
      image: this.image,
      rating: this.rating,
      location: this.location,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'rating': rating,
      'location': location,
    };
  }
}
