import 'package:denis/dataconnect_generated/generated.dart';
import 'package:denis/presentation/pages/cart_page.dart';
import 'package:flutter/material.dart';

class OrderDetailsPage extends StatefulWidget {
  final String orderId;
  final String status;
  final Color statusColor;
  final String dateTime;

  const OrderDetailsPage({
    super.key,
    required this.orderId,
    required this.status,
    required this.statusColor,
    required this.dateTime,
  });

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
   // สร้าง Future สำหรับดึงข้อมูล
  late Future<GetOrderDetailsData> _orderDetailsFuture;
  late String orderId;
  late String dateTime;
  late String status;
  late Color statusColor;
  @override
  void initState() {
    super.initState();
    orderId = widget.orderId;
    dateTime = widget.dateTime;
    status = widget.status;
    statusColor = widget.statusColor;
    // เรียกใช้ Data Connect เพื่อดึงข้อมูล Order Details
    _orderDetailsFuture = ExampleConnector.instance.getOrderDetails(orderId: widget.orderId).execute().then((res) => res.data);
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
                      'Order #${orderId.length > 4 ? orderId.substring(0, 4).toUpperCase() : orderId.toUpperCase()}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Nunito',
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Text(
                          'Order Date: ',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Nunito',
                          ),
                        ),
                        Expanded(
                          child: Text(
                            dateTime,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                              fontFamily: 'Nunito',
                            ),
                          ),
                        ),
                      ],
                    ),
                    // สถานะ
                    Row(
                      children: [
                        const Text(
                          'Status: ',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Nunito',
                          ),
                        ),
                        Text(
                          status,
                          style: TextStyle(
                            fontSize: 16,
                            color: statusColor,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    
                    // รายชื่อไอเท็มในออเดอร์
                    Expanded(
                      child: FutureBuilder<GetOrderDetailsData>(
                        future: _orderDetailsFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          if (snapshot.hasError) {
                            return Center(child: Text('Error: ${snapshot.error}'));
                          }

                          final order = snapshot.data?.order;
                          if (order == null || order.orderItems_on_order.isEmpty) {
                            return const Center(child: Text('No items found in this order.'));
                          }

                          final items = order.orderItems_on_order;

                          return ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemCount: items.length,
                            separatorBuilder: (context, index) => const SizedBox(height: 20),
                            itemBuilder: (context, index) {
                              final item = items[index];
                              final instrument = item.instrument;
                              // ดึงชื่อ Shelf แรก (ถ้ามี)
                              final shelf = instrument.stocks_on_instrument.isNotEmpty 
                                  ? instrument.stocks_on_instrument[0].shelf 
                                  : 'N/A';

                              return _buildOrderItemCard(
                                name: instrument.name,
                                imageUrl: instrument.imageUrl,
                                shelf: shelf,
                                amount: item.qty,
                              );
                            },
                          );
                        },
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
  // ปรับ _buildOrderItemCard ให้รองรับ imageUrl
  Widget _buildOrderItemCard({
    required String name, 
    required String imageUrl, 
    required String shelf, 
    required int amount
  }) {
    return Row(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.deepPurple)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Shelf $shelf',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Nunito',
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text('Qty: $amount', style: const TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ],
    );
  }
}
