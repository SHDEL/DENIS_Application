import 'package:denis/dataconnect_generated/generated.dart';
import 'package:denis/presentation/pages/cart_page.dart';
import 'package:denis/presentation/pages/order_details_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  late Future<QueryResult<GetMyOrdersData, void>> _ordersFuture;

  @override
  void initState() {
    super.initState();
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      _ordersFuture = ExampleConnector.instance.getMyOrders(userId: currentUser.uid).execute();
    }
  }
  
  Future<void> _loadOrders() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      setState(() {
        _ordersFuture = ExampleConnector.instance.getMyOrders(userId: currentUser.uid).execute();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Column(
          children: [
            // ส่วนหัว (Header)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 48), // สร้างพื้นที่ว่างเพื่อดันให้ Title อยู่ตรงกลาง
                  const Text(
                    'Order',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Nunito',
                    ),
                  ),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black12),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.shopping_bag_outlined, color: Colors.black87),
                      onPressed: () {
                        // กดแล้วไปหน้า CartPage
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const CartPage()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            
            // ส่วนรายการออเดอร์ (List of Orders)
            Expanded(
              child: FutureBuilder<QueryResult<GetMyOrdersData, void>>(
                future: _ordersFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  }

                  final orders = snapshot.data?.data.orders ?? [];

                  if (orders.isEmpty) {
                    return const Center(
                      child: Text(
                        'No orders found',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                          fontFamily: 'Nunito',
                        ),
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: _loadOrders,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                      itemCount: orders.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final order = orders[index];
                        // แปลงวันที่ให้อ่านง่าย
                        final localDate = order.orderDate.toDateTime().toUtc().toLocal();
                        final dateStr = DateFormat('dd MMMM yyyy - HH:mm').format(localDate);
                        
                        // กำหนดสีตาม Status
                        Color statusColor = Colors.grey;
                        final status = order.status.toLowerCase();
                        if (status == 'pending') {
                          statusColor = Colors.amber;
                        } else if (status == 'ready' || status == 'completed') {
                          statusColor = Colors.green.shade700;
                        } else if (status == 'success') {
                          statusColor = Colors.deepPurple;
                        } else if (status == 'cancelled' || status == 'canceled') {
                          statusColor = Colors.red.shade700;
                        }

                        return _buildOrderCard(
                          context,
                          orderId: order.id.substring(0, 8).toUpperCase(), // แสดง ID แบบสั้นๆ หรือเอาเต็มๆ ก็ได้
                          fullOrderId: order.id,
                          date: dateStr,
                          items: '${order.totalQty} Items',
                          status: order.status,
                          statusColor: statusColor,
                        );
                      },
                    ),
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }

  // วิดเจ็ตย่อยสำหรับสร้างการ์ดออเดอร์แต่ละอัน
  Widget _buildOrderCard(
    BuildContext context, {
    required String orderId,
    required String fullOrderId,
    required String date,
    required String items,
    required String status,
    required Color statusColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () {
            // เมื่อกดการ์ด ให้พาไปหน้า OrderDetailsPage และส่งค่าไปด้วย
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrderDetailsPage(
                  orderId: fullOrderId, // ส่ง ID ตัวเต็มไปดึงข้อมูล Data Connect ต่อ
                  status: status,
                  statusColor: statusColor,
                  dateTime: date,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order #${orderId.length > 4 ? orderId.substring(0, 4).toUpperCase() : orderId.toUpperCase()}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                    fontFamily: 'Nunito',
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    fontFamily: 'Nunito',
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  items,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontFamily: 'Nunito',
                  ),
                ),
                const SizedBox(height: 16),
                // แบดจ์สถานะของออเดอร์ (Pill shape)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    status,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Nunito',
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
}
