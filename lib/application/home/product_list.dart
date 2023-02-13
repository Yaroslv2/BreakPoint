class Product {
  int id;
  String mainPhoto;
  String label;
  double price;

  Product({
    required this.id,
    required this.mainPhoto,
    required this.label,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["item_id"],
        mainPhoto: json["main_photo_src"],
        label: json["name"],
        price: json["price"],
      );
}

int itemCounter = 0;
List<Product> productList = [];
