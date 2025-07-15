import 'package:joy_bor/features/place/domain/entities/porduct_entity.dart';

abstract class ProductRepository {
  Future<List<ProductEntity>> getAllProducts();
}
