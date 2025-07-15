import 'package:flutter/material.dart';

class LastSearchList extends StatelessWidget {
  final List<String> lastSearches;
  final Function(int) onDelete;
  final Function(String) onTap;

  const LastSearchList({
    required this.lastSearches,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Last Search",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: 8),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20),
            itemCount: lastSearches.length,
            itemBuilder: (context, index) {
              final search = lastSearches[index];
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.access_time, color: Colors.white54),
                title: Text(search, style: TextStyle(color: Colors.white)),
                trailing: IconButton(
                  icon: Icon(Icons.close, color: Colors.white54),
                  onPressed: () => onDelete(index),
                ),
                onTap: () => onTap(search),
              );
            },
          ),
        ),
      ],
    );
  }
}
