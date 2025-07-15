import 'package:dio/dio.dart';
import 'package:joy_bor/features/place/data/datasource/product_remote_datasource.dart';
import 'package:joy_bor/features/place/domain/entities/porduct_entity.dart';

class ProductRemoteDatasourceImpl implements ProductRemoteDatasource {
  final Dio dio;
  ProductRemoteDatasourceImpl(this.dio);

  @override
  Future<List<ProductEntity>> fetchProducts() async {
    try {
      final response = await dio.get('https://fakestoreapi.com/products');
      return (response.data as List)
          .map((e) => ProductEntity.fromJson(e))
          .toList();
    } catch (e) {
      throw Exception('Ma\'lumot yuklanmadi');
    }
  }
}
