import 'dart:async';
import 'dart:convert';

import 'package:denis/dataconnect_generated/generated.dart';
import 'package:denis/env/env.dart';
import 'package:denis/presentation/theme/app_colors.dart';
import 'package:denis/presentation/widgets/homewidget/camera_widget.dart';
import 'package:denis/presentation/widgets/category_button.dart';
import 'package:denis/presentation/widgets/instrument_grid.dart';
import 'package:denis/presentation/widgets/instrument_list.dart';
import 'package:denis/presentation/widgets/primary_app_button.dart';
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gradient_elevated_button/gradient_elevated_button.dart';
import 'package:http/http.dart' as http;

class HomeAdminWidget extends StatefulWidget {
  const HomeAdminWidget({super.key});

  @override
  State<HomeAdminWidget> createState() => _HomeAdminWidgetState();
}

class _HomeAdminWidgetState extends State<HomeAdminWidget> {
  
  int _selectedIndex = 0;

  bool isSelectionMode = false;
  final int listLength = 30;
  late List<bool> _selected;
  bool _selectAll = false;
  bool _isGridMode = false;
  double paddingValue = 16.0;
  Map<String, int> _detectedInstruments = {};
  bool _isFetchingCamera = false;
  Timer? _timer; // เพิ่มตัวแปรเก็บ Timer

  late Future<QueryResult<GetAllInstrumentsAndCategoriesData, void>> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = ExampleConnector.instance.getAllInstrumentsAndCategories().execute();
    initializeSelection(0);

    fetchCameraData();

    _timer = Timer.periodic(const Duration(seconds: 3), (Timer t) {
      if (mounted) {
        fetchCameraData();
      }
    });
  }
  
  Future<void> fetchCameraData() async {
    setState(() {
      _isFetchingCamera = true;
    });
    try {
      // แทนที่ URL ด้วย Endpoint API ของคุณ
      final response = await http.get(Uri.parse('https://denis.zedoexter.xyz/detects?token=${Env.jwtToken}'),
      );
      
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        final rawData = decodedData['data'] as Map<String, dynamic>;
        
        setState(() {
          // แปลงข้อมูลให้อยู่ในรูปแบบ Map<String, int>
          _detectedInstruments = rawData.map((key, value) => MapEntry(key, value as int));
        });
      }
    } catch (e) {
      print('Error fetching camera API: $e');
    } finally {
      setState(() {
        _isFetchingCamera = false;
      });
    }
  }

  void initializeSelection(int length) {
    _selected = List<bool>.generate(length, (_) => false);
  }

  @override
  void dispose() {
    _selected.clear();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb){
      paddingValue = 48.0;
    }
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(paddingValue),
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
              child: Center(
                  child: CameraWidget(),
              ),
            ),
            const SizedBox(height: 24),
            // ใส่ FutureBuilder เพื่อให้โหลดข้อมูล Categories และ Instruments แสดงขึ้นมา
            FutureBuilder<QueryResult<GetAllInstrumentsAndCategoriesData, void>>(
              future: _dataFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }

                // ดึงหมวดหมู่ และ ข้อมูลอุปกรณ์มาใส่แทน Array เปล่าๆ
                final dbCategories = snapshot.data?.data.instrumentCategories ?? [];
                final categoryNames = ['All', ...dbCategories.map((c) => c.name)];
                final allInstruments = snapshot.data?.data.instruments ?? [];

                // 1. กรองเครื่องมือเฉพาะที่กล้องตรวจเจอ (ถ้า _detectedInstruments ไม่ว่างเปล่า)
                final detectedInstrumentsList = allInstruments
                  .where((inst) => _detectedInstruments.containsKey(inst.name))
                  .toList();

                // 2. กรองตาม Category Tab ที่ถูกเลือกซ้อนอีกที
                final selectedCategoryName = _selectedIndex < categoryNames.length ? categoryNames[_selectedIndex] : 'All';
                final filteredInstruments = selectedCategoryName == 'All'
                    ? detectedInstrumentsList
                    : detectedInstrumentsList.where((inst) => inst.category.name == selectedCategoryName).toList();

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
                            padding: const EdgeInsets.only(right: 16),
                            child: CategoryButton(
                              key: ValueKey(categoryNames[index]),
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
                    const SizedBox(height: 16),
                    // ส่งข้อมูลเข้าระบบ List และ Grid เรียบร้อยแล้ว (ไม่เป็น [] แล้วครับ)
                    filteredInstruments.isEmpty
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.all(32.0),
                              child: Text('No instruments found.',
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
                              },
                              instruments: filteredInstruments,
                              detectedCounts: _detectedInstruments, userRole: 'ADMIN',
                          )
                          : InstrumentList(
                              isSelectionMode: isSelectionMode,
                              selectedList: _selected.length == filteredInstruments.length ? _selected : List.filled(filteredInstruments.length, false),
                              onSelectionChange: (bool x) {
                                setState(() {
                                  isSelectionMode = x;
                                });
                              }, 
                              instruments: filteredInstruments, 
                              detectedCounts: _detectedInstruments,
                              userRole: 'ADMIN',
                                  // <-- ไม่ว่างเปล่าแล้ว
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

