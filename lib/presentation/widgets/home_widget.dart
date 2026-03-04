import 'package:DENIS/presentation/widgets/camera_widget.dart';
import 'package:DENIS/presentation/widgets/category_button.dart';
import 'package:DENIS/presentation/widgets/primary_app_button.dart';
import 'package:flutter/material.dart';
import 'package:gradient_elevated_button/gradient_elevated_button.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final List<String> _categories = [
    'All',
    'Examination',
    'Surgical',
    'Restorative',
    'Extraction',
    'Orthodontic',
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Camera feed mockup — roughly half the available height
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Find Your', style: TextStyle(fontSize: 24, fontWeight: FontWeight.normal)),
                Text('Instruments Today', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Flexible(
            flex: 2,
            child: CameraWidget(),
          ),
          const SizedBox(height: 24),
          // ConstrainedBox(
          //   constraints: const BoxConstraints(maxHeight: 50),
          //   child: CarouselView(
          //     itemExtent: 120,
          //     shrinkExtent: 80,
          //     children: List<Widget>.generate(_categories.length, (int index) {
          //       return CategoryButton(
          //         index: index,
          //         label: _categories[index],
          //         isSelected: index == _selectedIndex,
          //         onTap: () => setState(() => _selectedIndex = index),
          //       );
          //     }),
          //   ),
          // ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(_categories.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 16), // ระยะห่างระหว่างปุ่ม
                  child: CategoryButton(
                    key: ValueKey(_categories[index]), // เพิ่ม Key เพื่อช่วยให้ Flutter รู้ว่าปุ่มไหนเป็นปุ่มไหน
                    index: index,
                    label: _categories[index],
                    isSelected: index == _selectedIndex,
                    onTap: () => setState(() => _selectedIndex = index),
                  ),
                );
              }),
            ),
          ),
          
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
                          // _InstrumentTile(name: 'Hemostat',              location: 'Shelf A1'),
                          // _InstrumentTile(name: 'Tissue Scissors',       location: 'Shelf A2'),
                          // _InstrumentTile(name: 'Dental Mirror',         location: 'Shelf B1'),
                          // _InstrumentTile(name: 'Explorer Probe',        location: 'Shelf B2'),
                          // _InstrumentTile(name: 'Dental Forceps',        location: 'Shelf B3'),
                          // _InstrumentTile(name: 'Scalpel Handle',        location: 'Shelf C1'),
                          // _InstrumentTile(name: 'Periosteal Elevator',   location: 'Shelf C2'),
                          // _InstrumentTile(name: 'Cheek Retractor',       location: 'Shelf C3'),
                          // _InstrumentTile(name: 'Amalgam Condenser',     location: 'Shelf D1'),
                          // _InstrumentTile(name: 'Saliva Ejector',        location: 'Shelf D2'),
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

enum CardInfo {
  camera('Cameras', Icons.video_call, Color(0xff2354C7), Color(0xffECEFFD)),
  lighting('Lighting', Icons.lightbulb, Color(0xff806C2A), Color(0xffFAEEDF)),
  climate('Climate', Icons.thermostat, Color(0xffA44D2A), Color(0xffFAEDE7)),
  wifi('Wifi', Icons.wifi, Color(0xff417345), Color(0xffE5F4E0)),
  media('Media', Icons.library_music, Color(0xff2556C8), Color(0xffECEFFD)),
  security(
    'Security',
    Icons.crisis_alert,
    Color(0xff794C01),
    Color(0xffFAEEDF),
  ),
  safety(
    'Safety',
    Icons.medical_services,
    Color(0xff2251C5),
    Color(0xffECEFFD),
  ),
  more('', Icons.add, Color(0xff201D1C), Color(0xffE3DFD8));

  const CardInfo(this.label, this.icon, this.color, this.backgroundColor);
  final String label;
  final IconData icon;
  final Color color;
  final Color backgroundColor;
}

class UncontainedLayoutCard extends StatelessWidget {
  const UncontainedLayoutCard({
    super.key,
    required this.index,
    required this.label,
  });

  final int index;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.primaries[index % Colors.primaries.length].withValues(alpha: 0.5),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 20),
          overflow: TextOverflow.clip,
          softWrap: false,
        ),
      ),
    );
  }
}