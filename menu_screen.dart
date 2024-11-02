import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:hive/hive.dart';
import 'package:hooka/screens/username.dart';
import 'contact_us_screen.dart';
import 'log_in.dart';
import 'main_screen.dart';
import 'settings.dart';

class MenuScreen extends StatefulWidget {
  final ZoomDrawerController zoomDrawerController;
  final Function(Widget) onScreenSelected;

  const MenuScreen({
    Key? key,
    required this.zoomDrawerController,
    required this.onScreenSelected,
  }) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  bool isLoggedIn = false;
  String? username; // Variable to store the username
  int _selectedIndex = 0;

  void _toggleDrawer() {
    widget.zoomDrawerController.toggle!();
  }

  @override
  void initState() {
    super.initState();
    _checkLoginStatus(); // Check login status on initialization
  }

  Future<void> _checkLoginStatus() async {
    final authBox = await Hive.openBox('userAuth');
    final loggedInUserId = authBox.get('loggedInUser Id') as String?;
    setState(() {
      isLoggedIn = loggedInUserId != null; // Update isLoggedIn based on user ID
      username = authBox.get('username') as String?; // Fetch username if logged in
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UsernamePage(onBack: _toggleDrawer)),
                  );
                  widget.zoomDrawerController.toggle!();
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.yellow,
                        child: Icon(Icons.person, color: Colors.black),
                      ),
                      SizedBox(width: 15),
                      Text(
                        username ?? 'Username', // Show actual username if available
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              // Menu items
              ListTile(
                leading: Icon(Icons.home, color: _selectedIndex == 0 ? Colors.black : Colors.yellow),
                title: Text('Main Screen', style: TextStyle(color: _selectedIndex == 0 ? Colors.black : Colors.white)),
                tileColor: _selectedIndex == 0 ? Colors.yellow : null,
                onTap: () {
                  setState(() {
                    _selectedIndex = 0;
                  });
                  widget.zoomDrawerController.close!();
                  widget.onScreenSelected(MainScreen(isLoggedIn: isLoggedIn)); // Pass the correct login state
                },
              ),
              ListTile(
                leading: Icon(Icons.fact_check_outlined, color: _selectedIndex == 1 ? Colors.black : Colors.yellow),
                title: Text('Checkout', style: TextStyle(color: _selectedIndex == 1 ? Colors.black : Colors.white)),
                tileColor: _selectedIndex == 1 ? Colors.yellow : null,
                onTap: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                  widget.zoomDrawerController.close!();
                },
              ),
              ListTile(
                leading: Icon(Icons.star_border, color: _selectedIndex == 2 ? Colors.black : Colors.yellow),
                title: Text('My Orders', style: TextStyle(color: _selectedIndex == 2 ? Colors.black : Colors.white)),
                tileColor: _selectedIndex == 2 ? Colors.yellow : null,
                onTap: () {
                  setState(() {
                    _selectedIndex = 2;
                  });
                  widget.zoomDrawerController.close!();
                },
              ),
              ListTile(
                leading: Icon(Icons.date_range, color: _selectedIndex == 3 ? Colors.black : Colors.yellow),
                title: Text('Invitations', style: TextStyle(color: _selectedIndex == 3 ? Colors.black : Colors.white)),
                tileColor: _selectedIndex == 3 ? Colors.yellow : null,
                onTap: () {
                  setState(() {
                    _selectedIndex = 3;
                  });
                  widget.zoomDrawerController.close!();
                },
              ),
              ListTile(
                leading: Icon(Icons.notifications, color: _selectedIndex == 4 ? Colors.black : Colors.yellow),
                title: Text('Notifications', style: TextStyle(color: _selectedIndex == 4 ? Colors.black : Colors.white)),
                tileColor: _selectedIndex == 4 ? Colors.yellow : null,
                onTap: () {
                  setState(() {
                    _selectedIndex = 4;
                  });
                  widget.zoomDrawerController.close!();
                },
              ),
              ListTile(
                leading: Icon(Icons.mail, color: _selectedIndex == 5 ? Colors.black : Colors.yellow),
                title: Text('Contact us', style: TextStyle(color: _selectedIndex == 5 ? Colors.black : Colors.white)),
                tileColor: _selectedIndex == 5 ? Colors.yellow : null,
                onTap: () {
                  setState(() {
                    _selectedIndex = 5;
                  });
                  widget.zoomDrawerController.close!();
                  widget.onScreenSelected(ContactUsScreen(zoomDrawerController: widget.zoomDrawerController));
                },
              ),
              ListTile(
                leading: Icon(Icons.settings, color: _selectedIndex == 6 ? Colors.black : Colors.yellow),
                title: Text('Settings', style: TextStyle(color: _selectedIndex == 6 ? Colors.black : Colors.white)),
                tileColor: _selectedIndex == 6 ? Colors.yellow : null,
                onTap: () {
                  setState(() {
                    _selectedIndex = 6;
                  });
                  widget.zoomDrawerController.close!();
                  widget.onScreenSelected(SettingsScreen(zoomDrawerController: widget.zoomDrawerController));
                },
              ),
              isLoggedIn
                  ? ListTile(
                leading: Icon(Icons.logout, color: _selectedIndex == 7 ? Colors.black : Colors.yellow),
                title: Text('Logout', style: TextStyle(color: _selectedIndex == 7 ? Colors.black : Colors.white)),
                tileColor: _selectedIndex == 7 ? Colors.yellow : null,
                onTap: () async {
                  await _logoutUser ();

                  setState(() {
                    _selectedIndex = 7;
                    isLoggedIn = false; // Update login status on logout
                  });
                  widget.zoomDrawerController.close!();
                },
              )
                  : ListTile(
                leading: Icon(Icons.login, color: _selectedIndex == 7 ? Colors.black : Colors.yellow),
                title: Text('Login', style: TextStyle(color: _selectedIndex == 7 ? Colors.black : Colors.white)),
                tileColor: _selectedIndex == 7 ? Colors.yellow : null,
                onTap: () {
                  setState(() {
                    _selectedIndex = 7;
                  });
                  widget.zoomDrawerController.close!();
                  // Navigate to the login page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()), // Replace LoginPage with your actual login page
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _logoutUser () async {
    final authBox = await Hive.openBox('userAuth');
    await authBox.delete('loggedInUser  Id');
    await authBox.delete('username'); // Clear username as well

    // Navigate to the login page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen(isLoggedIn: false)),
    );
  }
}
