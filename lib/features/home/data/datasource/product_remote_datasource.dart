import 'package:joy_bor/features/place/domain/entities/product_entity.dart';


abstract class ProductRemoteDatasource {
  Future<List<ProductEntity>> fetchProducts();
}
