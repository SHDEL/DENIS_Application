import 'dart:convert';

import 'package:denis/presentation/widgets/orderwidget/request_details_dialog.dart';
import 'package:flutter/material.dart';
import 'package:denis/dataconnect_generated/generated.dart';
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

// Import ปุ่มตามที่คุณมีในโปรเจกต์
import 'package:denis/presentation/widgets/primary_app_button.dart';
import 'package:denis/presentation/widgets/outline_app_button.dart';

class RequestManagement extends StatefulWidget {
  const RequestManagement({super.key});

  @override
  State<RequestManagement> createState() => _RequestManagementState();
}

class _RequestManagementState extends State<RequestManagement> {
  int _selectedTabIndex = 0;
  final List<String> _tabs = ['All'];

  late Future<QueryResult<GetAllOrdersData, void>> _ordersFuture;
  final Set<String> _selectedOrders = {};

  @override
  void initState() {
    super.initState();
    _ordersFuture = ExampleConnector.instance.getAllOrders().execute();
  }

  String _formatDateTime(Timestamp timestamp) {
    try {
      final localDate = timestamp.toDateTime().toUtc().toLocal();
      return DateFormat('dd MMMM yyyy - HH:mm').format(localDate);
    } catch (e) {
      return '-';
    }
  }

  // ฟังก์ชันดึงสีตาม Status ให้ตรงกับหน้า OrderPage
  Color _getStatusColor(String statusText) {
    final status = statusText.toLowerCase();
    if (status == 'pending') {
      return Colors.amber;
    } else if (status == 'ready' || status == 'completed') {
      return Colors.green.shade700;
    } else if (status == 'success') {
      return Colors.deepPurple;
    } else if (status == 'cancelled' || status == 'canceled') {
      return Colors.red.shade700;
    }
    return Colors.grey;
  }

  // ฟังก์ชันสำหรับอัปเดตสถานะของออเดอร์
  Future<void> _updateOrderStatus(BuildContext context, String orderId, String newStatus) async {
    // แสดงเครื่องหมายโหลด
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      // เรียกใช้ Mutation เพื่ออัปเดตสถานะของ Order
      await ExampleConnector.instance.updateOrderStatus(orderId: orderId, newStatus: newStatus).execute();
      if (newStatus == 'Success'){
        
      }
      
      // ปิด Loading
      if (context.mounted) Navigator.pop(context);
      // ปิด Dialog (หน้าออเดอร์)
      if (context.mounted) Navigator.pop(context);

      // รีเฟรชตารางโชว์ Order ใหม่
      setState(() {
        _ordersFuture = ExampleConnector.instance.getAllOrders().execute();
      });

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Order Status updated to $newStatus')),
        );
      }
    } catch (e) {
      // กรณีเกิดข้อผิดพลาด ปิด Loading แล้วแสดง error
      if (context.mounted) Navigator.pop(context);
      
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update status: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  Future<void> _updateOrderStatusApi(BuildContext context, String orderId, String newStatus) async {
    // แสดงเครื่องหมายโหลด
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final String baseUrl = 'https://us-central1-denis-2771b.cloudfunctions.net';
      final String apiUrl = '$baseUrl/updateOrderStatusApi';

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'orderId': orderId,
          'newStatus': newStatus
          ,
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode != 200 || responseData['success'] != true) {
        throw Exception('Failed to update status on server: ${response.body}');
      }
      
      // ปิด Loading
      if (context.mounted) Navigator.pop(context);
      // ปิด Dialog (หน้าออเดอร์)
      if (context.mounted) Navigator.pop(context);

      // รีเฟรชตารางโชว์ Order ใหม่
      setState(() {
        _ordersFuture = ExampleConnector.instance.getAllOrders().execute();
      });

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Order Status updated to $newStatus')),
        );
      }
    } catch (e) {
      // กรณีเกิดข้อผิดพลาด ปิด Loading แล้วแสดง error
      if (context.mounted) Navigator.pop(context);
      
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update status: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  // Dialog หน้าตาแบบเดียวกับ OrderDetails (เฉพาะส่วน Card สีขาวด้านล่าง)
  void _showOrderDetailsDialog(BuildContext context, GetAllOrdersOrders order, String timestamp) {
    final orderId = order.id;
    final statusColor = _getStatusColor(order.status);
    
    // โหลด Detail เมื่อเปิด Dialog
    final orderDetailsFuture = ExampleConnector.instance.getOrderDetails(orderId: order.id).execute();

    showDialog(
      context: context,
      builder: (context) {
        return RequestDetailsDialog(
          order: order, 
          timestamp: timestamp, 
          statusColor: statusColor, 
          orderDetailsFuture: orderDetailsFuture, 
          onUpdateStatus: _updateOrderStatusApi
        );
      },
    );
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
            'Requests',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildFiltersAndActions(),
          const SizedBox(height: 16),

          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(8),
              ),
              child: FutureBuilder<QueryResult<GetAllOrdersData, void>>(
                future: _ordersFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  final orders = snapshot.data?.data.orders ?? [];

                  if (orders.isEmpty) {
                    return const Center(child: Text('No requests found'));
                  }

                  return SingleChildScrollView(
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
                              itemCount: orders.length,
                              separatorBuilder: (context, index) => const Divider(height: 1),
                              itemBuilder: (context, index) {
                                final order = orders[index];
                                final formattedTime = _formatDateTime(order.orderDate);
                                
                                return InkWell(
                                  hoverColor: Colors.blue.withOpacity(0.05),
                                  onTap: () {
                                    // เรียก Dialog โดยส่ง order และเวลาที่จัดรูปแล้วไป
                                    _showOrderDetailsDialog(context, order, formattedTime);
                                  },
                                  child: _buildTableRow(
                                    id: order.id,
                                    shortId: order.id.substring(0, 7),
                                    username: order.user.username,
                                    status: order.status,
                                    timestamp: formattedTime,
                                    amount: order.totalQty,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
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
              label: const Text('Export'),
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
                  hintText: 'Search order ID',
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
              icon: const Icon(Icons.filter_list, size: 16),
              label: const Text('Filter'),
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

  Widget _buildTableRow({
    required String id,
    required String shortId,
    required String username,
    required String status,
    required String timestamp,
    required int amount,
  }) {
    bool isChecked = _selectedOrders.contains(id);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Checkbox(
                  value: isChecked, 
                  onChanged: (v) {
                    setState(() {
                      if (v == true) {
                        _selectedOrders.add(id);
                      } else {
                        _selectedOrders.remove(id);
                      }
                    });
                  }
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    shortId,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: _buildUserBadge(username),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              status,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: _getStatusColor(status), // ใช้ฟังก์ชันสีเดียวกัน
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(timestamp, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
          ),
          Expanded(
            flex: 2,
            child: Text('$amount items', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
          ),
        ],
      ),
    );
  }

  Widget _buildUserBadge(String username) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.person, size: 14, color: Colors.blue),
          const SizedBox(width: 4),
          Text(
            username,
            style: TextStyle(color: Colors.blue.shade700, fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}