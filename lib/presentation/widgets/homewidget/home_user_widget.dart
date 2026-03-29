import 'package:denis/presentation/theme/app_colors.dart';
import 'package:denis/presentation/widgets/homewidget/camera_widget.dart';
import 'package:denis/presentation/widgets/category_button.dart';
import 'package:denis/presentation/widgets/instrument_grid.dart';
import 'package:denis/presentation/widgets/instrument_list.dart';
import 'package:denis/presentation/widgets/homewidget/set_instrument_widget.dart';
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'package:denis/dataconnect_generated/generated.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeUserWidget extends StatefulWidget {
  const HomeUserWidget({super.key});

  @override
  State<HomeUserWidget> createState() => _HomeUserWidgetState();
}

class _HomeUserWidgetState extends State<HomeUserWidget> {
  int _selectedIndex = 0;

  bool isSelectionMode = false;
  late List<bool> _selected;
  bool _selectAll = false;
  bool _isGridMode = false;
  double paddingValue = 16.0;

  late Future<QueryResult<GetAllInstrumentsAndCategoriesData, void>> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = ExampleConnector.instance.getAllInstrumentsAndCategories().execute();
    initializeSelection(0);
  }

  void initializeSelection(int length) {
    _selected = List<bool>.generate(length, (_) => false);
  }

  @override
  void dispose() {
    _selected.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb){
      paddingValue = 48.0;
    }
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          left: paddingValue, 
          right: paddingValue, 
          top: 24.0,
          bottom: paddingValue
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
              child: Center(
                  child: SetInstrumentWidget(),
              ),
            ),
            const SizedBox(height: 24),
            FutureBuilder<QueryResult<GetAllInstrumentsAndCategoriesData, void>>(
              future: _dataFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }

                final dbCategories = snapshot.data?.data.instrumentCategories ?? [];
                final categoryNames = ['All', ...dbCategories.map((c) => c.name)];
                final allInstruments = snapshot.data?.data.instruments ?? [];

                final selectedCategoryName = categoryNames[_selectedIndex];
                final filteredInstruments = selectedCategoryName == 'All'
                    ? allInstruments
                    : allInstruments.where((inst) => inst.category.name == selectedCategoryName).toList();

                if (_selected.length != filteredInstruments.length) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted) {
                      setState(() {
                        initializeSelection(filteredInstruments.length);
                      });
                    }
                  });
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(categoryNames.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 16), // ระยะห่างระหว่างปุ่ม
                            child: CategoryButton(
                              key: ValueKey(categoryNames[index]), // เพิ่ม Key เพื่อช่วยให้ Flutter รู้ว่าปุ่มไหนเป็นปุ่มไหน
                              index: index,
                              label: categoryNames[index],
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
                        const Text('Intruments List', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
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
                    filteredInstruments.isEmpty
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.all(32.0),
                              child: Text('No instruments found in this category.',
                                  style: TextStyle(fontSize: 16, color: Colors.grey)),
                            ),
                          )
                        : _isGridMode 
                          ? InstrumentGrid(
                              isSelectionMode: isSelectionMode,
                              selectedList: _selected.length == filteredInstruments.length ? _selected : List.filled(filteredInstruments.length, false),
                              onSelectionChange: (bool x) {
                              setState(() {
                                isSelectionMode = x;
                              });
                            }, instruments: filteredInstruments,
                          )
                          : InstrumentList(
                              isSelectionMode: isSelectionMode,
                              selectedList: _selected.length == filteredInstruments.length ? _selected : List.filled(filteredInstruments.length, false),
                              onSelectionChange: (bool x) {
                                setState(() {
                                  isSelectionMode = x;
                                });
                              }, instruments: filteredInstruments,
                           ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}