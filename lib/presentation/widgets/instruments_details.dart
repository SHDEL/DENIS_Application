import 'package:denis/dataconnect_generated/generated.dart';
import 'package:denis/presentation/widgets/addtocart_dialog_widget.dart';
import 'package:denis/presentation/widgets/primary_app_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'package:flutter/material.dart';

class InstrumentsDetailsWidget extends StatefulWidget {
  const InstrumentsDetailsWidget({super.key, required this.instrument, });
  
  @override
  State<InstrumentsDetailsWidget> createState() => _InstrumentsDetailsWidgetState();
  final GetAllInstrumentsAndCategoriesInstruments instrument;
  
 
}

class _InstrumentsDetailsWidgetState extends State<InstrumentsDetailsWidget> {
   late Future<QueryResult<GetAllInstrumentsAndCategoriesData, void>> _dataFuture;
  @override
  void initState() {
    super.initState();
    // ดึงข้อมูลเมื่อเปิดหน้า
    _dataFuture = ExampleConnector.instance.getAllInstrumentsAndCategories().execute();
  }

  @override
  Widget build(BuildContext context) {
    // 2. ดึงข้อมูล Shelf และ Stock (qty) จาก instrument ที่ถูกส่งมา
    final shelfText = widget.instrument.stocks_on_instrument.isNotEmpty 
        ? widget.instrument.stocks_on_instrument.first.shelf 
        : 'No Shelf';
    final currentQty = widget.instrument.stocks_on_instrument.isNotEmpty 
        ? widget.instrument.stocks_on_instrument.first.inStockQty.toString() 
        : '0';
    final inUseQty = widget.instrument.stocks_on_instrument.isNotEmpty 
        ? widget.instrument.stocks_on_instrument.first.inUseQty.toString() 
        : '0';
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // สีพื้นหลังเทาอ่อนตามในภาพ
      body: SafeArea(
        bottom: false, // ปล่อยให้ Container สีขาวด้านล่างชิดขอบจอ
        child: Column(
          children: [
            // 1. ส่วนหัว (App Bar ด้านบน)
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
                    'Instrument Details',
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
            
            // 2. ส่วนรูปภาพตรงกลาง (จำลองด้วยไอคอนก่อน เนื่องจากไม่มีรูปเครื่องมือจริงๆ)
            Expanded(
              child: Center(
                child: widget.instrument.imageUrl.isNotEmpty
                  ? Image.network(widget.instrument.imageUrl, fit: BoxFit.contain)
                  : Icon(Icons.cut, size: 180, color: Colors.grey.shade400),
              ),
            ),

            // 3. ส่วนรายละเอียดด้านล่าง (Bottom Sheet ขาว)
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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, // ให้กล่องหดตามเนื้อหาภายใน
                children: [
                  // Title
                  Text(
                    widget.instrument.name, // แสดงชื่อเครื่องมือ
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Nunito',
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // Status Row (In Stock, In Use, Sterilize)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildStatusIndicator(Colors.green, 'In Stock:', currentQty),
                      const SizedBox(width: 16),
                      _buildStatusIndicator(Colors.blue, 'In Use:', inUseQty),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Shelf Info
                  RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 16, color: Colors.black87, fontFamily: 'Nunito'),
                      children: [
                        TextSpan(text: 'Shelf: '),
                        TextSpan(
                          text: shelfText,
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Category Info
                  Row(
                    children: [
                      const Text(
                        'Category: ',
                        style: TextStyle(fontSize: 16, color: Colors.black87, fontFamily: 'Nunito'),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          widget.instrument.category.name, // แสดงชื่อหมวดหมู่เครื่องมือ
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Nunito',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  
                  // Description Label
                  Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Nunito',
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // Description Details
                  Text(
                    widget.instrument.description, // แสดงคำอธิบายเครื่องมือ
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black87,
                      height: 1.5,
                      fontFamily: 'Nunito',
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  // Button
                  SizedBox(
                    width: double.infinity,
                    child: PrimaryAppButton(
                      onPressed: () async {
                        final currentUser = FirebaseAuth.instance.currentUser;
                        final userId = currentUser!.uid;
                        final cart = await ExampleConnector.instance.getCartByUserId(userId: userId).execute();
                        String activeCartId;
                          if (cart.data?.carts.isEmpty == true) {
                            // ถ้าไม่มี cart ให้สร้างใหม่
                            final result  = await ExampleConnector.instance.createCart(userId: userId, quantity: 1).execute();
                            activeCartId = result.data!.cart_insert.id;
                            Future.delayed(const Duration(seconds: 1));
                          } else {
                            activeCartId = cart.data!.carts.first.id;
                          }
                          await ExampleConnector.instance.addItemToCart(cartId: activeCartId, instrumentId: widget.instrument.id, quantity: 1).execute();
                          showDialog(
                            context: context, 
                            builder: (context) {
                              return AddtocartDialogWidget(
                                instrument: widget.instrument, 
                                shelfText: shelfText,
                                cartItemId: activeCartId,
                              );
                            }
                          );
                        
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(content: Text('เกิดข้อผิดพลาด: $e')),
                          // );
                        
                      },
                      text: 'Add to cart',
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

  // วิดเจ็ตย่อยสำหรับสร้างสถานะ (เช่น In Stock)
  Widget _buildStatusIndicator(Color color, String label, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 14,
            fontFamily: 'Nunito',
          ),
        ),
        const SizedBox(width: 4),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            fontFamily: 'Nunito',
          ),
        ),
      ],
    );
  }
}