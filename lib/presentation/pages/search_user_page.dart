import 'package:denis/dataconnect_generated/generated.dart';
import 'package:denis/presentation/theme/app_colors.dart';
import 'package:denis/presentation/widgets/category_button.dart';
import 'package:denis/presentation/widgets/category_section.dart';
import 'package:denis/presentation/widgets/instrument_grid.dart';
import 'package:denis/presentation/widgets/instrument_list.dart';
import 'package:denis/presentation/widgets/instruments_details.dart';
import 'package:denis/presentation/widgets/instrumentile.dart';
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'package:flutter/material.dart';

class SearchUserWidget extends StatefulWidget {
  const SearchUserWidget({super.key});

  @override
  State<SearchUserWidget> createState() => _SearchUserWidgetState();
}

class _SearchUserWidgetState extends State<SearchUserWidget> {
  String selectedFilter = 'All';
  bool _isGridMode = false;
  String _searchQuery = '';
  
  late Future<QueryResult<GetAllInstrumentsAndCategoriesData, void>> _dataFuture;
  @override
  void initState() {
    super.initState();
    // ดึงข้อมูลเมื่อเปิดหน้า
    _dataFuture = ExampleConnector.instance.getAllInstrumentsAndCategories().execute();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, left: 24.0, right: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Search bar (มีเงาและขอบโค้งมน) คงที่อยู่ด้านบน
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search instruments...',
                hintStyle: const TextStyle(fontFamily: 'Nunito', fontSize: 14),
                prefixIcon: const Icon(Icons.search, color: Colors.black87),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // 2. แถบปุ่ม Filter (All, Examination, ...) คงที่อยู่ด้านบน
          Expanded(
            child: FutureBuilder<QueryResult<GetAllInstrumentsAndCategoriesData, void>>(
              future: _dataFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }

                // ดึงข้อมูลออกมา
                final dbCategories = snapshot.data?.data.instrumentCategories ?? [];
                final categoryNames = ['All', ...dbCategories.map((c) => c.name)];
                final allInstruments = snapshot.data?.data.instruments ?? [];

                // --- ทำการ Filter & Search ตรงนี้ ---
                final filteredInstruments = allInstruments.where((inst) {
                  // เช็คประเภท
                  final matchCategory = selectedFilter == 'All' || inst.category.name == selectedFilter;
                  // เช็คคำค้น (ตัวเล็กเทียบกัน)
                  final matchSearch = _searchQuery.isEmpty || 
                                      inst.name.toLowerCase().contains(_searchQuery.toLowerCase());
                  
                  return matchCategory && matchSearch;
                }).toList();

                return Column(
                  children: [
                    // แถบปุ่ม Filter
                    Row(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            child: Row(
                              // แก้ไขบรรทัดนี้ โดยใช้ List.generate เพื่อสร้าง CategoryButton
                              children: List.generate(categoryNames.length, (index) {
                                final catName = categoryNames[index];
                                return Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: CategoryButton(
                                    key: ValueKey(catName), // ป้องกันการกระตุกของการเรนเดอร์ Flutter
                                    index: index,
                                    label: catName,
                                    isSelected: selectedFilter == catName,
                                    onTap: () {
                                      setState(() {
                                        selectedFilter = catName;
                                      });
                                    },
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                        // ปุ่มสลับโหมด
                        IconButton(
                          icon: Icon(_isGridMode ? Icons.list : Icons.grid_view, color: Colors.deepPurple),
                          onPressed: () {
                            setState(() {
                              _isGridMode = !_isGridMode;
                            });
                          },
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // ส่วนแสดงเนื้อหา
                    Expanded(
                      child: filteredInstruments.isEmpty 
                          ? const Center(child: Text('No instruments found'))
                          : _isGridMode 
                              ? SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  child: InstrumentGrid(
                                    instruments: filteredInstruments,
                                    isSelectionMode: false,
                                    selectedList: List.filled(filteredInstruments.length, false),
                                    onSelectionChange: (val) {},
                                    userRole: 'USER',

                                  ),
                                ) 
                              : _buildListView(filteredInstruments),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

   Widget _buildListView(List<GetAllInstrumentsAndCategoriesInstruments> instruments) {
    // หาว่าหลังจาก filter แล้ว เหลือของในหมวดหมู่ไหนบ้าง
    final availableCategoryNames = instruments.map((i) => i.category.name).toSet().toList();

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 24.0, top: 8.0),
      itemCount: availableCategoryNames.length,
      itemBuilder: (context, index) {
        final catName = availableCategoryNames[index];
        // หาพวกที่อยู่หมวดนี้
        final itemsInCategory = instruments.where((i) => i.category.name == catName).toList();
        
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          // นำกรอบสีขาวแบบเดิมครอบไว้ 
          child: _buildCategoryCard(
            // ตรงนี้เราจะไม่ใช้ CategorySection แล้ว เราจะสร้าง Column เองเลย
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // แสดงชื่อ Category ด้านบน
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                  child: Text(
                    catName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
                // แล้วใช้ InstrumentList สำหรับแสดงรายการภายใน Category นั้น
                InstrumentList(
                  instruments: itemsInCategory,
                  isSelectionMode: false,
                  selectedList: List.filled(itemsInCategory.length, false),
                  onSelectionChange: (val) {},
                  userRole: 'USER',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Widget ช่วยในการสร้างกล่องตีกรอบสีขาวแต่ละ Category
  Widget _buildCategoryCard({required Widget child}) {
    // ... เหมือนเดิมเป๊ะ ...
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        clipBehavior: Clip.antiAlias,
        child: Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), child: child),
      ),
    );
  }

}

