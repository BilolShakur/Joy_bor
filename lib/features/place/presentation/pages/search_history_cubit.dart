import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchHistoryCubit extends Cubit<List<String>> {
  SearchHistoryCubit() : super([]);

  Future<void> loadLastSearches() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList('last_searches') ?? [];
    emit(List<String>.from(saved));
  }

  Future<void> saveSearchQuery(String query) async {
    if (query.trim().isEmpty) return;
    final prefs = await SharedPreferences.getInstance();
    final current = List<String>.from(state);
    current.remove(query);
    current.insert(0, query);
    emit(List<String>.from(current));
    await prefs.setStringList('last_searches', current);
  }

  Future<void> deleteSearchQuery(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final current = List<String>.from(state);
    if (index >= 0 && index < current.length) {
      current.removeAt(index);
      emit(List<String>.from(current));
      await prefs.setStringList('last_searches', current);
    }
  }
}
