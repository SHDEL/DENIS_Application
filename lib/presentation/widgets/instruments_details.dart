import 'dart:convert';

import 'package:denis/dataconnect_generated/generated.dart';
import 'package:denis/presentation/widgets/addtocart_dialog_widget.dart';
import 'package:denis/presentation/widgets/primary_app_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class InstrumentsDetailsWidget extends StatefulWidget {
  InstrumentsDetailsWidget({super.key, required this.instrument, required this.userRole});
  final String userRole;
  
  @override
  State<InstrumentsDetailsWidget> createState() => _InstrumentsDetailsWidgetState();
  final GetAllInstrumentsAndCategoriesInstruments instrument;
  
}

class _InstrumentsDetailsWidgetState extends State<InstrumentsDetailsWidget> {
   late Future<QueryResult<GetAllInstrumentsAndCategoriesData, void>> _dataFuture;
   bool isCartReady = false;
   String? activeCartItemId;
   int itemQty = 1;
   bool isLoadingCart = false;
   late String userId;
  @override
  void initState() {
    super.initState();
    // ดึงข้อมูลเมื่อเปิดหน้า
    _dataFuture = ExampleConnector.instance.getAllInstrumentsAndCategories().execute();
  }


  Future<void> _preloadCartData() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      userId = currentUser!.uid;
      
      // 1. จัดการ Cart
      final cart = await ExampleConnector.instance.getCartByUserId(userId: userId).execute();
      String? activeCartId;
      if (cart.data?.carts.isEmpty == true) {
        final result = await ExampleConnector.instance.createCart(userId: userId, quantity: 1).execute();
        activeCartId = result.data!.cart_insert.id;
      } else {
        activeCartId = cart.data!.carts.first.id;
      }

      // 2. จัดการ Cart Item (เช็คของเก่า หรือ สร้างของใหม่)
      final existingItemResult = await ExampleConnector.instance.checkItemInCart(cartId: activeCartId, instrumentId: widget.instrument.id).execute();
      
      if (existingItemResult.data?.cartItems.isNotEmpty == true) {
        activeCartItemId = existingItemResult.data!.cartItems.first.id;
        itemQty = existingItemResult.data!.cartItems.first.qty;
      } else {
        final addItemResult = await ExampleConnector.instance.addItemToCart(cartId: activeCartId, instrumentId: widget.instrument.id, quantity: 1).execute();
        activeCartItemId = addItemResult.data!.cartItem_insert.id;
        itemQty = 1;
      }
      
      // โหลดเตรียมไว้สำเร็จ
      if (mounted) {
        setState(() {
          isCartReady = true;
        });
      }
    } catch (e) {
      print("Preload cart error: $e");
    }
  }

  Future<void> _preloadCartDataFromApi() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        print("User not logged in");
        return;
      }
      
      final userId = currentUser.uid;
      
      // ดึง URL ที่แปลงตามแพลตฟอร์มแล้ว เพื่อให้ Android Emulator มองเห็น
      final apiUrl = Uri.parse('https://us-central1-denis-2771b.cloudfunctions.net/addToCartApi');
      
      print("🚀 Testing API Data: $apiUrl");
      print("🚀 Body >> userId: $userId, instrumentId: ${widget.instrument.id}");

      // สร้าง HTTP POST Request ยิงไปที่ Local Emulator ของ Functions
      final response = await http.post(
        apiUrl,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'userId': userId,
          'instrumentId': widget.instrument.id,
          'qty': 1,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print("✅ API Success: $responseData");
        
        // เช็คว่า success เป็น true ก่อน
        if (responseData['success'] == true) {
          // แจกแจง Data ให้ถูกตรงกับที่ Backend (index.js) พ่นออกมา
          activeCartItemId = responseData['cartItemId']; 
          itemQty = responseData['qty'];

          if (mounted) {
            setState(() {
              isCartReady = true;
            });
          }
        } else {
          print("❌ API Logic Error: ${responseData['message']}");
        }
      } else {
        print("❌ API HTTP Error Status [${response.statusCode}]: ${response.body}");
      }
    } catch (e) {
      print("🔥 Preload API catch error: $e");
    }
  }

  void _showCartDialog() {
    showDialog(
      context: context, 
      builder: (context) {
        return AddtocartDialogWidget(
          instrument: widget.instrument, 
          shelfText: widget.instrument.stocks_on_instrument.isNotEmpty 
            ? widget.instrument.stocks_on_instrument.first.shelf 
            : 'No Shelf',
          cartItemId: activeCartItemId!,  // ส่งค่าที่รอดึงไว้แล้ว
          instrumentQty: itemQty,         // ส่งค่าที่รอดึงไว้แล้ว
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QueryResult<GetAllInstrumentsAndCategoriesData, void>>(
      future: _dataFuture,
      builder: (context, snapshot) {
        // ค่าเริ่มต้น อ้างอิงจากข้อมูลเก่าที่ส่งข้ามหน้ามา (widget.instrument)
        String shelfText = 'No Shelf';
        int currentQty = 0;
        int inUseQty = 0;

        // ถ้าเชื่อมต่อเรียบร้อยและมีตอบกลับเป็นชุดข้อมูลใหม่
        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          // ดึงข้อมูลตัวใหม่จาก future มาแทนที่ตัวเดิม
          final updatedInstrumentList = snapshot.data!.data.instruments
              .where((item) => item.id == widget.instrument.id)
              .toList();

          if (updatedInstrumentList.isNotEmpty && updatedInstrumentList.first.stocks_on_instrument.isNotEmpty) {
            shelfText = updatedInstrumentList.first.stocks_on_instrument.first.shelf;
            currentQty = updatedInstrumentList.first.stocks_on_instrument.first.inStockQty;
            inUseQty = updatedInstrumentList.first.stocks_on_instrument.first.inUseQty;
          }
        } else {
          // ระหว่างโหลด หรือเกิด Error ให้ fallback มาใช้ของเดิมก่อน
          if (widget.instrument.stocks_on_instrument.isNotEmpty) {
            shelfText = widget.instrument.stocks_on_instrument.first.shelf;
            currentQty = widget.instrument.stocks_on_instrument.first.inStockQty;
            inUseQty = widget.instrument.stocks_on_instrument.first.inUseQty;
          }
        }
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
                      if (widget.userRole != 'ADMIN')
                        SizedBox(
                          width: double.infinity,
                          child: PrimaryAppButton(
                            text: 'Add to List',
                            onPressed: currentQty <= 0 ? null : () async {
                              // ป้องกันการกดซ้ำขณะโหลด
                              if (isLoadingCart) return;

                              // กรณี 1: ข้อมูลดึงเตรียมไว้เสร็จเรียบร้อยแล้วตอนอยู่ดูหน้าเพจ (ส่วนใหญ่จะเป็นแบบนี้) เปิด Dialog ทันที!
                              if (isCartReady && activeCartItemId != null) {
                                _showCartDialog();
                                return;
                              }

                              // กรณี 2: ผู้ใช้กดปุ่มเร็วมากจน Background process โหลดไม่ทัน ให้โชว์ Loading รอ
                              setState(() => isLoadingCart = true);
                              
                              // รอจนกว่าจะโหลดเสร็จ
                              await _preloadCartDataFromApi();
                              
                              setState(() => isLoadingCart = false);
                              
                              // ถ้าโหลดผ่านแล้ว เปิดทันที
                              if (isCartReady && activeCartItemId != null) {
                                _showCartDialog();
                              }
                            },
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
      },
    );
  }

  // วิดเจ็ตย่อยสำหรับสร้างสถานะ (เช่น In Stock)
  Widget _buildStatusIndicator(Color color, String label, int value) {
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
          value.toString(),
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