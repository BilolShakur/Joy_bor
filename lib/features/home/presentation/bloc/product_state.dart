import 'package:joy_bor/features/place/domain/entities/product_entity.dart';

abstract class ProductState {
  List<ProductEntity> get allProducts => [];
  List<ProductEntity> get filteredProducts => [];
  bool get isLoading => false;
  String get query => '';
  String? get error => null;
  ProductState copyWith({
    List<ProductEntity>? allProducts,
    List<ProductEntity>? filteredProducts,
    bool? isLoading,
    String? query,
    String? error,
  }) => this;
}

class ProductInitial extends ProductState {
  @override
  ProductState copyWith({
    List<ProductEntity>? allProducts,
    List<ProductEntity>? filteredProducts,
    bool? isLoading,
    String? query,
    String? error,
  }) => this;
}

class ProductLoading extends ProductState {
  @override
  bool get isLoading => true;
  @override
  ProductState copyWith({
    List<ProductEntity>? allProducts,
    List<ProductEntity>? filteredProducts,
    bool? isLoading,
    String? query,
    String? error,
  }) => this;
}

class ProductLoaded extends ProductState {
  final List<ProductEntity> _allProducts;
  final List<ProductEntity> _filteredProducts;
  final String _query;
  final String? _error;
  ProductLoaded({
    required List<ProductEntity> allProducts,
    required List<ProductEntity> filteredProducts,
    String query = '',
    String? error,
  }) : _allProducts = allProducts,
       _filteredProducts = filteredProducts,
       _query = query,
       _error = error;
  @override
  List<ProductEntity> get allProducts => _allProducts;
  @override
  List<ProductEntity> get filteredProducts => _filteredProducts;
  @override
  String get query => _query;
  @override
  String? get error => _error;
  @override
  ProductState copyWith({
    List<ProductEntity>? allProducts,
    List<ProductEntity>? filteredProducts,
    bool? isLoading,
    String? query,
    String? error,
  }) {
    return ProductLoaded(
      allProducts: allProducts ?? _allProducts,
      filteredProducts: filteredProducts ?? _filteredProducts,
      query: query ?? _query,
      error: error ?? _error,
    );
  }
}

class ProductError extends ProductState {
  final String? _error;
  ProductError({String? error}) : _error = error;
  @override
  String? get error => _error;
  @override
  ProductState copyWith({
    List<ProductEntity>? allProducts,
    List<ProductEntity>? filteredProducts,
    bool? isLoading,
    String? query,
    String? error,
  }) {
    return ProductError(error: error ?? _error);
  }
}
