import 'package:flutter/material.dart';
import 'package:flutter_movies/constants/app_theme.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(showSelectedLabels: false, selectedItemColor: AppTheme.orange, unselectedItemColor: AppTheme.white, items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home', backgroundColor: AppTheme.blue),
      BottomNavigationBarItem(icon: Icon(Icons.bookmark_border_outlined), label: 'Bookmark', backgroundColor: AppTheme.blue),
      BottomNavigationBarItem(icon: Icon(Icons.movie_outlined), label: 'Ticket', backgroundColor: AppTheme.blue),
      BottomNavigationBarItem(icon: Icon(Icons.person_outline_outlined), label: 'Profile', backgroundColor: AppTheme.blue),
    ]);
  }
}
