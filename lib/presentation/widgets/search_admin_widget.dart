import 'package:flutter/material.dart';

class StockSearchAdminWidget extends StatefulWidget {
  const StockSearchAdminWidget({super.key});

  @override
  State<StockSearchAdminWidget> createState() => _StockSearchAdminWidgetState();
}

class _StockSearchAdminWidgetState extends State<StockSearchAdminWidget> {
  int _selectedTabIndex = 0;
  final List<String> _tabs = ['All', 'Examination', 'Surgical'];

  // Mock Data สำหรับแสดงผลในตาราง
  final List<Map<String, dynamic>> _mockProducts = [
    {'name': 'Artery Forceps', 'Category': 'Examination', 'In Stock': 45, 'In Use': 12, 'Sterilized': 11, 'Shelf': 'A'},
    {'name': 'Hydrate replenish', 'Category': 'Scoping', 'In Stock': 45, 'In Use': 65, 'Sterilized': 11, 'Shelf': 'A'},
    {'name': 'Illumination (mask)', 'Category': 'Quoting', 'In Stock': 45, 'In Use': 35, 'Sterilized': 11, 'Shelf': 'B'},
    {'name': 'Act+ acre hair mask', 'Category': 'Scoping', 'In Stock': 45, 'In Use': 24, 'Sterilized': 11, 'Shelf': 'A'},
    {'name': 'Mecca cosmetica', 'Category': 'Production', 'In Stock': 0, 'In Use': 22, 'Sterilized': 11, 'Shelf': 'A'},
    {'name': 'Hylamide (Glow)', 'Category': 'Scoping', 'In Stock': 45, 'In Use': 86, 'Sterilized': 11, 'Shelf': 'B'},
    {'name': 'Mecca cosmetica(body oil)', 'Category': 'Scoping', 'In Stock': 45, 'In Use': 68, 'Sterilized': 11, 'Shelf': 'A'},
    {'name': 'Hydrate replenish(body oil)', 'Category': 'Production', 'In Stock': 0, 'In Use': 70, 'Sterilized': 11, 'Shelf': 'C'},
    {'name': 'Illumination (mask)', 'Category': 'Scoping', 'In Stock': 45, 'In Use': 56, 'Sterilized': 11, 'Shelf': 'A'},
    {'name': 'Mecca cosmetica(body oil)', 'Category': 'Shipped', 'In Stock': 0, 'In Use': 72, 'Sterilized': 11, 'Shelf': 'A'},
    {'name': 'Mecca cosmetica(body oil)', 'Category': 'Shipped', 'In Stock': 0, 'In Use': 72, 'Sterilized': 11, 'Shelf': 'A'}
  ];

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
          _buildFiltersAndActions(),
          const SizedBox(height: 16),
          // Wrap content in Expanded and ScrollView
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
                        child: ListView.separated(
                          itemCount: _mockProducts.length,
                          separatorBuilder: (context, index) => const Divider(height: 1),
                          itemBuilder: (context, index) {
                            final product = _mockProducts[index];
                            return _buildTableRow(product);
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
                        if (index == 0) const Icon(Icons.check_circle_outline, size: 16, color: Colors.black54),
                        if (index == 1) const Icon(Icons.show_chart, size: 16, color: Colors.black54),
                        if (index == 2) const Icon(Icons.insert_drive_file_outlined, size: 16, color: Colors.black54),
                        if (index == 3) const Icon(Icons.archive_outlined, size: 16, color: Colors.black54),
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
            const SizedBox(width: 8),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add, size: 16),
              label: const Text('Add'),
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
          Expanded(flex: 3, child: _headerText('Product')),
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

  Widget _buildTableRow(Map<String, dynamic> product) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        children: [
          // 1. Checkbox + Image + Name
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Checkbox(value: false, onChanged: (v) {}),
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(Icons.image, size: 16, color: Colors.grey),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    product['name'],
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          // 2. Status Badge
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: _buildStatusBadge(product['Category']),
            ),
          ),
          // 3. In Stock
          Expanded(
            flex: 2,
            child: Text(
              '${product['In Stock']} in stock',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: product['In Stock'] == 0 ? Colors.red : Colors.black87,
                fontSize: 13,
              ),
            ),
          ),
          // 4. In Use
          Expanded(
            flex: 2,
            child: Text('${product['In Use']}', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
          ),
          // 5. Out of Stock
          Expanded(
            flex: 2,
            child: Text('${product['Sterilized']}', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
          ),
          // 6. Shelf
          Expanded(
            flex: 1,
            child: Text(product['Shelf'], style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String category) {
    Color bgColor;
    Color textColor;

    switch (category.toLowerCase()) {
      case 'scoping':
        bgColor = Colors.blue.shade50;
        textColor = Colors.blue.shade700;
        break;
      case 'quoting':
        bgColor = Colors.green.shade50;
        textColor = Colors.green.shade700;
        break;
      case 'production':
        bgColor = Colors.orange.shade50;
        textColor = Colors.orange.shade800;
        break;
      case 'shipped':
        bgColor = Colors.indigo.shade50;
        textColor = Colors.indigo.shade700;
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