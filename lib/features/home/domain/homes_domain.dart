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
    required this.images,
    required this.description,
    this.isFavourite = false,
  });

  factory HomesDomain.fromMap(Map<String, dynamic> json) {
    return HomesDomain(
      id: json['id'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
      rating: (json['rating'] as num).toDouble(),
      location: json['location'] as String,
      price_per_month: json['price_per_month'] as String,
      type: json['type'] as String,
      beds: json['beds'] as String,
      baths: json['baths'] as String,
      sqft: json['sqft'] as String,
      isFavourite: json['is_favourite'] as bool? ?? false,
      images: json['images'] != null
          ? List<String>.from(json['images'] as List)
          : [],
      description: json['description'] as String,
    );
  }

  final String id;
  final String name;
  final String image;
  final double rating;
  final String location;
  final String type;
  final String beds;
  final String baths;
  final String sqft;
  final String price_per_month;
  final List<String> images;
  final String description;
  final bool isFavourite;

  HomesDomain copyWith({
    String? id,
    String? name,
    String? image,
    double? rating,
    String? location,
    String? type,
    String? beds,
    String? baths,
    String? sqft,
    String? price_per_month,
    String? description,
    List<String>? images,
    bool? isFavourite,
  }) {
    return HomesDomain(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      rating: rating ?? this.rating,
      location: location ?? this.location,
      type: type ?? this.type,
      beds: beds ?? this.beds,
      baths: baths ?? this.baths,
      sqft: sqft ?? this.sqft,
      price_per_month: price_per_month ?? this.price_per_month,
      images: images ?? this.images,
      description: description ?? this.description,
      isFavourite: isFavourite ?? this.isFavourite,
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
      'images': images,
      'description': description,
      'is_favourite': isFavourite,
    };
  }

  dynamic operator [](int other) {}
}
