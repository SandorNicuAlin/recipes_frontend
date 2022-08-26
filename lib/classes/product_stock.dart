import 'product.dart';

class ProductStock {
  ProductStock({
    required this.id,
    required this.quantity,
    required this.product,
  });

  int id;
  double quantity;
  Product product;
}
