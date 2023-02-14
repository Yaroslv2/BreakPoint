class CartItem {
  String id;
  String photo_src;
  String label;
  double price;

  CartItem({
    required this.id,
    required this.label,
    required this.photo_src,
    required this.price,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        id: json["item_id"],
        label: json["name"],
        photo_src: json["main_photo_src"],
        price: json["price"].toDouble(),
      );
}

int cartItemCounter = 0;
List<CartItem> cart = [];
