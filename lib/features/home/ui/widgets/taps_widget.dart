import 'package:flutter/material.dart';
import 'package:onyx_task_app/features/home/logic/home_provider.dart';
import 'package:provider/provider.dart';

class TapsWidget extends StatefulWidget {
  const TapsWidget({super.key});

  @override
  State<TapsWidget> createState() => _TapsWidgetState();
}

class _TapsWidgetState extends State<TapsWidget> {
  Widget _buildTabButton(String title) {
    final isSelected = selectedTab == title;
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedTab = title;
        });
        context.read<HomeProvider>().filterByStatus(title);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isSelected ? Color.fromARGB(255, 1, 73, 128) : Colors.white,
        foregroundColor:
            isSelected ? Colors.white : Color.fromARGB(255, 1, 73, 128),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        elevation: isSelected ? 4 : 8,
      ),
      child: Text(title),
    );
  }

  String selectedTab = 'New';
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [_buildTabButton('New'), _buildTabButton('Others')],
    );
  }
}
