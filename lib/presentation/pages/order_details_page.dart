import 'package:denis/presentation/pages/cart_page.dart';
import 'package:flutter/material.dart';

class OrderDetailsPage extends StatelessWidget {
  final String orderId;
  final String status;
  final Color statusColor;

  const OrderDetailsPage({
    super.key,
    required this.orderId,
    required this.status,
    required this.statusColor,
  });

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
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black12),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: Colors.black87),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const Text(
                    'Order Details',
                    style: TextStyle(
                      fontSize: 22,
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

            // ส่วนเนื้อหาด้านล่าง (ใส่ Card สีขาวใบใหญ่)
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // หัวข้อ Order
                    Text(
                      orderId,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Nunito',
                      ),
                    ),
                    const SizedBox(height: 12),
                    // สถานะ
                    Row(
                      children: [
                        const Text(
                          'Status: ',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Nunito',
                          ),
                        ),
                        Text(
                          status,
                          style: TextStyle(
                            fontSize: 18,
                            color: statusColor,
                            fontFamily: 'Nunito',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    
                    // รายชื่อไอเท็มในออเดอร์
                    Expanded(
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          _buildOrderItemCard(
                            name: 'Hemostat',
                            shelf: 'Shelf A2',
                            amount: 3,
                          ),
                          const SizedBox(height: 20),
                          _buildOrderItemCard(
                            name: 'Hemostat',
                            shelf: 'Shelf A2',
                            amount: 3,
                          ),
                          const SizedBox(height: 20),
                          _buildOrderItemCard(
                            name: 'Hemostat',
                            shelf: 'Shelf A2',
                            amount: 3,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // วิดเจ็ตสร้างแสดงไอเท็มแต่ละชิ้นที่มีกรรไกร
  Widget _buildOrderItemCard({required String name, required String shelf, required int amount}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // กล่องรูปภาพกรรไกร
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Center(
            child: Icon(
              Icons.content_cut,
              size: 50,
              color: Colors.grey.shade400,
            ),
          ),
        ),
        const SizedBox(width: 20),
        // ข้อมูลของไอเท็ม
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Nunito',
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  shelf,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Nunito',
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Amount: $amount',
                style: const TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Nunito',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
