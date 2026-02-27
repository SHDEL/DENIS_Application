
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int currentPage = 0;

  void _onTapped(int index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    if (kIsWeb){
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        body: SafeArea(
          child: Row(
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
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.search),
                    label: Text('Search'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.person),
                    label: Text('Profile'),
                  ),
                ],
              ),
              const VerticalDivider(thickness: 1, width: 1),
              // This is the main content.
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: currentPage == 0
                      ? _buildWebHomePage()
                      : currentPage == 1
                          ? _buildWebSearchPage()
                          : const Center(
                              child: Text(
                                'Profile',
                                style: TextStyle(fontSize: 24),
                              ),
                            ),
                ),
              )
            ],
          )
        )
      );
    }
    
    // for mobile
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      body: SafeArea(
        child: currentPage == 0
            ? _buildWebHomePage()
            : currentPage == 1
                ? _buildWebSearchPage()
                : const Center(
                    child: Text('Profile', style: TextStyle(fontSize: 24)),
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
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
      ),
    );
  }

  Widget _buildWebSearchPage() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Search bar
          TextField(
            decoration: InputDecoration(
              hintText: 'Search instruments...',
              hintStyle: const TextStyle(fontFamily: 'Nunito', fontSize: 14),
              prefixIcon: const Icon(Icons.search, color: Colors.blueGrey),
              filled: true,
              fillColor: Colors.white70,
              contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Categorised list
          Expanded(
            child: ListView(
              children: const [
                _CategorySection(
                  category: 'Examination',
                  icon: Icons.search,
                  color: Colors.teal,
                  items: [
                    _InstrumentTile(name: 'Dental Mirror',       location: 'Shelf A1'),
                    _InstrumentTile(name: 'Explorer Probe',      location: 'Shelf A2'),
                    _InstrumentTile(name: 'Periodontal Probe',   location: 'Shelf A3'),
                  ],
                ),
                SizedBox(height: 12),
                _CategorySection(
                  category: 'Surgical',
                  icon: Icons.cut,
                  color: Colors.redAccent,
                  items: [
                    _InstrumentTile(name: 'Hemostat',            location: 'Shelf B1'),
                    _InstrumentTile(name: 'Tissue Scissors',     location: 'Shelf B2'),
                    _InstrumentTile(name: 'Scalpel Handle',      location: 'Shelf B3'),
                    _InstrumentTile(name: 'Periosteal Elevator', location: 'Shelf B4'),
                    _InstrumentTile(name: 'Dental Forceps',      location: 'Shelf B5'),
                  ],
                ),
                SizedBox(height: 12),
                _CategorySection(
                  category: 'Restorative',
                  icon: Icons.build_outlined,
                  color: Colors.indigo,
                  items: [
                    _InstrumentTile(name: 'Amalgam Condenser',   location: 'Shelf C1'),
                    _InstrumentTile(name: 'Composite Plugger',   location: 'Shelf C2'),
                    _InstrumentTile(name: 'Burnisher',           location: 'Shelf C3'),
                  ],
                ),
                SizedBox(height: 12),
                _CategorySection(
                  category: 'Airway & Suction',
                  icon: Icons.air,
                  color: Colors.blueGrey,
                  items: [
                    _InstrumentTile(name: 'Saliva Ejector',      location: 'Shelf D1'),
                    _InstrumentTile(name: 'Cheek Retractor',     location: 'Shelf D2'),
                    _InstrumentTile(name: 'Tongue Depressor',    location: 'Shelf D3'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWebHomePage() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Camera feed mockup — roughly half the available height
          Flexible(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[800]!, width: 2),
              ),
              child: const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.videocam,
                      color: Colors.white54,
                      size: 56,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Camera',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 20,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Bottom half — dental instrument list
          Flexible(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      color: Colors.white30,
                      child: const Text(
                        'Instrument Inventory',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    const Divider(height: 1, thickness: 1),
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        children: const [
                          _InstrumentTile(name: 'Hemostat',              location: 'Shelf A1'),
                          _InstrumentTile(name: 'Tissue Scissors',       location: 'Shelf A2'),
                          _InstrumentTile(name: 'Dental Mirror',         location: 'Shelf B1'),
                          _InstrumentTile(name: 'Explorer Probe',        location: 'Shelf B2'),
                          _InstrumentTile(name: 'Dental Forceps',        location: 'Shelf B3'),
                          _InstrumentTile(name: 'Scalpel Handle',        location: 'Shelf C1'),
                          _InstrumentTile(name: 'Periosteal Elevator',   location: 'Shelf C2'),
                          _InstrumentTile(name: 'Cheek Retractor',       location: 'Shelf C3'),
                          _InstrumentTile(name: 'Amalgam Condenser',     location: 'Shelf D1'),
                          _InstrumentTile(name: 'Saliva Ejector',        location: 'Shelf D2'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategorySection extends StatelessWidget {
  const _CategorySection({
    required this.category,
    required this.icon,
    required this.color,
    required this.items,
  });

  final String category;
  final IconData icon;
  final Color color;
  final List<Widget> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              color: color.withOpacity(0.15),
              child: Row(
                children: [
                  Icon(icon, size: 18, color: color),
                  const SizedBox(width: 8),
                  Text(
                    category,
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, thickness: 1),
            ...items,
          ],
        ),
      ),
    );
  }
}

class _InstrumentTile extends StatelessWidget {
  const _InstrumentTile({required this.name, required this.location});

  final String name;
  final String location;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: const Icon(Icons.medical_services_outlined, size: 20, color: Colors.blueGrey),
      title: Text(
        name,
        style: const TextStyle(
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.blueGrey.withOpacity(0.15),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          location,
          style: const TextStyle(
            fontFamily: 'Nunito',
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.blueGrey,
          ),
        ),
      ),
    );
  }
}