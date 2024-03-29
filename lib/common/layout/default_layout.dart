import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Widget child;
  final Color? backgoundColor;
  final String? title;
  final BottomNavigationBar? bottomNavigationBar;
  final Widget? floatingActionButton;
  const DefaultLayout({
    super.key,
    required this.child,
    this.backgoundColor,
    this.title,
    this.bottomNavigationBar,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgoundColor ?? Colors.white,
      appBar: renderAppBar(),
      body: child,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
    );
  }

  AppBar? renderAppBar() {
    if (title == null) {
      return null;
    } else {
      return AppBar(
        backgroundColor: Colors.white,
        title: Text(
          title!,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        foregroundColor: Colors.black,
        elevation: 0,
      );
    }
  }
}
