import 'package:joy_bor/features/place/data/datasource/product_remote_datasource.dart';
import 'package:joy_bor/features/place/domain/entities/porduct_entity.dart';
import 'package:joy_bor/features/place/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDatasource remoteDatasource;
  ProductRepositoryImpl(this.remoteDatasource);

  @override
  Future<List<ProductEntity>> getAllProducts() async {
    return await remoteDatasource.fetchProducts();
  }
}
