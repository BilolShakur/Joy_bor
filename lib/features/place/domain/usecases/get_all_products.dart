import 'package:joy_bor/features/place/domain/entities/porduct_entity.dart';
import 'package:joy_bor/features/place/domain/repositories/product_repository.dart';

class GetAllProducts {
  final ProductRepository repository;
  GetAllProducts(this.repository);

  Future<List<ProductEntity>> call() async {
    return await repository.getAllProducts();
  }
}
