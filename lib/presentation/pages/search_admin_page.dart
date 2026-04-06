import 'package:denis/presentation/widgets/instruments_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:denis/dataconnect_generated/generated.dart';
import 'package:firebase_data_connect/firebase_data_connect.dart';

class StockSearchAdminWidget extends StatefulWidget {
  const StockSearchAdminWidget({super.key});

  @override
  State<StockSearchAdminWidget> createState() => _StockSearchAdminWidgetState();
}

class _StockSearchAdminWidgetState extends State<StockSearchAdminWidget> {
  int _selectedTabIndex = 0;
  List<String> _tabs = ['All'];

  // สร้าง Future สำหรับดึงข้อมูล Stock
  late Future<QueryResult<GetAllInstrumentsAndCategoriesData, void>> _stockFuture;

  // สำหรับการทำ Checkbox ในแต่ละแถว (เก็บ ID ของ Instrument)
  Set<String> _selectedItems = {};

  @override
  void initState() {
    super.initState();
    // เรียก DataConnect ใช้ Query เดิมที่มีอยู่แต่เอามาแสดงเป็น Table 
    _stockFuture = ExampleConnector.instance.getAllInstrumentsAndCategories().execute();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader(),
          const SizedBox(height: 24),
          const Text(
            'Instruments in stock',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          
          Expanded(
            child: FutureBuilder<QueryResult<GetAllInstrumentsAndCategoriesData, void>>(
              future: _stockFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final data = snapshot.data?.data;
                if (data == null) {
                  return const Center(child: Text('No data found'));
                }

                // สร้าง Tabs แจกแจงตาม Categories จาก DB
                final dbCategories = data.instrumentCategories.map((e) => e.name).toList();
                if (_tabs.length == 1) {
                  // ถ้ายังไม่ได้เพิ่ม ให้เพิ่มเข้าระบบ (หลีกเลี่ยง setState ภายใน build)
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted && _tabs.length != dbCategories.length + 1) {
                        setState(() {
                        _tabs = ['All', ...dbCategories];
                      });
                    }
                  });
                }

                // กรองข้อมูลตาม Tab ที่ถูกเลือก
                final selectedCategory = _tabs.length > _selectedTabIndex ? _tabs[_selectedTabIndex] : 'All';
                final allInstruments = data.instruments;
                final filteredInstruments = selectedCategory == 'All' 
                    ? allInstruments 
                    : allInstruments.where((item) => item.category.name == selectedCategory).toList();

                return Column(
                  children: [
                    _buildFiltersAndActions(),
                    const SizedBox(height: 16),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade200),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width > 1048 ? MediaQuery.of(context).size.width - 48 : 1000,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                _buildTableHeader(),
                                const Divider(height: 1),
                                Expanded(
                                  child: filteredInstruments.isEmpty 
                                    ? const Center(child: Text("No items in this category."))
                                    : ListView.separated(
                                      itemCount: filteredInstruments.length,
                                      separatorBuilder: (context, index) => const Divider(height: 1),
                                      itemBuilder: (context, index) {
                                        final instrument = filteredInstruments[index];
                                        
                                        // ดึงข้อมูล Stock ที่ผูกมาด้วย
                                        final stocks = instrument.stocks_on_instrument;
                                        final stockInfo = stocks.isNotEmpty ? stocks.first : null;
                                        
                                        // แกะค่าออกมาใช้ (ถ้าไม่มี Stock Row ใน DB ถือว่าเป็น 0)
                                        final inStock = stockInfo?.inStockQty ?? 0;
                                        final inUse = stockInfo?.inUseQty ?? 0;
                                        final shelf = stockInfo?.shelf ?? '-';
                                        // ถ้าต้องการ Sterilized อาจจะคำนวณเอาจาก inUse หรือเว้นไว้ก่อน
                                        final sterilized = 0; 
                                        
                                        return _buildTableRow(
                                          id: instrument.id,
                                          name: instrument.name,
                                          imageUrl: instrument.imageUrl,
                                          category: instrument.category.name,
                                          inStock: inStock,
                                          inUse: inUse,
                                          sterilized: sterilized,
                                          shelf: shelf,
                                          onTap: () {
                                            final userId = FirebaseAuth.instance.currentUser?.uid ?? '';
                                            final userRoleFuture = ExampleConnector.instance.getRoleById(id: userId).execute();
                                            userRoleFuture.then((value) {
                                              final userRole = value.data?.user?.role ?? '';
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => InstrumentsDetailsWidget(instrument: instrument, userRole: userRole)));
                                            });
                                            
                                          }
                                        );
                                      },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Stock Management',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.download, size: 18),
              label: const Text('Import'),
            ),
            const SizedBox(width: 8),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.upload, size: 18),
              label: const Text('Export'),
            ),
            const SizedBox(width: 8),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add, size: 18, color: Colors.white,),
              label: const Text('Add product', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildFiltersAndActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: List.generate(_tabs.length, (index) {
            bool isSelected = _selectedTabIndex == index;
            return Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: InkWell(
                onTap: () => setState(() => _selectedTabIndex = index),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        if (index == 0) const Icon(Icons.apps, size: 16, color: Colors.black54)
                        else const Icon(Icons.category, size: 16, color: Colors.black54),
                        const SizedBox(width: 4),
                        Text(
                          _tabs[index],
                          style: TextStyle(
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                            color: isSelected ? Colors.black : Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Container(
                      height: 2,
                      width: 40,
                      color: isSelected ? Colors.black : Colors.transparent,
                    )
                  ],
                ),
              ),
            );
          }),
        ),
        Row(
          children: [
            SizedBox(
              width: 200,
              height: 36,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: const Icon(Icons.search, size: 18),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.grey.shade300)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.grey.shade300)),
                ),
              ),
            ),
            const SizedBox(width: 8),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.sort, size: 16),
              label: const Text('Sort'),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildTableHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        children: [
          Expanded(flex: 3, child: _headerText('Instrument')),
          Expanded(flex: 2, child: _headerText('Category')),
          Expanded(flex: 2, child: _headerText('In Stock')),
          Expanded(flex: 2, child: _headerText('In Use')),
          Expanded(flex: 2, child: _headerText('Sterilized')),
          Expanded(flex: 1, child: _headerText('Shelf')),
        ],
      ),
    );
  }

  Widget _headerText(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.grey.shade600,
        fontWeight: FontWeight.w600,
        fontSize: 13,
      ),
    );
  }

  Widget _buildTableRow({
    required String id,
    required String name,
    required String imageUrl,
    required String category,
    required int inStock,
    required int inUse,
    required int sterilized,
    required String shelf,
    required VoidCallback onTap,
  }) {
    bool isChecked = _selectedItems.contains(id);

    return InkWell(
      onTap: onTap,
      hoverColor: Colors.grey.shade100,
      child:
        Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          children: [
            // 1. Checkbox + Image + Name
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Checkbox(
                    value: isChecked, 
                    onChanged: (v) {
                      setState(() {
                        if (v == true) {
                          _selectedItems.add(id);
                        } else {
                          _selectedItems.remove(id);
                        }
                      });
                    }
                  ),
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(6),
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      name,
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            // 2. Status Badge (Category)
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.centerLeft,
                child: _buildStatusBadge(category),
              ),
            ),
            // 3. In Stock
            Expanded(
              flex: 2,
              child: Text(
                '$inStock',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: inStock == 0 ? Colors.red : Colors.black87,
                  fontSize: 13,
                ),
              ),
            ),
            // 4. In Use
            Expanded(
              flex: 2,
              child: Text('$inUse', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
            ),
            // 5. Sterilized (Mock value set to 0 for now)
            Expanded(
              flex: 2,
              child: Text('$sterilized', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
            ),
            // 6. Shelf
            Expanded(
              flex: 1,
              child: Text(shelf, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
            ),
          ],
        ),
      )
    );
  }

  Widget _buildStatusBadge(String category) {
    // Generate Randomish Colors for each category
    Color bgColor = Colors.blue.shade50;
    Color textColor = Colors.blue.shade700;

    switch (category.toLowerCase()) {
      case 'examination':
        bgColor = Colors.blue.shade50;
        textColor = Colors.blue.shade700;
        break;
      case 'surgical':
        bgColor = Colors.red.shade50;
        textColor = Colors.red.shade700;
        break;
      case 'extraction':
        bgColor = Colors.orange.shade50;
        textColor = Colors.orange.shade800;
        break;
      default:
        bgColor = Colors.grey.shade100;
        textColor = Colors.grey.shade700;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        category,
        style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }
}