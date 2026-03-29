import 'package:denis/presentation/widgets/category_section.dart';
import 'package:denis/presentation/widgets/instruments_details.dart';
import 'package:denis/presentation/widgets/instrumentile.dart';
import 'package:flutter/material.dart';

class SearchUserWidget extends StatefulWidget {
  const SearchUserWidget({super.key});

  @override
  State<SearchUserWidget> createState() => _SearchUserWidgetState();
}

class _SearchUserWidgetState extends State<SearchUserWidget> {
  String selectedFilter = 'All';
  bool _isGridMode = false;
  
  // สร้างฟังก์ชันสำหรับนำทางไปหน้าใหม่เมื่อกดแต่ละรายการ
  void _navigateToDetail(BuildContext context, String itemName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        // เลื่อนเปลี่ยนไปหน้า InstrumentsDetailsWidget
        builder: (context) => const InstrumentsDetailsWidget(),
      ),
    );
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
          Row(
            children: [
              _buildFilterChip('All'),
              const SizedBox(width: 12),
              _buildFilterChip('Examination'),
              // สามารถเพิ่ม Chip อื่นๆ ได้ถ้าต้องการ
              const Spacer(),
              IconButton(
                icon: Icon(_isGridMode ? Icons.list : Icons.grid_view, color: Colors.deepPurple), // ไอคอนสลับโหมด
                onPressed: () {
                  setState(() {
                    _isGridMode = !_isGridMode;
                  });
                },
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // 3. รายการ Category ที่แยกเป็นกล่อง ๆ (เลื่อนได้เฉพาะส่วนนี้)
          Expanded(
            child: _isGridMode ? _buildGridView() : _buildListView(),
          ),
        ],
      ),
    );
  }

  Widget _buildListView() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24.0, top: 8.0),
        child: Column(
          children: [
            _buildCategoryCard(
              child: CategorySection(
                category: 'Examination',
                icon: Icons.search,
                color: Colors.deepPurple,
                items: [
                  InstrumentTile(name: 'Hemostat', location: 'Shelf A1', onTap: () => _navigateToDetail(context, 'Hemostat')),
                  InstrumentTile(name: 'Hemostat', location: 'Shelf A1', onTap: () => _navigateToDetail(context, 'Hemostat')),
                  InstrumentTile(name: 'Dental Mirror', location: 'Shelf A1', onTap: () => _navigateToDetail(context, 'Dental Mirror')),
                  InstrumentTile(name: 'Explorer Probe', location: 'Shelf A2', onTap: () => _navigateToDetail(context, 'Explorer Probe')),
                  InstrumentTile(name: 'Periodontal Probe', location: 'Shelf A3', onTap: () => _navigateToDetail(context, 'Periodontal Probe')),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            _buildCategoryCard(
              child: CategorySection(
                category: 'Surgical',
                icon: Icons.cut,
                color: Colors.deepPurple,
                items: [
                  InstrumentTile(name: 'Tissue Scissors', location: 'Shelf B2', onTap: () => _navigateToDetail(context, 'Tissue Scissors')),
                  InstrumentTile(name: 'Scalpel Handle', location: 'Shelf B3', onTap: () => _navigateToDetail(context, 'Scalpel Handle')),
                  InstrumentTile(name: 'Periosteal Elevator', location: 'Shelf B4', onTap: () => _navigateToDetail(context, 'Periosteal Elevator')),
                  InstrumentTile(name: 'Dental Forceps', location: 'Shelf B5', onTap: () => _navigateToDetail(context, 'Dental Forceps')),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            _buildCategoryCard(
              child: CategorySection(
                category: 'Restorative',
                icon: Icons.build_outlined,
                color: Colors.deepPurple,
                items: [
                  InstrumentTile(name: 'Amalgam Condenser', location: 'Shelf C1', onTap: () => _navigateToDetail(context, 'Amalgam Condenser')),
                  InstrumentTile(name: 'Composite Plugger', location: 'Shelf C2', onTap: () => _navigateToDetail(context, 'Composite Plugger')),
                  InstrumentTile(name: 'Burnisher', location: 'Shelf C3', onTap: () => _navigateToDetail(context, 'Burnisher')),
                ],
              ),
            ),
            // ละส่วนอื่นๆ ไว้
          ],
        ),
      ),
    );
  }

  // สร้าง Grid View
  Widget _buildGridView() {
    final List<Map<String, String>> gridItems = [
      {'name': 'Hemostat', 'location': 'Shelf A2'},
      {'name': 'Hemostat', 'location': 'Shelf A2'},
      {'name': 'Hemostat', 'location': 'Shelf A2'},
      {'name': 'Hemostat', 'location': 'Shelf A2'},
      {'name': 'Hemostat', 'location': 'Shelf A2'},
      {'name': 'Hemostat', 'location': 'Shelf A2'},
    ];

    return GridView.builder(
      padding: const EdgeInsets.only(bottom: 24.0, top: 8.0),
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: gridItems.length,
      itemBuilder: (context, index) {
        final item = gridItems[index];
        return _buildGridItem(item);
      },
    );
  }

  // ไอเท็มแต่ละอันใน Grid View
  Widget _buildGridItem(Map<String, String> item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () => _navigateToDetail(context, item['name']!),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Center(
                    // จำลองรูปภาพด้วย Icon ขนาดใหญ่
                    child: Icon(Icons.cut, size: 50, color: Colors.grey.shade300),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  item['name']!,
                  style: const TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    item['location']!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget ช่วยในการสร้างกล่องตีกรอบสีขาวแต่ละ Category 
  Widget _buildCategoryCard({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        clipBehavior: Clip.antiAlias, // ทำให้เอฟเฟกต์กดไม่เกินขอบโค้ง
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: child,
        ),
      ),
    );
  }

  // Widget สำหรับสร้างปุ่ม Filter (Pill shape)
  Widget _buildFilterChip(String label) {
    bool isSelected = selectedFilter == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.deepPurple : Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}