abstract class ProductEvent {}

class LoadProductsEvent extends ProductEvent {}

class SearchProductsEvent extends ProductEvent {
  final String query;
  SearchProductsEvent(this.query);
}
