part of 'product_bloc.dart';

class ProductState extends Equatable {
  final List<ProductEntity> allProducts;
  final List<ProductEntity> filteredProducts;
  final bool isLoading;
  final String? error;
  final String query;

  const ProductState({
    this.allProducts = const [],
    this.filteredProducts = const [],
    this.isLoading = false,
    this.error,
    this.query = '',
  });

  ProductState copyWith({
    List<ProductEntity>? allProducts,
    List<ProductEntity>? filteredProducts,
    bool? isLoading,
    String? error,
    String? query,
  }) {
    return ProductState(
      allProducts: allProducts ?? this.allProducts,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      query: query ?? this.query,
    );
  }

  @override
  List<Object?> get props => [
    allProducts,
    filteredProducts,
    isLoading,
    error,
    query,
  ];
}
