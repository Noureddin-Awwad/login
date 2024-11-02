import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import '../../widgets/category_item.dart';
import 'places.dart';
import 'buddies.dart';
import 'offers.dart';
import 'products.dart';

class MainScreen extends StatefulWidget {
  final bool isLoggedIn;
  const MainScreen({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double wd = MediaQuery.of(context).size.width;
    double ht = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Hookapp',
          style: TextStyle(
            fontFamily: "Comfortaa-VariableFont_wght",
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            print('Menu button pressed');
            ZoomDrawer.of(context)?.toggle();
            FocusScope.of(context).unfocus();
          },
          icon: const Icon(Icons.menu, color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          if (ZoomDrawer.of(context)?.isOpen() ?? false) {
            ZoomDrawer.of(context)?.close();
          }
        },
        child: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFFFFFFF),
                  Color(0xFFFFFFFF),
                  Color(0xFFFAFAFA),
                  Color(0xFFF5F5F5),
                  Color(0xFFD6D6D6),
                  Color(0xFFD6D6D6),
                  Color(0xFFBDBDBD),
                ],
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  width: wd,
                  child: AspectRatio(
                    aspectRatio: 20 / 9,
                    child: Image.asset('assets/Home.png', fit: BoxFit.fitWidth),
                  ),
                ),
                const SizedBox(height: 0),
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: SizedBox(
                    height: ht * 0.24,
                    width: wd * 0.60,
                    child: Image.asset('assets/logo.png'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 6.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 6.5),
                        child: SizedBox(
                          width: wd * 0.409,
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: CategoryItem(
                              icon: Icons.map,
                              title: 'PLACES',
                              color: Color(hexColor('#fdc91b')),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const PlacesScreen()),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 0),
                        child: SizedBox(
                          width: wd * 0.407,
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: CategoryItem(
                              icon: Icons.groups,
                              title: 'BUDDIES',
                              color: Color(hexColor('#fdc91b')),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const BuddiesScreen()),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0, right: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 6.5),
                        child: SizedBox(
                          width: wd * 0.407,
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: CategoryItem(
                                icon: Icons.local_offer,
                                title: 'OFFERS',
                                color: Color(hexColor('#fdc91b')),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const OffersScreen()),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 0),
                        child: SizedBox(
                          width: wd * 0.407,
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: CategoryItem(
                              icon: Icons.view_module,
                              title: 'PRODUCTS',
                              color: Color(hexColor('#fdc91b')),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const ProductsScreen()),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 160),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



int hexColor(String color) {
  String newColor = '0xff' + color;
  newColor = newColor.replaceAll('#', '');
  int finalColor = int.parse(newColor);
  return finalColor;
}
