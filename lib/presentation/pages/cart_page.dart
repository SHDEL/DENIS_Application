import 'package:denis/dataconnect_generated/generated.dart';
import 'package:denis/presentation/pages/homepage.dart';
import 'package:denis/presentation/pages/orderpage.dart';
import 'package:denis/presentation/widgets/cartwidget/cartitem_card_widget.dart';
import 'package:denis/presentation/widgets/primary_app_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Future<QueryResult<GetMyFullCartData, void>> _cartFuture;
  late String _userId;
  int inStockQty = 0;

  List<GetMyFullCartCartsCartItemsOnCart> _localCartItems = [];
  bool _isDataLoaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final currentUser = FirebaseAuth.instance.currentUser;
    _userId = currentUser!.uid;
    // ขอข้อมูลตะกร้าของ user มาเก็บไว้ใน Future
    _cartFuture = ExampleConnector.instance.getMyFullCart(userId: _userId).execute();
  }

  Future<void> _updateItemQuantity(int index, int newQuantity, String cartItemId) async {
    setState(() {
      final currentItem = _localCartItems[index];
      _localCartItems[index] = GetMyFullCartCartsCartItemsOnCart(
        id: currentItem.id, 
        qty: newQuantity, 
        instrument: currentItem.instrument
      );
    });

    try {
      final String baseUrl = 'https://us-central1-denis-2771b.cloudfunctions.net';
      final String apiUrl = '$baseUrl/updateCartItemApi';
      
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'cartItemId': cartItemId,
          'quantity': newQuantity,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update: ${response.body}');
      }
    } catch (e) {
      print('Update error: $e');
    }
  }

  Future<void> _deleteCartItem(int index, String cartItemId) async {
    try {
      final String baseUrl = 'https://us-central1-denis-2771b.cloudfunctions.net';
      final String apiUrl = '$baseUrl/deleteCartItemApi';

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'cartItemId': cartItemId,
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          _localCartItems.removeAt(index);
        });
      } else {
        throw Exception('Failed to delete: ${response.body}');
      }
    } catch (e) {
      print('Delete error: $e');
    }
  }

  Future<void> _handleCheckout(String cartId, int totalItemsQty) async {
    if (cartId.isEmpty) return;

    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );
      
      final String baseUrl = 'https://us-central1-denis-2771b.cloudfunctions.net';
      final String apiUrl = '$baseUrl/checkoutApi';

      final itemsData = _localCartItems.map((item) {
        final stockInfo = item.instrument.stocks_on_instrument.isNotEmpty 
            ? item.instrument.stocks_on_instrument.first 
            : null;

        return {
          'instrumentId': item.instrument.id,
          'qty': item.qty,
          'stockId': stockInfo?.id,
          'inStockQty': stockInfo?.inStockQty ?? 0,
          'inUseQty': stockInfo?.inUseQty ?? 0,
        };
      }).toList();

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId': _userId,
          'cartId': cartId,
          'totalItemsQty': totalItemsQty,
          'items': itemsData,
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode != 200 || responseData['success'] != true) {
        throw Exception('Failed to checkout on server: ${response.body}');
      }
      
      if (mounted) Navigator.pop(context); 
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Home', role: 'USER', initialPage: 2)),
        );
      }
    } catch (e) {
      if (mounted) Navigator.pop(context); 
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to checkout: $e')));
      }
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QueryResult<GetMyFullCartData, void>>(
      future: _cartFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting && !_isDataLoaded) {
          return const Scaffold(
            backgroundColor: Color(0xFFFAFAFA),
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            backgroundColor: const Color(0xFFFAFAFA),
            body: Center(child: Text("Error: ${snapshot.error}")),
          );
        }

        if (!_isDataLoaded && snapshot.data?.data != null) {
          final data = snapshot.data!.data;
          final hasCart = data.carts.isNotEmpty;
          if (hasCart) {
            // โคลน List มาเก็บไว้เพื่อให้ระบบแยกแยะ UI ได้อิสระ
            _localCartItems = List.from(data.carts.first.cartItems_on_cart);
          }
          // บังคับให้ไม่เข้ามาบล็อกโอนข้อมูลใหญ่นี้อีก
          _isDataLoaded = true; 
        }
        
        int totalItemsQty = _localCartItems.fold(0, (sum, item) => sum + item.qty);

        return Scaffold(
          backgroundColor: const Color(0xFFFAFAFA),
          body: SafeArea(
            bottom: false, 
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
                        'My List',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Nunito',
                        ),
                      ),
                      const SizedBox(width: 48), 
                    ],
                  ),
                ),

                // ส่วนรายการในตะกร้า 
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
                    child: _localCartItems.isEmpty
                        ? const Center(
                            child: Text(
                              'Your list is empty',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                                fontFamily: 'Nunito',
                              ),
                            ),
                          )
                        : ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemCount: _localCartItems.length,
                            separatorBuilder: (context, index) => const SizedBox(height: 20),
                            itemBuilder: (context, index) {
                              final item = _localCartItems[index];

                              final shelfText = item.instrument.stocks_on_instrument.isNotEmpty
                                  ? 'Shelf ${item.instrument.stocks_on_instrument.first.shelf}'
                                  : 'No Shelf';
                              
                              inStockQty = item.instrument.stocks_on_instrument.first.inStockQty;

                              return CartitemCardWidget(
                                index: index, 
                                cartItemId: item.id, 
                                name: item.instrument.name, 
                                imageUrl: item.instrument.imageUrl, 
                                shelf: shelfText, 
                                amount: item.qty, 
                                inStockQty: item.instrument.stocks_on_instrument.first.inStockQty,
                                onDelete: _deleteCartItem, 
                                onUpdateQuantity: _updateItemQuantity,
                              );
                            },
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
                        children: [
                          const Text(
                            'Total Items',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Nunito',
                            ),
                          ),
                          Text(
                            '$totalItemsQty',
                            style: const TextStyle(
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
                          onPressed: () async {
                            final String cartId = _cartFuture != null && snapshot.data?.data?.carts.isNotEmpty == true 
                              ? snapshot.data!.data!.carts.first.id 
                              : "";
                            _handleCheckout(cartId, totalItemsQty);
                          },
                          text: 'Checkout',
                          padding: const EdgeInsets.symmetric(vertical: 20), 
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).padding.bottom),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }

}
