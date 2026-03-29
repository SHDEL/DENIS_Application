import 'package:flutter/material.dart';

class RequestManagement extends StatefulWidget {
  const RequestManagement({super.key});

  @override
  State<RequestManagement> createState() => _RequestManagementState();
}

class _RequestManagementState extends State<RequestManagement> {
  int _selectedTabIndex = 0;
  final List<String> _tabs = ['All'];

  // Mock Data สำหรับแสดงผลในตาราง
  final List<Map<String, dynamic>> _mockOrders = [
  {'orderid': '1048573', 'username': 'dr_alice', 'status': 'Pending', 'timestamp': '27/03/2026 09:15', 'amount': 12},
  {'orderid': '1048574', 'username': 'nurse_joy', 'status': 'Ready', 'timestamp': '27/03/2026 10:30', 'amount': 5},
  {'orderid': '1048575', 'username': 'somchai_k', 'status': 'Success', 'timestamp': '26/03/2026 14:20', 'amount': 45},
  {'orderid': '1048576', 'username': 'er_department', 'status': 'Cancelled', 'timestamp': '25/03/2026 08:45', 'amount': 2},
  {'orderid': '1048577', 'username': 'dr_smith', 'status': 'Pending', 'timestamp': '27/03/2026 11:05', 'amount': 18},
  {'orderid': '1048578', 'username': 'klinik_bkk', 'status': 'Success', 'timestamp': '26/03/2026 16:50', 'amount': 100},
  {'orderid': '1048579', 'username': 'dr_alice', 'status': 'Ready', 'timestamp': '27/03/2026 13:10', 'amount': 8},
  {'orderid': '1048580', 'username': 'or_room_01', 'status': 'Pending', 'timestamp': '27/03/2026 15:22', 'amount': 24},
  {'orderid': '1048581', 'username': 'somchai_k', 'status': 'Success', 'timestamp': '24/03/2026 09:00', 'amount': 50},
  {'orderid': '1048582', 'username': 'nurse_joy', 'status': 'Cancelled', 'timestamp': '27/03/2026 16:05', 'amount': 15},
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
            'Requests',
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
                          itemCount: _mockOrders.length,
                          separatorBuilder: (context, index) => const Divider(height: 1),
                          itemBuilder: (context, index) {
                            final order = _mockOrders[index];
                            return _buildTableRow(order);
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
          'Request Management',
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
          Expanded(flex: 2, child: _headerText('OrderID')),
          Expanded(flex: 2, child: _headerText('Username')),
          Expanded(flex: 2, child: _headerText('Status')),
          Expanded(flex: 2, child: _headerText('Timestamp')),
          Expanded(flex: 2, child: _headerText('Amount')),
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
            flex: 2,
            child: Row(
              children: [
                Checkbox(value: false, onChanged: (v) {}),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    product['orderid'],
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
              child: _buildStatusBadge(product['username']),
            ),
          ),
          // 3. In Stock
          Expanded(
            flex: 2,
            child: Text(
              '${product['status']}',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: product['status'] == 'Pending' ? Colors.orange : Colors.black87,
                fontSize: 13,
              ),
            ),
          ),
          // 4. In Use
          Expanded(
            flex: 2,
            child: Text('${product['timestamp']}', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
          ),
          // 5. Out of Stock
          Expanded(
            flex: 2,
            child: Text('${product['amount']}', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
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