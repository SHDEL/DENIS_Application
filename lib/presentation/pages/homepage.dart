
import 'package:denis/presentation/pages/orderpage.dart';
import 'package:denis/presentation/pages/profile.dart';
import 'package:denis/presentation/pages/request_manage._widget.dart';
import 'package:denis/presentation/widgets/homewidget/camera_widget.dart';
import 'package:denis/presentation/widgets/homewidget/home_user_widget.dart';
import 'package:denis/presentation/widgets/homewidget/home_admin_widget.dart';
import 'package:denis/presentation/pages/search_admin_page.dart';
import 'package:denis/presentation/pages/search_user_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyHomePage extends StatefulWidget {
  

  final String title;
  final String? role;
  final int initialPage;
  const MyHomePage({
    super.key, 
    required this.title, 
    required this.role,
    this.initialPage = 0
  });
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late int currentPage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentPage = widget.initialPage;
  }
  void _onTapped(int index) {
    setState(() {
      currentPage = index;
    });
  }

  List<NavigationRailDestination> get _webDestinations {
    List<NavigationRailDestination> items = [
      NavigationRailDestination(icon: ImageIcon(AssetImage('assets/icons/Home.png')), label: const Text('Home')),
    ];

    if (widget.role == 'ADMIN') {
       items.add(NavigationRailDestination(icon: ImageIcon(AssetImage('assets/icons/package_search.png')), label: const Text('Stock')));
    }
    else{
      items.add(NavigationRailDestination(icon: ImageIcon(AssetImage('assets/icons/Search.png')), label: const Text('Search')));
    }
    items.add(NavigationRailDestination(icon: ImageIcon(AssetImage('assets/icons/Archive.png')), label: const Text('Request')));
    items.add(NavigationRailDestination(icon: ImageIcon(AssetImage('assets/icons/User_alt.png')), label: const Text('Profile')));
    return items;
  }

  List<BottomNavigationBarItem> get _mobileDestinations {
    List<BottomNavigationBarItem> items = [
      const BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/icons/Home.png')), label: ''),
    ];

    if (widget.role == 'ADMIN') {
      items.add(const BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/icons/package_search.png')), label: ''));
    }
    else{
      items.add(const BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/icons/Search.png')), label: ''));
    }
    items.add(const BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/icons/Archive.png')), label: ''));
    items.add(const BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/icons/User_alt.png')), label: ''));
    return items;
  }


  @override
  Widget build(BuildContext context) {
    if (kIsWeb){
      return Scaffold(
        backgroundColor: Colors.white,
        body: Row(
            children: [
              NavigationRail(
                selectedIndex: currentPage,
                onDestinationSelected: _onTapped,
                labelType: NavigationRailLabelType.selected,
                selectedLabelTextStyle: const TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
                destinations: _webDestinations,
              ),
              const VerticalDivider(thickness: 1, width: 1),
              // This is the main content.
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: [
                    _buildWebHomePage(),
                    _buildWebSearchPage(),
                    _buildWebOrderPage(),
                    _buildProfilePage(),
                  ][currentPage],
                ),
              )
            ],
          )
      );
    }
    
    // for mobile
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: IndexedStack(
          index: currentPage,
          children: [
            _buildWebHomePage(),
            _buildWebSearchPage(),
            _buildWebOrderPage(),
            _buildProfilePage(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w700,
          fontSize: 13,
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
        currentIndex: currentPage,
        onTap: _onTapped,
        items: _mobileDestinations,
      ),
    );
  }

  Widget _buildWebSearchPage() {
    if (widget.role == 'ADMIN'){
      return StockSearchAdminWidget();
    }
    else{
      return SearchUserWidget();
    }
  }

  Widget _buildWebHomePage() {
    if (widget.role == 'ADMIN') {
      return HomeAdminWidget();
      
    }
    else {
      return HomeUserWidget();
    }
  }

  Widget _buildWebOrderPage() {
    if (widget.role == 'ADMIN') {
      return RequestManagement();
      
    }
    else {
      return OrderPage();
    }
  }

  Widget _buildProfilePage() {
    return ProfilePage();
  }
}
