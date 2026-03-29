import 'package:denis/presentation/pages/cart_page.dart';
import 'package:denis/presentation/pages/order_details_page.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

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
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                physics: const BouncingScrollPhysics(),
                children: [
                  _buildOrderCard(
                    context,
                    orderId: 'Order 1',
                    date: '24 March 2026 - 16:16',
                    items: '3 Items',
                    status: 'Pending',
                    statusColor: Colors.amber, // สีเหลือง
                  ),
                  const SizedBox(height: 16),
                  
                  _buildOrderCard(
                    context,
                    orderId: 'Order 1',
                    date: '24 March 2026 - 16:16',
                    items: '3 Items',
                    status: 'Ready',
                    statusColor: Colors.green.shade700, // สีเขียว
                  ),
                  const SizedBox(height: 16),
                  
                  _buildOrderCard(
                    context,
                    orderId: 'Order 1',
                    date: '24 March 2026 - 16:16',
                    items: '3 Items',
                    status: 'Success',
                    statusColor: Colors.deepPurple, // สีม่วง
                  ),
                  const SizedBox(height: 16),
                  
                  _buildOrderCard(
                    context,
                    orderId: 'Order 1',
                    date: '24 March 2026 - 16:16',
                    items: '3 Items',
                    status: 'Cancelled',
                    statusColor: Colors.red.shade700, // สีแดง
                  ),
                  const SizedBox(height: 16),
                ],
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
                  orderId: orderId,
                  status: status,
                  statusColor: statusColor,
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
                  orderId,
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
