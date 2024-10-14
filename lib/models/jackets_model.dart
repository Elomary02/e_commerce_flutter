import 'dart:convert';

List<Jacket> jacketFromJson(String str) => List<Jacket>.from(json.decode(str).map((x) => Jacket.fromJson(x)));

class Jacket {
  final String id;
  final String name;
  final String category;
  final List<dynamic> imageUrl;
  final String oldPrice;
  final List<dynamic> sizes;
  final String price;
  final String description;
  final String title;

  Jacket({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.oldPrice,
    required this.sizes,
    required this.price,
    required this.description,
    required this.title,
  });

  factory Jacket.fromJson(Map<String, dynamic> json) => Jacket(
    id: json["id"],
    name: json["name"],
    category: json["category"],
    imageUrl: json["imageUrl"],
    oldPrice: json["oldPrice"],
    sizes: List<dynamic>.from(json["sizes"].map((x) => x)),
    price: json["price"],
    description: json["description"],
    title: json["title"],
  );
}

