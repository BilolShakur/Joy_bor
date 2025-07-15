import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joy_bor/features/place/domain/entities/porduct_entity.dart';
import 'package:joy_bor/features/place/domain/usecases/get_all_products.dart';

part 'product_event.dart';
part 'product_state.dart';
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetAllProducts getAllProducts;

  ProductBloc(this.getAllProducts) : super(const ProductState()) {
    on<LoadProductsEvent>(_onLoadProducts);
    on<SearchProductsEvent>(_onSearchProducts);
  }

  Future<void> _onLoadProducts(
    LoadProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final products = await getAllProducts();
      emit(
        state.copyWith(
          allProducts: products,
          filteredProducts: products,
          isLoading: false,
          error: null,
        ),
      );
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  void _onSearchProducts(
    SearchProductsEvent event,
    Emitter<ProductState> emit,
  ) {
    if (event.query.isEmpty) {
      emit(
        state.copyWith(filteredProducts: state.allProducts, query: event.query),
      );
      return;
    }

    final filtered =
        state.allProducts.where((product) {
          return product.title.toLowerCase().contains(
                event.query.toLowerCase(),
              ) ||
              product.description.toLowerCase().contains(
                event.query.toLowerCase(),
              ) ||
              product.category.toLowerCase().contains(
                event.query.toLowerCase(),
              );
        }).toList();

    emit(state.copyWith(filteredProducts: filtered, query: event.query));
  }
}
