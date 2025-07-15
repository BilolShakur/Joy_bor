import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joy_bor/core/constants/app_images.dart';
import 'package:joy_bor/features/place/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:joy_bor/features/place/presentation/widgets/last_search_list.dart';
import 'package:joy_bor/features/place/presentation/widgets/search_app_bar.dart';
import 'package:joy_bor/features/place/presentation/widgets/search_field.dart';
import 'package:joy_bor/features/place/presentation/widgets/search_results.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  List<String> lastSearches = [];

  @override
  void initState() {
    super.initState();
    _loadLastSearches();
    _controller.addListener(() {
      final query = _controller.text;
      context.read<SearchBloc>().add(SearchQueryChanged(query));
    });
  }

  Future<void> _loadLastSearches() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList('last_searches');
    if (saved != null) {
      setState(() => lastSearches = saved);
    }
  }

  Future<void> _saveSearchQuery(String query) async {
    if (query.trim().isEmpty) return;
    setState(() {
      lastSearches.remove(query);
      lastSearches.insert(0, query);
    });
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('last_searches', lastSearches);
  }

  Future<void> _deleteSearchQuery(int index) async {
    setState(() => lastSearches.removeAt(index));
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('last_searches', lastSearches);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(AppImages.splash, fit: BoxFit.cover),
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: 10),
                SearchAppBar(),
                SizedBox(height: 30),
                SearchField(controller: _controller),
                SizedBox(height: 24),
                Expanded(
                  child: BlocBuilder<SearchBloc, SearchState>(
                    builder: (context, state) {
                      if (_controller.text.isEmpty) {
                        return LastSearchList(
                          lastSearches: lastSearches,
                          onDelete: _deleteSearchQuery,
                          onTap: (query) {
                            _controller.text = query;
                            context.read<SearchBloc>().add(
                              SearchQueryChanged(query),
                            );
                          },
                        );
                      } else if (state is SearchLoading) {
                        return Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        );
                      } else if (state is SearchLoaded) {
                        return SearchResults(
                          results: state.results,
                          onTap: (product) => _saveSearchQuery(product.title),
                        );
                      } else if (state is SearchError) {
                        return Center(
                          child: Text(
                            state.message,
                            style: TextStyle(color: Colors.redAccent),
                          ),
                        );
                      }
                      return SizedBox();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
