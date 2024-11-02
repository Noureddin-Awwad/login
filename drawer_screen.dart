import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'main_screen.dart';
import 'menu_screen.dart';

class DrawerScreen extends StatefulWidget {
  final bool isLoggedIn; // Add this parameter
  const DrawerScreen({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final zoomDrawerController = ZoomDrawerController();
  late Widget currentScreen;

  @override
  void initState() {
    super.initState();
    // Initialize currentScreen based on isLoggedIn
    currentScreen = MainScreen(isLoggedIn: widget.isLoggedIn);
  }

  @override
  void didUpdateWidget(DrawerScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update currentScreen if isLoggedIn changes
    if (oldWidget.isLoggedIn != widget.isLoggedIn) {
      setState(() {
        currentScreen = MainScreen(isLoggedIn: widget.isLoggedIn);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: zoomDrawerController,
      menuScreen: MenuScreen(
        zoomDrawerController: zoomDrawerController,
        onScreenSelected: (screen) {
          setState(() {
            currentScreen = screen;
          });
        },
      ),
      mainScreen: currentScreen,
      showShadow: true,
      drawerShadowsBackgroundColor: Colors.transparent,
      mainScreenTapClose: true,
    );
  }
}
