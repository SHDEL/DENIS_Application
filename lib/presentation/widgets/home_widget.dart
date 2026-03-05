import 'package:DENIS/presentation/theme/app_colors.dart';
import 'package:DENIS/presentation/widgets/camera_widget.dart';
import 'package:DENIS/presentation/widgets/category_button.dart';
import 'package:DENIS/presentation/widgets/instrument_grid.dart';
import 'package:DENIS/presentation/widgets/instrument_list.dart';
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

  bool isSelectionMode = false;
  final int listLength = 30;
  late List<bool> _selected;
  bool _selectAll = false;
  bool _isGridMode = false;

  @override
  void initState() {
    super.initState();
    initializeSelection();
  }

  void initializeSelection() {
    _selected = List<bool>.generate(listLength, (_) => false);
  }

  @override
  void dispose() {
    _selected.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Camera feed mockup
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Find Your', style: TextStyle(fontSize: 24, fontWeight: FontWeight.normal)),
                Text('Instruments Today', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 12),
            const SizedBox(
              height: 300,
              child: CameraWidget(),
            ),
            const SizedBox(height: 24),
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
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Intruments List', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _isGridMode = !_isGridMode;
                    });
                  }, 
                  icon: Icon(_isGridMode ? Icons.list : Icons.grid_view, color: AppColors.primary, size: 32,)
                )
              ],
            ),
            // Bottom half — dental instrument list
            const SizedBox(height: 16),
            // ส่วนแสดง list/grid
            _isGridMode 
              ? InstrumentGrid(
                isSelectionMode: isSelectionMode,
                selectedList: _selected,
                onSelectionChange: (bool x) {
                setState(() {
                  isSelectionMode = x;
                });
              },
              )
              : InstrumentList(
                isSelectionMode: isSelectionMode,
                selectedList: _selected,
                onSelectionChange: (bool x) {
                  setState(() {
                    isSelectionMode = x;
                  });
                },
              )
            ,
          ],
        ),
      ),
    );
  }
}

