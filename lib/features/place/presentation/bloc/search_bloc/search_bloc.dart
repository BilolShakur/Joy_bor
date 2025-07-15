import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joy_bor/features/place/domain/entities/porduct_entity.dart';
import 'package:joy_bor/features/place/domain/repositories/product_repository.dart';
part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ProductRepository repository;

  SearchBloc(this.repository) : super(SearchInitial()) {
    on<SearchQueryChanged>((event, emit) async {
      if (event.query.trim().isEmpty) {
        emit(SearchInitial());
        return;
      }
      emit(SearchLoading());
      try {
        final allProducts = await repository.getAllProducts();
        final results =
            allProducts
                .where(
                  (product) => product.title.toLowerCase().contains(
                    event.query.toLowerCase(),
                  ),
                )
                .toList();
        emit(SearchLoaded(results));
      } catch (e) {
        emit(SearchError("Qidiruvda xatolik yuz berdi"));
      }
    });
  }
}
