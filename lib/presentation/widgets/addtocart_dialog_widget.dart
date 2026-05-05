import 'package:denis/dataconnect_generated/generated.dart';
import 'package:denis/presentation/pages/cart_page.dart';
import 'package:denis/presentation/widgets/primary_app_button.dart';
import 'package:flutter/material.dart';

class AddtocartDialogWidget extends StatefulWidget {
  
  final GetAllInstrumentsAndCategoriesInstruments instrument;
  final String shelfText;
  final String cartItemId;
  final int instrumentQty;
  const AddtocartDialogWidget({
    super.key, 
    required this.instrument, 
    required this.shelfText,
    required this.cartItemId, 
    required this.instrumentQty
  });

  @override
  State<AddtocartDialogWidget> createState() => _AddtocartDialogWidgetState();
}

class _AddtocartDialogWidgetState extends State<AddtocartDialogWidget> {

  late int _currentQty;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentQty = widget.instrumentQty;

  }
  
  
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min, // ให้กล่องพอดีกับเนื้อหา
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Added to your list!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'Nunito',
              ),
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ส่วนกล่องรูปภาพเครื่องมือ
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: widget.instrument.imageUrl.isNotEmpty
                       ? Image.network(widget.instrument.imageUrl, fit: BoxFit.contain)
                       : Icon(Icons.content_cut, size: 60, color: Colors.grey.shade400),
                  ),
                ),
                const SizedBox(width: 16),
                // ส่วนข้อมูลเครื่องมือและการปรับจำนวน
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.instrument.name,
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
                          'Shelf ${widget.shelfText}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Nunito',
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text('Instock: ${widget.instrument.stocks_on_instrument.first.inStockQty}', 
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Nunito',
                            )),
                      const SizedBox(height: 16),
                      // ปุ่มปรับจำนวนเพิ่มลด (+ / -)
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (_currentQty> 1) {
                                setState(() => _currentQty--);
                              }
                            },
                            child: Icon(Icons.remove_circle_outline, color: Colors.red.shade600, size: 28),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            '$_currentQty',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 16),
                          GestureDetector(
                            onTap: () {
                              if (_currentQty >= widget.instrument.stocks_on_instrument.first.inStockQty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text('Cannot add more than available stock.'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }
                              setState(() => _currentQty++);
                            },
                            child: const Icon(Icons.add_circle_outline, color: Colors.deepPurple, size: 28),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // ปุ่ม Action ด้านล่าง 2 ปุ่ม
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () async{
                      await ExampleConnector.instance.updateCartItem(cartItemId: widget.cartItemId, quantity: _currentQty).execute();
                      if (!context.mounted) return;
                      Navigator.pop(context); // ปิด Dialog
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.deepPurple, width: 2),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Continue Browse',
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: PrimaryAppButton(
                    onPressed: () async {
                      // TODO: เพิ่ม Logic บันทึกลงฐานข้อมูล Cart ตรงนี้
                      print('Cart Item ID: ${widget.cartItemId}, Quantity: $_currentQty');
                      await ExampleConnector.instance.updateCartItem(cartItemId: widget.cartItemId, quantity: _currentQty).execute();
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartPage(),
                        ),
                      );
                    }, 
                    text: "View my list",
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    fontSize: 14,
                  )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}