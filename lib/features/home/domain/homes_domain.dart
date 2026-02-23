class HomesDomain {
  HomesDomain({
    required this.id,
    required this.name,
    required this.image,
    required this.rating,
    required this.location,
    required this.price_per_month,
    required this.type,
    required this.beds,
    required this.baths,
    required this.sqft,
  });

  factory HomesDomain.fromMap(Map<String, dynamic> json) {
    return HomesDomain(
      id: json['id'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
      rating: (json['rating'] as num).toDouble(),
      location: json['location'] as String,
      price_per_month: (json['price_per_month'] as num).toDouble(),
      type: json['type'] as String,
      beds: (json['beds'] as num).toDouble(),
      baths: (json['baths'] as num).toDouble(),
      sqft: (json['sqft'] as num).toDouble(),
    );
  }

  final String id;
  final String name;
  final String image;
  final double rating;
  final String location;
  final String type;
  final double beds;
  final double baths;
  final double sqft;
  final double price_per_month;

  HomesDomain copyWith({
    String? id,
    String? name,
    String? image,
    double? rating,
    String? location,
    String? type,
    double? beds,
    double? baths,
    double? sqft,
    double? price_per_month,
  }) {
    return HomesDomain(
      id: this.id,
      name: this.name,
      image: this.image,
      rating: this.rating,
      location: this.location,
      type: this.type,
      beds: this.beds,
      baths: this.baths,
      sqft: this.sqft,
      price_per_month: this.price_per_month,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'rating': rating,
      'location': location,
      'type': type,
      'beds': beds,
      'baths': baths,
      'sqft': sqft,
      'price_per_month': price_per_month,
    };
  }
}
