import 'package:dinner_assistant_flutter/core/theme/my_colors.dart';
import 'package:dinner_assistant_flutter/view/admin_recipes.dart';
import 'package:dinner_assistant_flutter/view/auth_screen.dart';
import 'package:dinner_assistant_flutter/view/profile_screen.dart';
import 'package:dinner_assistant_flutter/view/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class Bottom extends StatefulWidget {
  const Bottom({Key? key}) : super(key: key);
  @override
  _BottomState createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  int currentIndex = 0;

  PersistentTabController? _controller;

  TextStyle textStyle =
      const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700);

  List<Widget> _buildScreens() {
    return [
      const AdminRecipes(),
      const HomePage(),
      ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems(BuildContext context) {
    return [
      PersistentBottomNavBarItem(
        icon: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('assets/images/recipes.png', width: 24, color: Colors.white),
            Text('Yemek Tarifleri', style: textStyle)
          ],
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(CupertinoIcons.home, size: 24, color: Colors.white),
            Text('Ana Sayfa', style: textStyle)
          ],
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(CupertinoIcons.person_alt_circle, size: 24, color: Colors.white),
            Text('Hesabım', style: textStyle)
          ],
        ),
      ),
    ];
  }

  void changeIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    _controller = PersistentTabController(initialIndex: 0);
    return Material(
      child: PersistentTabView(
        context,
        controller: _controller,
        padding: const NavBarPadding.symmetric(horizontal: 2),
        screens: _buildScreens(),
        items: _navBarsItems(context),
        onItemSelected: changeIndex,
        confineInSafeArea: true,
        backgroundColor: Colors.white, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset:
            true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows:
            true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(0.0),
          gradient: LinearGradient(
              colors: [MyColors.primaryDarkColor, MyColors.primaryDarkColor.withOpacity(0.7)],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(0.5, 0.0),
              stops: const [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style6, // Choose the nav bar style with this property.
      ),
    );
  }
}
