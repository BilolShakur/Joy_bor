import '../datasource/product_remote_datasource.dart';
import '../../domain/repositories/product_repository.dart';

import 'package:joy_bor/features/place/domain/entities/product_entity.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDatasource remoteDatasource;
  ProductRepositoryImpl(this.remoteDatasource);

  @override
  Future<List<ProductEntity>> getAllProducts() async {
    return await remoteDatasource.fetchProducts();
  }
}
