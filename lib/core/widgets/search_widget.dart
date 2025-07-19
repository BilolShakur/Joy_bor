import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_images.dart';
import 'filter_bottom_sheet.dart';

class SearchTextField extends StatefulWidget {
  final String hintText;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final TextEditingController? controller;

  const SearchTextField({
    super.key,
    this.hintText = 'Search',
    this.onChanged,
    this.onSubmitted,
    this.controller,
  });

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(40),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Row(
          children: [
            Icon(Icons.search, color: Colors.grey, size: 24),
            SizedBox(width: 10),
            Text("Search", style: TextStyle(color: Colors.grey, fontSize: 18)),
            Spacer(),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  barrierColor: Colors.black,
                  builder: (_) => FilterBottomSheet(),
                );
              },
              child: Padding(
                padding: EdgeInsets.only(top: 5, right: 5, bottom: 5),
                child: Container(
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                    color: AppColors.yellow,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(13),
                    child: Image.asset(AppImages.filter),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
