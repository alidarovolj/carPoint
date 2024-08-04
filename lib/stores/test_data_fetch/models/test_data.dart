class TestData {
  final String title;
  final double longitude;
  final double latitude;
  final String address;
  final String city;
  final String country;
  final String postalCode;
  final List<String> images;
  final Map<String, dynamic> prices;
  final Map<String, String> workingTime;
  final bool isInFavourites;
  final bool isOpen;
  final double overallRating;
  final List<Review> reviews;

  TestData({
    required this.title,
    required this.longitude,
    required this.latitude,
    required this.address,
    required this.city,
    required this.country,
    required this.postalCode,
    required this.images,
    required this.prices,
    required this.workingTime,
    required this.isInFavourites,
    required this.isOpen,
    required this.overallRating,
    required this.reviews,
  });

  factory TestData.fromJson(Map<String, dynamic> json) {
    var reviewsList = json['reviews']['objects_list'] as List;
    List<Review> reviews = reviewsList.map((i) => Review.fromJson(i)).toList();

    return TestData(
      title: json['title'],
      longitude: double.parse(json['location']['longitude']),
      latitude: double.parse(json['location']['latitude']),
      address: json['location']['address'],
      city: json['location']['city'],
      country: json['location']['country'],
      postalCode: json['location']['postalCode'],
      images: List<String>.from(json['images']),
      prices: json['prices'],
      workingTime: Map<String, String>.from(json['working_time']),
      isInFavourites: json['is_in_favourites'],
      isOpen: json['is_open'],
      overallRating: double.parse(json['reviews']['overall_rating']),
      reviews: reviews,
    );
  }
}

class Review {
  final String id;
  final String name;
  final String avatar;
  final String brand;
  final String model;
  final String rating;
  final String text;

  Review({
    required this.id,
    required this.name,
    required this.avatar,
    required this.brand,
    required this.model,
    required this.rating,
    required this.text,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['author']['id'],
      name: json['author']['name'],
      avatar: json['author']['avatar'],
      brand: json['author']['car']['brand'],
      model: json['author']['car']['model'],
      rating: json['rating'],
      text: json['text'],
    );
  }
}
