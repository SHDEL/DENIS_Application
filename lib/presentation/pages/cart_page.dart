import 'package:denis/presentation/widgets/primary_app_button.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        bottom: false, // ปล่อยชิดขอบจอด้านล่าง
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
                    'Cart',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Nunito',
                    ),
                  ),
                  const SizedBox(width: 48), // สร้างพื้นที่ว่างเพื่อดันให้ Title อยู่ตรงกลาง
                ],
              ),
            ),

            // ส่วนรายการในตะกร้า (Card สีขาวแผ่นใหญ่)
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
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildCartItemCard(name: 'Hemostat', shelf: 'Shelf A2', amount: 1),
                    const SizedBox(height: 20),
                    _buildCartItemCard(name: 'Hemostat', shelf: 'Shelf A2', amount: 1),
                    const SizedBox(height: 20),
                    _buildCartItemCard(name: 'Hemostat', shelf: 'Shelf A2', amount: 1),
                  ],
                ),
              ),
            ),

            // แถบสรุปยอดและปุ่ม Checkout ด้านล่าง
            Container(
              padding: const EdgeInsets.all(32),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 20,
                    offset: Offset(0, -4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Nunito',
                        ),
                      ),
                      Text(
                        '3',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                          fontFamily: 'Nunito',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: PrimaryAppButton(
                      onPressed: () {
                        // TODO: Action สำหรับปุ่ม Checkout
                      },
                      text: 'Checkout',
                      padding: const EdgeInsets.symmetric(vertical: 20), // ปรับความสูงเล็กน้อย
                    ),
                  ),
                  // เพิ่มระยะห่างสำหรับจอที่มีแถบขีดด้านล่างบน iOS (SafeArea Bottom)
                  SizedBox(height: MediaQuery.of(context).padding.bottom),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // วิดเจ็ตสร้างแสดงไอเท็มในตะกร้า 
  // (มีปุ่มเพิ่ม/ลด จำนวนเหมือนในรูป)
  Widget _buildCartItemCard({required String name, required String shelf, required int amount}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // กล่องรูปภาพกรรไกร
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Center(
            child: Icon(
              Icons.content_cut,
              size: 45,
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
              // ปุ่มปรับจำนวนเพิ่มลด (+ / -)
              Row(
                children: [
                  Icon(Icons.remove_circle_outline, color: Colors.red.shade600, size: 28),
                  const SizedBox(width: 16),
                  Text(
                    '$amount',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Icon(Icons.add_circle_outline, color: Colors.deepPurple, size: 28),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
